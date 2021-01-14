--Add 'tournament' to players, player_modifications, team_roster
--So the tourney/non-tourney timelines can be kept separate for views/functions

ALTER TABLE data.players ADD COLUMN IF NOT EXISTS tournament INTEGER default -1;
ALTER TABLE data.player_modifications ADD COLUMN IF NOT EXISTS tournament INTEGER default -1;
ALTER TABLE data.team_roster ADD COLUMN IF NOT EXISTS tournament INTEGER default -1;