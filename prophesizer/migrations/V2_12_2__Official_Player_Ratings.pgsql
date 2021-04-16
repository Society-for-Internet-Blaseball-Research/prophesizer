
-- Start tracking the TGB-provided ratings
ALTER TABLE data.players
	ADD COLUMN batting_rating numeric DEFAULT -1,
	ADD COLUMN pitching_rating numeric DEFAULT -1,
	ADD COLUMN baserunning_rating numeric DEFAULT -1,
	ADD COLUMN defense_rating numeric DEFAULT -1;
