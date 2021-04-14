

ALTER TABLE data.chronicler_meta
ADD COLUMN division_timestamp timestamp without time zone,
ADD COLUMN stadium_timestamp timestamp without time zone,
ALTER COLUMN player_timestamp TYPE timestamp without time zone;

CREATE TABLE data.leagues (
	league_db_id SERIAL,
	league_id character varying(36),
	league_name character varying,
	valid_from timestamp without time zone,
	valid_until timestamp without time zone
);

CREATE TABLE data.subleagues (
	subleague_db_id SERIAL,
	league_id character varying(36),
	subleague_id character varying(36),
	subleague_name character varying,
	valid_from timestamp without time zone,
	valid_until timestamp without time zone
);

CREATE TABLE data.divisions (
	division_db_id SERIAL,
	division_id character varying(36),
	division_name character varying,
	league_id character varying(36),
	subleague_id character varying(36),
	valid_from timestamp without time zone,
	valid_until timestamp without time zone
);

CREATE TABLE data.division_teams (
	division_teams_id SERIAL,
	league_id character varying(36),
	subleague_id character varying(36),
	division_id character varying(36),
	team_id character varying,
	valid_From timestamp without time zone,
	valid_until timestamp without time zone
);
