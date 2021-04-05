drop table if exists data.stadiums;
drop table if exists data.stadium_modifications;

--
-- Name: stadiums; Type: TABLE; Schema: data; Owner: -
--
CREATE TABLE data.stadiums (
	id SERIAL,
	stadium_id VARCHAR(36) NOT NULL,
	hype INTEGER NULL DEFAULT NULL,
	name TEXT NULL DEFAULT NULL,
	birds INTEGER NULL DEFAULT NULL,
	model INTEGER NULL DEFAULT NULL,
	team_id VARCHAR(36) NOT NULL,
	nickname TEXT NULL DEFAULT NULL,
	main_color VARCHAR(10) NULL,
	secondary_color VARCHAR(10) NULL,
	tertiary_color VARCHAR(10) NULL,
	mysticism NUMERIC NULL DEFAULT NULL,
	viscosity NUMERIC NULL DEFAULT NULL,
	elongation NUMERIC NULL DEFAULT NULL,
	filthiness NUMERIC NULL DEFAULT NULL,
	obtuseness NUMERIC NULL DEFAULT NULL,
	forwardness NUMERIC NULL DEFAULT NULL,
	grandiosity NUMERIC NULL DEFAULT NULL,
	ominousness NUMERIC NULL DEFAULT NULL,
	fortification NUMERIC NULL DEFAULT NULL,
	inconvenience NUMERIC NULL DEFAULT NULL,
	luxuriousness NUMERIC NULL DEFAULT NULL,
	valid_from TIMESTAMP NULL DEFAULT NULL,
	valid_until TIMESTAMP NULL DEFAULT NULL
);

--
-- Name: stadium_modifications; Type: TABLE; Schema: data; Owner: -
--
CREATE TABLE data.stadium_modifications (
	id SERIAL,
	stadium_id VARCHAR(36) NOT NULL,
	modification VARCHAR NULL,
	level INTEGER NULL,
	valid_from TIMESTAMP NULL,
	valid_until TIMESTAMP NULL
);