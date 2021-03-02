

ALTER TABLE data.game_events
	ALTER COLUMN home_strike_count TYPE integer,
	ALTER COLUMN home_strike_count SET DEFAULT 3,
	ALTER COLUMN away_strike_count TYPE integer,
	ALTER COLUMN away_strike_count SET DEFAULT 3;