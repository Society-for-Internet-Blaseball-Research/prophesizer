
-- initial player items table
CREATE TABLE data.player_items(
	id SERIAL,
	player_id VARCHAR(36) NOT NULL,
	item_id VARCHAR(36) NOT NULL,
	name TEXT NULL DEFAULT NULL,
	health INTEGER NULL DEFAULT NULL,
	durability INTEGER NULL DEFAULT NULL,
	defense_rating NUMERIC NULL DEFAULT NULL,
	hitting_rating NUMERIC NULL DEFAULT NULL,
	pitching_rating NUMERIC NULL DEFAULT NULL,
	baserunning_rating NUMERIC NULL DEFAULT NULL,
	forger_name TEXT NULL DEFAULT NULL,
	valid_from TIMESTAMP NULL DEFAULT NULL,
	valid_until TIMESTAMP NULL DEFAULT NULL
);

