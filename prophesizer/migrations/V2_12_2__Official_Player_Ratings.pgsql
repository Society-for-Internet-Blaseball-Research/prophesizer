
-- Start tracking the TGB-provided ratings
ALTER TABLE data.players
	ADD COLUMN batting_rating numeric,
	ADD COLUMN pitching_rating numeric,
	ADD COLUMN baserunning_rating numeric,
	ADD COLUMN defense_rating numeric;
