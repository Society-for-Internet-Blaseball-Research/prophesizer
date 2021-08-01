# Basics of Prophesizer

This document is an attempt to describe in simple-ish terms what happens when Prophesizer runs, for those who come after me.

## Startup

* Connects to the DB via the PSQL_CONNECTION_STRING environment variable
* Uses [Evolve](https://evolve-db.netlify.app/) to migrate the DB to the latest version (see About Migrations)
* Enters a loop that runs `Poll` every minute, which does:

## Prophesizer.Poll

* Opens a metadata record in `data.prophesizer_meta` for this run
* Uses the blaseball.com `/games` endpoint to get the games each day of each known season and populate the `data.games` table
* Checks `data.chronicler_meta` for information about the season/day/timestamp of the last info received from Chronicler
* Uses blaseball.com `/simulationData` endpoint to find out the current season/day/etc
* Loads [non-game-event data](#non-game-event-data) (previously referred to as "hourly" data since that's what the original S3 bucket called it)
* Processes [Game Event data](#game-event-data)
* Closes the metadata record in `data.prophesizer_meta` for this run
* Outputs details on what happened to `#prophesizer-events` on Discord

## Non Game Event Data

All of these data types use Chronicler's v2 api to fetch all versions of data of this type.
They all use utility functions to do the common logic of "take this new version of an entity, check to see if a record exists with this ID, if so close the `valid_until` timestamp, and add the new record with `valid_from` equalling now.
They also use `data.chronicler_meta` to only pull "new" records from Chronicler and update that table once data is stored.

### Leagues, Subleagues, and Divisions

* Leagues
  * Adds all new league entries to `data.leagues`
  * Then records a mapping of subleagues to leagues
* Subleagues
  * Adds all new subleague entries to `data.subleagues`
  * Then records a mapping of divisions to subleagues
  * And sets the league ID on each entry in `data.subleagues` based on the leagues mapping
* Divisions
  * Adds all new division entries to `data.divisions`
  * Goes through the list of teams in the division and updates `data.division_teams` accordingly
  * And set the subleague ID on each entry in `data.divisions` based on the subleagues mapping

All of this gives us records linking leagues, subleagues, divisions, and teams.

### Teams

* Update/add any new Team entries to `data.teams` by hashing the Team entry
* Update/add any new Team modifications by finding the diff between the existing mods and new ones and closing old entries / opening new ones in `data.team_modifications`

### Players

* Update/add any new Player entries to `data.players` by hashing the Player entry
* Update/add any new Player modifications by finding the diff between the existing mods and new ones and closing old entries / opening new ones in `data.player_modifications`

### Stadiums

* Update/add any new Stadium entries to `data.stadiums` by hashing the Stadium entry
* Update/add any new Stadium modifications by finding the diff between the existing mods and new ones and closing old entries / opening new ones in `data.stadium_modifications`

### Time Map

* Using the Chronicler v2 API for `versions?type=sim`, store the first timestamp where we perceive each season/day/phase combination into `data.time_map`
* Includes an ugly Coffee Cup hack for TGB's bad season value during the Cup

## Game Event Data

This is the true heart of the Datablase that uses Cauldron to parse actual game data

### Initial Work

* Get all known games from the `data.games` table
* Get all days stored in the `data.game_events` table
* Use the two to find all games we need to process
  * But ignore stuff before S1 D97
  * And ignore a few days that are known to be busted
    * S3 D71-72 (waveback in Season 4)
    * S9 D101
    * S10 D108

### Batch Load Missing Games

This portion exists to perform a full DB repopulation in a faster way when we know we're processing tons of data. It uses `COPY` to just cram binary data into the DB tables, so this code needs to always precisely match the DB table schema or Bad Things will happen.

* 10 `Tasks` are created that run in parallel, each processing data from a given game day
* Game updates for a day are fetched from Chronicler's v1 `games/updates` endpoint
* Each update is processed through [Cauldron.Processor](#cauldron)
* Once all 10 days are done
  * Game Event data is inserted in `data.game_events` via `COPY`.
  * Game Event baserunner data is inserted in `data.game_event_base_runners` via `COPY`.
  * Outcome data is inserted in `data.outcomes` via `COPY`.
  * Mapping of Chronicler hashes to game events is added to `data.chronicler_hash_game_event` via `COPY`.
  * Pitching results are updated in the `data.games` table.
* This process is repeated until all missing games have been processed.

### Incremental Update Games

This portion exists to do the per-minute gradual updating of games as play goes on. On a DB rebuild, most entries will be handled in the [batch](#batch-load-missing-games) case above, but any new entries since the batch load started will then be handled here.

* Chronicler's v1 `games/updates` endpoint is used to get all game updates since the last time we recorded in `data.chronicler_meta`.
* Updates are sent to [Cauldron](#cauldron) one at a time.
  * When a full Game Event (basically a complete at-bat) is ready, Cauldron fires an event and Prophesizer adds that event to `data.game_events`
  * When a game is complete, Cauldron fires an event and Prophesizer adds the pitching results to `data.games`
* The `data.chronicler_meta` table is updated with the last request time so that the next poll can ask for new data only.

### DB Patches

* Patch files from the `patch` directory are MD5-hashed and compared to entries in the `data.applied_patches` table
* If a patch file is present that is not applied, the SQL code in that file will be run. This is used for manually cleanup and patching of Weird Cases like Thomas England / Sixpack Dogwalker
* Once a patch is applied, it's added to `applied_patches` and shouldn't be applied again unless it changes.

### Refresh Matviews

At this point Prophesizer will refresh the materialized views in the DB if necessary.

* If it's been at last one game day since the last refresh, or we've entered the Election phase since the last refresh:
  * Check how many games are happening today (via `data.games`), and how many are finished (via `data.game_events`)
  * If all games for today are finished, or there are zero games but the season has changed, or its the Election phase:
    * Use some SQL trickery to see if the matviews are already populated
    * If so, call `data.refresh_materialized_views_concurrently()`
    * If now, call `data.refresh_materialized_views()` which must be done at least once initially

# Cauldron

At various points, Prophesizer creates a `Cauldron.Processor` object and send updates into it over time by calling `ProcessGameObject`.

Internally `Processor` has a map of `GameEventParser`s, one for each game it knows about.

## GameEventParser

This is the Main Thing in Cauldron that does all the conversion of individual **game updates** (from Blaseball) into **Game Events** (our SIBR format).

Incoming game updates are deserialized from JSON into C# objects and go through a big state machine:

* Duplicate updates (based on their Chronicler hash) are discarded
* A mapping of player IDs to names is updated based on the new batter & pitcher in the update - this may not be needed any more?
* The `playCount` value is used to fix data misordering problems (which occur when Chronicler ingests from multiple sources)
  * If the `playCount` jumps by more than 1, the update is placed in a queue for later processing
  * If we queue up 5 updates without finding the "next" one we're waiting for, we give up and just process the queue
  * If we find the next update in time, we process it, and then work on the queued updates

At all times Cauldron is working on building a Game Event by adding more and more stuff to it, until the time that the event is complete and is emitted. This start with the Inning State Machine.

## Inning State Machine

In `CheckInningState`, based on the current update and last update, determine what the current inning state is:
* GameStart ("Play Ball!")
* HalfInningStart ("Top of"/"Bottom of")
* BatterMessage ("batting for the")
* ValidBatter (a non-null batter ID is seen)
* PlayEnded (batter ID went to null from non-null)
* OutingMessage ("is now an Outing")
* GameOver (gameComplete is true)

If we got an unexpected weird transition, set an error flag but still try to get into the right state now

## Data Gap Handling

If the inning state machine found an error - something weird happening that probably means a data gap, try to fix it:
* Fill in any outs we missed by closing the current event as an `UNKNOWN_OUT` and adding more dummy `UNKNOWN_OUT`s if necessary.

## Game Event Logic

For each update, the following happens in order:

* Fill in the batter ID, pitcher ID, as well as the current "owning pitcher" for both home and away (used to determine winning pitchers)
* `UpdateSpecialNonsense` handles weird cases like shelled batters, black hole and Sun 2 procs, Elsewhere batters, Tunnels procs, etc by just emitting those special events.
* `UpdateBallsAndStrikes` handles updating the ball and strike counts
  * Notably when a batter strikes out, we never get an update with 3 strikes - the strikes reset to 0, the batter goes null, and the outs increment (unless the half-inning is over, but more on that later)
  * This function also sets the ball/strike count for cases like Charm walks, intentional walks, Mind Trick strikeouts, hit by pitch, mild pitches
  * This function also updates the pitch list, including attempting to fill in missed balls & strikes
* `UpdateOuts` handles tracking outs on a play
  * Notably when the 3rd out of a half-inning happens, we never see 3 outs in an update, and have to infer this case from the fact that the `inning` or `topOfInning` changed.
  * This function also sets the `eventType` correctly for the kind of out that occurred.
* `UpdateHits` handles setting data about any hit that happened on the play
  * This includes updating `basesHit`, `eventType`, `battedBallType`, `batterBaseAfterPlay`, and the `eventType`
* `UpdateFielding` updates fielding-related flags on the event
  * This includes `isSacrificeFly`, `isSacrificeHit`, `isDoublePlay`, `isTriplePlay`, and `eventType`
  * This also includes detecting Caught Stealing events
* `UpdateBaserunning` updates baserunner information on the event
  * Blaseball only sends a snapshot of who is on base *right now*, so to produce the complex data we want in the DB we have to track the runner state very precisely.
  * This function does a lot of logic to set all the appropriate fields to handle:
    * Secret Base procs
    * Steal / Caught Stealing cases
    * Setting the `baseBeforePlay`, `baseAfterPlay`, `runsScored` correctly for all runners known in the old and new states
    * Setting the responsible pitcher for each runner, for winning pitcher logic
* `UpdateScoreChanges` handles winning pitcher logic
  * If the lead changed from the previous update:
    * If a runner scored, set the "owning pitcher" for the lead to the responsible pitcher for that runner
    * If a runner didn't score for the new leading team (the lead changed via Triple Threat, Polarity- or some other mechanic), we just blame the current pitcher for the loser because there's no other easy person to blame
* `UpdateOutcomes` handles setting Outcomes on the game event. These are **not** limited to just the `outcomes` field seen when a game ends - we parse and tag far more Outcomes than just these.
  * The `simple-outcomes.cfg` file in Cauldron consists of regexes used to produce Outcomes.
  * Each line of the file is a string followed by a `|` and a regex, like:
  * > `HIT_BY_PITCH_UNSTABLE|hits .+ with a pitch!.+ is now Unstable!`
  * This means the pipe character can't be used in the regexes, I know. If it's a problem, go change the delimiter :D
  * The first line of `simple-outcomes.cfg` is a version number.
  * Whenever Cauldron processes a game update it direclty grabs the `simple-outcomes.cfg` from the main (`future-perfect`) branch of the Prophesizer repo and uses that file if the version number is greater than the local file. This lets us theoretically add Outcomes directly during the season without having to redeploy Prophesizer every time.
  * But it is kind of hacky
* Original text of the update is added to the event for reference
* If we've concluded that this event is "done", emit it!
  * This is a huge conditional that includes outs, steals, walks, hits, various weird effect procs, etc
* Emitting the event includes pre-populating the next event for cases where the at-bat continues
* We also do some error checking and flagging for weird data gap cases like null player IDs or events that could not be categorized for some reason.
* If the game is now complete, emit that event with the winning and losing pitchers
