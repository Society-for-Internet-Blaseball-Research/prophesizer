# Prophesizer

Part of the SIBR Archiving Pipeline™

## What

Prophesizer runs continuously, waking every 5 minutes to check the clock. When it wakes in the :45-:50 window of an hour, it does the following:

1) Get the latest data from the Blaseball `/games` endpoint and store it in the `games` table
2) Query S3 for all available log files
3) Check these against the database (`imported_logs` table) to see which are new
4) Process the log files in two big batches: "hourly" logs and "update" logs:

### Hourly logs

These are archives of all the standard public endpoints taken multiple times per hour (naming, eh).
Prophesizer cares about the `players` and `teams` structures only at this point, and does the following:

1) Add entries to `teams` for any team data changes (like name changes)
2) Add entries to `team_roster` to reflect any lineup/rotation/etc changes
3) Add entries to `team_modifications` to reflect any new "tags" (like the blood bath tags) for a team
4) Add entries to `players` for any player data changes (names, attributes)
5) Add entries to `player_modifications` for any new "tags" (like SHELLED) for a player

### Update logs

These are logs of the individual (one every ~4seconds) `streamData` updates for gameplay.
Prophesizer sends these through [Cauldron](https://github.com/Society-for-Internet-Blaseball-Research/Cauldron) to convert them into SIBR's "Game Event" format.
Game Events roughly correspond to one at-bat (with some exceptions like a runner caught stealing) and are more easily queried than the raw JSON updates from the stream.
These Game Events are added to the `game_events` table, with child tables `game_event_base_runners` for baserunning information and `outcomes` for Outcome (incineration, peanuts, partying, etc).

## Running Prophesizer Locally

Vague and ancient instructions from Discord pin:

1) install postgres (or have access to an install, I guess)
2) get the prophesizer repo and Visual Studio / VS Code / another way to build .csproj files, as well as .NET Core
3) Set a `PSQL_CONNECTION_STRING` environment variable in the format required by ngpsql (aka a c# connection string) - it'll be something akin to `Host=localhost;username=postgres;password=<whatever>;database=blaseball`
4) Get an aws key and secret and set them to `AWS_KEY` and `AWS_SECRET` respectively

To set up the DB schema, run `node schema.js load` to load the schema from schema.sql.
To commit changes to the schema, run `node schema.js dump` to dump the schema to schema.sql
