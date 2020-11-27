# Prophesizer

Prophesizer is part of the SIBR Archiving Pipeline™.

## Table of Contents
  * [What](#what)
    * [Non-Update Data](#non-update-data)
    * [Update Data](#update-data)
  * [Installation](#installation)


## What

Prophesizer runs continuously, waking every minute to ask Chronicler (https://github.com/xSke/Chronicler) for new data.
It does the following:

1) Get the latest data from the Blaseball `/games` endpoint and store it in the `games` table
2) Check the DB's `chronicler_meta` table to see what the last day/time processed was
3) Check Blaseball's `/simulationData` endpoint to see what the current season/day is
4) Batch-process any updates for days up to the current day
5) Incrementally ask Chronicler for updates from the current day

Typically on first run Prophesizer will batch-process many seasons of data into the DB, and only grab a minute's worth of updates every minute after that.

### Non-Update Data

Prophesizer also asks Chronicler for updates to `players` and `teams`:

1) Add entries to `teams` for any team data changes (like name changes)
2) Add entries to `team_roster` to reflect any lineup/rotation/etc changes
3) Add entries to `team_modifications` to reflect any new "tags" (like the blood bath tags) for a team
4) Add entries to `players` for any player data changes (names, attributes)
5) Add entries to `player_modifications` for any new "tags" (like SHELLED) for a player

### Update data

These are logs of the individual (one every ~4seconds) `streamData` updates for gameplay.

Prophesizer sends these through [Cauldron](https://github.com/Society-for-Internet-Blaseball-Research/Cauldron) to convert them into SIBR's "Game Event" format.

Game Events roughly correspond to one at-bat (with some exceptions like a runner caught stealing) and are more easily queried for statistics than the raw JSON updates from the stream.

These Game Events are added to the `game_events` table, with child tables `game_event_base_runners` for baserunning information and `outcomes` for Outcome (incineration, peanuts, partying, etc).

## Installation

The following instructions are written for Windows PCs.

1. Prophesizer depends on [git](https://git-scm.com/), [PostgreSQL](https://www.postgresql.org/), [Visual Studio Code](https://code.visualstudio.com/), and [Node.js](https://nodejs.org/en/). You can manually download and install all of these, but if you have the package manager [Chocolatey](https://chocolatey.org/) installed, you can automatically install these tools by opening a prompt (cmd/powershell) as administrator and running: `choco install git postgresql vscode nodejs`
2. Use git to clone Prophesizer from github into your desired directory: `git clone https://github.com/Society-for-Internet-Blaseball-Research/prophesizer/`. 
3. Set the environment var PSQL_CONNECTION_STRING to "Host=localhost;username=[postgres username, default 'postgres'];password=[postgres password];database=blaseball", with `setx`, making appropriate changes if any are necessary.
4. Set the environment var EVOLVE_CONNECTION_STRING to "Server=localhost;User Id=[postgres username, default 'postgres'];Password=[postgres password];Database=blaseball" with `setx`, making appropriate changes if any are necessary.
5. Make sure psql is added to PATH (you can test by typing it in as a command), and your C# connection string environment variable is correctly set.
6. Using pgAdmin or `psql`, create a database named `blaseball`.
7. Compile and run Prophesizer from VS Code via File -> Open Folder, selecting Prophesizer's folder, going to 'Run' in the menu bar, and selecting "Run Without Debugging". As part of the build process, you should see Evolve perform a migration on your database.

## Changing the DB Schema

Prophesizer is now using the [Evolve](https://evolve-db.netlify.app/) package to manage database schema migrations.

All modification of the DB schema happens via `.pgsql` files in the `migrations` folder.
These come in two varieties:

### Versioned Migration Files

- Versioned migrations start with a V, such as `V_2_8_1__Unaccent.pgsql`.
- The filename denotes the version number (2.8.1), then (after a `__` separator) a description of the schema change.
- Currently the DB schema version is being kept in sync with the Prophesizer version (though not every Prophesizer change involves a schema change).
- Versioned migrations are applied in version order and must be used when *tables* change.
- The SQL code in the file must alter the tables in such a way that data is not lost, so that DB schema migrations can happen without having to completely drop the DB.

### Repeatable Migration Files

- Repeatable migrations start with an R, such as `R__4_Create_Views.pgsql`. The filename only contains a description (after the `__` separator).
- They are applied in alphabetical order - Prophesizer numbers the descriptions to enforce the correct dependencies.
- Repeatable migrations are useful for elements of the database that can simply be dropped and re-created, such as Functions, Procedures, and Views.
- Prophesizer also uses a repeatable migration for the `taxa` schema which consists only of taxonomy data that always comes from these files.

### Disallowed Syntax

Evolve doesn't support the following PostgreSQL commands in migrations:
- CREATE INDEX CONCURRENTLY
- CREATE/DROP DATABASE
- COPY FROM STDIN
- VACUUM

## Deploy Steps for sibr.dev

At the moment only @lilserf has the permissions to do this process, but it should be documented for the future.

1. Stop the Prophesizer container via Portainer (Stacks -> datablase -> datablase_prophesizer_1 -> Stop)
2. Deploy DB if necessary (TODO: get that deploy script committed somewhere useful)
3. Update the Datablase stack to the new Prophesizer version (Stacks -> Editor -> change the version number, Update Stack)

