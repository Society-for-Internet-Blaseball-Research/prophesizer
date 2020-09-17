--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 12.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY data.outcomes DROP CONSTRAINT IF EXISTS player_events_game_event_id_fkey;
ALTER TABLE IF EXISTS ONLY data.game_events DROP CONSTRAINT IF EXISTS game_events_game_id_fkey;
ALTER TABLE IF EXISTS ONLY data.game_event_base_runners DROP CONSTRAINT IF EXISTS game_event_base_runners_game_event_id_fkey;
DROP INDEX IF EXISTS data.team_roster_idx;
ALTER TABLE IF EXISTS ONLY taxa.event_types DROP CONSTRAINT IF EXISTS event_types_pkey;
ALTER TABLE IF EXISTS ONLY taxa.attributes DROP CONSTRAINT IF EXISTS attributes_pkey;
ALTER TABLE IF EXISTS ONLY data.time_map DROP CONSTRAINT IF EXISTS time_map_pkey;
ALTER TABLE IF EXISTS ONLY data.teams DROP CONSTRAINT IF EXISTS teams_pkey;
ALTER TABLE IF EXISTS ONLY data.team_roster DROP CONSTRAINT IF EXISTS team_roster_pkey;
ALTER TABLE IF EXISTS ONLY data.team_modifications DROP CONSTRAINT IF EXISTS team_modifications_pkey;
ALTER TABLE IF EXISTS ONLY data.time_map DROP CONSTRAINT IF EXISTS season_day_unique;
ALTER TABLE IF EXISTS ONLY data.players DROP CONSTRAINT IF EXISTS players_pkey;
ALTER TABLE IF EXISTS ONLY data.player_modifications DROP CONSTRAINT IF EXISTS player_modifications_pkey;
ALTER TABLE IF EXISTS ONLY data.outcomes DROP CONSTRAINT IF EXISTS player_events_pkey;
ALTER TABLE IF EXISTS ONLY data.imported_logs DROP CONSTRAINT IF EXISTS imported_logs_pkey;
ALTER TABLE IF EXISTS ONLY data.games DROP CONSTRAINT IF EXISTS game_pkey;
ALTER TABLE IF EXISTS ONLY data.game_events DROP CONSTRAINT IF EXISTS game_events_pkey;
ALTER TABLE IF EXISTS ONLY data.game_event_base_runners DROP CONSTRAINT IF EXISTS game_event_base_runners_pkey;
ALTER TABLE IF EXISTS taxa.vibe_to_arrows ALTER COLUMN vibe_to_arrow_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.team_divine_favor ALTER COLUMN team_divine_favor_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.player_url_slugs ALTER COLUMN player_url_slug_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.leagues ALTER COLUMN league_db_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.event_types ALTER COLUMN event_type_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.divisions ALTER COLUMN division_db_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.division_teams ALTER COLUMN division_teams_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.change_types ALTER COLUMN change_type_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.attributes ALTER COLUMN attribute_id DROP DEFAULT;
ALTER TABLE IF EXISTS data.time_map ALTER COLUMN time_map_id DROP DEFAULT;
ALTER TABLE IF EXISTS data.teams ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS data.team_roster ALTER COLUMN team_roster_id DROP DEFAULT;
ALTER TABLE IF EXISTS data.team_modifications ALTER COLUMN team_modifications_id DROP DEFAULT;
ALTER TABLE IF EXISTS data.players ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS data.player_modifications ALTER COLUMN player_modifications_id DROP DEFAULT;
ALTER TABLE IF EXISTS data.outcomes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS data.imported_logs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS data.game_events ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS data.game_event_base_runners ALTER COLUMN id DROP DEFAULT;
DROP TABLE IF EXISTS taxa.weather;
DROP SEQUENCE IF EXISTS taxa.vibe_to_arrows_vibe_to_arrow_id_seq;
DROP TABLE IF EXISTS taxa.vibe_to_arrows;
DROP SEQUENCE IF EXISTS taxa.team_divine_favor_team_divine_favor_id_seq;
DROP TABLE IF EXISTS taxa.team_divine_favor;
DROP SEQUENCE IF EXISTS taxa.player_url_slugs_player_url_slug_id_seq;
DROP SEQUENCE IF EXISTS taxa.leagues_league_id_seq;
DROP SEQUENCE IF EXISTS taxa.event_types_event_type_id_seq;
DROP SEQUENCE IF EXISTS taxa.divisions_division_id_seq;
DROP SEQUENCE IF EXISTS taxa.division_teams_division_teams_id_seq;
DROP TABLE IF EXISTS taxa.changes;
DROP SEQUENCE IF EXISTS taxa.change_types_change_type_id_seq;
DROP TABLE IF EXISTS taxa.change_types;
DROP TABLE IF EXISTS taxa.blessings;
DROP SEQUENCE IF EXISTS taxa.attributes_attribute_id_seq;
DROP TABLE IF EXISTS taxa.attributes;
DROP SEQUENCE IF EXISTS data.time_map_time_map_id_seq;
DROP TABLE IF EXISTS data.time_map;
DROP SEQUENCE IF EXISTS data.teams_id_seq;
DROP SEQUENCE IF EXISTS data.team_positions_team_position_id_seq;
DROP SEQUENCE IF EXISTS data.team_modifications_team_modifications_id_seq;
DROP TABLE IF EXISTS data.team_modifications;
DROP VIEW IF EXISTS data.stars_team_all_current;
DROP VIEW IF EXISTS data.season_leaders_outs_defended;
DROP VIEW IF EXISTS data.running_stats_player_playoffs_career;
DROP VIEW IF EXISTS data.running_stats_player_playoffs_by_season_team;
DROP VIEW IF EXISTS data.running_stats_player_playoffs_by_season_combined_teams;
DROP VIEW IF EXISTS data.running_stats_player_career;
DROP VIEW IF EXISTS data.running_stats_player_by_season_team;
DROP VIEW IF EXISTS data.rosters_extended_current;
DROP VIEW IF EXISTS data.rosters_current;
DROP VIEW IF EXISTS data.players_info_expanded_all;
DROP SEQUENCE IF EXISTS data.players_id_seq;
DROP VIEW IF EXISTS data.players_extended_current;
DROP VIEW IF EXISTS data.players_attributes_expanded_all;
DROP SEQUENCE IF EXISTS data.player_modifications_player_modifications_id_seq;
DROP TABLE IF EXISTS data.player_modifications;
DROP SEQUENCE IF EXISTS data.player_events_id_seq;
DROP VIEW IF EXISTS data.pitching_stats_player_playoffs_career;
DROP VIEW IF EXISTS data.pitching_stats_player_playoffs_by_season;
DROP VIEW IF EXISTS data.pitching_stats_player_career;
DROP VIEW IF EXISTS data.pitching_stats_player_by_season;
DROP TABLE IF EXISTS data.outcomes;
DROP SEQUENCE IF EXISTS data.imported_logs_id_seq;
DROP TABLE IF EXISTS data.imported_logs;
DROP SEQUENCE IF EXISTS data.game_events_id_seq;
DROP SEQUENCE IF EXISTS data.game_event_base_runners_id_seq;
DROP VIEW IF EXISTS data.batting_stats_player_vs_pitcher_season;
DROP VIEW IF EXISTS data.batting_stats_player_vs_pitcher_playoffs_season;
DROP VIEW IF EXISTS data.batting_stats_player_vs_pitcher_playoffs_lifetime;
DROP VIEW IF EXISTS data.batting_stats_player_vs_pitcher_lifetime;
DROP VIEW IF EXISTS data.players_current;
DROP TABLE IF EXISTS taxa.position_types;
DROP TABLE IF EXISTS taxa.player_url_slugs;
DROP TABLE IF EXISTS taxa.coffee;
DROP TABLE IF EXISTS taxa.blood;
DROP VIEW IF EXISTS data.teams_current;
DROP TABLE IF EXISTS taxa.leagues;
DROP TABLE IF EXISTS taxa.divisions;
DROP TABLE IF EXISTS taxa.division_teams;
DROP TABLE IF EXISTS data.teams;
DROP TABLE IF EXISTS data.team_roster;
DROP TABLE IF EXISTS data.players;
DROP VIEW IF EXISTS data.batting_stats_all_events;
DROP TABLE IF EXISTS taxa.event_types;
DROP TABLE IF EXISTS data.games;
DROP TABLE IF EXISTS data.game_events;
DROP TABLE IF EXISTS data.game_event_base_runners;
DROP PROCEDURE IF EXISTS data.wipe_hourly();
DROP PROCEDURE IF EXISTS data.wipe_events();
DROP PROCEDURE IF EXISTS data.wipe_all();
DROP FUNCTION IF EXISTS data.teams_from_timestamp(in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.slugging(in_total_bases_from_hits bigint, in_at_bats bigint);
DROP FUNCTION IF EXISTS data.season_timespan(in_season integer);
DROP FUNCTION IF EXISTS data.round_half_even(val numeric, prec integer);
DROP FUNCTION IF EXISTS data.rosters_from_timestamp(in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.rating_to_star(in_rating numeric);
DROP FUNCTION IF EXISTS data.players_from_timestamp(in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.player_day_vibe(in_player_id character varying, in_gameday integer, in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.pitching_rating(in_player_id character varying, in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.pitcher_idol_coins(in_player_id character varying, in_season integer);
DROP FUNCTION IF EXISTS data.on_base_percentage(in_hits bigint, in_raw_at_bats bigint, in_walks bigint, in_sacs bigint);
DROP FUNCTION IF EXISTS data.last_position_in_string(in_string text, in_search text);
DROP FUNCTION IF EXISTS data.innings_from_outs(in_outs numeric);
DROP FUNCTION IF EXISTS data.gameday_from_timestamp(in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.earned_run_average(in_runs numeric, in_outs numeric);
DROP FUNCTION IF EXISTS data.defense_rating(in_player_id character varying, in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.current_season();
DROP FUNCTION IF EXISTS data.current_gameday();
DROP FUNCTION IF EXISTS data.batting_rating(in_player_id character varying, in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.batting_average(in_hits bigint, in_raw_at_bats bigint);
DROP FUNCTION IF EXISTS data.batter_idol_coins(in_player_id character varying, in_season integer);
DROP FUNCTION IF EXISTS data.baserunning_rating(in_player_id character varying, in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.bankers_round(in_val numeric, in_prec integer);
DROP SCHEMA IF EXISTS taxa;
DROP SCHEMA IF EXISTS data;
--
-- Name: data; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA data;


--
-- Name: SCHEMA data; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA data IS 'standard data schema';


--
-- Name: taxa; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA taxa;


--
-- Name: bankers_round(numeric, integer); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.bankers_round(in_val numeric, in_prec integer) RETURNS numeric
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$

declare

    retval numeric;

    difference numeric;

    even boolean;

begin

    retval := round(in_val,in_prec);

    difference := retval-in_val;

    if abs(difference)*(10::numeric^in_prec) = 0.5::numeric then

        even := (retval * (10::numeric^in_prec)) % 2::numeric = 0::numeric;

        if not even then

            retval := round(val-difference,in_prec);

        end if;

    end if;

    return retval;

end;

$$;


--
-- Name: baserunning_rating(character varying, timestamp without time zone); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.baserunning_rating(in_player_id character varying, in_timestamp timestamp without time zone DEFAULT (now())::timestamp without time zone) RETURNS numeric
    LANGUAGE sql
    AS $$
SELECT 
	power(p.laserlikeness,0.5) *
   	power(p.continuation * p.base_thirst * p.indulgence * p.ground_friction, 0.1)
FROM data.players_from_timestamp(in_timestamp) p

WHERE p.player_id = in_player_id
$$;


--
-- Name: batter_idol_coins(character varying, integer); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.batter_idol_coins(in_player_id character varying, in_season integer DEFAULT '-1'::integer) RETURNS bigint
    LANGUAGE sql
    AS $$

SELECT 

SUM

(

	CASE

	  WHEN ge.event_type IN ('SINGLE','DOUBLE','TRIPLE') THEN 200

	  WHEN ge.event_type = 'HOME_RUN' THEN 1200

	  ELSE 0

	END 

) AS coins

FROM data.game_events ge

WHERE ge.season = 

CASE

  when in_season = -1 then (SELECT data.current_season())

  else in_season

END

AND ge.batter_id = in_player_id;

$$;


--
-- Name: batting_average(bigint, bigint); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.batting_average(in_hits bigint, in_raw_at_bats bigint) RETURNS numeric
    LANGUAGE sql
    AS $$
SELECT (in_hits::numeric/ in_raw_at_bats::numeric)::numeric(10,3)
$$;


--
-- Name: batting_rating(character varying, timestamp without time zone); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.batting_rating(in_player_id character varying, in_timestamp timestamp without time zone DEFAULT (now())::timestamp without time zone) RETURNS numeric
    LANGUAGE sql
    AS $$
SELECT 
   power((1 - p.tragicness),0.01) * 
   power((1 - p.patheticism),0.05) *
   power((p.thwackability * p.divinity),0.35) *
   power((p.moxie * p.musclitude),0.075) * 
   power(p.martyrdom,0.02)
FROM data.players_from_timestamp(in_timestamp) p
WHERE player_id = in_player_id;
$$;


--
-- Name: current_gameday(); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.current_gameday() RETURNS integer
    LANGUAGE sql
    AS $$

SELECT max(day) FROM data.game_events WHERE

season = (SELECT data.current_season());

$$;


--
-- Name: current_season(); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.current_season() RETURNS integer
    LANGUAGE sql
    AS $$

SELECT max(season) from data.games;

$$;


--
-- Name: defense_rating(character varying, timestamp without time zone); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.defense_rating(in_player_id character varying, in_timestamp timestamp without time zone DEFAULT (now())::timestamp without time zone) RETURNS numeric
    LANGUAGE sql
    AS $$
SELECT 
	power((p.omniscience * p.tenaciousness),0.2) *
   	power((p.watchfulness * p.anticapitalism * p.chasiness),0.1)
FROM data.players_from_timestamp(in_timestamp) p
WHERE p.player_id = in_player_id;
$$;


--
-- Name: earned_run_average(numeric, numeric); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.earned_run_average(in_runs numeric, in_outs numeric) RETURNS numeric
    LANGUAGE sql
    AS $$

SELECT round(9*(in_runs/((in_outs::DECIMAL)/3)::DECIMAL) ,2)

$$;


--
-- Name: gameday_from_timestamp(timestamp without time zone); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.gameday_from_timestamp(in_timestamp timestamp without time zone) RETURNS TABLE(season integer, gameday integer)
    LANGUAGE sql
    AS $$
SELECT

(
	SELECT COALESCE
	(
  		(
  			SELECT day FROM data.time_map WHERE first_time = 
			(
				SELECT max(first_time)
				FROM data.time_map 
				WHERE first_time < in_timestamp
			)	
		)
	,0)
),
(
	SELECT COALESCE
	(
  		(
  			SELECT season FROM data.time_map WHERE first_time = 
			(
				SELECT max(first_time)
				FROM data.time_map 
				WHERE first_time < in_timestamp
			)	
		)
	,0)
);
$$;


--
-- Name: innings_from_outs(numeric); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.innings_from_outs(in_outs numeric) RETURNS numeric
    LANGUAGE sql
    AS $$

select ((round(in_outs/3,0))::TEXT || '.' ||  (mod(in_outs,3))::text)::numeric

$$;


--
-- Name: last_position_in_string(text, text); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.last_position_in_string(in_string text, in_search text) RETURNS integer
    LANGUAGE sql
    AS $$

Select length(in_string) - 

position(reverse(in_search) in reverse(in_string)) - length(in_search);

$$;


--
-- Name: on_base_percentage(bigint, bigint, bigint, bigint); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.on_base_percentage(in_hits bigint, in_raw_at_bats bigint, in_walks bigint, in_sacs bigint DEFAULT 0) RETURNS numeric
    LANGUAGE sql
    AS $$

SELECT ((in_hits + in_walks)/ (in_raw_at_bats +in_walks + in_sacs)::numeric)::numeric(10,3)

$$;


--
-- Name: pitcher_idol_coins(character varying, integer); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.pitcher_idol_coins(in_player_id character varying, in_season integer DEFAULT '-1'::integer) RETURNS bigint
    LANGUAGE sql
    AS $$

select

(

	SELECT 

	(count(1)) * 200

	FROM data.game_events ge

	WHERE ge.season = 

	CASE

  	  when in_season = -1 then (SELECT data.current_season())

  	  else in_season

	END

	AND ge.event_type = 'STRIKEOUT'

	AND ge.pitcher_id = in_player_id

) 

+

(

	SELECT SUM(shutout) FROM

	(

		SELECT 10000 as shutout

		FROM DATA.game_events ge

		WHERE ge.season = 

		CASE

  		  when in_season = -1 then (SELECT data.current_season())

  		  else in_season

		END

		AND ge.pitcher_id = in_player_id 

		GROUP BY game_id, top_of_inning

		HAVING 

		CASE

		  WHEN top_of_inning THEN MAX(away_score)

		  ELSE MAX(home_score)

		END = 0

		-- Removing all outs check for now, speed issue

		/*

		AND (MAX(inning) +1) * 3 = 

		SUM

		(

		  CASE 

		    WHEN event_type IN ('CAUGHT_STEALING','OUT','STRIKEOUT','FIELDERS_CHOICE')

		    THEN 1

		    ELSE 0

		  END 

		)

		*/

	) s

)

$$;


--
-- Name: pitching_rating(character varying, timestamp without time zone); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.pitching_rating(in_player_id character varying, in_timestamp timestamp without time zone DEFAULT (now())::timestamp without time zone) RETURNS numeric
    LANGUAGE sql
    AS $$
SELECT 
power(p.unthwackability,0.5) * 
power(p.ruthlessness,0.4) *
power(p.overpowerment,0.15) * 
power(p.shakespearianism,0.1) * 
power(p.coldness,0.025)
FROM data.players_from_timestamp(in_timestamp) p
WHERE 
p.player_id = in_player_id;
$$;


--
-- Name: player_day_vibe(character varying, integer, timestamp without time zone); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.player_day_vibe(in_player_id character varying, in_gameday integer DEFAULT 0, in_timestamp timestamp without time zone DEFAULT NULL::timestamp without time zone) RETURNS numeric
    LANGUAGE sql
    AS $$


SELECT 


(0.5 * (p.pressurization + p.cinnamon) * sin(PI() * 


(2 / (6 + round(10 * p.buoyancy)) * in_gameday + .5)) - .5 


* p.pressurization + .5 * p.cinnamon)::numeric


FROM data.players_from_timestamp(in_timestamp) p


WHERE 


p.player_id = in_player_id;

$$;


--
-- Name: players_from_timestamp(timestamp without time zone); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.players_from_timestamp(in_timestamp timestamp without time zone DEFAULT (now())::timestamp without time zone) RETURNS TABLE(id integer, player_id character varying, valid_from timestamp without time zone, valid_until timestamp without time zone, player_name character varying, deceased boolean, hash uuid, anticapitalism numeric, base_thirst numeric, buoyancy numeric, chasiness numeric, coldness numeric, continuation numeric, divinity numeric, ground_friction numeric, indulgence numeric, laserlikeness numeric, martyrdom numeric, moxie numeric, musclitude numeric, omniscience numeric, overpowerment numeric, patheticism numeric, ruthlessness numeric, shakespearianism numeric, suppression numeric, tenaciousness numeric, thwackability numeric, tragicness numeric, unthwackability numeric, watchfulness numeric, pressurization numeric, cinnamon numeric, total_fingers smallint, soul smallint, fate smallint, peanut_allergy boolean, armor text, bat text, ritual text, coffee smallint, blood smallint, url_slug character varying)
    LANGUAGE plpgsql
    AS $$
begin
	return query 
	
	select *
	from data.players p
	where in_timestamp + (INTERVAL '1 millisecond') 
	BETWEEN p.valid_from AND coalesce(p.valid_until,NOW() + (INTERVAL '1 millisecond'));

end;
$$;


--
-- Name: rating_to_star(numeric); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.rating_to_star(in_rating numeric) RETURNS numeric
    LANGUAGE sql
    AS $$


SELECT 0.5 * data.round_half_even((


(in_rating)* 10),0);


$$;


--
-- Name: rosters_from_timestamp(timestamp without time zone); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.rosters_from_timestamp(in_timestamp timestamp without time zone) RETURNS TABLE(team_roster_id integer, team_id character varying, position_id integer, valid_from timestamp without time zone, valid_until timestamp without time zone, player_id character varying, position_type character varying)
    LANGUAGE plpgsql
    AS $$
begin
	return query 
	
	select *
	from data.team_roster r
	where in_timestamp + (INTERVAL '1 millisecond') 
	BETWEEN r.valid_from AND coalesce(r.valid_until,NOW() + (INTERVAL '1 millisecond'));

end;
$$;


--
-- Name: round_half_even(numeric, integer); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.round_half_even(val numeric, prec integer) RETURNS numeric
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
declare

    retval numeric;
    difference numeric;
    even boolean;

begin

    retval := round(val,prec);
    difference := retval-val;

    if abs(difference)*(10::numeric^prec) = 0.5::numeric then

        even := (retval * (10::numeric^prec)) % 2::numeric = 0::numeric;

        if not even then
            retval := round(val-difference,prec);
        end if;
		
    end if;
    return retval;

end;
$$;


--
-- Name: season_timespan(integer); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.season_timespan(in_season integer) RETURNS TABLE(season_start timestamp without time zone, season_end timestamp without time zone)
    LANGUAGE sql
    AS $$
SELECT
(
	SELECT first_time FROM data.time_map WHERE DAY = 0 AND season = in_season
) AS season_start,

COALESCE
(
	(
		SELECT first_time - INTERVAL '1 SECOND' FROM data.time_map WHERE DAY = 0 AND season = 
		(in_season + 1)
	), 
	NOW()::timestamp
) AS season_end
$$;


--
-- Name: slugging(bigint, bigint); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.slugging(in_total_bases_from_hits bigint, in_at_bats bigint) RETURNS numeric
    LANGUAGE sql
    AS $$
SELECT (in_total_bases_from_hits::numeric/in_at_bats::numeric)::numeric(10,3)
$$;


--
-- Name: teams_from_timestamp(timestamp without time zone); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.teams_from_timestamp(in_timestamp timestamp without time zone) RETURNS TABLE(id integer, team_id character varying, location text, nickname text, full_name text, valid_from timestamp without time zone, valid_until timestamp without time zone, hash uuid)
    LANGUAGE plpgsql
    AS $$
begin
	return query 
		select *
		from data.teams t
		where in_timestamp + (INTERVAL '1 millisecond') 
		BETWEEN t.valid_from AND coalesce(t.valid_until,NOW() + (INTERVAL '1 millisecond'));
end;
$$;


--
-- Name: wipe_all(); Type: PROCEDURE; Schema: data; Owner: -
--

CREATE PROCEDURE data.wipe_all()
    LANGUAGE plpgsql
    AS $$begin

call data.wipe_events();

call data.wipe_hourly();

end;$$;


--
-- Name: wipe_events(); Type: PROCEDURE; Schema: data; Owner: -
--

CREATE PROCEDURE data.wipe_events()
    LANGUAGE plpgsql
    AS $$begin

truncate data.game_events cascade;

delete from data.imported_logs where key like 'blaseball-log%';

truncate data.time_map;

end;$$;


--
-- Name: wipe_hourly(); Type: PROCEDURE; Schema: data; Owner: -
--

CREATE PROCEDURE data.wipe_hourly()
    LANGUAGE plpgsql
    AS $$begin
delete from data.imported_logs where key like 'compressed-hourly%';
truncate data.players cascade;
truncate data.teams cascade;
truncate data.games cascade;
truncate data.team_roster cascade;
truncate data.player_modifications cascade;
truncate data.team_modifications cascade;
end;$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: game_event_base_runners; Type: TABLE; Schema: data; Owner: -
--

CREATE TABLE data.game_event_base_runners (
    id integer NOT NULL,
    game_event_id integer,
    runner_id character varying(36),
    responsible_pitcher_id character varying(36),
    base_before_play integer,
    base_after_play integer,
    was_base_stolen boolean,
    was_caught_stealing boolean,
    was_picked_off boolean,
    run_scored boolean DEFAULT false
);


--
-- Name: game_events; Type: TABLE; Schema: data; Owner: -
--

CREATE TABLE data.game_events (
    id integer NOT NULL,
    perceived_at timestamp without time zone,
    game_id character varying(36),
    event_type text,
    event_index integer,
    inning smallint,
    top_of_inning boolean,
    outs_before_play smallint,
    batter_id character varying(36),
    batter_team_id character varying(36),
    pitcher_id character varying(36),
    pitcher_team_id character varying(36),
    home_score numeric,
    away_score numeric,
    home_strike_count smallint,
    away_strike_count smallint,
    batter_count integer,
    pitches character varying(1)[],
    total_strikes smallint,
    total_balls smallint,
    total_fouls smallint,
    is_leadoff boolean,
    is_pinch_hit boolean,
    lineup_position smallint,
    is_last_event_for_plate_appearance boolean,
    bases_hit smallint,
    runs_batted_in smallint,
    is_sacrifice_hit boolean,
    is_sacrifice_fly boolean,
    outs_on_play smallint,
    is_double_play boolean,
    is_triple_play boolean,
    is_wild_pitch boolean,
    batted_ball_type text,
    is_bunt boolean,
    errors_on_play smallint,
    batter_base_after_play smallint,
    is_last_game_event boolean,
    event_text text[],
    additional_context text,
    season integer,
    day integer,
    parsing_error boolean,
    parsing_error_list text[],
    fixed_error boolean,
    fixed_error_list text[]
);


--
-- Name: games; Type: TABLE; Schema: data; Owner: -
--

CREATE TABLE data.games (
    game_id character varying(36) NOT NULL,
    day integer,
    season integer,
    last_game_event integer,
    home_odds numeric,
    away_odds numeric,
    weather integer,
    series_index integer,
    series_length integer,
    is_postseason boolean,
    home_team character varying(36),
    away_team character varying(36),
    home_score integer,
    away_score integer,
    number_of_innings integer,
    ended_on_top_of_inning boolean,
    ended_in_shame boolean,
    terminology_id character varying(36),
    rules_id character varying(36),
    statsheet_id character varying(36)
);


--
-- Name: event_types; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.event_types (
    event_type_id integer NOT NULL,
    event_type text,
    plate_appearance integer,
    at_bat integer,
    hit integer,
    total_bases integer,
    "out" integer
);


--
-- Name: batting_stats_all_events; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_all_events AS
 SELECT ge.batter_team_id,
    ge.batter_id AS player_id,
    ge.pitcher_team_id,
    ge.pitcher_id,
    ge.inning,
        CASE
            WHEN ge.top_of_inning THEN 'home'::text
            ELSE 'away'::text
        END AS ballfield,
    ge.season,
    ge.game_id,
    xe.plate_appearance,
    xe.at_bat,
        CASE
            WHEN (EXISTS ( SELECT 1
               FROM data.game_event_base_runners geb
              WHERE ((ge.id = geb.game_event_id) AND (geb.base_before_play = ANY (ARRAY[2, 3]))))) THEN xe.at_bat
            ELSE 0
        END AS at_bat_risp,
        CASE
            WHEN ((xe.hit = 1) AND (EXISTS ( SELECT 1
               FROM data.game_event_base_runners geb
              WHERE ((ge.id = geb.game_event_id) AND (geb.base_before_play = ANY (ARRAY[2, 3])))))) THEN 1
            ELSE 0
        END AS hits_risp,
    xe.hit,
    xe.total_bases,
    ge.runs_batted_in,
        CASE
            WHEN (ge.event_type = 'SINGLE'::text) THEN 1
            ELSE 0
        END AS single,
        CASE
            WHEN (ge.event_type = 'DOUBLE'::text) THEN 1
            ELSE 0
        END AS double,
        CASE
            WHEN (ge.event_type = 'TRIPLE'::text) THEN 1
            ELSE 0
        END AS triple,
        CASE
            WHEN (ge.event_type = 'HOME_RUN'::text) THEN 1
            ELSE 0
        END AS home_run,
        CASE
            WHEN (ge.event_type = 'WALK'::text) THEN 1
            ELSE 0
        END AS walk,
        CASE
            WHEN (ge.event_type = 'STRIKEOUT'::text) THEN 1
            ELSE 0
        END AS strikeout,
        CASE
            WHEN (ge.event_type = 'SACRIFICE'::text) THEN 1
            ELSE 0
        END AS sacrifice,
        CASE
            WHEN (ge.event_type = 'HIT_BY_PITCH'::text) THEN 1
            ELSE 0
        END AS hbp,
        CASE
            WHEN ((ge.batted_ball_type = 'GROUNDER'::text) AND (ge.event_type = 'OUT'::text)) THEN 1
            ELSE 0
        END AS ground_out,
        CASE
            WHEN ((ge.batted_ball_type = 'FLY'::text) AND (ge.event_type = 'OUT'::text)) THEN 1
            ELSE 0
        END AS flyout,
        CASE
            WHEN ge.is_double_play THEN 1
            ELSE 0
        END AS gidp,
    ga.is_postseason
   FROM ((data.game_events ge
     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
     JOIN data.games ga ON (((ge.game_id)::text = (ga.game_id)::text)))
  WHERE (xe.plate_appearance = 1);


--
-- Name: players; Type: TABLE; Schema: data; Owner: -
--

CREATE TABLE data.players (
    id integer NOT NULL,
    player_id character varying(36),
    valid_from timestamp without time zone,
    valid_until timestamp without time zone,
    player_name character varying,
    deceased boolean,
    hash uuid,
    anticapitalism numeric,
    base_thirst numeric,
    buoyancy numeric,
    chasiness numeric,
    coldness numeric,
    continuation numeric,
    divinity numeric,
    ground_friction numeric,
    indulgence numeric,
    laserlikeness numeric,
    martyrdom numeric,
    moxie numeric,
    musclitude numeric,
    omniscience numeric,
    overpowerment numeric,
    patheticism numeric,
    ruthlessness numeric,
    shakespearianism numeric,
    suppression numeric,
    tenaciousness numeric,
    thwackability numeric,
    tragicness numeric,
    unthwackability numeric,
    watchfulness numeric,
    pressurization numeric,
    cinnamon numeric,
    total_fingers smallint,
    soul smallint,
    fate smallint,
    peanut_allergy boolean,
    armor text,
    bat text,
    ritual text,
    coffee smallint,
    blood smallint,
    url_slug character varying
);


--
-- Name: team_roster; Type: TABLE; Schema: data; Owner: -
--

CREATE TABLE data.team_roster (
    team_roster_id integer NOT NULL,
    team_id character varying,
    position_id integer,
    valid_from timestamp without time zone,
    valid_until timestamp without time zone,
    player_id character varying,
    position_type_id numeric
);


--
-- Name: teams; Type: TABLE; Schema: data; Owner: -
--

CREATE TABLE data.teams (
    id integer NOT NULL,
    team_id character varying(36),
    location text,
    nickname text,
    full_name text,
    valid_from timestamp without time zone,
    valid_until timestamp without time zone,
    hash uuid
);


--
-- Name: division_teams; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.division_teams (
    division_teams_id integer NOT NULL,
    division_id character varying,
    team_id character varying,
    valid_from timestamp without time zone,
    valid_until timestamp without time zone
);


--
-- Name: divisions; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.divisions (
    division_db_id integer NOT NULL,
    division_text character varying,
    league_id integer,
    valid_until timestamp without time zone,
    division_seasons integer[],
    division_id character varying,
    valid_from timestamp without time zone
);


--
-- Name: leagues; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.leagues (
    league_db_id integer NOT NULL,
    league_text character varying,
    league_seasons integer[],
    valid_until timestamp without time zone,
    league_id character varying,
    valid_from timestamp without time zone
);


--
-- Name: teams_current; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.teams_current AS
 SELECT t.team_id,
    t.location,
    t.nickname,
    t.full_name,
    t.valid_from,
    ( SELECT gameday_from_timestamp.gameday
           FROM data.gameday_from_timestamp(t.valid_from) gameday_from_timestamp(season, gameday)) AS gameday_from,
    ( SELECT gameday_from_timestamp.season
           FROM data.gameday_from_timestamp(t.valid_from) gameday_from_timestamp(season, gameday)) AS season_from,
    d.division_text AS division,
    d.division_id,
    l.league_text AS league,
    l.league_id
   FROM (((data.teams t
     JOIN taxa.division_teams dt ON ((((t.team_id)::text = (dt.team_id)::text) AND (dt.valid_until IS NULL))))
     JOIN taxa.divisions d ON ((((dt.division_id)::text = (d.division_id)::text) AND (d.valid_until IS NULL))))
     JOIN taxa.leagues l ON (((d.league_id = l.league_db_id) AND (l.valid_until IS NULL))))
  WHERE (t.valid_until IS NULL)
  ORDER BY l.league_text, d.division_text, t.nickname;


--
-- Name: blood; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.blood (
    blood_id integer,
    blood_type character varying
);


--
-- Name: coffee; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.coffee (
    coffee_id integer,
    coffee_text character varying
);


--
-- Name: player_url_slugs; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.player_url_slugs (
    player_url_slug_id integer NOT NULL,
    player_id character varying,
    valid_from timestamp without time zone,
    valid_until timestamp without time zone,
    player_url_slug character varying
);


--
-- Name: position_types; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.position_types (
    position_type_id integer,
    position_type character varying
);


--
-- Name: players_current; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.players_current AS
 SELECT p.player_id,
    p.valid_from,
    ( SELECT gameday_from_timestamp.gameday
           FROM data.gameday_from_timestamp(p.valid_from) gameday_from_timestamp(season, gameday)) AS gameday_from,
    ( SELECT gameday_from_timestamp.season
           FROM data.gameday_from_timestamp(p.valid_from) gameday_from_timestamp(season, gameday)) AS season_from,
    p.player_name,
    p.anticapitalism,
    p.base_thirst,
    p.buoyancy,
    p.chasiness,
    p.coldness,
    p.continuation,
    p.divinity,
    p.ground_friction,
    p.indulgence,
    p.laserlikeness,
    p.martyrdom,
    p.moxie,
    p.musclitude,
    p.omniscience,
    p.overpowerment,
    p.patheticism,
    p.ruthlessness,
    p.shakespearianism,
    p.suppression,
    p.tenaciousness,
    p.thwackability,
    p.tragicness,
    p.unthwackability,
    p.watchfulness,
    p.pressurization,
    p.cinnamon,
    p.total_fingers,
    p.soul,
    p.fate,
    p.peanut_allergy,
    p.armor,
    p.bat,
    p.ritual,
    xc.coffee_text AS coffee,
    xb.blood_type AS blood,
    t.team_id,
    t.nickname AS team,
    tr.position_id,
    xp.position_type,
    p.url_slug AS player_url_slug,
    ( SELECT array_agg(DISTINCT xs.player_url_slug) AS array_agg
           FROM taxa.player_url_slugs xs
          WHERE (((xs.player_id)::text = (p.player_id)::text) AND ((xs.player_url_slug)::text <> (p.url_slug)::text))) AS previous_url_slugs,
    p.deceased
   FROM (((((data.players p
     LEFT JOIN taxa.blood xb ON ((p.blood = xb.blood_id)))
     LEFT JOIN taxa.coffee xc ON ((p.coffee = xc.coffee_id)))
     LEFT JOIN data.team_roster tr ON ((((p.player_id)::text = (tr.player_id)::text) AND (tr.valid_until IS NULL))))
     LEFT JOIN data.teams_current t ON (((tr.team_id)::text = (t.team_id)::text)))
     LEFT JOIN taxa.position_types xp ON ((tr.position_type_id = (xp.position_type_id)::numeric)))
  WHERE (((p.valid_until IS NULL) OR (p.deceased = true)) AND (tr.position_type_id < (2)::numeric) AND ((p.player_id)::text <> 'bc4187fa-459a-4c06-bbf2-4e0e013d27ce'::text));


--
-- Name: batting_stats_player_vs_pitcher_lifetime; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_player_vs_pitcher_lifetime AS
 SELECT p.player_name,
    a.player_id,
    v.player_name AS pitcher,
    a.pitcher_id,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hit), sum(a.at_bat))
        END AS batting_average,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice))
        END AS on_base_percentage,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.slugging(sum(a.total_bases), sum(a.at_bat))
        END AS slugging,
    sum(a.plate_appearance) AS plate_appearances,
    sum(a.at_bat) AS at_bats,
    sum(a.hit) AS hits,
    sum(a.walk) AS walks,
    sum(a.single) AS singles,
    sum(a.double) AS doubles,
    sum(a.triple) AS triples,
    sum(a.home_run) AS home_runs,
    sum(a.runs_batted_in) AS runs_batted_in,
    sum(a.strikeout) AS strikeouts,
    sum(a.sacrifice) AS sacrifices,
    sum(a.at_bat_risp) AS at_bats_risp,
    sum(a.hits_risp) AS hits_risps,
        CASE
            WHEN (sum(a.at_bat_risp) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hits_risp), sum(a.at_bat_risp))
        END AS batting_average_risp,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE (data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice)) + data.slugging(sum(a.total_bases), sum(a.at_bat)))
        END AS on_base_slugging,
    sum(a.total_bases) AS total_bases,
    sum(a.hbp) AS hbps,
    sum(a.ground_out) AS ground_outs,
    sum(a.flyout) AS flyouts,
    sum(a.gidp) AS gidps
   FROM ((data.batting_stats_all_events a
     JOIN data.players_current p ON (((a.player_id)::text = (p.player_id)::text)))
     JOIN data.players_current v ON (((a.pitcher_id)::text = (v.player_id)::text)))
  WHERE (NOT a.is_postseason)
  GROUP BY v.player_name, a.player_id, p.player_name, a.pitcher_id;


--
-- Name: batting_stats_player_vs_pitcher_playoffs_lifetime; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_player_vs_pitcher_playoffs_lifetime AS
 SELECT p.player_name,
    a.player_id,
    v.player_name AS pitcher,
    a.pitcher_id,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hit), sum(a.at_bat))
        END AS batting_average,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice))
        END AS on_base_percentage,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.slugging(sum(a.total_bases), sum(a.at_bat))
        END AS slugging,
    sum(a.plate_appearance) AS plate_appearances,
    sum(a.at_bat) AS at_bats,
    sum(a.hit) AS hits,
    sum(a.walk) AS walks,
    sum(a.single) AS singles,
    sum(a.double) AS doubles,
    sum(a.triple) AS triples,
    sum(a.home_run) AS home_runs,
    sum(a.runs_batted_in) AS runs_batted_in,
    sum(a.strikeout) AS strikeouts,
    sum(a.sacrifice) AS sacrifices,
    sum(a.at_bat_risp) AS at_bats_risp,
    sum(a.hits_risp) AS hits_risps,
        CASE
            WHEN (sum(a.at_bat_risp) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hits_risp), sum(a.at_bat_risp))
        END AS batting_average_risp,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE (data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice)) + data.slugging(sum(a.total_bases), sum(a.at_bat)))
        END AS on_base_slugging,
    sum(a.total_bases) AS total_bases,
    sum(a.hbp) AS hbps,
    sum(a.ground_out) AS ground_outs,
    sum(a.flyout) AS flyouts,
    sum(a.gidp) AS gidps
   FROM ((data.batting_stats_all_events a
     JOIN data.players_current p ON (((a.player_id)::text = (p.player_id)::text)))
     JOIN data.players_current v ON (((a.pitcher_id)::text = (v.player_id)::text)))
  WHERE a.is_postseason
  GROUP BY v.player_name, a.player_id, p.player_name, a.pitcher_id;


--
-- Name: batting_stats_player_vs_pitcher_playoffs_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_player_vs_pitcher_playoffs_season AS
 SELECT p.player_name,
    a.player_id,
    v.player_name AS pitcher,
    a.pitcher_id,
    a.season,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hit), sum(a.at_bat))
        END AS batting_average,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice))
        END AS on_base_percentage,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.slugging(sum(a.total_bases), sum(a.at_bat))
        END AS slugging,
    sum(a.plate_appearance) AS plate_appearances,
    sum(a.at_bat) AS at_bats,
    sum(a.hit) AS hits,
    sum(a.walk) AS walks,
    sum(a.single) AS singles,
    sum(a.double) AS doubles,
    sum(a.triple) AS triples,
    sum(a.home_run) AS home_runs,
    sum(a.runs_batted_in) AS runs_batted_in,
    sum(a.strikeout) AS strikeouts,
    sum(a.sacrifice) AS sacrifices,
    sum(a.at_bat_risp) AS at_bats_risp,
    sum(a.hits_risp) AS hits_risps,
        CASE
            WHEN (sum(a.at_bat_risp) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hits_risp), sum(a.at_bat_risp))
        END AS batting_average_risp,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE (data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice)) + data.slugging(sum(a.total_bases), sum(a.at_bat)))
        END AS on_base_slugging,
    sum(a.total_bases) AS total_bases,
    sum(a.hbp) AS hbps,
    sum(a.ground_out) AS ground_outs,
    sum(a.flyout) AS flyouts,
    sum(a.gidp) AS gidps
   FROM ((data.batting_stats_all_events a
     JOIN data.players_current p ON (((a.player_id)::text = (p.player_id)::text)))
     JOIN data.players_current v ON (((a.pitcher_id)::text = (v.player_id)::text)))
  WHERE a.is_postseason
  GROUP BY v.player_name, a.player_id, p.player_name, a.pitcher_id, a.season;


--
-- Name: batting_stats_player_vs_pitcher_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_player_vs_pitcher_season AS
 SELECT p.player_name,
    a.player_id,
    v.player_name AS pitcher,
    a.pitcher_id,
    a.season,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hit), sum(a.at_bat))
        END AS batting_average,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice))
        END AS on_base_percentage,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.slugging(sum(a.total_bases), sum(a.at_bat))
        END AS slugging,
    sum(a.plate_appearance) AS plate_appearances,
    sum(a.at_bat) AS at_bats,
    sum(a.hit) AS hits,
    sum(a.walk) AS walks,
    sum(a.single) AS singles,
    sum(a.double) AS doubles,
    sum(a.triple) AS triples,
    sum(a.home_run) AS home_runs,
    sum(a.runs_batted_in) AS runs_batted_in,
    sum(a.strikeout) AS strikeouts,
    sum(a.sacrifice) AS sacrifices,
    sum(a.at_bat_risp) AS at_bats_risp,
    sum(a.hits_risp) AS hits_risps,
        CASE
            WHEN (sum(a.at_bat_risp) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hits_risp), sum(a.at_bat_risp))
        END AS batting_average_risp,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE (data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice)) + data.slugging(sum(a.total_bases), sum(a.at_bat)))
        END AS on_base_slugging,
    sum(a.total_bases) AS total_bases,
    sum(a.hbp) AS hbps,
    sum(a.ground_out) AS ground_outs,
    sum(a.flyout) AS flyouts,
    sum(a.gidp) AS gidps
   FROM ((data.batting_stats_all_events a
     JOIN data.players_current p ON (((a.player_id)::text = (p.player_id)::text)))
     JOIN data.players_current v ON (((a.pitcher_id)::text = (v.player_id)::text)))
  WHERE (NOT a.is_postseason)
  GROUP BY v.player_name, a.player_id, p.player_name, a.pitcher_id, a.season;


--
-- Name: game_event_base_runners_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.game_event_base_runners_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: game_event_base_runners_id_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: -
--

ALTER SEQUENCE data.game_event_base_runners_id_seq OWNED BY data.game_event_base_runners.id;


--
-- Name: game_events_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.game_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: game_events_id_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: -
--

ALTER SEQUENCE data.game_events_id_seq OWNED BY data.game_events.id;


--
-- Name: imported_logs; Type: TABLE; Schema: data; Owner: -
--

CREATE TABLE data.imported_logs (
    id integer NOT NULL,
    key text,
    imported_at timestamp without time zone
);


--
-- Name: imported_logs_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.imported_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: imported_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: -
--

ALTER SEQUENCE data.imported_logs_id_seq OWNED BY data.imported_logs.id;


--
-- Name: outcomes; Type: TABLE; Schema: data; Owner: -
--

CREATE TABLE data.outcomes (
    id integer NOT NULL,
    game_event_id integer,
    entity_id character varying(36),
    event_type text,
    original_text text
);


--
-- Name: pitching_stats_player_by_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.pitching_stats_player_by_season AS
 SELECT p.player_name,
    a.season,
    sum(a.win) AS wins,
    sum(a.loss) AS losses,
    sum(a.k) AS strikeouts,
    sum(a.bb) AS walks,
    sum(a.hr) AS hrs_allowed,
    sum(a.hit) AS hits,
    sum(a.run) AS runs,
    sum(a."out") AS outs,
    sum(
        CASE
            WHEN (a.run = 0) THEN 1
            ELSE 0
        END) AS shutouts,
    data.innings_from_outs(sum(a."out")) AS innings,
    data.earned_run_average(sum(a.run), sum(a."out")) AS era
   FROM (( SELECT ge.game_id,
            ge.pitcher_id,
            ge.season,
                CASE
                    WHEN (ge.top_of_inning AND (fs.home_final > fs.away_final)) THEN 1
                    WHEN ((NOT ge.top_of_inning) AND (fs.home_final < fs.away_final)) THEN 1
                    ELSE 0
                END AS win,
                CASE
                    WHEN (ge.top_of_inning AND (fs.home_final > fs.away_final)) THEN 0
                    WHEN ((NOT ge.top_of_inning) AND (fs.home_final < fs.away_final)) THEN 0
                    ELSE 1
                END AS loss,
            sum(
                CASE
                    WHEN (ge.event_type = 'STRIKEOUT'::text) THEN 1
                    ELSE 0
                END) AS k,
            sum(
                CASE
                    WHEN (ge.event_type = 'WALK'::text) THEN 1
                    ELSE 0
                END) AS bb,
            sum(
                CASE
                    WHEN (ge.event_type = 'HOME_RUN'::text) THEN 1
                    ELSE 0
                END) AS hr,
            sum(xe.hit) AS hit,
            sum(
                CASE
                    WHEN (geb.base_after_play = 4) THEN 1
                    ELSE 0
                END) AS run,
            sum(ge.outs_on_play) AS "out",
            max(ge.event_index) AS last_event
           FROM (((data.game_events ge
             JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
             JOIN data.game_event_base_runners geb ON ((ge.id = geb.game_event_id)))
             JOIN ( SELECT max(game_events.home_score) AS home_final,
                    max(game_events.away_score) AS away_final,
                    game_events.game_id
                   FROM data.game_events
                  GROUP BY game_events.game_id) fs ON (((ge.game_id)::text = (fs.game_id)::text)))
          WHERE (ge.day < 99)
          GROUP BY ge.game_id, ge.pitcher_id, ge.top_of_inning, fs.home_final, fs.away_final, ge.season) a
     JOIN data.players_current p ON (((a.pitcher_id)::text = (p.player_id)::text)))
  GROUP BY p.player_name, a.season;


--
-- Name: pitching_stats_player_career; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.pitching_stats_player_career AS
 SELECT p.player_name,
    sum(a.win) AS wins,
    sum(a.loss) AS losses,
    sum(a.k) AS strikeouts,
    sum(a.bb) AS walks,
    sum(a.hr) AS hrs_allowed,
    sum(a.hit) AS hits,
    sum(a.run) AS runs,
    sum(a."out") AS outs,
    sum(
        CASE
            WHEN (a.run = 0) THEN 1
            ELSE 0
        END) AS shutouts,
    data.innings_from_outs(sum(a."out")) AS innings,
    data.earned_run_average(sum(a.run), sum(a."out")) AS era
   FROM (( SELECT ge.game_id,
            ge.pitcher_id,
                CASE
                    WHEN (ge.top_of_inning AND (fs.home_final > fs.away_final)) THEN 1
                    WHEN ((NOT ge.top_of_inning) AND (fs.home_final < fs.away_final)) THEN 1
                    ELSE 0
                END AS win,
                CASE
                    WHEN (ge.top_of_inning AND (fs.home_final > fs.away_final)) THEN 0
                    WHEN ((NOT ge.top_of_inning) AND (fs.home_final < fs.away_final)) THEN 0
                    ELSE 1
                END AS loss,
            sum(
                CASE
                    WHEN (ge.event_type = 'STRIKEOUT'::text) THEN 1
                    ELSE 0
                END) AS k,
            sum(
                CASE
                    WHEN (ge.event_type = 'WALK'::text) THEN 1
                    ELSE 0
                END) AS bb,
            sum(
                CASE
                    WHEN (ge.event_type = 'HOME_RUN'::text) THEN 1
                    ELSE 0
                END) AS hr,
            sum(xe.hit) AS hit,
            sum(
                CASE
                    WHEN (geb.base_after_play = 4) THEN 1
                    ELSE 0
                END) AS run,
            sum(ge.outs_on_play) AS "out",
            max(ge.event_index) AS last_event
           FROM (((data.game_events ge
             JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
             JOIN data.game_event_base_runners geb ON ((ge.id = geb.game_event_id)))
             JOIN ( SELECT max(game_events.home_score) AS home_final,
                    max(game_events.away_score) AS away_final,
                    game_events.game_id
                   FROM data.game_events
                  GROUP BY game_events.game_id) fs ON (((ge.game_id)::text = (fs.game_id)::text)))
          WHERE (ge.day < 99)
          GROUP BY ge.game_id, ge.pitcher_id, ge.top_of_inning, fs.home_final, fs.away_final) a
     JOIN data.players_current p ON (((a.pitcher_id)::text = (p.player_id)::text)))
  GROUP BY p.player_name;


--
-- Name: pitching_stats_player_playoffs_by_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.pitching_stats_player_playoffs_by_season AS
 SELECT p.player_name,
    a.season,
    sum(a.win) AS wins,
    sum(a.loss) AS losses,
    sum(a.k) AS strikeouts,
    sum(a.bb) AS walks,
    sum(a.hr) AS hrs_allowed,
    sum(a.hit) AS hits,
    sum(a.run) AS runs,
    sum(a."out") AS outs,
    sum(
        CASE
            WHEN (a.run = 0) THEN 1
            ELSE 0
        END) AS shutouts,
    data.innings_from_outs(sum(a."out")) AS innings,
    data.earned_run_average(sum(a.run), sum(a."out")) AS era
   FROM (( SELECT ge.game_id,
            ge.pitcher_id,
            ge.season,
                CASE
                    WHEN (ge.top_of_inning AND (fs.home_final > fs.away_final)) THEN 1
                    WHEN ((NOT ge.top_of_inning) AND (fs.home_final < fs.away_final)) THEN 1
                    ELSE 0
                END AS win,
                CASE
                    WHEN (ge.top_of_inning AND (fs.home_final > fs.away_final)) THEN 0
                    WHEN ((NOT ge.top_of_inning) AND (fs.home_final < fs.away_final)) THEN 0
                    ELSE 1
                END AS loss,
            sum(
                CASE
                    WHEN (ge.event_type = 'STRIKEOUT'::text) THEN 1
                    ELSE 0
                END) AS k,
            sum(
                CASE
                    WHEN (ge.event_type = 'WALK'::text) THEN 1
                    ELSE 0
                END) AS bb,
            sum(
                CASE
                    WHEN (ge.event_type = 'HOME_RUN'::text) THEN 1
                    ELSE 0
                END) AS hr,
            sum(xe.hit) AS hit,
            sum(
                CASE
                    WHEN (geb.base_after_play = 4) THEN 1
                    ELSE 0
                END) AS run,
            sum(ge.outs_on_play) AS "out",
            max(ge.event_index) AS last_event
           FROM (((data.game_events ge
             JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
             JOIN data.game_event_base_runners geb ON ((ge.id = geb.game_event_id)))
             JOIN ( SELECT max(game_events.home_score) AS home_final,
                    max(game_events.away_score) AS away_final,
                    game_events.game_id
                   FROM data.game_events
                  GROUP BY game_events.game_id) fs ON (((ge.game_id)::text = (fs.game_id)::text)))
          WHERE (ge.day >= 99)
          GROUP BY ge.game_id, ge.pitcher_id, ge.top_of_inning, fs.home_final, fs.away_final, ge.season) a
     JOIN data.players_current p ON (((a.pitcher_id)::text = (p.player_id)::text)))
  GROUP BY p.player_name, a.season;


--
-- Name: pitching_stats_player_playoffs_career; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.pitching_stats_player_playoffs_career AS
 SELECT p.player_name,
    sum(a.win) AS wins,
    sum(a.loss) AS losses,
    sum(a.k) AS strikeouts,
    sum(a.bb) AS walks,
    sum(a.hr) AS hrs_allowed,
    sum(a.hit) AS hits,
    sum(a.run) AS runs,
    sum(a."out") AS outs,
    sum(
        CASE
            WHEN (a.run = 0) THEN 1
            ELSE 0
        END) AS shutouts,
    data.innings_from_outs(sum(a."out")) AS innings,
    data.earned_run_average(sum(a.run), sum(a."out")) AS era
   FROM (( SELECT ge.game_id,
            ge.pitcher_id,
                CASE
                    WHEN (ge.top_of_inning AND (fs.home_final > fs.away_final)) THEN 1
                    WHEN ((NOT ge.top_of_inning) AND (fs.home_final < fs.away_final)) THEN 1
                    ELSE 0
                END AS win,
                CASE
                    WHEN (ge.top_of_inning AND (fs.home_final > fs.away_final)) THEN 0
                    WHEN ((NOT ge.top_of_inning) AND (fs.home_final < fs.away_final)) THEN 0
                    ELSE 1
                END AS loss,
            sum(
                CASE
                    WHEN (ge.event_type = 'STRIKEOUT'::text) THEN 1
                    ELSE 0
                END) AS k,
            sum(
                CASE
                    WHEN (ge.event_type = 'WALK'::text) THEN 1
                    ELSE 0
                END) AS bb,
            sum(
                CASE
                    WHEN (ge.event_type = 'HOME_RUN'::text) THEN 1
                    ELSE 0
                END) AS hr,
            sum(xe.hit) AS hit,
            sum(
                CASE
                    WHEN (geb.base_after_play = 4) THEN 1
                    ELSE 0
                END) AS run,
            sum(ge.outs_on_play) AS "out",
            max(ge.event_index) AS last_event
           FROM (((data.game_events ge
             JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
             JOIN data.game_event_base_runners geb ON ((ge.id = geb.game_event_id)))
             JOIN ( SELECT max(game_events.home_score) AS home_final,
                    max(game_events.away_score) AS away_final,
                    game_events.game_id
                   FROM data.game_events
                  GROUP BY game_events.game_id) fs ON (((ge.game_id)::text = (fs.game_id)::text)))
          WHERE (ge.day >= 99)
          GROUP BY ge.game_id, ge.pitcher_id, ge.top_of_inning, fs.home_final, fs.away_final) a
     JOIN data.players_current p ON (((a.pitcher_id)::text = (p.player_id)::text)))
  GROUP BY p.player_name;


--
-- Name: player_events_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.player_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: player_events_id_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: -
--

ALTER SEQUENCE data.player_events_id_seq OWNED BY data.outcomes.id;


--
-- Name: player_modifications; Type: TABLE; Schema: data; Owner: -
--

CREATE TABLE data.player_modifications (
    player_modifications_id integer NOT NULL,
    player_id character varying,
    modification character varying,
    valid_from timestamp without time zone,
    valid_until timestamp without time zone
);


--
-- Name: player_modifications_player_modifications_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.player_modifications_player_modifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: player_modifications_player_modifications_id_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: -
--

ALTER SEQUENCE data.player_modifications_player_modifications_id_seq OWNED BY data.player_modifications.player_modifications_id;


--
-- Name: players_attributes_expanded_all; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.players_attributes_expanded_all AS
 SELECT players.id,
    players.player_id,
    players.valid_from,
    players.valid_until,
    players.player_name,
    players.deceased,
    players.hash,
    players.anticapitalism,
    players.base_thirst,
    players.buoyancy,
    players.chasiness,
    players.coldness,
    players.continuation,
    players.divinity,
    players.ground_friction,
    players.indulgence,
    players.laserlikeness,
    players.martyrdom,
    players.moxie,
    players.musclitude,
    players.omniscience,
    players.overpowerment,
    players.patheticism,
    players.ruthlessness,
    players.shakespearianism,
    players.suppression,
    players.tenaciousness,
    players.thwackability,
    players.tragicness,
    players.unthwackability,
    players.watchfulness,
    players.pressurization,
    players.cinnamon,
    players.total_fingers,
    players.soul,
    players.fate,
    players.peanut_allergy,
    players.armor,
    players.bat,
    players.ritual,
    players.coffee,
    players.blood,
    players.url_slug,
    data.batting_rating(players.player_id, COALESCE(players.valid_until, (now())::timestamp without time zone)) AS batting_rating,
    data.baserunning_rating(players.player_id, COALESCE(players.valid_until, (now())::timestamp without time zone)) AS baserunning_rating,
    data.defense_rating(players.player_id, COALESCE(players.valid_until, (now())::timestamp without time zone)) AS defense_rating,
    data.pitching_rating(players.player_id, COALESCE(players.valid_until, (now())::timestamp without time zone)) AS pitching_rating,
    data.rating_to_star(data.batting_rating(players.player_id, COALESCE(players.valid_until, (now())::timestamp without time zone))) AS batting_stars,
    data.rating_to_star(data.baserunning_rating(players.player_id, COALESCE(players.valid_until, (now())::timestamp without time zone))) AS baserunning_stars,
    data.rating_to_star(data.defense_rating(players.player_id, COALESCE(players.valid_until, (now())::timestamp without time zone))) AS defense_stars,
    data.rating_to_star(data.pitching_rating(players.player_id, COALESCE(players.valid_until, (now())::timestamp without time zone))) AS pitching_stars
   FROM data.players;


--
-- Name: players_extended_current; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.players_extended_current AS
 SELECT p.player_id,
    p.valid_from,
    ( SELECT gameday_from_timestamp.gameday
           FROM data.gameday_from_timestamp(p.valid_from) gameday_from_timestamp(season, gameday)) AS gameday_from,
    ( SELECT gameday_from_timestamp.season
           FROM data.gameday_from_timestamp(p.valid_from) gameday_from_timestamp(season, gameday)) AS season_from,
    p.player_name,
    p.anticapitalism,
    p.base_thirst,
    p.buoyancy,
    p.chasiness,
    p.coldness,
    p.continuation,
    p.divinity,
    p.ground_friction,
    p.indulgence,
    p.laserlikeness,
    p.martyrdom,
    p.moxie,
    p.musclitude,
    p.omniscience,
    p.overpowerment,
    p.patheticism,
    p.ruthlessness,
    p.shakespearianism,
    p.suppression,
    p.tenaciousness,
    p.thwackability,
    p.tragicness,
    p.unthwackability,
    p.watchfulness,
    p.pressurization,
    p.cinnamon,
    p.total_fingers,
    p.soul,
    p.fate,
    p.peanut_allergy,
    p.armor,
    p.bat,
    p.ritual,
    xc.coffee_text AS coffee,
    xb.blood_type AS blood,
    t.team_id,
    t.nickname AS team,
    tr.position_id,
    xp.position_type,
    p.url_slug AS player_url_slug,
    ( SELECT array_agg(DISTINCT xs.player_url_slug) AS array_agg
           FROM taxa.player_url_slugs xs
          WHERE (((xs.player_id)::text = (p.player_id)::text) AND ((xs.player_url_slug)::text <> (p.url_slug)::text))) AS previous_url_slugs,
    p.deceased
   FROM (((((data.players p
     LEFT JOIN taxa.blood xb ON ((p.blood = xb.blood_id)))
     LEFT JOIN taxa.coffee xc ON ((p.coffee = xc.coffee_id)))
     LEFT JOIN data.team_roster tr ON ((((p.player_id)::text = (tr.player_id)::text) AND (tr.valid_until IS NULL))))
     LEFT JOIN data.teams_current t ON (((tr.team_id)::text = (t.team_id)::text)))
     LEFT JOIN taxa.position_types xp ON ((tr.position_type_id = (xp.position_type_id)::numeric)))
  WHERE (((p.valid_until IS NULL) OR (p.deceased = true)) AND ((p.player_id)::text <> 'bc4187fa-459a-4c06-bbf2-4e0e013d27ce'::text));


--
-- Name: players_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.players_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: -
--

ALTER SEQUENCE data.players_id_seq OWNED BY data.players.id;


--
-- Name: players_info_expanded_all; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.players_info_expanded_all AS
 SELECT p.player_id,
    p.valid_from,
    p.valid_until,
    p.player_name,
    p.deceased,
    p.hash,
    p.anticapitalism,
    p.base_thirst,
    p.buoyancy,
    p.chasiness,
    p.coldness,
    p.continuation,
    p.divinity,
    p.ground_friction,
    p.indulgence,
    p.laserlikeness,
    p.martyrdom,
    p.moxie,
    p.musclitude,
    p.omniscience,
    p.overpowerment,
    p.patheticism,
    p.ruthlessness,
    p.shakespearianism,
    p.suppression,
    p.tenaciousness,
    p.thwackability,
    p.tragicness,
    p.unthwackability,
    p.watchfulness,
    p.pressurization,
    p.cinnamon,
    p.total_fingers,
    p.soul,
    p.fate,
    p.peanut_allergy,
    p.armor,
    p.bat,
    p.ritual,
    p.coffee,
    p.blood,
    p.url_slug,
    data.batting_rating(p.player_id, COALESCE(p.valid_until, (now())::timestamp without time zone)) AS batting_rating,
    data.baserunning_rating(p.player_id, COALESCE(p.valid_until, (now())::timestamp without time zone)) AS baserunning_rating,
    data.defense_rating(p.player_id, COALESCE(p.valid_until, (now())::timestamp without time zone)) AS defense_rating,
    data.pitching_rating(p.player_id, COALESCE(p.valid_until, (now())::timestamp without time zone)) AS pitching_rating,
    data.rating_to_star(data.batting_rating(p.player_id, COALESCE(p.valid_until, (now())::timestamp without time zone))) AS batting_stars,
    data.rating_to_star(data.baserunning_rating(p.player_id, COALESCE(p.valid_until, (now())::timestamp without time zone))) AS baserunning_stars,
    data.rating_to_star(data.defense_rating(p.player_id, COALESCE(p.valid_until, (now())::timestamp without time zone))) AS defense_stars,
    data.rating_to_star(data.pitching_rating(p.player_id, COALESCE(p.valid_until, (now())::timestamp without time zone))) AS pitching_stars
   FROM data.players p;


--
-- Name: rosters_current; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.rosters_current AS
 SELECT r.valid_from,
    ( SELECT gameday_from_timestamp.gameday
           FROM data.gameday_from_timestamp(r.valid_from) gameday_from_timestamp(season, gameday)) AS gameday_from,
    ( SELECT gameday_from_timestamp.season
           FROM data.gameday_from_timestamp(r.valid_from) gameday_from_timestamp(season, gameday)) AS season_from,
    r.team_id,
    t.nickname,
    r.player_id,
    p.player_name,
    xp.position_type,
    r.position_id
   FROM (((data.team_roster r
     JOIN data.players p ON ((((r.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
     JOIN data.teams t ON ((((r.team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
     JOIN taxa.position_types xp ON ((r.position_type_id = (xp.position_type_id)::numeric)))
  WHERE ((r.valid_until IS NULL) AND (xp.position_type_id < 2))
  ORDER BY t.nickname, r.position_type_id, r.position_id;


--
-- Name: rosters_extended_current; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.rosters_extended_current AS
 SELECT r.valid_from,
    ( SELECT gameday_from_timestamp.gameday
           FROM data.gameday_from_timestamp(r.valid_from) gameday_from_timestamp(season, gameday)) AS gameday_from,
    ( SELECT gameday_from_timestamp.season
           FROM data.gameday_from_timestamp(r.valid_from) gameday_from_timestamp(season, gameday)) AS season_from,
    r.team_id,
    t.nickname,
    r.player_id,
    p.player_name,
    xp.position_type,
    r.position_id
   FROM (((data.team_roster r
     JOIN data.players p ON ((((r.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
     JOIN data.teams t ON ((((r.team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
     JOIN taxa.position_types xp ON ((r.position_type_id = (xp.position_type_id)::numeric)))
  WHERE (r.valid_until IS NULL)
  ORDER BY t.nickname, r.position_type_id, r.position_id;


--
-- Name: running_stats_player_by_season_team; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.running_stats_player_by_season_team AS
 SELECT p.player_name,
    p.player_id,
    t.nickname AS team,
    ru.season,
    ru.runs,
    ru.stolen_bases,
    ru.caught_stealing
   FROM ((( SELECT geb.runner_id AS player_id,
            ge.season,
            ge.batter_team_id AS team_id,
            sum(
                CASE
                    WHEN (geb.base_after_play = 4) THEN 1
                    ELSE 0
                END) AS runs,
            sum(
                CASE
                    WHEN geb.was_base_stolen THEN 1
                    ELSE 0
                END) AS stolen_bases,
            sum(
                CASE
                    WHEN geb.was_caught_stealing THEN 1
                    ELSE 0
                END) AS caught_stealing
           FROM ((data.game_event_base_runners geb
             JOIN data.game_events ge ON ((ge.id = geb.game_event_id)))
             JOIN data.games ga ON (((ga.game_id)::text = (ge.game_id)::text)))
          WHERE (((geb.runner_id)::text <> ''::text) AND (NOT ga.is_postseason))
          GROUP BY geb.runner_id, ge.season, ge.batter_team_id) ru
     JOIN data.players_current p ON (((ru.player_id)::text = (p.player_id)::text)))
     JOIN data.teams_current t ON (((ru.team_id)::text = (t.team_id)::text)));


--
-- Name: running_stats_player_career; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.running_stats_player_career AS
 SELECT p.player_name,
    p.player_id,
    ru.runs,
    ru.stolen_bases,
    ru.caught_stealing
   FROM (( SELECT geb.runner_id AS player_id,
            sum(
                CASE
                    WHEN (geb.base_after_play = 4) THEN 1
                    ELSE 0
                END) AS runs,
            sum(
                CASE
                    WHEN geb.was_base_stolen THEN 1
                    ELSE 0
                END) AS stolen_bases,
            sum(
                CASE
                    WHEN geb.was_caught_stealing THEN 1
                    ELSE 0
                END) AS caught_stealing
           FROM ((data.game_event_base_runners geb
             JOIN data.game_events ge ON ((ge.id = geb.game_event_id)))
             JOIN data.games ga ON (((ga.game_id)::text = (ge.game_id)::text)))
          WHERE (((geb.runner_id)::text <> ''::text) AND (NOT ga.is_postseason))
          GROUP BY geb.runner_id) ru
     JOIN data.players_current p ON (((ru.player_id)::text = (p.player_id)::text)));


--
-- Name: running_stats_player_playoffs_by_season_combined_teams; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.running_stats_player_playoffs_by_season_combined_teams AS
 SELECT p.player_name,
    p.player_id,
    ru.season,
    'TOTAL'::character varying AS team,
    ru.runs,
    ru.stolen_bases,
    ru.caught_stealing
   FROM (( SELECT geb.runner_id AS player_id,
            ge.season,
            sum(
                CASE
                    WHEN (geb.base_after_play = 4) THEN 1
                    ELSE 0
                END) AS runs,
            sum(
                CASE
                    WHEN geb.was_base_stolen THEN 1
                    ELSE 0
                END) AS stolen_bases,
            sum(
                CASE
                    WHEN geb.was_caught_stealing THEN 1
                    ELSE 0
                END) AS caught_stealing
           FROM ((data.game_event_base_runners geb
             JOIN data.game_events ge ON ((ge.id = geb.game_event_id)))
             JOIN data.games ga ON (((ga.game_id)::text = (ge.game_id)::text)))
          WHERE (((geb.runner_id)::text <> ''::text) AND (NOT ga.is_postseason))
          GROUP BY geb.runner_id, ge.season
         HAVING (count(DISTINCT ge.batter_team_id) > 1)) ru
     JOIN data.players_current p ON (((ru.player_id)::text = (p.player_id)::text)));


--
-- Name: running_stats_player_playoffs_by_season_team; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.running_stats_player_playoffs_by_season_team AS
 SELECT p.player_name,
    p.player_id,
    t.nickname AS team,
    ru.season,
    ru.runs,
    ru.stolen_bases,
    ru.caught_stealing
   FROM ((( SELECT geb.runner_id AS player_id,
            ge.season,
            ge.batter_team_id AS team_id,
            sum(
                CASE
                    WHEN (geb.base_after_play = 4) THEN 1
                    ELSE 0
                END) AS runs,
            sum(
                CASE
                    WHEN geb.was_base_stolen THEN 1
                    ELSE 0
                END) AS stolen_bases,
            sum(
                CASE
                    WHEN geb.was_caught_stealing THEN 1
                    ELSE 0
                END) AS caught_stealing
           FROM ((data.game_event_base_runners geb
             JOIN data.game_events ge ON ((ge.id = geb.game_event_id)))
             JOIN data.games ga ON (((ga.game_id)::text = (ge.game_id)::text)))
          WHERE (((geb.runner_id)::text <> ''::text) AND ga.is_postseason)
          GROUP BY geb.runner_id, ge.season, ge.batter_team_id) ru
     JOIN data.players_current p ON (((ru.player_id)::text = (p.player_id)::text)))
     JOIN data.teams_current t ON (((ru.team_id)::text = (t.team_id)::text)));


--
-- Name: running_stats_player_playoffs_career; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.running_stats_player_playoffs_career AS
 SELECT p.player_name,
    p.player_id,
    ru.runs,
    ru.stolen_bases,
    ru.caught_stealing
   FROM (( SELECT geb.runner_id AS player_id,
            sum(
                CASE
                    WHEN (geb.base_after_play = 4) THEN 1
                    ELSE 0
                END) AS runs,
            sum(
                CASE
                    WHEN geb.was_base_stolen THEN 1
                    ELSE 0
                END) AS stolen_bases,
            sum(
                CASE
                    WHEN geb.was_caught_stealing THEN 1
                    ELSE 0
                END) AS caught_stealing
           FROM ((data.game_event_base_runners geb
             JOIN data.game_events ge ON ((ge.id = geb.game_event_id)))
             JOIN data.games ga ON (((ga.game_id)::text = (ge.game_id)::text)))
          WHERE (((geb.runner_id)::text <> ''::text) AND ga.is_postseason)
          GROUP BY geb.runner_id) ru
     JOIN data.players_current p ON (((ru.player_id)::text = (p.player_id)::text)));


--
-- Name: season_leaders_outs_defended; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.season_leaders_outs_defended AS
 SELECT rank() OVER (ORDER BY (COALESCE(gr.groundouts, (0)::bigint) + COALESCE(fl.flyouts, (0)::bigint)) DESC) AS rank,
    p.player_name,
    r.nickname,
    gr.groundouts,
    fl.flyouts,
    (COALESCE(gr.groundouts, (0)::bigint) + COALESCE(fl.flyouts, (0)::bigint)) AS outs_defended
   FROM (((data.players_current p
     JOIN data.rosters_current r ON (((p.player_id)::text = (r.player_id)::text)))
     LEFT JOIN ( SELECT count(1) AS groundouts,
            replace("substring"((gr_1.event_text)::text, '.*ground out to \s*([^.]*)'::text), '''s Shell'::text, ''::text) AS player_name
           FROM data.game_events gr_1
          WHERE (gr_1.season = ( SELECT data.current_season() AS current_season))
          GROUP BY (replace("substring"((gr_1.event_text)::text, '.*ground out to \s*([^.]*)'::text), '''s Shell'::text, ''::text))) gr ON (((p.player_name)::text = gr.player_name)))
     LEFT JOIN ( SELECT count(1) AS flyouts,
            replace("substring"((gr_1.event_text)::text, '.*flyout to \s*([^.]*)'::text), '''s Shell'::text, ''::text) AS player_name
           FROM data.game_events gr_1
          WHERE (gr_1.season = ( SELECT data.current_season() AS current_season))
          GROUP BY (replace("substring"((gr_1.event_text)::text, '.*flyout to \s*([^.]*)'::text), '''s Shell'::text, ''::text))) fl ON (((p.player_name)::text = fl.player_name)))
  WHERE (r.position_id < 9)
  ORDER BY (COALESCE(gr.groundouts, (0)::bigint) + COALESCE(fl.flyouts, (0)::bigint)) DESC;


--
-- Name: stars_team_all_current; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.stars_team_all_current AS
 SELECT p.nickname,
    b.batting,
    b.running,
    b.defense,
    p.pitching,
    (((b.batting + b.running) + b.defense) + p.pitching) AS total
   FROM (( SELECT sum(data.rating_to_star(data.batting_rating(rosters_current.player_id))) AS batting,
            sum(data.rating_to_star(data.baserunning_rating(rosters_current.player_id))) AS running,
            sum(data.rating_to_star(data.defense_rating(rosters_current.player_id))) AS defense,
            rosters_current.nickname
           FROM data.rosters_current
          WHERE ((rosters_current.position_type)::text = 'BATTER'::text)
          GROUP BY rosters_current.nickname) b
     JOIN ( SELECT sum(data.rating_to_star(data.pitching_rating(rosters_current.player_id))) AS pitching,
            rosters_current.nickname
           FROM data.rosters_current
          WHERE ((rosters_current.position_type)::text = 'PITCHER'::text)
          GROUP BY rosters_current.nickname) p ON ((b.nickname = p.nickname)))
  GROUP BY p.nickname, b.batting, b.running, b.defense, p.pitching
  ORDER BY (((b.batting + b.running) + b.defense) + p.pitching) DESC;


--
-- Name: team_modifications; Type: TABLE; Schema: data; Owner: -
--

CREATE TABLE data.team_modifications (
    team_modifications_id integer NOT NULL,
    team_id character varying,
    modification character varying,
    valid_from timestamp without time zone,
    valid_until timestamp without time zone
);


--
-- Name: team_modifications_team_modifications_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.team_modifications_team_modifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: team_modifications_team_modifications_id_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: -
--

ALTER SEQUENCE data.team_modifications_team_modifications_id_seq OWNED BY data.team_modifications.team_modifications_id;


--
-- Name: team_positions_team_position_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.team_positions_team_position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: team_positions_team_position_id_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: -
--

ALTER SEQUENCE data.team_positions_team_position_id_seq OWNED BY data.team_roster.team_roster_id;


--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.teams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: -
--

ALTER SEQUENCE data.teams_id_seq OWNED BY data.teams.id;


--
-- Name: time_map; Type: TABLE; Schema: data; Owner: -
--

CREATE TABLE data.time_map (
    season integer NOT NULL,
    day integer NOT NULL,
    first_time timestamp without time zone,
    time_map_id integer NOT NULL
);


--
-- Name: time_map_time_map_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.time_map_time_map_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: time_map_time_map_id_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: -
--

ALTER SEQUENCE data.time_map_time_map_id_seq OWNED BY data.time_map.time_map_id;


--
-- Name: attributes; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.attributes (
    attribute_id integer NOT NULL,
    attribute_text character varying,
    attribute_desc character varying,
    attribute_objects integer[],
    attributes_short character varying,
    attribute_short character varying
);


--
-- Name: attributes_attribute_id_seq; Type: SEQUENCE; Schema: taxa; Owner: -
--

CREATE SEQUENCE taxa.attributes_attribute_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attributes_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: taxa; Owner: -
--

ALTER SEQUENCE taxa.attributes_attribute_id_seq OWNED BY taxa.attributes.attribute_id;


--
-- Name: blessings; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.blessings (
    blessing_id integer,
    blessing_short character varying,
    blessing character varying,
    blessing_desc character varying,
    blessing_value numeric,
    season integer,
    team_id character varying
);


--
-- Name: change_types; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.change_types (
    change_type_id integer NOT NULL,
    change_type character varying
);


--
-- Name: change_types_change_type_id_seq; Type: SEQUENCE; Schema: taxa; Owner: -
--

CREATE SEQUENCE taxa.change_types_change_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: change_types_change_type_id_seq; Type: SEQUENCE OWNED BY; Schema: taxa; Owner: -
--

ALTER SEQUENCE taxa.change_types_change_type_id_seq OWNED BY taxa.change_types.change_type_id;


--
-- Name: changes; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.changes (
    change_id integer,
    change character varying,
    change_text character varying,
    change_definition character varying,
    change_phase_id integer,
    change_type_id integer,
    change_target character varying
);


--
-- Name: division_teams_division_teams_id_seq; Type: SEQUENCE; Schema: taxa; Owner: -
--

CREATE SEQUENCE taxa.division_teams_division_teams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: division_teams_division_teams_id_seq; Type: SEQUENCE OWNED BY; Schema: taxa; Owner: -
--

ALTER SEQUENCE taxa.division_teams_division_teams_id_seq OWNED BY taxa.division_teams.division_teams_id;


--
-- Name: divisions_division_id_seq; Type: SEQUENCE; Schema: taxa; Owner: -
--

CREATE SEQUENCE taxa.divisions_division_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: divisions_division_id_seq; Type: SEQUENCE OWNED BY; Schema: taxa; Owner: -
--

ALTER SEQUENCE taxa.divisions_division_id_seq OWNED BY taxa.divisions.division_db_id;


--
-- Name: event_types_event_type_id_seq; Type: SEQUENCE; Schema: taxa; Owner: -
--

CREATE SEQUENCE taxa.event_types_event_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: event_types_event_type_id_seq; Type: SEQUENCE OWNED BY; Schema: taxa; Owner: -
--

ALTER SEQUENCE taxa.event_types_event_type_id_seq OWNED BY taxa.event_types.event_type_id;


--
-- Name: leagues_league_id_seq; Type: SEQUENCE; Schema: taxa; Owner: -
--

CREATE SEQUENCE taxa.leagues_league_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: leagues_league_id_seq; Type: SEQUENCE OWNED BY; Schema: taxa; Owner: -
--

ALTER SEQUENCE taxa.leagues_league_id_seq OWNED BY taxa.leagues.league_db_id;


--
-- Name: player_url_slugs_player_url_slug_id_seq; Type: SEQUENCE; Schema: taxa; Owner: -
--

CREATE SEQUENCE taxa.player_url_slugs_player_url_slug_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: player_url_slugs_player_url_slug_id_seq; Type: SEQUENCE OWNED BY; Schema: taxa; Owner: -
--

ALTER SEQUENCE taxa.player_url_slugs_player_url_slug_id_seq OWNED BY taxa.player_url_slugs.player_url_slug_id;


--
-- Name: team_divine_favor; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.team_divine_favor (
    team_divine_favor_id integer NOT NULL,
    team_id character varying,
    valid_from timestamp without time zone,
    valid_until timestamp without time zone,
    divine_favor integer
);


--
-- Name: team_divine_favor_team_divine_favor_id_seq; Type: SEQUENCE; Schema: taxa; Owner: -
--

CREATE SEQUENCE taxa.team_divine_favor_team_divine_favor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: team_divine_favor_team_divine_favor_id_seq; Type: SEQUENCE OWNED BY; Schema: taxa; Owner: -
--

ALTER SEQUENCE taxa.team_divine_favor_team_divine_favor_id_seq OWNED BY taxa.team_divine_favor.team_divine_favor_id;


--
-- Name: vibe_to_arrows; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.vibe_to_arrows (
    vibe_to_arrow_id integer NOT NULL,
    arrow_count integer,
    min_vibe numeric,
    max_vibe numeric
);


--
-- Name: vibe_to_arrows_vibe_to_arrow_id_seq; Type: SEQUENCE; Schema: taxa; Owner: -
--

CREATE SEQUENCE taxa.vibe_to_arrows_vibe_to_arrow_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vibe_to_arrows_vibe_to_arrow_id_seq; Type: SEQUENCE OWNED BY; Schema: taxa; Owner: -
--

ALTER SEQUENCE taxa.vibe_to_arrows_vibe_to_arrow_id_seq OWNED BY taxa.vibe_to_arrows.vibe_to_arrow_id;


--
-- Name: weather; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.weather (
    weather_id integer,
    weather_text character varying
);


--
-- Name: game_event_base_runners id; Type: DEFAULT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.game_event_base_runners ALTER COLUMN id SET DEFAULT nextval('data.game_event_base_runners_id_seq'::regclass);


--
-- Name: game_events id; Type: DEFAULT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.game_events ALTER COLUMN id SET DEFAULT nextval('data.game_events_id_seq'::regclass);


--
-- Name: imported_logs id; Type: DEFAULT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.imported_logs ALTER COLUMN id SET DEFAULT nextval('data.imported_logs_id_seq'::regclass);


--
-- Name: outcomes id; Type: DEFAULT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.outcomes ALTER COLUMN id SET DEFAULT nextval('data.player_events_id_seq'::regclass);


--
-- Name: player_modifications player_modifications_id; Type: DEFAULT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.player_modifications ALTER COLUMN player_modifications_id SET DEFAULT nextval('data.player_modifications_player_modifications_id_seq'::regclass);


--
-- Name: players id; Type: DEFAULT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.players ALTER COLUMN id SET DEFAULT nextval('data.players_id_seq'::regclass);


--
-- Name: team_modifications team_modifications_id; Type: DEFAULT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.team_modifications ALTER COLUMN team_modifications_id SET DEFAULT nextval('data.team_modifications_team_modifications_id_seq'::regclass);


--
-- Name: team_roster team_roster_id; Type: DEFAULT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.team_roster ALTER COLUMN team_roster_id SET DEFAULT nextval('data.team_positions_team_position_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.teams ALTER COLUMN id SET DEFAULT nextval('data.teams_id_seq'::regclass);


--
-- Name: time_map time_map_id; Type: DEFAULT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.time_map ALTER COLUMN time_map_id SET DEFAULT nextval('data.time_map_time_map_id_seq'::regclass);


--
-- Name: attributes attribute_id; Type: DEFAULT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.attributes ALTER COLUMN attribute_id SET DEFAULT nextval('taxa.attributes_attribute_id_seq'::regclass);


--
-- Name: change_types change_type_id; Type: DEFAULT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.change_types ALTER COLUMN change_type_id SET DEFAULT nextval('taxa.change_types_change_type_id_seq'::regclass);


--
-- Name: division_teams division_teams_id; Type: DEFAULT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.division_teams ALTER COLUMN division_teams_id SET DEFAULT nextval('taxa.division_teams_division_teams_id_seq'::regclass);


--
-- Name: divisions division_db_id; Type: DEFAULT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.divisions ALTER COLUMN division_db_id SET DEFAULT nextval('taxa.divisions_division_id_seq'::regclass);


--
-- Name: event_types event_type_id; Type: DEFAULT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.event_types ALTER COLUMN event_type_id SET DEFAULT nextval('taxa.event_types_event_type_id_seq'::regclass);


--
-- Name: leagues league_db_id; Type: DEFAULT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.leagues ALTER COLUMN league_db_id SET DEFAULT nextval('taxa.leagues_league_id_seq'::regclass);


--
-- Name: player_url_slugs player_url_slug_id; Type: DEFAULT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.player_url_slugs ALTER COLUMN player_url_slug_id SET DEFAULT nextval('taxa.player_url_slugs_player_url_slug_id_seq'::regclass);


--
-- Name: team_divine_favor team_divine_favor_id; Type: DEFAULT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.team_divine_favor ALTER COLUMN team_divine_favor_id SET DEFAULT nextval('taxa.team_divine_favor_team_divine_favor_id_seq'::regclass);


--
-- Name: vibe_to_arrows vibe_to_arrow_id; Type: DEFAULT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.vibe_to_arrows ALTER COLUMN vibe_to_arrow_id SET DEFAULT nextval('taxa.vibe_to_arrows_vibe_to_arrow_id_seq'::regclass);


--
-- Data for Name: game_event_base_runners; Type: TABLE DATA; Schema: data; Owner: -
--

COPY data.game_event_base_runners (id, game_event_id, runner_id, responsible_pitcher_id, base_before_play, base_after_play, was_base_stolen, was_caught_stealing, was_picked_off, run_scored) FROM stdin;
\.


--
-- Data for Name: game_events; Type: TABLE DATA; Schema: data; Owner: -
--

COPY data.game_events (id, perceived_at, game_id, event_type, event_index, inning, top_of_inning, outs_before_play, batter_id, batter_team_id, pitcher_id, pitcher_team_id, home_score, away_score, home_strike_count, away_strike_count, batter_count, pitches, total_strikes, total_balls, total_fouls, is_leadoff, is_pinch_hit, lineup_position, is_last_event_for_plate_appearance, bases_hit, runs_batted_in, is_sacrifice_hit, is_sacrifice_fly, outs_on_play, is_double_play, is_triple_play, is_wild_pitch, batted_ball_type, is_bunt, errors_on_play, batter_base_after_play, is_last_game_event, event_text, additional_context, season, day, parsing_error, parsing_error_list, fixed_error, fixed_error_list) FROM stdin;
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: data; Owner: -
--

COPY data.games (game_id, day, season, last_game_event, home_odds, away_odds, weather, series_index, series_length, is_postseason, home_team, away_team, home_score, away_score, number_of_innings, ended_on_top_of_inning, ended_in_shame, terminology_id, rules_id, statsheet_id) FROM stdin;
\.


--
-- Data for Name: imported_logs; Type: TABLE DATA; Schema: data; Owner: -
--

COPY data.imported_logs (id, key, imported_at) FROM stdin;
\.


--
-- Data for Name: outcomes; Type: TABLE DATA; Schema: data; Owner: -
--

COPY data.outcomes (id, game_event_id, entity_id, event_type, original_text) FROM stdin;
\.


--
-- Data for Name: player_modifications; Type: TABLE DATA; Schema: data; Owner: -
--

COPY data.player_modifications (player_modifications_id, player_id, modification, valid_from, valid_until) FROM stdin;
\.


--
-- Data for Name: players; Type: TABLE DATA; Schema: data; Owner: -
--

COPY data.players (id, player_id, valid_from, valid_until, player_name, deceased, hash, anticapitalism, base_thirst, buoyancy, chasiness, coldness, continuation, divinity, ground_friction, indulgence, laserlikeness, martyrdom, moxie, musclitude, omniscience, overpowerment, patheticism, ruthlessness, shakespearianism, suppression, tenaciousness, thwackability, tragicness, unthwackability, watchfulness, pressurization, cinnamon, total_fingers, soul, fate, peanut_allergy, armor, bat, ritual, coffee, blood, url_slug) FROM stdin;
\.


--
-- Data for Name: team_modifications; Type: TABLE DATA; Schema: data; Owner: -
--

COPY data.team_modifications (team_modifications_id, team_id, modification, valid_from, valid_until) FROM stdin;
\.


--
-- Data for Name: team_roster; Type: TABLE DATA; Schema: data; Owner: -
--

COPY data.team_roster (team_roster_id, team_id, position_id, valid_from, valid_until, player_id, position_type_id) FROM stdin;
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: data; Owner: -
--

COPY data.teams (id, team_id, location, nickname, full_name, valid_from, valid_until, hash) FROM stdin;
\.


--
-- Data for Name: time_map; Type: TABLE DATA; Schema: data; Owner: -
--

COPY data.time_map (season, day, first_time, time_map_id) FROM stdin;
\.


--
-- Data for Name: attributes; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.attributes (attribute_id, attribute_text, attribute_desc, attribute_objects, attributes_short, attribute_short) FROM stdin;
33	suppression	\N	\N	\N	
34	pressurization	\N	\N	\N	Pr
35	chasiness	\N	\N	\N	Ch
36	peanut_allergy	\N	\N	\N	
37	unthwackability	\N	\N	\N	Un
38	moxie	\N	\N	\N	Mo
39	base_thirst	\N	\N	\N	Bt
40	soul	\N	\N	\N	
41	indulgence	\N	\N	\N	I
42	tragicness	\N	\N	\N	Tr
43	musclitude	\N	\N	\N	Ms
44	anticapitalism	\N	\N	\N	A
45	total_fingers	\N	\N	\N	
46	ground_friction	\N	\N	\N	G
47	divinity	\N	\N	\N	Dv
48	overpowerment	\N	\N	\N	Ov
49	coffee	\N	\N	\N	
50	thwackability	\N	\N	\N	Tw
51	shakespearianism	\N	\N	\N	S
52	laserlikeness	\N	\N	\N	L
53	tenaciousness	\N	\N	\N	Te
54	continuation	\N	\N	\N	Cn
55	cinnamon	\N	\N	\N	Ci
56	watchfulness	\N	\N	\N	W
57	martyrdom	\N	\N	\N	Mr
58	omniscience	\N	\N	\N	Om
59	blood	\N	\N	\N	
60	fate	\N	\N	\N	
61	coldness	\N	\N	\N	Co
62	buoyancy	\N	\N	\N	Bu
63	ruthlessness	\N	\N	\N	R
64	patheticism	\N	\N	\N	Pa
\.


--
-- Data for Name: blessings; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.blessings (blessing_id, blessing_short, blessing, blessing_desc, blessing_value, season, team_id) FROM stdin;
\N	\N	Hitting Boost	Give your players cups of Yes Plz coffee. This will boost your team's hitting by 10%.	\N	0	7966eb04-efcc-499b-8f03-d13916330531
\N	\N	Max Out Hitter	This will max out the hitting stats of a random hitter on your team.	\N	0	b024e975-1c4a-4575-8936-a3754a08806a
\N	\N	Max Out Pitcher	This will max out the hitting stats of a random pitcher on your team.	\N	0	adc5b394-8f76-416d-9ce9-813706877b84
\N	\N	Mysterious Improvement	This blessing happened at the same time as the regular election but were not officially part of said election.	\N	0	adc5b394-8f76-416d-9ce9-813706877b84
\N	\N	Mystery Defection	This blessing happened at the same time as the regular election but were not officially part of said election.	\N	0	979aee4a-6d80-4863-bf1c-ee1a78e06024
\N	\N	Pitching Boost	Your pitchers each grow an extra finger. This will boost your team's pitching by 10%.	\N	0	747b8e4a-7e50-4638-a973-ea7950a3e739
\N	\N	Randomize Players	Your five worst players will be sent into deep hypnosis, randomizing their stats.	\N	0	747b8e4a-7e50-4638-a973-ea7950a3e739
\N	\N	Steal Best Pitcher	This will steal the highest rated pitcher in the league to your team.	\N	0	8d87c468-699a-47a8-b40d-cfb73a5660ad
\N	\N	Team Boost	Your team goes to a team-building workshop. This will boost your team's stats overall by 6%.	\N	0	8d87c468-699a-47a8-b40d-cfb73a5660ad
\N	\N	Bloodlust	URRRRRRGGHHHHHH. Maxes the stats of a random player on your team.	\N	1	b72f3061-f573-40d7-832a-5ad475bd7909
\N	\N	Defection	It's business. The best pitcher in the league joins your team.	\N	1	eb67ae5e-c4bf-46ca-bbbc-425cd34182ff
\N	\N	Gunblade Bat	A random hitter on your team will gain the gunblade bat, maxing out their hitting stats.	\N	1	979aee4a-6d80-4863-bf1c-ee1a78e06024
\N	\N	Literal Arm Cannon	A random pitcher on your team will gain an arm cannon, maxing out their pitching stats.	\N	1	adc5b394-8f76-416d-9ce9-813706877b84
\N	\N	Performance Enhancing Demons	Mggoka match ng strike fm'latghor. Fm'latgh. +8% Team Overall	\N	1	b72f3061-f573-40d7-832a-5ad475bd7909
\N	\N	Pseudo-Thumbs	Pseudo-Thumbs burst from the skin on the opposite of your pitchers' hands. +10% Team Pitching	\N	1	105bc3ff-1320-4e37-8ef0-8d595cb95dd0
\N	\N	Seduction	Swing Away. The best hitter in the league joins your team.	\N	1	747b8e4a-7e50-4638-a973-ea7950a3e739
\N	\N	Soul Swap	They won't stop screaming. Randomizes your team's 5 worst players.	\N	1	36569151-a2fb-43c1-9df7-2df512424c82
\N	\N	Wind Sprints	Run. +15% Team Baserunning	\N	1	adc5b394-8f76-416d-9ce9-813706877b84
\N	\N	Yes Plz!	Wake up your hitters with a cup of Yes Plz coffee. +10% Team Hitting	\N	1	bfd38797-8404-4b38-8b82-341da28b1f83
\N	\N	Anticapitalism	Your team will become fully anticapitalist.	\N	2	878c1bf6-0d21-4659-bfee-916c8314d69c
\N	\N	Bloodlust	URRRRRRGGHHHHHH. Maxes the stats of a random player on your team.	\N	2	747b8e4a-7e50-4638-a973-ea7950a3e739
\N	\N	Evil Wind Sprints	The Wind can be Evil. Run. +15% Team Baserunning	\N	2	a37f9158-7f82-46bc-908c-c9e2dda7c33b
\N	\N	Exile	Send your team's worst hitter to a random other team. Receive a random player back.	\N	2	747b8e4a-7e50-4638-a973-ea7950a3e739
\N	\N	Exploratory Surgeries	Re-rolls your team's worst 3 pitchers	\N	2	878c1bf6-0d21-4659-bfee-916c8314d69c
\N	\N	Headhunter	The best hitter in your team's subleague (Good or Evil) joins your team.	\N	2	8d87c468-699a-47a8-b40d-cfb73a5660ad
\N	\N	Highway Robbery	The best player in the league joins your team.	\N	2	a37f9158-7f82-46bc-908c-c9e2dda7c33b
\N	\N	Performance Enhancing Demons	Mggoka match ng strike fm'latghor. Fm'latgh. +8% Team Overall	\N	2	ca3f1c8c-c025-4d8e-8eef-5be6accbeb16
\N	\N	Pretty Plz?	Feed your hitters coffee grounds. Team hitting changes from -5% to +15%	\N	2	105bc3ff-1320-4e37-8ef0-8d595cb95dd0
\N	\N	Pseudo-Thumbs	Pseudo-Thumbs burst from the skin on the opposite of your pitchers' hands. +10% Team Pitching	\N	2	105bc3ff-1320-4e37-8ef0-8d595cb95dd0
\N	\N	Rigour Mortis	Stiff Limbs. -10% team baserunning to your team's division opponents.	\N	2	9debc64f-74b7-4ae1-a4d6-fce0144b6ea5
\N	\N	Summoning Circle	Re-rolls your team's 3 worst hitters	\N	2	adc5b394-8f76-416d-9ce9-813706877b84
\N	\N	Team-Building Exercise	Re-rolls your team's three worst players	\N	2	ca3f1c8c-c025-4d8e-8eef-5be6accbeb16
\N	\N	The Rack	[cartilage and bone snapping] +15% Team Defense	\N	2	adc5b394-8f76-416d-9ce9-813706877b84
\N	\N	Vulture	The best player in your team's division joins your team.	\N	2	ca3f1c8c-c025-4d8e-8eef-5be6accbeb16
\N	\N	Evil Wind Sprints	The Wind can be Evil. Run. +15% Team Baserunning	\N	3	b63be8c2-576a-4d6e-8daf-814f8bcea96f
\N	\N	Exploratory Surgeries	Re-rolls your team's 3 worst pitchers	\N	3	3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e
\N	\N	Extra Elbows	Improve 3 random pitchers on your team by one Star (20%)	\N	3	b72f3061-f573-40d7-832a-5ad475bd7909
\N	\N	Getting in Their Heads (Literally)	Impair your Division opponents' Max Vibes by 7%	\N	3	3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e
\N	\N	Grappling Hook	Item. A random player on your team gets improved Baserunning and Defense.	\N	3	bfd38797-8404-4b38-8b82-341da28b1f83
\N	\N	Keeping it Wavy	Improve your Team's Min Vibes by 15%	\N	3	979aee4a-6d80-4863-bf1c-ee1a78e06024
\N	\N	Mutual Aid	Praxis. Swap the positions of your worst hitter and worst pitcher.	\N	3	8d87c468-699a-47a8-b40d-cfb73a5660ad
\N	\N	Non-Dominant Arms	Maybe try throwing with the other one? Team pitching changes anywhere from -5% to +15%	\N	3	adc5b394-8f76-416d-9ce9-813706877b84
\N	\N	Precognition	Vision of things to come. Improve 3 random hitters on your team by one Star (20%)	\N	3	f02aeae2-5e6a-4098-9842-02d2273f25c7
\N	\N	Questioning Their Every Decision	Just asking questions. Impair your Division opponents' Min Vibes by 7%	\N	3	eb67ae5e-c4bf-46ca-bbbc-425cd34182ff
\N	\N	Solidarity	Improve your Team's Max Vibes by 15%	\N	3	747b8e4a-7e50-4638-a973-ea7950a3e739
\N	\N	Summoning Circle	Re-rolls your team's 3 worst hitters	\N	3	9debc64f-74b7-4ae1-a4d6-fce0144b6ea5
\N	\N	The Best Defense	Is good offense. Swap your best hitting pitcher into your lineup.	\N	3	8d87c468-699a-47a8-b40d-cfb73a5660ad
\N	\N	Steal Best Hitter	This will steal the highest rated hitter in the league to your team.	\N	0	23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7
\N	\N	The Rack	[cartilage and bone snapping] +15% Team Defense	\N	1	23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7
\N	\N	Go Away	Send your team's worst pitcher to a random team. Receive a random player back.	\N	2	23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7
\N	\N	The Best Offense	Is good defense. Swap your best pitching hitter into your rotation.	\N	3	23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7
\N	\N	The Rack	[cartilage and bone snapping] +15% Team Defense	\N	3	979aee4a-6d80-4863-bf1c-ee1a78e06024
\N	\N	Bad Neighbors	Impair your Division opponents' Overall rating by 3%.	\N	4	bfd38797-8404-4b38-8b82-341da28b1f83
\N	\N	Falling Stars	Improve 4 random players on your team by one Star (20%).	\N	4	8d87c468-699a-47a8-b40d-cfb73a5660ad
\N	\N	Fireproof Jacket	Armor. Protect a random Player on your team from incinerations.	\N	4	747b8e4a-7e50-4638-a973-ea7950a3e739
\N	\N	Flame-Resistant Foam	Your team is protected from Incinerations for the following season.	\N	4	eb67ae5e-c4bf-46ca-bbbc-425cd34182ff
\N	\N	Horde Hallucinations	They're coming! Improve your Team's Baserunning anywhere from -8% to +24%.	\N	4	8d87c468-699a-47a8-b40d-cfb73a5660ad
\N	\N	Katamari	Grab everything you can. Improve your Team's Defense anywhere from -8% to +24%.	\N	4	ca3f1c8c-c025-4d8e-8eef-5be6accbeb16
\N	\N	Keeping it Wavy	Improve your Team's Min Vibes by 15%	\N	4	adc5b394-8f76-416d-9ce9-813706877b84
\N	\N	Mutual Aid	Praxis. Swap the positions of your worst hitter and worst pitcher.	\N	4	b024e975-1c4a-4575-8936-a3754a08806a
\N	\N	Noise-Cancelling Headphones	Have you heard a thing we said? Armor. Protect a random Player on your team from Feedback.	\N	4	747b8e4a-7e50-4638-a973-ea7950a3e739
\N	\N	Rollback Netcode	Improve your Team's Overall rating anywhere from -3% to +9%.	\N	4	8d87c468-699a-47a8-b40d-cfb73a5660ad
\N	\N	Seduction	Swing Away. The best hitter in the league joins your team.	\N	4	a37f9158-7f82-46bc-908c-c9e2dda7c33b
\N	\N	Solidarity	Improve your Team's Max Vibes by 15%	\N	4	979aee4a-6d80-4863-bf1c-ee1a78e06024
\N	\N	Soul Swap	They won't stop screaming. Randomizes your team's 5 worst players.	\N	4	bfd38797-8404-4b38-8b82-341da28b1f83
\N	\N	The Plan? Hit from the Mound	Steal the best hitting pitcher in the league.	\N	4	b024e975-1c4a-4575-8936-a3754a08806a
\N	\N	The Plan? Pitch from the Plate	Steal the best pitching hitter in the league.	\N	4	8d87c468-699a-47a8-b40d-cfb73a5660ad
\N	\N	Wax	Your team is protected from Feedback for the following season.	\N	4	979aee4a-6d80-4863-bf1c-ee1a78e06024
\N	\N	Mushroom	Item. A random player on your team becomes BIG. Increased Power, Max Vibe. Decreased Baserunning.	\N	3	57ec08cc-0411-4643-b304-0e80dbc15ac7
\N	\N	Blood Sacrifice	Your team sacrifices a fan from the stands. The Gods show favor. Your team will win all tiebreakers.	\N	1	23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7
\.


--
-- Data for Name: blood; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.blood (blood_id, blood_type) FROM stdin;
0	A
1	AAA
2	AA
3	Acidic
4	Basic
5	O
6	O No
7	H₂O
8	Electric
9	Love
10	Fire
11	Psychic
12	Grass
\.


--
-- Data for Name: change_types; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.change_types (change_type_id, change_type) FROM stdin;
1	Modification
2	Outcome
3	Both
\.


--
-- Data for Name: changes; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.changes (change_id, change, change_text, change_definition, change_phase_id, change_type_id, change_target) FROM stdin;
5	ALTERNATE	Alternate	This player is an Alternate...	\N	3	player
6	SOUNDPROOF	Soundproof	A Soundproof player can not be caught in Feedback's reality flickers.	\N	1	{player, team}
7	SHELLED	Shelled	A Shelled player is Shelled.	\N	1	player
8	REVERBERATING	Reverberating	A Reverberating player has a small chance of batting again after each of their At-Bats end.	\N	1	player
1	EXTRA_STRIKE	The Fourth Strike	Those with the Fourth Strike will get an extra strike in each at bat.	\N	1	team
2	SHAME_PIT	Targeted Shame	Teams with Targeted Shame will star with negative runs the game after being shamed.	\N	1	team
3	HOME_FIELD	Home Field Advantage	Teams with Home Field Advantage will start each home game with one run.	\N	1	team
4	FIREPROOF	Fireproof	A Fireproof player can not be incinerated.	\N	1	{player, team}
9	BLOOD_PITY	Blood Pity	In the Blood Bath each season, this team must give Stars to the team that finished last in their division.	\N	1	team
10	BLOOD_WINNER	Blood Winner	In the Blood Bath each season, this team must give Stars to the team that finished first in their division.	\N	1	team
11	BLOOD_DONOR	Blood Donor	In the Blood Bath each season, this team will donate Stars to a division opponent that finished behind them in the standings.	\N	1	team
12	BLOOD_THIEF	Blood Thief	In the Blood Bath each season, this team will steal Stars from a division opponent that finished ahead of them in the standings.	\N	1	team
13	BLOOD_FAITH	Blood Faith	In the Blood Bath each season, this player will receive a small boost to a random stat.	\N	1	team
14	BLOOD_LAW	Blood Law	In the Blood Bath each season, this team will gain or lose Stars depending on how low or high they finish in their division.	\N	1	team
15	BLOOD_CHAOS	Blood Chaos	In the Blood Bath each season, each player on this team will gain or lose a random amount of Stars.	\N	1	team
16	BLOOD_DRAIN	Blood Drain	The Blood Drain gurgles, one player siphoned some stats from another.	\N	2	player
17	FEEDBACK	Feedback	Two players switch teams in the feedback.	\N	2	roster
18	INCINERATION	Incineration	A Rogue Umpire incinerated the player!	\N	2	player
19	PEANUT_BAD	Peanut Allergy	The player swallowed a stray Peanut and had an allergic reaction!	\N	2	player
24	ELECTION	Election	An offeason Decree or Blessing has caused a change.	\N	2	{player, roster, team}
23	ARMOR_ITEM	Armor/Item	An Item or Armor has caused a change.	\N	2	player
22	REVERB_PLAYER	Player Reverb	A Reverberating player has a small change of batting again after each of their At-Bats end.	\N	1	player
20	PEANUT_GOOD	Yummy Peanut	The player swallowed a stray Peanut and had a yummy reaction!\t\t\t\t\t\t	\N	2	player
21	REVERB_ALL	Team Reverb	The team had their entire team shuffled in the Reverb!	\N	2	roster
\.


--
-- Data for Name: coffee; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.coffee (coffee_id, coffee_text) FROM stdin;
0	Black
1	Light & Sweet
2	Macchiato
3	Cream & Sugar
4	Cold Brew
5	Flat White
6	Americano
7	Expresso
8	Heavy Foam
9	Latte
10	Decaf
11	Milk Substitute
12	Plenty of Sugar
13	Anything
\.


--
-- Data for Name: division_teams; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.division_teams (division_teams_id, division_id, team_id, valid_from, valid_until) FROM stdin;
1	fadc9684-45b3-47a6-b647-3be3f0735a84	57ec08cc-0411-4643-b304-0e80dbc15ac7	2020-09-06 15:26:34.254566	\N
2	fadc9684-45b3-47a6-b647-3be3f0735a84	979aee4a-6d80-4863-bf1c-ee1a78e06024	2020-09-06 15:26:34.254566	\N
3	fadc9684-45b3-47a6-b647-3be3f0735a84	23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7	2020-09-06 15:26:34.254566	\N
4	fadc9684-45b3-47a6-b647-3be3f0735a84	bfd38797-8404-4b38-8b82-341da28b1f83	2020-09-06 15:26:34.254566	\N
5	fadc9684-45b3-47a6-b647-3be3f0735a84	7966eb04-efcc-499b-8f03-d13916330531	2020-09-06 15:26:34.254566	\N
6	f711d960-dc28-4ae2-9249-e1f320fec7d7	b72f3061-f573-40d7-832a-5ad475bd7909	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
7	f711d960-dc28-4ae2-9249-e1f320fec7d7	878c1bf6-0d21-4659-bfee-916c8314d69c	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
8	f711d960-dc28-4ae2-9249-e1f320fec7d7	b024e975-1c4a-4575-8936-a3754a08806a	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
9	f711d960-dc28-4ae2-9249-e1f320fec7d7	adc5b394-8f76-416d-9ce9-813706877b84	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
10	f711d960-dc28-4ae2-9249-e1f320fec7d7	ca3f1c8c-c025-4d8e-8eef-5be6accbeb16	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
11	5eb2271a-3e49-48dc-b002-9cb615288836	bfd38797-8404-4b38-8b82-341da28b1f83	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
12	5eb2271a-3e49-48dc-b002-9cb615288836	3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
13	5eb2271a-3e49-48dc-b002-9cb615288836	979aee4a-6d80-4863-bf1c-ee1a78e06024	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
14	5eb2271a-3e49-48dc-b002-9cb615288836	7966eb04-efcc-499b-8f03-d13916330531	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
15	5eb2271a-3e49-48dc-b002-9cb615288836	36569151-a2fb-43c1-9df7-2df512424c82	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
16	765a1e03-4101-4e8e-b611-389e71d13619	8d87c468-699a-47a8-b40d-cfb73a5660ad	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
17	765a1e03-4101-4e8e-b611-389e71d13619	23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
18	765a1e03-4101-4e8e-b611-389e71d13619	f02aeae2-5e6a-4098-9842-02d2273f25c7	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
19	765a1e03-4101-4e8e-b611-389e71d13619	57ec08cc-0411-4643-b304-0e80dbc15ac7	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
20	765a1e03-4101-4e8e-b611-389e71d13619	747b8e4a-7e50-4638-a973-ea7950a3e739	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
21	7fbad33c-59ab-4e80-ba63-347177edaa2e	eb67ae5e-c4bf-46ca-bbbc-425cd34182ff	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
22	7fbad33c-59ab-4e80-ba63-347177edaa2e	9debc64f-74b7-4ae1-a4d6-fce0144b6ea5	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
23	7fbad33c-59ab-4e80-ba63-347177edaa2e	b63be8c2-576a-4d6e-8daf-814f8bcea96f	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
24	7fbad33c-59ab-4e80-ba63-347177edaa2e	105bc3ff-1320-4e37-8ef0-8d595cb95dd0	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
25	7fbad33c-59ab-4e80-ba63-347177edaa2e	a37f9158-7f82-46bc-908c-c9e2dda7c33b	2020-07-29 08:12:22.438	2020-09-06 15:26:39.925823
26	d4cc18de-a136-4271-84f1-32516be91a80	b72f3061-f573-40d7-832a-5ad475bd7909	2020-09-06 15:26:34.254566	\N
27	d4cc18de-a136-4271-84f1-32516be91a80	8d87c468-699a-47a8-b40d-cfb73a5660ad	2020-09-06 15:26:34.254566	\N
28	d4cc18de-a136-4271-84f1-32516be91a80	36569151-a2fb-43c1-9df7-2df512424c82	2020-09-06 15:26:34.254566	\N
29	d4cc18de-a136-4271-84f1-32516be91a80	ca3f1c8c-c025-4d8e-8eef-5be6accbeb16	2020-09-06 15:26:34.254566	\N
30	d4cc18de-a136-4271-84f1-32516be91a80	a37f9158-7f82-46bc-908c-c9e2dda7c33b	2020-09-06 15:26:34.254566	\N
31	98c92da4-0ea7-43be-bd75-c6150e184326	9debc64f-74b7-4ae1-a4d6-fce0144b6ea5	2020-09-06 15:26:34.254566	\N
32	98c92da4-0ea7-43be-bd75-c6150e184326	3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e	2020-09-06 15:26:34.254566	\N
33	98c92da4-0ea7-43be-bd75-c6150e184326	b63be8c2-576a-4d6e-8daf-814f8bcea96f	2020-09-06 15:26:34.254566	\N
34	98c92da4-0ea7-43be-bd75-c6150e184326	f02aeae2-5e6a-4098-9842-02d2273f25c7	2020-09-06 15:26:34.254566	\N
35	98c92da4-0ea7-43be-bd75-c6150e184326	878c1bf6-0d21-4659-bfee-916c8314d69c	2020-09-06 15:26:34.254566	\N
36	456089f0-f338-4620-a014-9540868789c9	747b8e4a-7e50-4638-a973-ea7950a3e739	2020-09-06 15:26:34.254566	\N
37	456089f0-f338-4620-a014-9540868789c9	eb67ae5e-c4bf-46ca-bbbc-425cd34182ff	2020-09-06 15:26:34.254566	\N
38	456089f0-f338-4620-a014-9540868789c9	105bc3ff-1320-4e37-8ef0-8d595cb95dd0	2020-09-06 15:26:34.254566	\N
39	456089f0-f338-4620-a014-9540868789c9	b024e975-1c4a-4575-8936-a3754a08806a	2020-09-06 15:26:34.254566	\N
40	456089f0-f338-4620-a014-9540868789c9	adc5b394-8f76-416d-9ce9-813706877b84	2020-09-06 15:26:34.254566	\N
\.


--
-- Data for Name: divisions; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.divisions (division_db_id, division_text, league_id, valid_until, division_seasons, division_id, valid_from) FROM stdin;
1	Lawful Good	1	2020-09-06 15:26:39.925823	{0,1,2,3,4}	f711d960-dc28-4ae2-9249-e1f320fec7d7	2020-07-29 08:12:22.438
2	Chaotic Good	1	2020-09-06 15:26:39.925823	{0,1,2,3,4}	5eb2271a-3e49-48dc-b002-9cb615288836	2020-07-29 08:12:22.438
3	Lawful Evil	2	2020-09-06 15:26:39.925823	{0,1,2,3,4}	765a1e03-4101-4e8e-b611-389e71d13619	2020-07-29 08:12:22.438
4	Chaotic Evil	2	2020-09-06 15:26:39.925823	{0,1,2,3,4}	7fbad33c-59ab-4e80-ba63-347177edaa2e	2020-07-29 08:12:22.438
5	Wild High	3	\N	{5}	d4cc18de-a136-4271-84f1-32516be91a80	2020-09-06 15:26:34.254566
6	Wild Low	3	\N	{5}	98c92da4-0ea7-43be-bd75-c6150e184326	2020-09-06 15:26:34.254566
7	Mild High	4	\N	{5}	456089f0-f338-4620-a014-9540868789c9	2020-09-06 15:26:34.254566
8	Mild Low	4	\N	{5}	fadc9684-45b3-47a6-b647-3be3f0735a84	2020-09-06 15:26:34.254566
\.


--
-- Data for Name: event_types; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.event_types (event_type_id, event_type, plate_appearance, at_bat, hit, total_bases, "out") FROM stdin;
1	CAUGHT_STEALING	0	0	0	0	1
4	FIELDERS_CHOICE	1	1	0	1	1
6	OUT	1	1	0	0	1
9	STRIKEOUT	1	1	0	0	1
3	DOUBLE	1	1	1	2	0
5	HOME_RUN	1	1	1	4	0
7	SINGLE	1	1	1	1	0
8	STOLEN_BASE	0	0	0	0	0
10	TRIPLE	1	1	1	3	0
12	UNKNOWN	0	0	0	0	0
11	WALK	1	0	0	1	0
13	HIT_BY_PITCH	1	0	0	1	0
26	SACRIFICE	1	0	0	0	1
27	QUADRUPLE	1	1	1	4	0
28	XL_HOME_RUN	1	1	1	5	0
\.


--
-- Data for Name: leagues; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.leagues (league_db_id, league_text, league_seasons, valid_until, league_id, valid_from) FROM stdin;
1	Good	{0,1,2,3,4}	2020-09-06 15:26:34.254566	7d3a3dd6-9ea1-4535-9d91-bde875c85e80	2020-07-29 08:12:22.438
2	Evil	{0,1,2,3,4}	2020-09-06 15:26:34.254566	93e58443-9617-44d4-8561-e254a1dbd450	2020-07-29 08:12:22.438
3	Wild	{5}	\N	aabc11a1-81af-4036-9f18-229c759ca8a9	2020-09-06 15:26:34.254566
4	Mild	{5}	\N	4fe65afa-804f-4bb2-9b15-1281b2eab110	2020-09-06 15:26:34.254566
\.


--
-- Data for Name: player_url_slugs; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.player_url_slugs (player_url_slug_id, player_id, valid_from, valid_until, player_url_slug) FROM stdin;
1	5ca7e854-dc00-4955-9235-d7fcd732ddcf	2020-08-09 19:27:41.958	2020-08-12 21:25:43.399	wyatt-mason-6
2	0d5300f6-0966-430f-903f-a4c2338abf00	2020-08-09 19:27:41.958	2020-08-12 21:55:48.749	wyatt-mason-3
3	63df8701-1871-4987-87d7-b55d4f1df2e9	2020-08-09 19:27:41.958	2020-08-12 22:10:51.203	wyatt-mason-7
4	f741dc01-2bae-4459-bfc0-f97536193eea	2020-08-09 19:27:41.958	2020-08-12 21:25:43.399	wyatt-mason-14
5	ea44bd36-65b4-4f3b-ac71-78d87a540b48	2020-08-09 19:27:41.958	2020-08-12 21:40:45.977	wyatt-mason-13
6	a1ed3396-114a-40bc-9ff0-54d7e1ad1718	2020-08-09 19:27:41.958	2020-08-12 20:55:38.256	wyatt-mason-9
7	e16c3f28-eecd-4571-be1a-606bbac36b2b	2020-08-09 19:27:41.958	2020-08-12 20:55:38.256	wyatt-mason-11
8	0eea4a48-c84b-4538-97e7-3303671934d2	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	helga-moreno
9	3be2c730-b351-43f7-a832-a5294fe8468f	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	amaya-jackson
10	3c331c87-1634-46c4-87ce-e4b9c59e2969	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	yosh-carpenter
11	43bf6a6d-cc03-4bcf-938d-620e185433e1	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	miguel-javier
12	03d06163-6f06-4817-abe5-0d14c3154236	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	garcia-tabby
13	0bd5a3ec-e14c-45bf-8283-7bc191ae53e4	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	stephanie-donaldson
14	167751d5-210c-4a6e-9568-e92d61bab185	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	jacob-winner
15	1e8b09bd-fbdd-444e-bd7e-10326bd57156	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	fletcher-yamamoto
16	3954bdfa-931f-4787-b9ac-f44b72fe09d7	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	nicholas-nolan
17	3a96d76a-c508-45a0-94a0-8f64cd6beeb4	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	thomas-england
18	1f159bab-923a-4811-b6fa-02bfde50925a	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	wyatt-mason
19	4941976e-31fc-49b5-801a-18abe072178b	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	sebastian-sunshine
20	73265ee3-bb35-40d1-b696-1f241a6f5966	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	parker-meng
21	7c5ae357-e079-4427-a90f-97d164c7262e	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	milo-brown
22	80a2f015-9d40-426b-a4f6-b9911ba3add8	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	paul-barnes
23	9313e41c-3bf7-436d-8bdc-013d3a1ecdeb	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	sandie-nelson
24	9f6d06d6-c616-4599-996b-ec4eefcff8b8	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	silvia-winner
25	b390b28c-df96-443e-b81f-f0104bd37860	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	karato-rangel
26	527c1f6e-a7e4-4447-a824-703b662bae4e	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	melton-campbell
27	57448b62-f952-40e2-820c-48d8afe0f64d	2020-07-29 08:12:22.438	\N	jessi-wise
28	62823073-84b8-46c2-8451-28fd10dff250	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	mckinney-vaughan
29	7158d158-e7bf-4e9b-9259-62e5b25e3de8	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	karato-bean
30	1f159bab-923a-4811-b6fa-02bfde50925a	2020-08-02 10:22:48.089	2020-08-05 21:06:33.008	wyatt-mason
31	7b55d484-6ea9-4670-8145-986cb9e32412	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	stevenson-heat
32	805ba480-df4d-4f56-a4cf-0b99959111b5	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	leticia-lozano
33	89ec77d8-c186-4027-bd45-f407b4800c2c	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	james-mora
34	8a6fc67d-a7fe-443b-a084-744294cec647	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	terrell-bradley
35	960f041a-f795-4001-bd88-5ddcf58ee520	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	mayra-buckley
36	9ac2e7c5-5a34-4738-98d8-9f917bc6d119	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	christian-combs
37	a2483925-697f-468f-931c-bcd0071394e5	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	timmy-manco
38	b3d518b9-dc68-4902-b68c-0022ceb25aa0	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	hendricks-rangel
39	d97835fd-2e92-4698-8900-1f5abea0a3b6	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	king-roland
40	db33a54c-3934-478f-bad4-fc313ac2580e	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	percival-wheeler
41	e749dc27-ca3b-456e-889c-d2ec02ac7f5f	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	aureliano-estes
42	ee55248b-318a-4bfb-8894-1cc70e4e0720	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	theo-king
43	f1185b20-7b4a-4ccc-a977-dc1afdfd4cb9	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	frazier-tosser
44	042962c8-4d8b-44a6-b854-6ccef3d82716	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	ronan-jaylee
45	05bd08d5-7d9f-450b-abfa-1788b8ee8b91	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	stevenson-monstera
46	cbd19e6f-3d08-4734-b23f-585330028665	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	knight-urlacher
47	13cfbadf-b048-4c4f-903d-f9b52616b15c	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	bennett-bowen
48	bd549bfe-b395-4dc0-8546-5c04c08e24a5	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	sam-solis
49	c0732e36-3731-4f1a-abdc-daa9563b6506	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	nagomi-mcdaniel
50	ccc99f2f-2feb-4f32-a9b9-c289f619d84c	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	itsuki-winner
51	cd6b102e-1881-4079-9a37-455038bbf10e	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	caleb-morin
52	fbb5291c-2438-400e-ab32-30ce1259c600	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	cory-novak
53	0cc5bd39-e90d-42f9-9dd8-7e703f316436	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	don-elliott
54	0daf04fc-8d0d-4513-8e98-4f610616453b	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	lee-mist
55	0eddd056-9d72-4804-bd60-53144b785d5c	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	caleb-novak
56	12577256-bc4e-4955-81d6-b422d895fb12	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	jasmine-washington
57	76c4853b-7fbc-4688-8cda-c5b8de1724e4	2020-07-29 08:12:22.438	\N	lars-mendoza
58	17397256-c28c-4cad-85f2-a21768c66e67	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	cory-ross
59	3f08f8cd-6418-447a-84d3-22a981c68f16	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	pollard-beard
60	4fe28bc1-f690-4ad6-ad09-1b2e984bf30b	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	cell-longarms
61	6b8d128f-ed51-496d-a965-6614476f8256	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	orville-manco
62	721fb947-7548-49ea-8cbe-7721b0ed49e0	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	tamara-lopez
63	732899a3-2082-4d9f-b1c2-74c8b75e15fb	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	minato-ito
64	4bda6584-6c21-4185-8895-47d07e8ad0c0	2020-07-29 08:12:22.438	\N	aldon-anthony
65	740d5fef-d59f-4dac-9a75-739ec07f91cf	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	conner-haley
66	81a0889a-4606-4f49-b419-866b57331383	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	summers-pony
67	82d1b7b4-ce00-4536-8631-a025f05150ce	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	sam-scandal
68	1aec2c01-b766-4018-a271-419e5371bc8f	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	rush-ito
69	20be1c34-071d-40c6-8824-dde2af184b4d	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	qais-dogwalker
70	2e6d4fa9-f930-47bd-971a-dd54a3cf7db1	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	raul-leal
71	4aa843a4-baa1-4f35-8748-63aa82bd0e03	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	aureliano-dollie
72	5a26fc61-d75d-4c01-9ce2-1880ffb5550f	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	randy-dennis
73	64b055d1-b691-4e0c-8583-fc08ba663846	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	theodore-passon
74	7fed72df-87de-407d-8253-2295a2b60d3b	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	stout-schmitt
75	b7ca8f3f-2fdc-477b-84f4-157f2802e9b5	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	leach-herman
76	c17a4397-4dcc-440e-8c53-d897e971cae9	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	august-mina
77	c6bd21a8-7880-4c00-8abe-33560fe84ac5	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	wendy-cerna
78	c83f0fe0-44d1-4342-81e8-944bb38f8e23	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	langley-wheeler
79	d796d287-77ef-49f0-89ef-87bcdeb280ee	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	izuki-clark
80	dd7e710f-da4e-475b-b870-2c29fe9d8c00	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	itsuki-weeks
81	889c9ef9-d521-4436-b41c-9021b81b4dfb	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	liam-snail
82	c83a13f6-ee66-4b1c-9747-faa67395a6f1	2020-07-29 08:12:22.438	\N	zi-delacruz
83	8903a74f-f322-41d2-bd75-dbf7563c4abb	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	francisca-sasquatch
84	97ec5a2f-ac1a-4cde-86b7-897c030a1fa8	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	alston-woods
85	9820f2c5-f9da-4a07-b610-c2dd7bee2ef6	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	dan-bong
86	af6b3edc-ed52-4edc-b0c9-14e0a5ae0ee3	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	rivers-clembons
87	1f159bab-923a-4811-b6fa-02bfde50925a	2020-08-05 21:06:33.008	2020-08-06 01:22:06.166	wyatt-mason
88	b019fb2b-9f4b-4deb-bf78-6bee2f16d98d	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	gloria-bentley
89	b7adbbcc-0679-43f3-a939-07f009a393db	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	jode-crutch
90	1f159bab-923a-4811-b6fa-02bfde50925a	2020-08-06 01:22:06.166	2020-08-06 10:08:37.49	wyatt-mason
91	bbf9543f-f100-445a-a467-81d7aab12236	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	farrell-seagull
92	c22e3af5-9001-465f-b450-864d7db2b4a0	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	logan-horseman
93	c4418663-7aa4-4c9f-ae73-0e81e442e8a2	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	chris-thibault
94	d5192d95-a547-498a-b4ea-6770dde4b9f5	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	summers-slugger
95	ebf2da50-7711-46ba-9e49-341ce3487e00	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	baldwin-jones
96	fdfd36c7-e0c1-4fce-98f7-921c3d17eafe	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	reese-harrington
97	1513aab6-142c-48c6-b43e-fbda65fd64e8	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	caleb-alvarado
98	16aff709-e855-47c8-8818-b9ba66e90fe8	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	mullen-peterson
99	20e13b56-599b-4a22-b752-8059effc81dc	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	lou-roseheart
100	3c051b92-4a86-4157-988a-e334bf6dc691	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	tyler-leatherman
101	43d5da5f-c6a1-42f1-ab7f-50ea956b6cd5	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	justice-spoon
102	262c49c6-8301-487d-8356-747023fa46a9	2020-07-29 08:12:22.438	\N	alexandria-dracaena
103	4bf352d2-6a57-420a-9d45-b23b2b947375	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	rivers-rosa
104	520e6066-b14b-45cf-985c-0a6ee2dc3f7a	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	zi-sliders
105	54e5f222-fb16-47e0-adf9-21813218dafa	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	grit-watson
106	f0bcf4bb-74b3-412e-a54c-04c12ad28ecb	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	hahn-fox
107	fcbe1d14-04c4-4331-97ad-46e170610633	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	jode-preston
108	0f61d948-4f0c-4550-8410-ae1c7f9f5613	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	tamara-crankit
109	16a59f5f-ef0f-4ada-8682-891ad571a0b6	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	boyfriend-berger
110	3de17e21-17db-4a6b-b7ab-0b2f3c154f42	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	brewer-vapor
111	4f328502-d347-4d2c-8fad-6ae59431d781	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	stephens-lightner
112	52cfebfb-8008-4b9f-a566-72a30e0b64bf	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	spears-rogers
113	68f98a04-204f-4675-92a7-8823f2277075	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	isaac-johnson
114	69196296-f652-42ff-b2ca-0d9b50bd9b7b	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	joshua-butt
115	7e4f012e-828c-43bb-8b8a-6c33bdfd7e3f	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	patel-olive
116	88ca603e-b2e5-4916-bef5-d6bba03235f5	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	clare-mccall
117	a7edbf19-caf6-45dd-83d5-46496c99aa88	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	rush-valenzuela
118	ad8d15f4-e041-4a12-a10e-901e6285fdc5	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	baby-urlacher
119	bfd9ff52-9bf6-4aaf-a859-d308d8f29616	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	declan-suzanne
120	64aaa3cb-7daf-47e3-89a8-e565a3715b5d	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	travis-nakamura
121	c0177f76-67fc-4316-b650-894159dede45	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	paula-mason
122	c182f33c-aea5-48a2-97ed-dc74fa29b3c0	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	swamuel-mora
123	5fbf04bb-f5ec-4589-ab19-1d89cda056bd	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	donia-dollie
124	678170e4-0688-436d-a02d-c0467f9af8c0	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	baby-doyle
125	75f9d874-5e69-438d-900d-a3fcb1d429b3	2020-08-09 19:27:41.958	2020-08-12 21:10:40.842	wyatt-mason-8
126	0ecf6190-f869-421a-b339-29195d30d37c	2020-08-09 19:27:41.958	\N	mcbaseball-clembons
127	1f159bab-923a-4811-b6fa-02bfde50925a	2020-08-09 19:27:41.958	2020-08-12 21:25:43.399	wyatt-mason
128	90c2cec7-0ed5-426a-9de8-754f34d59b39	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	tot-fox
129	9c3273a0-2711-4958-b716-bfcf60857013	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	kathy-mathews
130	b348c037-eefc-4b81-8edd-dfa96188a97e	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	lowe-forbes
131	b5c95dba-2624-41b0-aacd-ac3e1e1fe828	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	cote-rodgers
132	10ea5d50-ec88-40a0-ab53-c6e11cc1e479	2020-08-09 19:27:41.958	\N	nicholas-vincent
133	b9293beb-d199-4b46-add9-c02f9362d802	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	bauer-zimmerman
134	e4034192-4dc6-4901-bb30-07fe3cf77b5e	2020-08-09 19:27:41.958	2020-08-12 21:25:43.399	wyatt-mason-12
135	bf122660-df52-4fc4-9e70-ee185423ff93	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	walton-sports
136	d81ce662-07b6-4a73-baa4-acbbb41f9dc5	2020-08-09 19:27:41.958	\N	yummy-elliott
137	d23a1f7e-0071-444e-8361-6ae01f13036f	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	edric-tosser
138	d46abb00-c546-4952-9218-4f16084e3238	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	atlas-guerra
139	e4e4c17d-8128-4704-9e04-f244d4573c4d	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	wesley-poole
140	f071889c-f10f-4d2f-a1dd-c5dda34b3e2b	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	zion-facepunch
141	089af518-e27c-4256-adc8-62e3f4b30f43	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	silvia-rugrat
142	80e474a3-7d2b-431d-8192-2f1e27162607	2020-08-12 20:25:34.306	2020-08-12 20:40:36.879	wyatt-mason-15
143	094ad9a1-e2c7-49a0-af18-da0e3eb656ba	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	erickson-sato
144	3af96a6b-866c-4b03-bc14-090acf6ecee5	2020-08-09 19:27:43.22	2020-08-10 18:47:01.611	axel-trololol
145	d5b6b11d-3924-4634-bd50-76553f1f162b	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	ogden-mendoza
146	1f159bab-923a-4811-b6fa-02bfde50925a	2020-08-12 21:25:43.399	\N	nan
147	5ca7e854-dc00-4955-9235-d7fcd732ddcf	2020-08-12 21:25:43.399	\N	wyatt-quitter
148	bf6a24d1-4e89-4790-a4ba-eeb2870cbf6f	2020-08-09 19:27:41.958	2020-08-12 21:40:45.977	wyatt-mason-10
149	ce0a156b-ba7b-4313-8fea-75807b4bc77f	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	conrad-twelve
150	d8ee256f-e3d0-46cb-8c77-b1f88d8c9df9	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	comfort-septemberish
151	dac2fd55-5686-465f-a1b6-6fbed0b417c5	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	russo-slugger
152	e376a90b-7ffe-47a2-a934-f36d6806f17d	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	howell-rocha
153	e6114fd4-a11d-4f6c-b823-65691bb2d288	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	bevan-underbuck
154	ecf19925-dc57-4b89-b114-923d5a714dbe	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	margarito-bishop
155	efafe75e-2f00-4418-914c-9b6675d39264	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	aldon-cashmoney
156	f10ba06e-d509-414b-90cd-4d70d43c75f9	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	hernando-winter
157	f3c07eaf-3d6c-4cc3-9e54-cbecc9c08286	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	campos-arias
158	f4a5d734-0ade-4410-abb6-c0cd5a7a1c26	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	agan-harrison
159	f6342729-a38a-4204-af8d-64b7accb5620	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	marco-winner
160	2b9f9c25-43ec-4f0b-9937-a5aa23be0d9e	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	lawrence-horne
161	316abea7-9890-4fb8-aaea-86b35e24d9be	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	kennedy-rodgers
162	4204c2d1-ca48-4af7-b827-e99907f12d61	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	axel-cardenas
163	4542f0b0-3409-4a4a-a9e1-e8e8e5d73fcf	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	brock-watson
164	65273615-22d5-4df1-9a73-707b23e828d5	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	burke-gonzales
165	6bd4cf6e-fefe-499a-aa7a-890bcc7b53fa	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	igneus-mcdaniel
166	7007cbd3-7c7b-44fd-9d6b-393e82b1c06e	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	rafael-davids
167	19af0d67-c73b-4ef2-bc84-e923c1336db5	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	grit-ramos
168	1f145436-b25d-49b9-a1e3-2d3c91626211	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	joe-voorhees
169	24cb35c1-c24c-45ca-ac0b-f99a2e650d89	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	tyreek-peterson
170	25f3a67c-4ed5-45b6-94b1-ce468d3ead21	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	hobbs-cain
171	27faa5a7-d3a8-4d2d-8e62-47cfeba74ff0	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	spears-nolan
172	3ebb5361-3895-4a50-801e-e7a0ee61750c	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	augusto-reddick
173	51cba429-13e8-487e-9568-847b7b8b9ac5	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	collins-mina
174	542af915-79c5-431c-a271-f7185e37c6ae	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	oliver-notarobot
175	5b9727f7-6a20-47d2-93d9-779f0a85c4ee	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	kennedy-alstott
176	64f59d5f-8740-4ebf-91bd-d7697b542a9f	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	zeke-wallace
177	6524e9e0-828a-46c4-935d-0ee2edeb7e9a	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	carter-turnip
178	80e474a3-7d2b-431d-8192-2f1e27162607	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	summers-preston
179	aa7ac9cb-e9db-4313-9941-9f3431728dce	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	matteo-cash
180	ad1e670a-f346-4bf7-a02f-a91649c41ccb	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	stephanie-winters
181	b7267aba-6114-4d53-a519-bf6c99f4e3a9	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	sosa-hayes
182	bd8778e5-02e8-4d1f-9c31-7b63942cc570	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	cell-barajas
183	bd8d58b6-f37f-48e6-9919-8e14ec91f92a	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	jose-haley
184	ca709205-226d-4d92-8be6-5f7871f48e26	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	rivers-javier
185	70a458ed-25ca-4ff8-97fc-21cbf58f2c2a	2020-07-29 08:12:22.438	\N	trevino-merritt
186	cd68d3a6-7fbc-445d-90f1-970c955e32f4	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	miguel-wheeler
187	ce0e57a7-89f5-41ea-80f9-6e649dd54089	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	yong-wright
188	7853aa8c-e86d-4483-927d-c1d14ea3a34d	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	tucker-flores
189	8f11ad58-e0b9-465c-9442-f46991274557	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	amos-melon
190	90768354-957e-4b4c-bb6d-eab6bbda0ba3	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	eugenia-garbage
191	9ba361a1-16d5-4f30-b590-fc4fc2fb53d2	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	mooney-doctor
192	9be56060-3b01-47aa-a090-d072ef109fbf	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	jesus-koch
193	a691f2ba-9b69-41f8-892c-1acd42c336e4	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	jenkins-good
194	c3b1b4e5-4b88-4245-b2b1-ae3ade57349e	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	wall-osborn
195	c57222fd-df55-464c-a44e-b15443e61b70	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	natha-spruce
196	2b1cb8a2-9eba-4fce-85cf-5d997ec45714	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	isaac-rubberman
197	2cadc28c-88a5-4e25-a6eb-cdab60dd446d	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	elijah-bookbaby
198	3064c7d6-91cc-4c2a-a433-1ce1aabc1ad4	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	jorge-ito
199	ceac785e-55fd-4a4e-9bc8-17a662a58a38	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	best-cerna
200	e4f1f358-ee1f-4466-863e-f329766279d0	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	ronan-combs
201	e919dfae-91c3-475c-b5d5-8b0c14940c41	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	famous-meng
202	f4ca437c-c31c-4508-afe7-6dae4330d717	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	fran-beans
203	24f6829e-7bb4-4e1e-8b59-a07514657e72	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	king-weatherman
204	ceb5606d-ea3f-4471-9ca7-3d2e71a50dde	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	london-simmons
205	d1a7c13f-8e78-4d2e-9cae-ebf3a5fcdb5d	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	elijah-bates
206	d4a10c2a-0c28-466a-9213-38ba3339b65e	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	richmond-harrison
207	d744f534-2352-472b-9e42-cd91fa540f1b	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	tyler-violet
208	d8742d68-8fce-4d52-9a49-f4e33bd2a6fc	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	ortiz-morse
209	e6502bc7-5b76-4939-9fb8-132057390b30	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	greer-lott
210	07ac91e9-0269-4e2c-a62d-a87ef61e3bbe	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	eduardo-perez
211	24ad200d-a45f-4286-bfa5-48909f98a1f7	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	nicholas-summer
212	285ce77d-e5cd-4daa-9784-801347140d48	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	son-scotch
213	30218684-7fa1-41a5-a3b3-5d9cd97dd36b	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	jordan-hildebert
214	4b73367f-b2bb-4df6-b2eb-2a0dd373eead	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	tristin-crankit
215	51985516-5033-4ab8-a185-7bda07829bdb	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	stephanie-schmitt
216	51c5473a-7545-4a9a-920d-d9b718d0e8d1	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	jacob-haynes
217	718dea1a-d9a8-4c2b-933a-f0667b5250e6	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	margarito-nava
218	7a75d626-d4fd-474f-a862-473138d8c376	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	beck-whitney
219	81b25b16-3370-4eb0-9d1b-6d630194c680	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	zeboriah-whiskey
220	98f26a25-905f-4850-8960-b741b0c583a4	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	stu-mcdaniel
221	3afb30c1-1b12-466a-968a-5a9a21458c7f	2020-07-29 08:12:22.438	\N	dickerson-greatness
222	32551e28-3a40-47ae-aed1-ff5bc66be879	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	math-velazquez
223	3a8c52d7-4124-4a65-a20d-d51abcbe6540	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	theodore-holloway
224	446a3366-3fe3-41bb-bfdd-d8717f2152a9	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	marco-escobar
225	503a235f-9fa6-41b5-8514-9475c944273f	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	reese-clark
226	57b4827b-26b0-4384-a431-9f63f715bc5b	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	aureliano-cerna
227	68462bfa-9006-4637-8830-2e7840d9089a	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	parker-horseman
228	6bac62ad-7117-4e41-80f9-5a155a434856	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	grit-freeman
229	7dca7137-b872-46f5-8e59-8c9c996e9d22	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	emmett-tabby
230	90c6e6ca-77fc-42b7-94d8-d8afd6d299e5	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	miki-santana
231	97981e86-4a42-4f85-8783-9f29833c192b	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	daiya-vine
232	a938f586-f5c1-4a35-9e7f-8eaab6de67a6	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	jasper-destiny
233	a98917bc-e9df-4b0e-bbde-caa6168aa3d7	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	jenkins-ingram
234	ab9eb213-0917-4374-a259-458295045021	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	matheo-carpenter
235	c771abab-f468-46e9-bac5-43db4c5b410f	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	wade-howe
236	d9a072f5-1cbb-45ce-87fb-b138e4d8f769	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	francisco-object
237	de67b585-9bf4-4e49-b410-101483ca2fbc	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	shaquille-sunshine
238	defbc540-a36d-460b-afd8-07da2375ee63	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	castillo-turner
239	b86237bb-ade6-4b1d-9199-a3cc354118d9	2020-07-29 08:12:22.438	\N	hurley-pacheco
240	dfd5ccbb-90ed-4bfe-83e0-dae9cc763f10	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	owen-picklestein
241	e3e1d190-2b94-40c0-8e88-baa3fd198d0f	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	chambers-kennedy
242	a8530be5-8923-4f74-9675-bf8a1a8f7878	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	mohammed-picklestein
243	b7c1ddda-945c-4b2e-8831-ad9f2ec4a608	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	nolan-violet
244	b7c4f986-e62a-4a8f-b5f0-8f30ecc35c5d	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	oscar-hollywood
245	ceb8f8cd-80b2-47f0-b43e-4d885fa48aa4	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	donia-bailey
246	d2d76815-cbdc-4c4b-9c9e-32ebf2297cc7	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	denzel-scott
247	e111a46d-5ada-4311-ac4f-175cca3357da	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	alexandria-rosales
248	e972984c-2895-451c-b518-f06a0d8bd375	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	becker-solis
249	ecb8d2f5-4ff5-4890-9693-5654e00055f6	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	yeongho-benitez
250	06ced607-7f96-41e7-a8cd-b501d11d1a7e	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	morrow-wilson
251	083d09d4-7ed3-4100-b021-8fbe30dd43e8	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	jessica-telephone
252	093af82c-84aa-4bd6-ad1a-401fae1fce44	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	elijah-glover
253	13a05157-6172-4431-947b-a058217b4aa5	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	spears-taylor
254	15ae64cd-f698-4b00-9d61-c9fffd037ae2	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	mickey-woods
255	1732e623-ffc2-40f0-87ba-fdcf97131f1f	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	betsy-trombone
256	1a93a2d2-b5b6-479b-a595-703e4a2f3885	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	pedro-davids
257	0672a4be-7e00-402c-b8d6-0b813f58ba96	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	castillo-logan
258	1ba715f2-caa3-44c0-9118-b045ea702a34	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	juan-rangel
259	1ffb1153-909d-44c7-9df1-6ed3a9a45bbd	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	montgomery-bullock
260	20395b48-279d-44ff-b5bf-7cf2624a2d30	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	adrian-melon
261	26cfccf2-850e-43eb-b085-ff73ad0749b8	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	beasley-day
262	338694b7-6256-4724-86b6-3884299a5d9e	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	polkadot-patterson
263	34e1b683-ecd5-477f-b9e3-dd4bca76db45	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	alexandria-hess
264	4e63cb5d-4fce-441b-b9e4-dc6a467cf2fd	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	axel-campbell
265	4ecee7be-93e4-4f04-b114-6b333e0e6408	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	sutton-dreamy
266	f38c5d80-093f-46eb-99d6-942aa45cd921	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	andrew-solis
267	fa477c92-39b6-4a52-b065-40af2f29840a	2020-07-29 08:12:22.438	2020-08-02 10:22:51.755	howell-franklin
268	60026a9d-fc9a-4f5a-94fd-2225398fa3da	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	bright-zimmerman
269	62111c49-1521-4ca7-8678-cd45dacf0858	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	bambi-perez
270	66cebbbf-9933-4329-924a-72bd3718f321	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	kennedy-cena
271	7afedcd8-870d-4655-9659-3bdfb2e17730	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	pierre-haley
272	7dcf6902-632f-48c5-936a-7cf88802b93a	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	parker-parra
273	7e160e9f-2c79-4e08-8b76-b816de388a98	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	thomas-marsh
274	7f379b72-f4f0-4d8f-b88b-63211cf50ba6	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	jesus-rodriguez
275	6fc3689f-bb7d-4382-98a2-cf6ddc76909d	2020-07-29 08:12:22.438	\N	cedric-gonzalez
276	80dff591-2393-448a-8d88-122bd424fa4c	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	elvis-figueroa
277	814bae61-071a-449b-981e-e7afc839d6d6	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	ruslan-greatness
278	817dee99-9ccf-4f41-84e3-dc9773237bc8	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	holden-stanton
279	84a2b5f6-4955-4007-9299-3d35ae7135d3	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	kennedy-loser
280	906a5728-5454-44a0-adfe-fd8be15b8d9b	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	jefferson-delacruz
281	90cc0211-cd04-4cac-bdac-646c792773fc	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	case-lancaster
282	9786b2c9-1205-4718-b0f7-fc000ce91106	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	kevin-dudley
283	97dfc1f6-ac94-4cdc-b0d5-1cb9f8984aa5	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	brock-forbes
284	a7b0bef3-ee3c-42d4-9e6d-683cd9f5ed84	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	haruta-byrd
285	b082ca6e-eb11-4eab-8d6a-30f8be522ec4	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	nicholas-mora
286	198fd9c8-cb75-482d-873e-e6b91d42a446	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	ren-hunter
287	b85161da-7f4c-42a8-b7f6-19789cf6861d	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	javier-lotus
288	c675fcdf-6117-49a6-ac32-99a89a3a88aa	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	valentine-games
289	cd5494b4-05d0-4b2e-8578-357f0923ff4c	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	mcfarland-vargas
290	ce3fb736-d20e-4e2a-88cb-e136783d3a47	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	javier-howe
291	d0d7b8fe-bad8-481f-978e-cb659304ed49	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	adalberto-tosser
292	d2a1e734-60d9-4989-b7d9-6eacda70486b	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	tiana-takahashi
293	18798b8f-6391-4cb2-8a5f-6fb540d646d5	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	morrow-doyle
294	d2f827a5-0133-4d96-b403-85a5e50d49e0	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	robbins-schmitt
295	d35ccee1-9559-49a1-aaa4-7809f7b5c46e	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	forrest-best
296	d6c69d2d-9344-4b19-85a4-6cfcbaead5d2	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	joshua-watson
297	d8bc482e-9309-4230-abcb-2c5a6412446d	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	august-obrien
298	dd6ba7f1-a97a-4374-a3a7-b3596e286bb3	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	matheo-tanaka
299	dd8a43a4-a024-44e9-a522-785d998b29c3	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	miguel-peterson
300	e1e33aab-df8c-4f53-b30a-ca1cea9f046e	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	joyner-rugrat
301	f70dd57b-55c4-4a62-a5ea-7cc4bf9d8ac1	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	tillman-henderson
302	f8c20693-f439-4a29-a421-05ed92749f10	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	combs-duende
303	04f955fe-9cc9-4482-a4d2-07fe033b59ee	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	zane-vapor
304	2d22f026-2873-410b-a45f-3b1dac665ffd	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	donia-johnson
305	3531c282-cb48-43df-b549-c5276296aaa7	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	oliver-hess
306	36786f44-9066-4028-98d9-4fa84465ab9e	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	beasley-gloom
307	4ca52626-58cd-449d-88bb-f6d631588640	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	velasquez-alstott
308	50154d56-c58a-461f-976d-b06a4ae467f9	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	carter-oconnor
309	5b3f0a43-45e7-44e7-9496-512c24c040f0	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	rhys-rivera
310	5b5bcc6c-d011-490f-b084-6fdc2c52f958	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	simba-davis
311	2ae8cbfc-2155-4647-9996-3f2591091baf	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	forrest-bookbaby
312	5e4dfa16-f1b9-400f-b8ef-a1613c2b026a	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	snyder-briggs
313	2720559e-9173-4042-aaa0-d3852b72ab2e	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	hiroto-wilcox
314	2727215d-3714-438d-b1ba-2ed15ec481c0	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	dominic-woman
315	2e86de11-a2dd-4b28-b5fe-f4d0c38cd20b	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	zion-aliciakeyes
316	32c9bce6-6e52-40fa-9f64-3629b3d026a8	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	ren-morin
317	37efef78-2df4-4c76-800c-43d4faf07737	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	lenix-ren
318	58fca5fa-e559-4f5e-ac87-dc99dd19e410	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	sullivan-septemberish
319	5fc4713c-45e1-4593-a968-7defeb00a0d4	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	percival-bendie
320	5ff66eae-7111-4e3b-a9b8-a9579165b0a5	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	daniel-duffy
321	695daf02-113d-4e76-b802-0862df16afbd	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	pacheco-weeks
322	99e7de75-d2b8-4330-b897-a7334708aff9	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	winnie-loser
323	b056a825-b629-4856-856b-53a15ad34acb	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	bennett-takahashi
324	b4505c48-fc75-4f9e-8419-42b28dcc5273	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	sebastian-townsend
325	b8ab86c6-9054-4832-9b96-508dbd4eb624	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	esme-ramsey
326	bd4c6837-eeaa-4675-ae48-061efa0fd11a	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	workman-gloom
327	6e744b21-c4fa-4fa8-b4ea-e0e97f68ded5	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	daniel-koch
328	70ccff1e-6b53-40e2-8844-0a28621cb33e	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	moody-cookbook
329	93502db3-85fa-4393-acae-2a5ff3980dde	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	rodriguez-sunshine
330	77a41c29-8abd-4456-b6e0-a034252700d2	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	elip-dean
331	7932c7c7-babb-4245-b9f5-cdadb97c99fb	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	randy-castillo
332	7aeb8e0b-f6fb-4a9e-bba2-335dada5f0a3	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	dunlap-figueroa
333	7cf83bdc-f95f-49d3-b716-06f2cf60a78d	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	matteo-urlacher
334	7e9a514a-7850-4ed0-93ab-f3a6e2f41c03	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	nolanestophia-patterson
335	80de2b05-e0d4-4d33-9297-9951b2b5c950	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	alyssa-harrell
336	9abe02fb-2b5a-432f-b0af-176be6bd62cf	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	nagomi-meng
337	a73427b3-e96a-4156-a9ab-844edc696fed	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	wesley-vodka
338	afc90398-b891-4cdf-9dea-af8a3a79d793	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	yazmin-mason
339	b3e512df-c411-4100-9544-0ceadddb28cf	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	famous-owens
340	0ecf6190-f869-421a-b339-29195d30d37c	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	mcbaseball-clembons
341	10ea5d50-ec88-40a0-ab53-c6e11cc1e479	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	nicholas-vincent
342	27c68d7f-5e40-4afa-8b6f-9df47b79e7dd	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	basilio-preston
343	d002946f-e7ed-4ce4-a405-63bdaf5eabb5	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	jorge-owens
344	d47dd08e-833c-4302-a965-a391d345455c	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	stu-trololol
345	d6e9a211-7b33-45d9-8f09-6d1a1a7a3c78	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	william-boone
346	0d5300f6-0966-430f-903f-a4c2338abf00	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	lee-davenport
347	eaaef47e-82cc-4c90-b77d-75c3fb279e83	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	herring-winfield
348	f9c0d3cb-d8be-4f53-94c9-fc53bcbce520	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	matteo-prestige
349	09f2787a-3352-41a6-8810-d80e97b253b5	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	curry-aliciakeyes
350	0c83e3b6-360e-4b7d-85e3-d906633c9ca0	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	penelope-mathews
351	17392be2-7344-48a0-b4db-8a040a7fb532	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	washer-barajas
352	1af239ae-7e12-42be-9120-feff90453c85	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	melton-telephone
353	1ded0384-d290-4ea1-a72b-4f9d220cbe37	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	juan-murphy
354	d74a2473-1f29-40fa-a41e-66fa2281dfca	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	landry-violence
355	d89da2d2-674c-4b85-8959-a4bd406f760a	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	fish-summer
356	db3ff6f0-1045-4223-b3a8-a016ca987af9	2020-07-29 08:12:22.438	2020-08-02 10:22:51.488	murphy-thibault
357	5ca7e854-dc00-4955-9235-d7fcd732ddcf	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	taiga-quitter
358	6192daab-3318-44b5-953f-14d68cdb2722	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	justin-alstott
359	63a31035-2e6d-4922-a3f9-fa6e659b54ad	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	moody-rodriguez
360	63df8701-1871-4987-87d7-b55d4f1df2e9	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	mcdowell-sasquatch
361	75f9d874-5e69-438d-900d-a3fcb1d429b3	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	moses-simmons
362	773712f6-d76d-4caa-8a9b-56fe1d1a5a68	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	natha-kath
363	937c1a37-4b05-4dc5-a86d-d75226f8490a	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	pippin-carpenter
364	5149c919-48fe-45c6-b7ee-bb8e5828a095	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	adkins-davis
365	44c92d97-bb39-469d-a13b-f2dd9ae644d1	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	francisco-preston
366	450e6483-d116-41d8-933b-1b541d5f0026	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	england-voorhees
367	4e6ad1a1-7c71-49de-8bd5-c286712faf9e	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	sutton-picklestein
368	63512571-2eca-4bc4-8ad9-a5308a22ae22	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	oscar-dollie
369	82733eb4-103d-4be1-843e-6eb6df35ecd7	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	adkins-tosser
370	8adb084b-19fe-4295-bcd2-f92afdb62bd7	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	logan-rodriguez
371	9397ed91-608e-4b13-98ea-e94c795f651e	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	yeongho-garcia
372	945974c5-17d9-43e7-92f6-ba49064bbc59	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	bates-silk
373	94f30f21-f889-4a2e-9b94-818475bb1ca0	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	kirkland-sobremesa
374	9a031b9a-16f8-4165-a468-5d0e28a81151	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	tiana-wheeler
375	c86b5add-6c9a-40e0-aa43-e4fd7dd4f2c7	2020-07-29 08:12:22.438	\N	sosa-elftower
376	bf6a24d1-4e89-4790-a4ba-eeb2870cbf6f	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	rat-polk
377	d81ce662-07b6-4a73-baa4-acbbb41f9dc5	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	yummy-elliott
378	d8758c1b-afbb-43a5-b00b-6004d419e2c5	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	ortiz-nelson
379	dfe3bc1b-fca8-47eb-965f-6cf947c35447	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	linus-haley
380	e16c3f28-eecd-4571-be1a-606bbac36b2b	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	comfort-glover
381	e4034192-4dc6-4901-bb30-07fe3cf77b5e	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	baldwin-breadwinner
382	bca38809-81de-42ff-94e3-1c0ebfb1e797	2020-07-29 08:12:22.438	\N	famous-oconnor
383	ea44bd36-65b4-4f3b-ac71-78d87a540b48	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	wanda-pothos
384	f0594932-8ef7-4d70-9894-df4be64875d8	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	fitzgerald-wanderlust
385	a5adc84c-80b8-49e4-9962-8b4ade99a922	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	richardson-turquoise
386	aa6c2662-75f8-4506-aa06-9a0993313216	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	eizabeth-elliott
387	ac57cf28-556f-47af-9154-6bcea2ace9fc	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	rey-wooten
388	ac69dba3-6225-4afd-ab4b-23fc78f730fb	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	bevan-wise
389	b6aa8ce8-2587-4627-83c1-2a48d44afaee	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	inky-rutledge
390	b77dffaa-e0f5-408f-b9f2-1894ed26e744	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	tucker-lenny
391	c6146c45-3d9b-4749-9f03-d4faae61e2c3	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	atlas-diaz
392	db53211c-f841-4f33-accf-0c3e167889a0	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	travis-bendie
393	138fccc3-e66f-4b07-8327-d4b6f372f654	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	oscar-vaughan
394	33fbfe23-37bd-4e37-a481-a87eadb8192d	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	whit-steakknife
395	35d5b43f-8322-4666-aab1-d466b4a5a388	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	jordan-boone
396	3af96a6b-866c-4b03-bc14-090acf6ecee5	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	axel-trololol
397	493a83de-6bcf-41a1-97dd-cc5e150548a3	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	boyfriend-monreal
398	088884af-f38d-4914-9d67-b319287481b4	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	liam-petty
399	14bfad43-2638-41ec-8964-8351f22e9c4f	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	baby-sliders
400	113f47b2-3111-4abb-b25e-18f7889e2d44	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	adkins-swagger
401	190a0f31-d686-4ac4-a7f3-cfc87b72c145	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	nerd-pacheco
402	206bd649-4f5f-4707-ad85-92784be4eb95	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	newton-underbuck
403	20fd71e7-4fa0-4132-9f47-06a314ed539a	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	lars-taylor
404	25376b55-bb6f-48a7-9381-7b8210842fad	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	emmett-internet
405	333067fd-c2b4-4045-a9a4-e87a8d0332d0	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	miguel-james
406	3d3be7b8-1cbf-450d-8503-fce0daf46cbf	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	zack-sanders
407	3dd85c20-a251-4903-8a3b-1b96941c07b7	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	tot-best
408	4562ac1f-026c-472c-b4e9-ee6ff800d701	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	chris-koch
409	459f7700-521e-40da-9483-4d111119d659	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	comfort-monreal
410	472f50c0-ef98-4d05-91d0-d6359eec3946	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	rhys-trombone
411	64f4cd75-0c1e-42cf-9ff0-e41c4756f22a	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	grey-alvarado
412	6598e40a-d76d-413f-ad06-ac4872875bde	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	daniel-mendoza
413	6e373fca-b8ab-4848-9dcc-50e92cd732b7	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	conrad-bates
414	7663c3ca-40a1-4f13-a430-14637dce797a	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	polkadot-zavala
415	849e13dc-6eb1-40a8-b55c-d4b4cd160aab	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	justice-valenzuela
416	88cd6efa-dbf2-4309-aabe-ec1d6f21f98a	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	hewitt-best
417	90c8be89-896d-404c-945e-c135d063a74e	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	james-boy
418	53e701c7-e3c8-4e18-ba05-9b41b4b64cda	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	marquez-clark
419	9fd1f392-d492-4c48-8d46-27fb4283b2db	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	lucas-petty
420	a199a681-decf-4433-b6ab-5454450bbe5e	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	leach-ingram
421	a8a5cf36-d1a9-47d1-8d22-4a665933a7cc	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	helga-washington
422	4f69e8c2-b2a1-4e98-996a-ccf35ac844c5	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	igneus-delacruz
423	5703141c-25d9-46d0-b680-0cf9cfbf4777	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	sandoval-crossing
424	6644d767-ab15-4528-a4ce-ae1f8aadb65f	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	paula-reddick
425	8604e861-d784-43f0-b0f8-0d43ea6f7814	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	randall-marijuana
426	89f74891-2e25-4b5a-bd99-c95ba3f36aa0	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	nagomi-nava
427	8b0d717f-ae42-4492-b2ed-106912e2b530	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	avila-baker
428	8e1fd784-99d5-41c1-a6c5-6b947cec6714	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	velasquez-meadows
429	b39b5aae-8571-4c90-887a-6a00f2a2f6fd	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	dickerson-morse
430	c73d59dd-32a0-49ce-8ab4-b2dbb7dc94ec	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	eduardo-ingram
431	cd417f8a-ce01-4ab2-921d-42e2e445bbe2	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	eizabeth-guerra
432	f2a27a7e-bf04-4d31-86f5-16bfa3addbe7	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	winnie-hess
433	fa5b54d2-b488-47cd-a529-592831e4813d	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	kina-larsen
434	1e229fe5-a191-48ef-a7dd-6f6e13d6d73f	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	erickson-fischer
435	b69aa26f-71f7-4e17-bc36-49c875872cc1	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	francisca-burton
436	aae38811-122c-43dd-b59c-d0e203154dbe	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	sandie-carver
437	df4da81a-917b-434f-b309-f00423ee4967	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	eugenia-bickle
438	e3c06405-0564-47ce-bbbd-552bee4dd66f	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	scrap-weeks
439	f2468055-e880-40bf-8ac6-a0763d846eb2	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	alaynabella-hollywood
440	f56657d3-3bdc-4840-a20c-91aca9cc360e	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	malik-romayne
441	f883269f-117e-45ec-bb1e-fa8dbcf40d3e	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	jayden-wright
442	03097200-0d48-4236-a3d2-8bdb153aa8f7	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	bennett-browning
443	061b209a-9cda-44e8-88ce-6a4a37251970	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	mcdowell-karim
444	1068f44b-34a0-42d8-a92e-2be748681a6f	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	allison-abbott
445	1301ee81-406e-43d9-b2bb-55ca6e0f7765	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	malik-destiny
446	1c73f91e-0562-480d-9543-2aab1d5e5acd	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	sparks-beans
447	29bf512a-cd8c-4ceb-b25a-d96300c184bb	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	garcia-soto
448	378c07b0-5645-44b5-869f-497d144c7b35	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	fynn-doyle
449	413b3ddb-d933-4567-a60e-6d157480239d	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	winnie-mccall
450	4b3e8e9b-6de1-4840-8751-b1fb45dc5605	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	thomas-dracaena
451	4ffd2e50-bb5b-45d0-b7c4-e24d41b2ff5d	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	schneider-bendie
452	5c60f834-a133-4dc6-9c07-392fb37b3e6a	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	ramirez-winters
453	5dbf11c0-994a-4482-bd1e-99379148ee45	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	conrad-vaughan
454	40db1b0b-6d04-4851-adab-dd6320ad2ed9	2020-07-29 08:12:22.438	\N	scrap-murphy
455	6a869b40-be99-4520-89e5-d382b07e4a3c	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	jake-swinger
456	7310c32f-8f32-40f2-b086-54555a2c0e86	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	dominic-marijuana
457	81d7d022-19d6-427d-aafc-031fcb79b29e	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	patty-fox
458	41949d4d-b151-4f46-8bf7-73119a48fac8	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	ron-monstera
459	425f3f84-bab0-4cf2-91c1-96e78cf5cd02	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	luis-acevedo
460	495a6bdc-174d-4ad6-8d51-9ee88b1c2e4a	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	shaquille-torres
461	4ed61b18-c1f6-4d71-aea3-caac01470b5c	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	lenny-marijuana
462	6f9de777-e812-4c84-915c-ef283c9f0cde	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	arturo-huerta
463	864b3be8-e836-426e-ae56-20345b41d03d	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	goodwin-morin
464	8b53ce82-4b1a-48f0-999d-1774b3719202	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	oliver-mueller
465	9965eed5-086c-4977-9470-fe410f92d353	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	bates-bentley
466	9e724d9a-92a0-436e-bde1-da0b2af85d8f	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	hatfield-suzuki
467	a1628d97-16ca-4a75-b8df-569bae02bef9	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	chorby-soul
468	a311c089-0df4-46bd-9f5d-8c45c7eb5ae2	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	mclaughlin-scorpler
469	ab9b2592-a64a-4913-bf6c-3ae5bd5d26a5	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	beau-huerta
470	ae4acebd-edb5-4d20-bf69-f2d5151312ff	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	theodore-cervantes
471	b1b141fc-e867-40d1-842a-cea30a97ca4f	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	richardson-games
472	94d772c7-0254-4f08-814c-f6fc58fcfb9b	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	fletcher-peck
473	b7cdb93b-6f9d-468a-ae00-54cbc324ee84	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	ruslan-duran
474	c4951cae-0b47-468b-a3ac-390cc8e9fd05	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	timmy-vine
475	8cf78b49-d0ca-4703-88e8-4bcad26c44b1	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	avila-guzman
476	a3947fbc-50ec-45a4-bca4-49ffebb77dbe	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	chorby-short
477	b88d313f-e546-407e-8bc6-94040499daa5	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	oliver-loofah
478	bd9d1d6e-7822-4ad9-bac4-89b8afd8a630	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	derrick-krueger
479	c6a277c3-d2b5-4363-839b-950896a5ec5e	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	mike-townsend
480	ce58415f-4e62-47e2-a2c9-4d6a85961e1e	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	schneider-blanco
481	da0bbbe6-d13c-40cc-9594-8c476975d93d	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	lang-richardson
482	dd0b48fe-2d49-4344-83ed-9f0770b370a8	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	tillman-wan
483	86d4e22b-f107-4bcf-9625-32d387fcb521	2020-07-30 21:14:43.418	2020-07-31 20:15:38.656	york-silk
484	cf8e152e-2d27-4dcc-ba2b-68127de4e6a4	2020-07-31 02:14:52.332	2020-07-31 20:15:38.656	hendricks-richardson
485	03b80a57-77ea-4913-9be4-7a85c3594745	2020-07-30 10:14:05.423	2020-07-31 20:15:38.656	halexandrey-walton
486	2da49de2-34e5-49d0-b752-af2a2ee061be	2020-07-30 11:14:09.04	2020-07-31 20:15:38.656	cory-twelve
487	2ca0c790-e1d5-4a14-ab3c-e9241c87fc23	2020-07-31 11:15:27.365	2020-07-31 21:15:41.951	murray-pony
488	87e6ae4b-67de-4973-aa56-0fc9835a1e1e	2020-07-29 23:13:26.051	2020-07-31 21:15:41.951	marco-stink
489	f73009c5-2ede-4dc4-b96d-84ba93c8a429	2020-07-30 19:14:38.651	2020-07-31 21:15:41.951	thomas-kirby
490	18af933a-4afa-4cba-bda5-45160f3af99b	2020-07-29 09:12:25.968	2020-07-29 20:13:18.107	felix-garbage
491	020ed630-8bae-4441-95cc-0e4ecc27253b	2020-07-30 19:14:38.651	2020-07-31 21:15:41.951	simon-haley
492	855775c1-266f-40f6-b07b-3a67ccdf8551	2020-07-31 02:14:52.332	2020-07-31 21:15:41.951	nic-winkler
493	ef9f8b95-9e73-49cd-be54-60f84858a285	2020-07-30 12:14:12.808	2020-07-31 21:15:41.951	collins-melon
494	18af933a-4afa-4cba-bda5-45160f3af99b	2020-07-29 20:13:18.107	2020-08-02 10:22:49.929	felix-garbage
495	f967d064-0eaf-4445-b225-daed700e044b	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	wesley-dudley
496	e3c514ae-f813-470e-9c91-d5baf5ffcf16	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	tot-clark
497	efa73de4-af17-4f88-99d6-d0d69ed1d200	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	antonio-mccall
498	f3ddfd87-73a2-4681-96fe-829476c97886	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	theodore-duende
499	f6b38e56-0d98-4e00-a96e-345aaac1e653	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	leticia-snyder
500	f968532a-bf06-478e-89e0-3856b7f4b124	2020-07-29 08:12:22.438	2020-08-02 10:22:51.881	daniel-benedicte
501	0e27df51-ad0c-4546-acf5-96b3cb4d7501	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	chorby-spoon
502	f73009c5-2ede-4dc4-b96d-84ba93c8a429	2020-07-31 21:15:41.951	2020-08-02 10:22:48.962	thomas-kirby
503	855775c1-266f-40f6-b07b-3a67ccdf8551	2020-07-31 21:15:41.951	2020-08-02 10:22:49.747	nic-winkler
504	86d4e22b-f107-4bcf-9625-32d387fcb521	2020-07-31 20:15:38.656	2020-08-02 10:22:49.747	york-silk
505	03b80a57-77ea-4913-9be4-7a85c3594745	2020-07-31 20:15:38.656	2020-08-02 10:22:49.929	halexandrey-walton
506	2da49de2-34e5-49d0-b752-af2a2ee061be	2020-07-31 20:15:38.656	2020-08-02 10:22:49.929	cory-twelve
507	667cb445-c288-4e62-b603-27291c1e475d	2020-07-31 20:15:38.656	2020-08-02 10:22:50.243	dan-holloway
508	0bb35615-63f2-4492-80ec-b6b322dc5450	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	sexton-wheeler
509	020ed630-8bae-4441-95cc-0e4ecc27253b	2020-07-31 21:15:41.951	2020-08-02 10:22:51.488	simon-haley
510	2ca0c790-e1d5-4a14-ab3c-e9241c87fc23	2020-07-31 21:15:41.951	2020-08-02 10:22:51.755	murray-pony
511	ef9f8b95-9e73-49cd-be54-60f84858a285	2020-07-31 21:15:41.951	2020-08-02 10:22:51.755	collins-melon
512	cf8e152e-2d27-4dcc-ba2b-68127de4e6a4	2020-07-31 20:15:38.656	2020-08-02 10:22:51.881	hendricks-richardson
513	0eea4a48-c84b-4538-97e7-3303671934d2	2020-08-02 10:22:48.089	2020-08-02 19:09:05.571	helga-moreno
514	0e27df51-ad0c-4546-acf5-96b3cb4d7501	2020-08-02 10:22:48.089	2020-08-02 21:23:42.002	chorby-spoon
515	0f62c20c-72d0-4c12-a9d7-312ea3d3bcd1	2020-08-02 10:22:48.089	2020-08-03 02:23:49.05	abner-wood
516	0bb35615-63f2-4492-80ec-b6b322dc5450	2020-08-02 10:22:48.089	2020-08-09 07:23:36.435	sexton-wheeler
517	0d5300f6-0966-430f-903f-a4c2338abf00	2020-08-02 10:22:48.089	2020-08-09 07:23:36.435	lee-davenport
518	0ecf6190-f869-421a-b339-29195d30d37c	2020-08-02 10:22:48.089	2020-08-09 07:23:36.435	mcbaseball-clembons
519	126fb128-7c53-45b5-ac2b-5dbf9943d71b	2020-08-02 10:22:48.089	2020-08-02 19:09:05.571	sigmund-castillo
520	2b157c5c-9a6a-45a6-858f-bf4cf4cbc0bd	2020-08-02 10:22:48.089	2020-08-02 19:09:05.571	ortiz-lopez
521	3c331c87-1634-46c4-87ce-e4b9c59e2969	2020-08-02 10:22:48.089	2020-08-02 19:09:05.571	yosh-carpenter
522	43bf6a6d-cc03-4bcf-938d-620e185433e1	2020-08-02 10:22:48.089	2020-08-02 19:09:05.571	miguel-javier
523	58c9e294-bd49-457c-883f-fb3162fc668e	2020-08-02 10:22:48.089	2020-08-02 19:09:05.571	kichiro-guerra
524	10ea5d50-ec88-40a0-ab53-c6e11cc1e479	2020-08-02 10:22:48.089	2020-08-02 21:23:42.002	nicholas-vincent
525	36786f44-9066-4028-98d9-4fa84465ab9e	2020-09-09 10:18:48.789	\N	beasley-gloom
526	3db02423-92af-485f-b30f-78256721dcc6	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	son-jensen
527	58c9e294-bd49-457c-883f-fb3162fc668e	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	kichiro-guerra
528	5149c919-48fe-45c6-b7ee-bb8e5828a095	2020-08-02 10:22:48.089	2020-08-02 21:23:42.002	adkins-davis
529	63a31035-2e6d-4922-a3f9-fa6e659b54ad	2020-08-02 10:22:48.089	2020-08-03 02:23:49.05	moody-rodriguez
530	5ca7e854-dc00-4955-9235-d7fcd732ddcf	2020-08-02 10:22:48.089	2020-08-06 09:08:27.052	taiga-quitter
531	23e78d92-ee2d-498a-a99c-f40bc4c5fe99	2020-08-02 10:22:48.089	2020-08-09 07:23:36.435	annie-williams
532	26f01324-9d1c-470b-8eaa-1b9bfbcd8b65	2020-08-02 10:22:48.089	2020-08-09 07:23:36.435	nerd-james
533	27c68d7f-5e40-4afa-8b6f-9df47b79e7dd	2020-08-02 10:22:48.089	2020-08-09 07:23:36.435	basilio-preston
534	3be2c730-b351-43f7-a832-a5294fe8468f	2020-08-02 10:22:48.089	2020-08-09 07:23:36.435	amaya-jackson
535	3db02423-92af-485f-b30f-78256721dcc6	2020-08-02 10:22:48.089	2020-08-09 07:23:36.435	son-jensen
536	773712f6-d76d-4caa-8a9b-56fe1d1a5a68	2020-08-02 10:22:48.089	\N	natha-kath
537	a1ed3396-114a-40bc-9ff0-54d7e1ad1718	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	patel-beyonce
538	bd24e18b-800d-4f15-878d-e334fb4803c4	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	helga-burton
539	7c5ae357-e079-4427-a90f-97d164c7262e	2020-08-02 10:22:48.089	2020-08-02 19:09:05.571	milo-brown
540	80a2f015-9d40-426b-a4f6-b9911ba3add8	2020-08-02 10:22:48.089	2020-08-02 19:09:05.571	paul-barnes
541	bd24e18b-800d-4f15-878d-e334fb4803c4	2020-08-02 10:22:48.089	2020-08-02 19:09:05.571	helga-burton
542	cbd19e6f-3d08-4734-b23f-585330028665	2020-08-02 10:22:48.089	2020-08-02 19:09:05.571	knight-urlacher
543	75f9d874-5e69-438d-900d-a3fcb1d429b3	2020-08-02 10:22:48.089	2020-08-02 21:23:42.002	moses-simmons
544	937c1a37-4b05-4dc5-a86d-d75226f8490a	2020-08-02 10:22:48.089	2020-08-02 21:23:42.002	pippin-carpenter
545	bf6a24d1-4e89-4790-a4ba-eeb2870cbf6f	2020-08-02 10:22:48.089	2020-08-02 21:23:42.002	rat-polk
546	9313e41c-3bf7-436d-8bdc-013d3a1ecdeb	2020-08-02 10:22:48.089	2020-08-03 02:23:49.05	sandie-nelson
547	63df8701-1871-4987-87d7-b55d4f1df2e9	2020-08-02 10:22:48.089	2020-08-09 07:23:36.435	mcdowell-sasquatch
548	9f6d06d6-c616-4599-996b-ec4eefcff8b8	2020-08-02 10:22:48.089	2020-08-09 07:23:36.435	silvia-winner
549	a1ed3396-114a-40bc-9ff0-54d7e1ad1718	2020-08-02 10:22:48.089	2020-08-09 07:23:36.435	patel-beyonce
550	b390b28c-df96-443e-b81f-f0104bd37860	2020-08-02 10:22:48.089	2020-08-09 07:23:36.435	karato-rangel
551	d81ce662-07b6-4a73-baa4-acbbb41f9dc5	2020-08-02 10:22:48.089	2020-08-09 07:23:36.435	yummy-elliott
552	d8758c1b-afbb-43a5-b00b-6004d419e2c5	2020-08-02 10:22:48.089	2020-08-09 07:23:36.435	ortiz-nelson
553	d97835fd-2e92-4698-8900-1f5abea0a3b6	2020-08-02 10:22:48.089	2020-08-09 07:23:36.435	king-roland
554	14d88771-7a96-48aa-ba59-07bae1733e96	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	sebastian-telephone
555	ee55248b-318a-4bfb-8894-1cc70e4e0720	2020-08-02 10:22:48.089	2020-08-02 19:09:05.571	theo-king
556	f0594932-8ef7-4d70-9894-df4be64875d8	2020-08-02 10:22:48.089	2020-08-02 21:23:42.002	fitzgerald-wanderlust
557	f1185b20-7b4a-4ccc-a977-dc1afdfd4cb9	2020-08-02 10:22:48.089	2020-08-02 21:23:42.002	frazier-tosser
558	05bd08d5-7d9f-450b-abfa-1788b8ee8b91	2020-08-02 10:22:48.962	2020-08-02 21:23:42.155	stevenson-monstera
559	13cfbadf-b048-4c4f-903d-f9b52616b15c	2020-08-02 10:22:48.962	2020-08-02 21:23:42.155	bennett-bowen
560	f741dc01-2bae-4459-bfc0-f97536193eea	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	alejandro-leaf
561	14d88771-7a96-48aa-ba59-07bae1733e96	2020-08-02 10:22:48.962	2020-08-02 21:23:42.155	sebastian-telephone
562	17397256-c28c-4cad-85f2-a21768c66e67	2020-08-02 10:22:48.962	2020-08-02 21:23:42.155	cory-ross
563	e4034192-4dc6-4901-bb30-07fe3cf77b5e	2020-08-02 10:22:48.089	2020-08-03 02:23:49.05	baldwin-breadwinner
564	e749dc27-ca3b-456e-889c-d2ec02ac7f5f	2020-08-02 10:22:48.089	2020-08-03 02:23:49.05	aureliano-estes
565	ea44bd36-65b4-4f3b-ac71-78d87a540b48	2020-08-02 10:22:48.089	2020-08-03 02:23:49.05	wanda-pothos
566	138fccc3-e66f-4b07-8327-d4b6f372f654	2020-08-02 10:22:48.962	2020-08-03 02:23:49.247	oscar-vaughan
567	dfe3bc1b-fca8-47eb-965f-6cf947c35447	2020-08-02 10:22:48.089	2020-08-09 07:23:36.435	linus-haley
568	f741dc01-2bae-4459-bfc0-f97536193eea	2020-08-02 10:22:48.089	2020-08-09 07:23:36.435	alejandro-leaf
569	042962c8-4d8b-44a6-b854-6ccef3d82716	2020-08-02 10:22:48.962	2020-08-09 07:23:36.613	ronan-jaylee
570	113f47b2-3111-4abb-b25e-18f7889e2d44	2020-08-02 10:22:48.962	2020-08-09 07:23:36.613	adkins-swagger
571	3af96a6b-866c-4b03-bc14-090acf6ecee5	2020-08-02 10:22:48.962	2020-08-02 19:09:05.754	axel-trololol
572	f0bcf4bb-74b3-412e-a54c-04c12ad28ecb	2020-08-02 10:22:51.755	2020-08-02 21:23:43.721	hahn-fox
573	493a83de-6bcf-41a1-97dd-cc5e150548a3	2020-08-02 10:22:48.962	2020-08-02 19:09:05.754	boyfriend-monreal
574	4b6f0a4e-de18-44ad-b497-03b1f470c43c	2020-08-02 10:22:48.962	2020-08-02 19:09:05.754	rodriguez-internet
575	53e701c7-e3c8-4e18-ba05-9b41b4b64cda	2020-08-02 10:22:48.962	2020-08-02 19:09:05.754	marquez-clark
576	64f4cd75-0c1e-42cf-9ff0-e41c4756f22a	2020-08-02 10:22:48.962	2020-08-02 19:09:05.754	grey-alvarado
577	4b6f0a4e-de18-44ad-b497-03b1f470c43c	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	rodriguez-internet
578	6e373fca-b8ab-4848-9dcc-50e92cd732b7	2020-08-02 10:22:48.962	2020-08-02 21:23:42.155	conrad-bates
579	6598e40a-d76d-413f-ad06-ac4872875bde	2020-08-02 10:22:48.962	2020-08-03 02:23:49.247	daniel-mendoza
580	7663c3ca-40a1-4f13-a430-14637dce797a	2020-08-02 10:22:48.962	2020-08-03 02:23:49.247	polkadot-zavala
581	82d1b7b4-ce00-4536-8631-a025f05150ce	2020-08-02 10:22:48.962	2020-08-03 05:23:55.538	sam-scandal
582	35d5b43f-8322-4666-aab1-d466b4a5a388	2020-08-02 10:22:48.962	2020-08-09 07:23:36.613	jordan-boone
583	3f08f8cd-6418-447a-84d3-22a981c68f16	2020-08-02 10:22:48.962	2020-08-09 07:23:36.613	pollard-beard
584	4fe28bc1-f690-4ad6-ad09-1b2e984bf30b	2020-08-02 10:22:48.962	2020-08-09 07:23:36.613	cell-longarms
585	6b8d128f-ed51-496d-a965-6614476f8256	2020-08-02 10:22:48.962	2020-08-09 07:23:36.613	orville-manco
586	732899a3-2082-4d9f-b1c2-74c8b75e15fb	2020-08-02 10:22:48.962	2020-08-09 07:23:36.613	minato-ito
587	740d5fef-d59f-4dac-9a75-739ec07f91cf	2020-08-02 10:22:48.962	2020-08-09 07:23:36.613	conner-haley
588	81a0889a-4606-4f49-b419-866b57331383	2020-08-02 10:22:48.962	2020-08-09 07:23:36.613	summers-pony
589	87e6ae4b-67de-4973-aa56-0fc9835a1e1e	2020-07-31 21:15:41.951	2020-08-02 10:22:48.962	marco-stink
590	94baa9ac-ff96-4f56-a987-10358e917d91	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	gabriel-griffith
591	a8e757c6-e299-4a2e-a370-4f7c3da98bd1	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	hendricks-lenny
592	b39b5aae-8571-4c90-887a-6a00f2a2f6fd	2020-08-02 10:22:48.962	2020-08-02 19:09:05.754	dickerson-morse
593	c73d59dd-32a0-49ce-8ab4-b2dbb7dc94ec	2020-08-02 10:22:48.962	2020-08-02 19:09:05.754	eduardo-ingram
594	94baa9ac-ff96-4f56-a987-10358e917d91	2020-08-02 10:22:48.962	2020-08-02 21:23:42.155	gabriel-griffith
595	a8a5cf36-d1a9-47d1-8d22-4a665933a7cc	2020-08-02 10:22:48.962	2020-08-02 21:23:42.155	helga-washington
596	c17a4397-4dcc-440e-8c53-d897e971cae9	2020-08-02 10:22:48.962	2020-08-02 21:23:42.155	august-mina
597	c6bd21a8-7880-4c00-8abe-33560fe84ac5	2020-08-02 10:22:48.962	2020-08-02 21:23:42.155	wendy-cerna
598	849e13dc-6eb1-40a8-b55c-d4b4cd160aab	2020-08-02 10:22:48.962	2020-08-03 02:23:49.247	justice-valenzuela
599	87e6ae4b-67de-4973-aa56-0fc9835a1e1e	2020-08-02 10:22:48.962	2020-08-03 02:23:49.247	marco-stink
600	90c8be89-896d-404c-945e-c135d063a74e	2020-08-02 10:22:48.962	2020-08-03 02:23:49.247	james-boy
601	a8e757c6-e299-4a2e-a370-4f7c3da98bd1	2020-08-02 10:22:48.962	2020-08-03 02:23:49.247	hendricks-lenny
602	aae38811-122c-43dd-b59c-d0e203154dbe	2020-08-02 10:22:48.962	2020-08-03 02:23:49.247	sandie-carver
603	b7ca8f3f-2fdc-477b-84f4-157f2802e9b5	2020-08-02 10:22:48.962	2020-08-03 02:23:49.247	leach-herman
604	c83f0fe0-44d1-4342-81e8-944bb38f8e23	2020-08-02 10:22:48.962	2020-08-03 02:23:49.247	langley-wheeler
605	9fd1f392-d492-4c48-8d46-27fb4283b2db	2020-08-02 10:22:48.962	2020-08-09 07:23:36.613	lucas-petty
606	a199a681-decf-4433-b6ab-5454450bbe5e	2020-08-02 10:22:48.962	2020-08-09 07:23:36.613	leach-ingram
607	248ccf3d-d5f6-4b69-83d9-40230ca909cd	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	antonio-wallace
608	18798b8f-6391-4cb2-8a5f-6fb540d646d5	2020-08-02 10:22:49.478	2020-08-02 19:09:05.992	morrow-doyle
609	198fd9c8-cb75-482d-873e-e6b91d42a446	2020-08-02 10:22:49.478	2020-08-02 19:09:05.992	ren-hunter
610	248ccf3d-d5f6-4b69-83d9-40230ca909cd	2020-08-02 10:22:49.478	2020-08-02 19:09:05.992	antonio-wallace
611	f73009c5-2ede-4dc4-b96d-84ba93c8a429	2020-08-02 10:22:48.962	2020-08-02 21:23:42.155	thomas-kirby
612	de52d5c0-cba4-4ace-8308-e2ed3f8799d0	2020-07-29 08:12:22.438	2020-08-02 10:22:48.962	jose-mitchell
613	03f920cc-411f-44ef-ae66-98a44e883291	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	cornelius-games
614	dd7e710f-da4e-475b-b870-2c29fe9d8c00	2020-08-02 10:22:48.962	2020-08-03 02:23:49.247	itsuki-weeks
615	f2a27a7e-bf04-4d31-86f5-16bfa3addbe7	2020-08-02 10:22:48.962	2020-08-03 02:23:49.247	winnie-hess
616	03f920cc-411f-44ef-ae66-98a44e883291	2020-08-02 10:22:49.478	2020-08-03 02:23:49.449	cornelius-games
617	1513aab6-142c-48c6-b43e-fbda65fd64e8	2020-08-02 10:22:49.478	2020-08-03 02:23:49.449	caleb-alvarado
618	16aff709-e855-47c8-8818-b9ba66e90fe8	2020-08-02 10:22:49.478	2020-08-03 02:23:49.449	mullen-peterson
619	20e13b56-599b-4a22-b752-8059effc81dc	2020-08-02 10:22:49.478	2020-08-03 02:23:49.449	lou-roseheart
620	d796d287-77ef-49f0-89ef-87bcdeb280ee	2020-08-02 10:22:48.962	2020-08-09 07:23:36.613	izuki-clark
621	de52d5c0-cba4-4ace-8308-e2ed3f8799d0	2020-08-02 10:22:48.962	2020-08-09 07:23:36.613	jose-mitchell
622	ebf2da50-7711-46ba-9e49-341ce3487e00	2020-08-02 10:22:48.962	2020-08-09 07:23:36.613	baldwin-jones
623	fa5b54d2-b488-47cd-a529-592831e4813d	2020-08-02 10:22:48.962	2020-08-09 07:23:36.613	kina-larsen
624	3531c282-cb48-43df-b549-c5276296aaa7	2020-08-02 10:22:49.478	2020-08-02 21:23:42.352	oliver-hess
625	36786f44-9066-4028-98d9-4fa84465ab9e	2020-08-02 10:22:49.478	2020-08-02 21:23:42.352	beasley-gloom
626	3c051b92-4a86-4157-988a-e334bf6dc691	2020-08-02 10:22:49.478	2020-08-02 21:23:42.352	tyler-leatherman
627	54e5f222-fb16-47e0-adf9-21813218dafa	2020-08-02 10:22:49.478	2020-08-02 21:23:42.352	grit-watson
628	5f3b5dc2-351a-4dee-a9d6-fa5f44f2a365	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	alston-england
629	2ae8cbfc-2155-4647-9996-3f2591091baf	2020-08-02 10:22:49.478	2020-08-03 02:23:49.449	forrest-bookbaby
630	43d5da5f-c6a1-42f1-ab7f-50ea956b6cd5	2020-08-02 10:22:49.478	2020-08-03 02:23:49.449	justice-spoon
631	4bf352d2-6a57-420a-9d45-b23b2b947375	2020-08-02 10:22:49.478	2020-08-03 02:23:49.449	rivers-rosa
632	5e4dfa16-f1b9-400f-b8ef-a1613c2b026a	2020-08-02 10:22:49.478	2020-08-03 02:23:49.449	snyder-briggs
633	5f3b5dc2-351a-4dee-a9d6-fa5f44f2a365	2020-08-02 10:22:49.478	2020-08-03 02:23:49.449	alston-england
634	69196296-f652-42ff-b2ca-0d9b50bd9b7b	2020-08-02 10:22:49.478	2020-08-03 02:23:49.449	joshua-butt
635	2d22f026-2873-410b-a45f-3b1dac665ffd	2020-08-02 10:22:49.478	2020-08-09 07:23:36.831	donia-johnson
636	50154d56-c58a-461f-976d-b06a4ae467f9	2020-08-02 10:22:49.478	2020-08-09 07:23:36.831	carter-oconnor
637	520e6066-b14b-45cf-985c-0a6ee2dc3f7a	2020-08-02 10:22:49.478	2020-08-09 07:23:36.831	zi-sliders
638	5b3f0a43-45e7-44e7-9496-512c24c040f0	2020-08-02 10:22:49.478	2020-08-09 07:23:36.831	rhys-rivera
639	5b5bcc6c-d011-490f-b084-6fdc2c52f958	2020-08-02 10:22:49.478	2020-08-09 07:23:36.831	simba-davis
640	68f98a04-204f-4675-92a7-8823f2277075	2020-08-02 10:22:49.478	2020-08-09 07:23:36.831	isaac-johnson
641	c8de53a4-d90f-4192-955b-cec1732d920e	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	tyreek-cain
642	b4505c48-fc75-4f9e-8419-42b28dcc5273	2020-08-02 10:22:49.478	2020-08-02 19:09:05.992	sebastian-townsend
643	b8ab86c6-9054-4832-9b96-508dbd4eb624	2020-08-02 10:22:49.478	2020-08-02 19:09:05.992	esme-ramsey
644	bd4c6837-eeaa-4675-ae48-061efa0fd11a	2020-08-02 10:22:49.478	2020-08-02 19:09:05.992	workman-gloom
645	7b0f91aa-4d66-4362-993d-6ff60f7ce0ef	2020-07-29 08:12:22.438	2020-08-02 10:22:49.478	blankenship-fischer
646	88ca603e-b2e5-4916-bef5-d6bba03235f5	2020-08-02 10:22:49.478	2020-08-02 21:23:42.352	clare-mccall
647	c0177f76-67fc-4316-b650-894159dede45	2020-08-02 10:22:49.478	2020-08-02 21:23:42.352	paula-mason
648	c182f33c-aea5-48a2-97ed-dc74fa29b3c0	2020-08-02 10:22:49.478	2020-08-02 21:23:42.352	swamuel-mora
649	c8de53a4-d90f-4192-955b-cec1732d920e	2020-08-02 10:22:49.478	2020-08-02 21:23:42.352	tyreek-cain
650	93502db3-85fa-4393-acae-2a5ff3980dde	2020-08-02 10:22:49.478	2020-08-03 02:23:49.449	rodriguez-sunshine
651	99e7de75-d2b8-4330-b897-a7334708aff9	2020-08-02 10:22:49.478	2020-08-03 02:23:49.449	winnie-loser
652	a7edbf19-caf6-45dd-83d5-46496c99aa88	2020-08-02 10:22:49.478	2020-08-03 02:23:49.449	rush-valenzuela
653	ad8d15f4-e041-4a12-a10e-901e6285fdc5	2020-08-02 10:22:49.478	2020-08-03 02:23:49.449	baby-urlacher
654	bfd9ff52-9bf6-4aaf-a859-d308d8f29616	2020-08-02 10:22:49.478	2020-08-03 02:23:49.449	declan-suzanne
655	7e4f012e-828c-43bb-8b8a-6c33bdfd7e3f	2020-08-02 10:22:49.478	2020-08-09 07:23:36.831	patel-olive
656	ce0a156b-ba7b-4313-8fea-75807b4bc77f	2020-08-02 10:22:49.478	2020-08-09 07:23:36.831	conrad-twelve
657	d002946f-e7ed-4ce4-a405-63bdaf5eabb5	2020-08-02 10:22:49.478	2020-08-09 07:23:36.831	jorge-owens
658	0fe896e1-108c-4ce9-97be-3470dde73c21	2020-08-02 10:22:49.747	\N	bryanayah-chang
659	d46abb00-c546-4952-9218-4f16084e3238	2020-08-02 10:22:49.478	2020-08-02 21:23:42.352	atlas-guerra
660	e4e4c17d-8128-4704-9e04-f244d4573c4d	2020-08-02 10:22:49.478	2020-08-02 21:23:42.352	wesley-poole
661	24f6829e-7bb4-4e1e-8b59-a07514657e72	2020-08-02 10:22:49.747	2020-08-02 23:06:56.127	king-weatherman
662	0fe896e1-108c-4ce9-97be-3470dde73c21	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	bryanayah-chang
663	3064c7d6-91cc-4c2a-a433-1ce1aabc1ad4	2020-08-02 10:22:49.747	2020-08-02 23:06:56.127	jorge-ito
664	eaaef47e-82cc-4c90-b77d-75c3fb279e83	2020-08-02 10:22:49.478	2020-08-03 02:23:49.449	herring-winfield
665	f071889c-f10f-4d2f-a1dd-c5dda34b3e2b	2020-08-02 10:22:49.478	2020-08-03 02:23:49.449	zion-facepunch
666	f9c0d3cb-d8be-4f53-94c9-fc53bcbce520	2020-08-02 10:22:49.478	2020-08-03 02:23:49.449	matteo-prestige
667	0bd5a3ec-e14c-45bf-8283-7bc191ae53e4	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	stephanie-donaldson
668	1e8b09bd-fbdd-444e-bd7e-10326bd57156	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	fletcher-yamamoto
669	2b1cb8a2-9eba-4fce-85cf-5d997ec45714	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	isaac-rubberman
1638	99e7de75-d2b8-4330-b897-a7334708aff9	2020-08-09 07:23:36.831	\N	winnie-loser
670	2f3d7bc7-6ffb-40c3-a94f-5e626be413c9	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	elijah-valenzuela
671	d23a1f7e-0071-444e-8361-6ae01f13036f	2020-08-02 10:22:49.478	2020-08-04 14:17:36.57	edric-tosser
672	d6e9a211-7b33-45d9-8f09-6d1a1a7a3c78	2020-08-02 10:22:49.478	2020-08-09 07:23:36.831	william-boone
673	167751d5-210c-4a6e-9568-e92d61bab185	2020-08-02 10:22:49.747	2020-08-09 07:23:37.02	jacob-winner
674	2cadc28c-88a5-4e25-a6eb-cdab60dd446d	2020-08-02 10:22:49.747	2020-08-09 07:23:37.02	elijah-bookbaby
675	4941976e-31fc-49b5-801a-18abe072178b	2020-08-02 10:22:49.747	2020-08-02 23:06:56.127	sebastian-sunshine
676	62823073-84b8-46c2-8451-28fd10dff250	2020-08-02 10:22:49.747	2020-08-02 23:06:56.127	mckinney-vaughan
677	805ba480-df4d-4f56-a4cf-0b99959111b5	2020-08-02 10:22:49.747	2020-08-02 23:06:56.127	leticia-lozano
678	855775c1-266f-40f6-b07b-3a67ccdf8551	2020-08-02 10:22:49.747	2020-08-02 23:06:56.127	nic-winkler
679	3e008f60-6842-42e7-b125-b88c7e5c1a95	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	zeboriah-wilson
680	3954bdfa-931f-4787-b9ac-f44b72fe09d7	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	nicholas-nolan
681	3a96d76a-c508-45a0-94a0-8f64cd6beeb4	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	thomas-england
682	3e008f60-6842-42e7-b125-b88c7e5c1a95	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	zeboriah-wilson
683	51985516-5033-4ab8-a185-7bda07829bdb	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	stephanie-schmitt
684	51c5473a-7545-4a9a-920d-d9b718d0e8d1	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	jacob-haynes
685	718dea1a-d9a8-4c2b-933a-f0667b5250e6	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	margarito-nava
686	7a75d626-d4fd-474f-a862-473138d8c376	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	beck-whitney
687	81b25b16-3370-4eb0-9d1b-6d630194c680	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	zeboriah-whiskey
688	4b73367f-b2bb-4df6-b2eb-2a0dd373eead	2020-08-02 10:22:49.747	2020-08-09 07:23:37.02	tristin-crankit
689	527c1f6e-a7e4-4447-a824-703b662bae4e	2020-08-02 10:22:49.747	2020-08-09 07:23:37.02	melton-campbell
690	7158d158-e7bf-4e9b-9259-62e5b25e3de8	2020-08-02 10:22:49.747	2020-08-09 07:23:37.02	karato-bean
691	89ec77d8-c186-4027-bd45-f407b4800c2c	2020-08-02 10:22:49.747	2020-08-09 07:23:37.02	james-mora
692	bd549bfe-b395-4dc0-8546-5c04c08e24a5	2020-08-02 10:22:49.747	\N	sam-solis
693	9ac2e7c5-5a34-4738-98d8-9f917bc6d119	2020-08-02 10:22:49.747	2020-08-02 23:06:56.127	christian-combs
694	a938f586-f5c1-4a35-9e7f-8eaab6de67a6	2020-08-02 10:22:49.747	2020-08-02 23:06:56.127	jasper-destiny
695	b3d518b9-dc68-4902-b68c-0022ceb25aa0	2020-08-02 10:22:49.747	2020-08-02 23:06:56.127	hendricks-rangel
696	a647388d-fc59-4c1b-90d3-8c1826e07775	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	chambers-simmons
697	c771abab-f468-46e9-bac5-43db4c5b410f	2020-08-02 10:22:49.747	2020-08-02 23:06:56.127	wade-howe
698	960f041a-f795-4001-bd88-5ddcf58ee520	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	mayra-buckley
699	a647388d-fc59-4c1b-90d3-8c1826e07775	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	chambers-simmons
700	a98917bc-e9df-4b0e-bbde-caa6168aa3d7	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	jenkins-ingram
701	c0732e36-3731-4f1a-abdc-daa9563b6506	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	nagomi-mcdaniel
702	cd6b102e-1881-4079-9a37-455038bbf10e	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	caleb-morin
703	98f26a25-905f-4850-8960-b741b0c583a4	2020-08-02 10:22:49.747	2020-08-09 07:23:37.02	stu-mcdaniel
704	a2483925-697f-468f-931c-bcd0071394e5	2020-08-02 10:22:49.747	2020-08-09 07:23:37.02	timmy-manco
705	ab9eb213-0917-4374-a259-458295045021	2020-08-02 10:22:49.747	2020-08-09 07:23:37.02	matheo-carpenter
706	ccc99f2f-2feb-4f32-a9b9-c289f619d84c	2020-08-02 10:22:49.747	2020-08-09 07:23:37.02	itsuki-winner
707	de67b585-9bf4-4e49-b410-101483ca2fbc	2020-08-02 10:22:49.747	2020-08-09 07:23:37.02	shaquille-sunshine
708	defbc540-a36d-460b-afd8-07da2375ee63	2020-08-02 10:22:49.747	2020-08-09 07:23:37.02	castillo-turner
709	1e7b02b7-6981-427a-b249-8e9bd35f3882	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	nora-reddick
710	413b3ddb-d933-4567-a60e-6d157480239d	2020-08-02 10:22:49.929	2020-08-02 19:09:06.375	winnie-mccall
711	18af933a-4afa-4cba-bda5-45160f3af99b	2020-08-02 10:22:49.929	2020-08-02 23:06:56.344	felix-garbage
712	1ded0384-d290-4ea1-a72b-4f9d220cbe37	2020-08-02 10:22:49.929	2020-08-02 23:06:56.344	juan-murphy
713	ff5a37d9-a6dd-49aa-b6fb-b935fd670820	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	dunn-keyes
714	29bf512a-cd8c-4ceb-b25a-d96300c184bb	2020-08-02 10:22:49.929	2020-08-02 23:06:56.344	garcia-soto
715	e3e1d190-2b94-40c0-8e88-baa3fd198d0f	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	chambers-kennedy
716	fbb5291c-2438-400e-ab32-30ce1259c600	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	cory-novak
717	ff5a37d9-a6dd-49aa-b6fb-b935fd670820	2020-08-02 10:22:49.747	2020-08-03 04:23:53.018	dunn-keyes
718	03b80a57-77ea-4913-9be4-7a85c3594745	2020-08-02 10:22:49.929	2020-08-03 04:23:53.241	halexandrey-walton
719	dfd5ccbb-90ed-4bfe-83e0-dae9cc763f10	2020-08-02 10:22:49.747	2020-08-09 07:23:37.02	owen-picklestein
720	09f2787a-3352-41a6-8810-d80e97b253b5	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	curry-aliciakeyes
721	0c83e3b6-360e-4b7d-85e3-d906633c9ca0	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	penelope-mathews
722	17392be2-7344-48a0-b4db-8a040a7fb532	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	washer-barajas
723	1af239ae-7e12-42be-9120-feff90453c85	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	melton-telephone
724	1e7b02b7-6981-427a-b249-8e9bd35f3882	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	nora-reddick
725	2da49de2-34e5-49d0-b752-af2a2ee061be	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	cory-twelve
726	4e6ad1a1-7c71-49de-8bd5-c286712faf9e	2020-08-02 10:22:49.929	2020-08-02 23:06:56.344	sutton-picklestein
727	4ffd2e50-bb5b-45d0-b7c4-e24d41b2ff5d	2020-08-02 10:22:49.929	2020-08-02 23:06:56.344	schneider-bendie
728	6a869b40-be99-4520-89e5-d382b07e4a3c	2020-08-02 10:22:49.929	2020-08-02 23:06:56.344	jake-swinger
729	7310c32f-8f32-40f2-b086-54555a2c0e86	2020-08-02 10:22:49.929	2020-08-02 23:06:56.344	dominic-marijuana
730	8d81b190-d3b8-4cd9-bcec-0e59fdd7f2bc	2020-07-29 08:12:22.438	2020-08-02 10:22:49.929	albert-stink
731	9397ed91-608e-4b13-98ea-e94c795f651e	2020-08-02 10:22:49.929	2020-08-02 23:06:56.344	yeongho-garcia
732	945974c5-17d9-43e7-92f6-ba49064bbc59	2020-08-02 10:22:49.929	2020-08-02 23:06:56.344	bates-silk
733	81d7d022-19d6-427d-aafc-031fcb79b29e	2020-08-02 10:22:49.929	2020-08-03 04:23:53.241	patty-fox
734	8d81b190-d3b8-4cd9-bcec-0e59fdd7f2bc	2020-08-02 10:22:49.929	2020-08-03 04:23:53.241	albert-stink
735	94f30f21-f889-4a2e-9b94-818475bb1ca0	2020-08-02 10:22:49.929	2020-08-03 04:23:53.241	kirkland-sobremesa
736	44c92d97-bb39-469d-a13b-f2dd9ae644d1	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	francisco-preston
737	450e6483-d116-41d8-933b-1b541d5f0026	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	england-voorhees
738	4b3e8e9b-6de1-4840-8751-b1fb45dc5605	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	thomas-dracaena
739	63512571-2eca-4bc4-8ad9-a5308a22ae22	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	oscar-dollie
740	82733eb4-103d-4be1-843e-6eb6df35ecd7	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	adkins-tosser
741	8adb084b-19fe-4295-bcd2-f92afdb62bd7	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	logan-rodriguez
742	94d772c7-0254-4f08-814c-f6fc58fcfb9b	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	fletcher-peck
743	a1628d97-16ca-4a75-b8df-569bae02bef9	2020-08-02 10:22:49.929	2020-08-02 23:06:56.344	chorby-soul
744	ac57cf28-556f-47af-9154-6bcea2ace9fc	2020-08-02 10:22:49.929	2020-08-02 23:06:56.344	rey-wooten
745	9965eed5-086c-4977-9470-fe410f92d353	2020-08-02 10:22:49.929	2020-08-03 04:23:53.241	bates-bentley
746	9a031b9a-16f8-4165-a468-5d0e28a81151	2020-08-02 10:22:49.929	2020-08-03 04:23:53.241	tiana-wheeler
747	b1b141fc-e867-40d1-842a-cea30a97ca4f	2020-08-02 10:22:49.929	2020-08-02 19:09:06.375	richardson-games
748	a311c089-0df4-46bd-9f5d-8c45c7eb5ae2	2020-08-02 10:22:49.929	2020-08-03 04:23:53.241	mclaughlin-scorpler
749	a5adc84c-80b8-49e4-9962-8b4ade99a922	2020-08-02 10:22:49.929	2020-08-03 04:23:53.241	richardson-turquoise
750	ac69dba3-6225-4afd-ab4b-23fc78f730fb	2020-08-02 10:22:49.929	2020-08-03 04:23:53.241	bevan-wise
751	b77dffaa-e0f5-408f-b9f2-1894ed26e744	2020-08-02 10:22:49.929	2020-08-03 04:23:53.241	tucker-lenny
752	db53211c-f841-4f33-accf-0c3e167889a0	2020-08-02 10:22:49.929	2020-08-03 04:23:53.241	travis-bendie
753	9e724d9a-92a0-436e-bde1-da0b2af85d8f	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	hatfield-suzuki
754	aa6c2662-75f8-4506-aa06-9a0993313216	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	eizabeth-elliott
755	ab9b2592-a64a-4913-bf6c-3ae5bd5d26a5	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	beau-huerta
756	b6aa8ce8-2587-4627-83c1-2a48d44afaee	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	inky-rutledge
757	c4951cae-0b47-468b-a3ac-390cc8e9fd05	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	timmy-vine
758	c6146c45-3d9b-4749-9f03-d4faae61e2c3	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	atlas-diaz
759	f967d064-0eaf-4445-b225-daed700e044b	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	wesley-dudley
760	13a05157-6172-4431-947b-a058217b4aa5	2020-08-02 10:22:50.243	2020-08-02 19:09:06.572	spears-taylor
761	15ae64cd-f698-4b00-9d61-c9fffd037ae2	2020-08-02 10:22:50.243	2020-08-02 19:09:06.572	mickey-woods
762	1732e623-ffc2-40f0-87ba-fdcf97131f1f	2020-08-02 10:22:50.243	2020-08-02 19:09:06.572	betsy-trombone
763	1ba715f2-caa3-44c0-9118-b045ea702a34	2020-08-02 10:22:50.243	2020-08-02 19:09:06.572	juan-rangel
764	5915b7bb-e532-4036-9009-79f1e80c0e28	2020-07-29 08:12:22.438	2020-08-02 10:22:50.243	rosa-holloway
765	26cfccf2-850e-43eb-b085-ff73ad0749b8	2020-08-02 10:22:50.243	2020-08-02 19:09:06.572	beasley-day
766	60026a9d-fc9a-4f5a-94fd-2225398fa3da	2020-08-02 10:22:50.243	2020-08-02 19:09:06.572	bright-zimmerman
767	0672a4be-7e00-402c-b8d6-0b813f58ba96	2020-08-02 10:22:50.243	2020-08-02 21:23:43.024	castillo-logan
768	5915b7bb-e532-4036-9009-79f1e80c0e28	2020-08-02 10:22:50.243	2020-08-02 21:23:43.024	rosa-holloway
769	083d09d4-7ed3-4100-b021-8fbe30dd43e8	2020-08-02 10:22:50.243	2020-08-02 21:23:43.507	jessica-telephone
770	338694b7-6256-4724-86b6-3884299a5d9e	2020-08-02 10:22:50.243	2020-08-03 04:23:53.763	polkadot-patterson
771	1ffb1153-909d-44c7-9df1-6ed3a9a45bbd	2020-08-02 10:22:50.243	2020-08-03 05:23:56.421	montgomery-bullock
772	20395b48-279d-44ff-b5bf-7cf2624a2d30	2020-08-02 10:22:50.243	2020-08-03 05:23:56.421	adrian-melon
773	4ecee7be-93e4-4f04-b114-6b333e0e6408	2020-08-02 10:22:50.243	2020-08-03 05:23:56.421	sutton-dreamy
774	1a93a2d2-b5b6-479b-a595-703e4a2f3885	2020-08-02 10:22:50.243	2020-08-09 07:23:37.743	pedro-davids
775	34e1b683-ecd5-477f-b9e3-dd4bca76db45	2020-08-02 10:22:50.243	2020-08-09 07:23:37.743	alexandria-hess
776	4e63cb5d-4fce-441b-b9e4-dc6a467cf2fd	2020-08-02 10:22:50.243	2020-08-09 07:23:37.743	axel-campbell
777	80dff591-2393-448a-8d88-122bd424fa4c	2020-08-02 10:22:50.243	2020-08-02 19:09:06.572	elvis-figueroa
778	814bae61-071a-449b-981e-e7afc839d6d6	2020-08-02 10:22:50.243	2020-08-02 19:09:06.572	ruslan-greatness
779	9786b2c9-1205-4718-b0f7-fc000ce91106	2020-08-02 10:22:50.243	2020-08-02 19:09:06.572	kevin-dudley
780	b082ca6e-eb11-4eab-8d6a-30f8be522ec4	2020-08-02 10:22:50.243	2020-08-02 19:09:06.572	nicholas-mora
781	66cebbbf-9933-4329-924a-72bd3718f321	2020-08-02 10:22:50.243	2020-08-02 19:09:06.572	kennedy-cena
782	62111c49-1521-4ca7-8678-cd45dacf0858	2020-08-02 10:22:50.243	2020-08-02 21:23:43.024	bambi-perez
783	7dcf6902-632f-48c5-936a-7cf88802b93a	2020-08-02 10:22:50.243	2020-08-02 21:23:43.024	parker-parra
784	906a5728-5454-44a0-adfe-fd8be15b8d9b	2020-08-02 10:22:50.243	2020-08-02 21:23:43.024	jefferson-delacruz
785	97dfc1f6-ac94-4cdc-b0d5-1cb9f8984aa5	2020-08-02 10:22:50.243	2020-08-02 21:23:43.024	brock-forbes
786	7e160e9f-2c79-4e08-8b76-b816de388a98	2020-08-02 10:22:50.243	2020-08-03 05:23:56.421	thomas-marsh
787	90cc0211-cd04-4cac-bdac-646c792773fc	2020-08-02 10:22:50.243	2020-08-03 05:23:56.421	case-lancaster
788	c675fcdf-6117-49a6-ac32-99a89a3a88aa	2020-08-02 10:22:50.243	2020-08-03 05:23:56.421	valentine-games
789	7afedcd8-870d-4655-9659-3bdfb2e17730	2020-08-02 10:22:50.243	2020-08-09 07:23:37.743	pierre-haley
790	817dee99-9ccf-4f41-84e3-dc9773237bc8	2020-08-02 10:22:50.243	2020-08-09 07:23:37.743	holden-stanton
791	84a2b5f6-4955-4007-9299-3d35ae7135d3	2020-08-02 10:22:50.243	2020-08-09 07:23:37.743	kennedy-loser
792	a7b0bef3-ee3c-42d4-9e6d-683cd9f5ed84	2020-08-02 10:22:50.243	2020-08-09 07:23:37.743	haruta-byrd
793	b85161da-7f4c-42a8-b7f6-19789cf6861d	2020-08-02 10:22:50.243	2020-08-09 07:23:37.743	javier-lotus
794	d35ccee1-9559-49a1-aaa4-7809f7b5c46e	2020-08-02 10:22:50.243	2020-08-02 21:23:43.024	forrest-best
795	dd8a43a4-a024-44e9-a522-785d998b29c3	2020-08-02 10:22:50.243	2020-08-02 21:23:43.024	miguel-peterson
796	089af518-e27c-4256-adc8-62e3f4b30f43	2020-08-02 10:22:51.036	2020-08-03 04:23:53.572	silvia-rugrat
797	d2a1e734-60d9-4989-b7d9-6eacda70486b	2020-08-02 10:22:50.243	2020-08-03 05:23:56.421	tiana-takahashi
798	1750de38-8f5f-426a-9e23-2899a15a2031	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	kline-nightmare
799	d6c69d2d-9344-4b19-85a4-6cfcbaead5d2	2020-08-02 10:22:50.243	2020-08-03 05:23:56.421	joshua-watson
800	f70dd57b-55c4-4a62-a5ea-7cc4bf9d8ac1	2020-08-02 10:22:50.243	2020-08-03 05:23:56.421	tillman-henderson
801	f8c20693-f439-4a29-a421-05ed92749f10	2020-08-02 10:22:50.243	2020-08-03 05:23:56.421	combs-duende
802	cd5494b4-05d0-4b2e-8578-357f0923ff4c	2020-08-02 10:22:50.243	2020-08-09 07:23:37.743	mcfarland-vargas
803	ce3fb736-d20e-4e2a-88cb-e136783d3a47	2020-08-02 10:22:50.243	2020-08-09 07:23:37.743	javier-howe
804	d0d7b8fe-bad8-481f-978e-cb659304ed49	2020-08-02 10:22:50.243	2020-08-09 07:23:37.743	adalberto-tosser
805	d8bc482e-9309-4230-abcb-2c5a6412446d	2020-08-02 10:22:50.243	2020-08-09 07:23:37.743	august-obrien
806	dd6ba7f1-a97a-4374-a3a7-b3596e286bb3	2020-08-02 10:22:50.243	2020-08-09 07:23:37.743	matheo-tanaka
807	e1e33aab-df8c-4f53-b30a-ca1cea9f046e	2020-08-02 10:22:50.243	2020-08-09 07:23:37.743	joyner-rugrat
808	088884af-f38d-4914-9d67-b319287481b4	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	liam-petty
809	14bfad43-2638-41ec-8964-8351f22e9c4f	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	baby-sliders
810	1750de38-8f5f-426a-9e23-2899a15a2031	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	kline-nightmare
811	4542f0b0-3409-4a4a-a9e1-e8e8e5d73fcf	2020-08-02 10:22:51.036	2020-08-02 21:23:43.264	brock-watson
812	4562ac1f-026c-472c-b4e9-ee6ff800d701	2020-08-02 10:22:51.036	2020-08-02 21:23:43.264	chris-koch
813	190a0f31-d686-4ac4-a7f3-cfc87b72c145	2020-08-02 10:22:51.036	2020-08-03 04:23:53.572	nerd-pacheco
814	19af0d67-c73b-4ef2-bc84-e923c1336db5	2020-08-02 10:22:51.036	2020-08-03 04:23:53.572	grit-ramos
815	472f50c0-ef98-4d05-91d0-d6359eec3946	2020-08-02 10:22:51.036	\N	rhys-trombone
816	2b9f9c25-43ec-4f0b-9937-a5aa23be0d9e	2020-08-02 10:22:51.036	2020-08-03 04:23:53.572	lawrence-horne
817	6644d767-ab15-4528-a4ce-ae1f8aadb65f	2020-08-02 10:22:51.036	2020-08-03 04:23:53.572	paula-reddick
818	206bd649-4f5f-4707-ad85-92784be4eb95	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	newton-underbuck
819	20fd71e7-4fa0-4132-9f47-06a314ed539a	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	lars-taylor
820	25376b55-bb6f-48a7-9381-7b8210842fad	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	emmett-internet
821	316abea7-9890-4fb8-aaea-86b35e24d9be	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	kennedy-rodgers
822	333067fd-c2b4-4045-a9a4-e87a8d0332d0	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	miguel-james
823	3d3be7b8-1cbf-450d-8503-fce0daf46cbf	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	zack-sanders
824	3dd85c20-a251-4903-8a3b-1b96941c07b7	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	tot-best
825	4f69e8c2-b2a1-4e98-996a-ccf35ac844c5	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	igneus-delacruz
826	5703141c-25d9-46d0-b680-0cf9cfbf4777	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	sandoval-crossing
827	65273615-22d5-4df1-9a73-707b23e828d5	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	burke-gonzales
828	7951836f-581a-49d5-ae2f-049c6bcc575e	2020-08-02 10:22:51.036	2020-08-02 21:23:43.264	adkins-gwiffin
829	8604e861-d784-43f0-b0f8-0d43ea6f7814	2020-08-02 10:22:51.036	2020-08-02 21:23:43.264	randall-marijuana
830	8e1fd784-99d5-41c1-a6c5-6b947cec6714	2020-08-02 10:22:51.036	2020-08-02 21:23:43.264	velasquez-meadows
831	89f74891-2e25-4b5a-bd99-c95ba3f36aa0	2020-08-02 10:22:51.036	2020-08-03 04:23:53.572	nagomi-nava
832	7951836f-581a-49d5-ae2f-049c6bcc575e	2020-07-29 08:12:22.438	2020-08-02 10:22:51.036	adkins-gwiffin
833	bd9d1d6e-7822-4ad9-bac4-89b8afd8a630	2020-08-02 19:09:07.396	\N	derrick-krueger
834	aa7ac9cb-e9db-4313-9941-9f3431728dce	2020-08-02 10:22:51.036	2020-08-03 04:23:53.572	matteo-cash
835	ad1e670a-f346-4bf7-a02f-a91649c41ccb	2020-08-02 10:22:51.036	2020-08-03 04:23:53.572	stephanie-winters
836	b7267aba-6114-4d53-a519-bf6c99f4e3a9	2020-08-02 10:22:51.036	2020-08-03 04:23:53.572	sosa-hayes
837	bd8778e5-02e8-4d1f-9c31-7b63942cc570	2020-08-02 10:22:51.036	2020-08-03 04:23:53.572	cell-barajas
838	7007cbd3-7c7b-44fd-9d6b-393e82b1c06e	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	rafael-davids
839	80e474a3-7d2b-431d-8192-2f1e27162607	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	summers-preston
840	8b0d717f-ae42-4492-b2ed-106912e2b530	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	avila-baker
841	b69aa26f-71f7-4e17-bc36-49c875872cc1	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	francisca-burton
842	bd8d58b6-f37f-48e6-9919-8e14ec91f92a	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	jose-haley
843	ca709205-226d-4d92-8be6-5f7871f48e26	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	rivers-javier
844	ce0e57a7-89f5-41ea-80f9-6e649dd54089	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	yong-wright
845	ceac785e-55fd-4a4e-9bc8-17a662a58a38	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	best-cerna
846	2720559e-9173-4042-aaa0-d3852b72ab2e	2020-08-02 10:22:51.488	2020-08-02 21:23:43.507	hiroto-wilcox
847	2e86de11-a2dd-4b28-b5fe-f4d0c38cd20b	2020-08-02 10:22:51.488	2020-08-02 21:23:43.507	zion-aliciakeyes
848	e4f1f358-ee1f-4466-863e-f329766279d0	2020-08-02 10:22:51.036	2020-08-03 04:23:53.572	ronan-combs
849	25f3a67c-4ed5-45b6-94b1-ce468d3ead21	2020-08-02 10:22:51.488	2020-08-02 21:23:43.507	hobbs-cain
850	f4ca437c-c31c-4508-afe7-6dae4330d717	2020-08-02 10:22:51.036	2020-08-03 04:23:53.572	fran-beans
851	020ed630-8bae-4441-95cc-0e4ecc27253b	2020-08-02 10:22:51.488	2020-08-03 04:23:53.763	simon-haley
852	27faa5a7-d3a8-4d2d-8e62-47cfeba74ff0	2020-08-02 10:22:51.488	2020-08-03 04:23:53.763	spears-nolan
853	37efef78-2df4-4c76-800c-43d4faf07737	2020-08-02 10:22:51.488	2020-08-03 04:23:53.763	lenix-ren
854	e3c06405-0564-47ce-bbbd-552bee4dd66f	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	scrap-weeks
855	e919dfae-91c3-475c-b5d5-8b0c14940c41	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	famous-meng
856	f2468055-e880-40bf-8ac6-a0763d846eb2	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	alaynabella-hollywood
857	f56657d3-3bdc-4840-a20c-91aca9cc360e	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	malik-romayne
858	f883269f-117e-45ec-bb1e-fa8dbcf40d3e	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	jayden-wright
859	1f145436-b25d-49b9-a1e3-2d3c91626211	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	joe-voorhees
860	24cb35c1-c24c-45ca-ac0b-f99a2e650d89	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	tyreek-peterson
861	2727215d-3714-438d-b1ba-2ed15ec481c0	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	dominic-woman
862	32c9bce6-6e52-40fa-9f64-3629b3d026a8	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	ren-morin
863	3ebb5361-3895-4a50-801e-e7a0ee61750c	2020-08-02 10:22:51.488	2020-08-02 21:23:43.507	augusto-reddick
864	64f59d5f-8740-4ebf-91bd-d7697b542a9f	2020-08-02 10:22:51.488	2020-08-02 21:23:43.507	zeke-wallace
865	77a41c29-8abd-4456-b6e0-a034252700d2	2020-08-02 10:22:51.488	2020-08-02 21:23:43.507	elip-dean
866	5ff66eae-7111-4e3b-a9b8-a9579165b0a5	2020-08-02 10:22:51.488	2020-08-02 19:09:06.98	daniel-duffy
867	7aeb8e0b-f6fb-4a9e-bba2-335dada5f0a3	2020-08-02 10:22:51.488	2020-08-02 21:23:43.507	dunlap-figueroa
868	51cba429-13e8-487e-9568-847b7b8b9ac5	2020-08-02 10:22:51.488	2020-08-03 04:23:53.763	collins-mina
869	5b9727f7-6a20-47d2-93d9-779f0a85c4ee	2020-08-02 10:22:51.488	2020-08-03 04:23:53.763	kennedy-alstott
870	695daf02-113d-4e76-b802-0862df16afbd	2020-08-02 10:22:51.488	2020-08-03 04:23:53.763	pacheco-weeks
871	542af915-79c5-431c-a271-f7185e37c6ae	2020-08-02 10:22:51.488	2020-08-09 07:23:37.743	oliver-notarobot
872	58fca5fa-e559-4f5e-ac87-dc99dd19e410	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	sullivan-septemberish
873	90c2cec7-0ed5-426a-9de8-754f34d59b39	2020-08-02 21:23:43.84	2020-08-03 04:23:54.25	tot-fox
874	5fc4713c-45e1-4593-a968-7defeb00a0d4	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	percival-bendie
875	6524e9e0-828a-46c4-935d-0ee2edeb7e9a	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	carter-turnip
876	6e744b21-c4fa-4fa8-b4ea-e0e97f68ded5	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	daniel-koch
877	7853aa8c-e86d-4483-927d-c1d14ea3a34d	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	tucker-flores
878	7932c7c7-babb-4245-b9f5-cdadb97c99fb	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	randy-castillo
879	7cf83bdc-f95f-49d3-b716-06f2cf60a78d	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	matteo-urlacher
880	80de2b05-e0d4-4d33-9297-9951b2b5c950	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	alyssa-harrell
881	c3b1b4e5-4b88-4245-b2b1-ae3ade57349e	2020-08-02 10:22:51.488	2020-08-02 21:23:43.507	wall-osborn
882	d4a10c2a-0c28-466a-9213-38ba3339b65e	2020-08-02 10:22:51.488	2020-08-02 21:23:43.507	richmond-harrison
883	afc90398-b891-4cdf-9dea-af8a3a79d793	2020-08-02 10:22:51.488	2020-08-02 21:23:43.507	yazmin-mason
884	d744f534-2352-472b-9e42-cd91fa540f1b	2020-08-02 10:22:51.488	2020-08-02 21:23:43.507	tyler-violet
885	d74a2473-1f29-40fa-a41e-66fa2281dfca	2020-08-02 10:22:51.488	2020-08-02 21:23:43.507	landry-violence
886	8f11ad58-e0b9-465c-9442-f46991274557	2020-08-02 10:22:51.488	2020-08-03 04:23:53.763	amos-melon
887	9abe02fb-2b5a-432f-b0af-176be6bd62cf	2020-08-02 10:22:51.488	2020-08-03 04:23:53.763	nagomi-meng
888	9be56060-3b01-47aa-a090-d072ef109fbf	2020-08-02 10:22:51.488	2020-08-03 04:23:53.763	jesus-koch
889	ceb5606d-ea3f-4471-9ca7-3d2e71a50dde	2020-08-02 10:22:51.488	2020-08-03 04:23:53.763	london-simmons
890	d1a7c13f-8e78-4d2e-9cae-ebf3a5fcdb5d	2020-08-02 10:22:51.488	2020-08-03 04:23:53.763	elijah-bates
891	d8742d68-8fce-4d52-9a49-f4e33bd2a6fc	2020-08-02 10:22:51.488	2020-08-03 04:23:53.763	ortiz-morse
1639	a7edbf19-caf6-45dd-83d5-46496c99aa88	2020-08-09 07:23:36.831	\N	rush-valenzuela
892	90768354-957e-4b4c-bb6d-eab6bbda0ba3	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	eugenia-garbage
893	9ba361a1-16d5-4f30-b590-fc4fc2fb53d2	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	mooney-doctor
894	b3e512df-c411-4100-9544-0ceadddb28cf	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	famous-owens
895	c57222fd-df55-464c-a44e-b15443e61b70	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	natha-spruce
896	d89da2d2-674c-4b85-8959-a4bd406f760a	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	fish-summer
897	db3ff6f0-1045-4223-b3a8-a016ca987af9	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	murphy-thibault
898	32551e28-3a40-47ae-aed1-ff5bc66be879	2020-08-02 10:22:51.755	2020-08-02 21:23:43.721	math-velazquez
899	446a3366-3fe3-41bb-bfdd-d8717f2152a9	2020-08-02 10:22:51.755	2020-08-02 21:23:43.721	marco-escobar
900	0daf04fc-8d0d-4513-8e98-4f610616453b	2020-08-02 10:22:51.755	2020-08-02 21:23:43.721	lee-mist
901	4aa843a4-baa1-4f35-8748-63aa82bd0e03	2020-08-02 10:22:51.755	2020-08-02 21:23:43.721	aureliano-dollie
902	57b4827b-26b0-4384-a431-9f63f715bc5b	2020-08-02 10:22:51.755	2020-08-02 21:23:43.721	aureliano-cerna
903	0eddd056-9d72-4804-bd60-53144b785d5c	2020-08-02 10:22:51.755	2020-08-03 02:23:50.577	caleb-novak
904	1aec2c01-b766-4018-a271-419e5371bc8f	2020-08-02 10:22:51.755	2020-08-03 02:23:50.577	rush-ito
905	20be1c34-071d-40c6-8824-dde2af184b4d	2020-08-02 10:22:51.755	2020-08-03 02:23:50.577	qais-dogwalker
906	285ce77d-e5cd-4daa-9784-801347140d48	2020-08-02 10:22:51.755	2020-08-03 02:23:50.577	son-scotch
907	2ca0c790-e1d5-4a14-ab3c-e9241c87fc23	2020-08-02 10:22:51.755	2020-08-03 04:23:54.117	murray-pony
908	2e6d4fa9-f930-47bd-971a-dd54a3cf7db1	2020-08-02 10:22:51.755	2020-08-04 20:18:31.843	raul-leal
909	e6502bc7-5b76-4939-9fb8-132057390b30	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	greer-lott
910	07ac91e9-0269-4e2c-a62d-a87ef61e3bbe	2020-08-02 10:22:51.755	2020-08-09 07:23:38.236	eduardo-perez
911	12577256-bc4e-4955-81d6-b422d895fb12	2020-08-02 10:22:51.755	2020-08-09 07:23:38.236	jasmine-washington
912	24ad200d-a45f-4286-bfa5-48909f98a1f7	2020-08-02 10:22:51.755	2020-08-09 07:23:38.236	nicholas-summer
913	3a8c52d7-4124-4a65-a20d-d51abcbe6540	2020-08-02 10:22:51.755	2020-08-09 07:23:38.236	theodore-holloway
914	503a235f-9fa6-41b5-8514-9475c944273f	2020-08-02 10:22:51.755	2020-08-09 07:23:38.236	reese-clark
915	8903a74f-f322-41d2-bd75-dbf7563c4abb	2020-08-02 10:22:51.755	2020-08-02 21:23:43.721	francisca-sasquatch
916	90c6e6ca-77fc-42b7-94d8-d8afd6d299e5	2020-08-02 10:22:51.755	2020-08-02 21:23:43.721	miki-santana
917	68462bfa-9006-4637-8830-2e7840d9089a	2020-08-02 10:22:51.755	2020-08-02 21:23:43.721	parker-horseman
918	97981e86-4a42-4f85-8783-9f29833c192b	2020-08-02 10:22:51.755	2020-08-02 21:23:43.721	daiya-vine
919	97ec5a2f-ac1a-4cde-86b7-897c030a1fa8	2020-08-02 10:22:51.755	2020-08-02 21:23:43.721	alston-woods
920	a8530be5-8923-4f74-9675-bf8a1a8f7878	2020-08-02 10:22:51.755	2020-08-02 21:23:43.721	mohammed-picklestein
921	b7adbbcc-0679-43f3-a939-07f009a393db	2020-08-02 10:22:51.755	2020-08-02 21:23:43.721	jode-crutch
922	b7c4f986-e62a-4a8f-b5f0-8f30ecc35c5d	2020-08-02 10:22:51.755	2020-08-02 21:23:43.721	oscar-hollywood
923	64b055d1-b691-4e0c-8583-fc08ba663846	2020-08-02 10:22:51.755	2020-08-03 02:23:50.577	theodore-passon
924	889c9ef9-d521-4436-b41c-9021b81b4dfb	2020-08-02 10:22:51.755	2020-08-03 02:23:50.577	liam-snail
925	bbf9543f-f100-445a-a467-81d7aab12236	2020-08-02 10:22:51.755	2020-08-03 02:23:50.577	farrell-seagull
926	5a26fc61-d75d-4c01-9ce2-1880ffb5550f	2020-08-02 10:22:51.755	2020-08-05 04:34:24.62	randy-dennis
927	6bac62ad-7117-4e41-80f9-5a155a434856	2020-08-02 10:22:51.755	2020-08-09 07:23:38.236	grit-freeman
928	7fed72df-87de-407d-8253-2295a2b60d3b	2020-08-02 10:22:51.755	2020-08-09 07:23:38.236	stout-schmitt
929	af6b3edc-ed52-4edc-b0c9-14e0a5ae0ee3	2020-08-02 10:22:51.755	2020-08-09 07:23:38.236	rivers-clembons
930	b019fb2b-9f4b-4deb-bf78-6bee2f16d98d	2020-08-02 10:22:51.755	2020-08-09 07:23:38.236	gloria-bentley
931	b7c1ddda-945c-4b2e-8831-ad9f2ec4a608	2020-08-02 10:22:51.755	2020-08-09 07:23:38.236	nolan-violet
932	e972984c-2895-451c-b518-f06a0d8bd375	2020-08-02 10:22:51.755	2020-08-02 21:23:43.721	becker-solis
933	ecb8d2f5-4ff5-4890-9693-5654e00055f6	2020-08-02 10:22:51.755	2020-08-02 21:23:43.721	yeongho-benitez
934	e111a46d-5ada-4311-ac4f-175cca3357da	2020-08-02 10:22:51.755	2020-08-02 21:23:43.721	alexandria-rosales
935	ef9f8b95-9e73-49cd-be54-60f84858a285	2020-08-02 10:22:51.755	2020-08-03 02:23:50.577	collins-melon
936	0f61d948-4f0c-4550-8410-ae1c7f9f5613	2020-08-02 10:22:51.881	2020-08-03 02:23:50.85	tamara-crankit
937	03097200-0d48-4236-a3d2-8bdb153aa8f7	2020-08-02 10:22:51.881	2020-08-03 04:23:54.25	bennett-browning
938	1301ee81-406e-43d9-b2bb-55ca6e0f7765	2020-08-02 10:22:51.881	2020-08-03 04:23:54.25	malik-destiny
939	fa477c92-39b6-4a52-b065-40af2f29840a	2020-08-02 10:22:51.755	2020-08-08 03:15:12.948	howell-franklin
940	c22e3af5-9001-465f-b450-864d7db2b4a0	2020-08-02 10:22:51.755	2020-08-09 07:23:38.236	logan-horseman
941	c4418663-7aa4-4c9f-ae73-0e81e442e8a2	2020-08-02 10:22:51.755	2020-08-09 07:23:38.236	chris-thibault
942	ceb8f8cd-80b2-47f0-b43e-4d885fa48aa4	2020-08-02 10:22:51.755	2020-08-09 07:23:38.236	donia-bailey
943	d2d76815-cbdc-4c4b-9c9e-32ebf2297cc7	2020-08-02 10:22:51.755	2020-08-09 07:23:38.236	denzel-scott
944	f38c5d80-093f-46eb-99d6-942aa45cd921	2020-08-02 10:22:51.755	2020-08-09 07:23:38.236	andrew-solis
945	061b209a-9cda-44e8-88ce-6a4a37251970	2020-08-02 10:22:51.881	2020-08-09 07:23:38.432	mcdowell-karim
946	1068f44b-34a0-42d8-a92e-2be748681a6f	2020-08-02 10:22:51.881	2020-08-09 07:23:38.432	allison-abbott
947	16a59f5f-ef0f-4ada-8682-891ad571a0b6	2020-08-02 10:22:51.881	2020-08-09 07:23:38.432	boyfriend-berger
948	1c73f91e-0562-480d-9543-2aab1d5e5acd	2020-08-02 10:22:51.881	2020-08-02 21:23:43.84	sparks-beans
949	3de17e21-17db-4a6b-b7ab-0b2f3c154f42	2020-08-02 10:22:51.881	2020-08-02 21:23:43.84	brewer-vapor
950	495a6bdc-174d-4ad6-8d51-9ee88b1c2e4a	2020-08-02 10:22:51.881	2020-08-02 21:23:43.84	shaquille-torres
951	6f9de777-e812-4c84-915c-ef283c9f0cde	2020-08-02 10:22:51.881	2020-08-02 19:09:07.396	arturo-huerta
952	5fbf04bb-f5ec-4589-ab19-1d89cda056bd	2020-08-02 10:22:51.881	2020-08-02 21:23:43.84	donia-dollie
953	864b3be8-e836-426e-ae56-20345b41d03d	2020-08-02 10:22:51.881	2020-08-02 21:23:43.84	goodwin-morin
954	90c2cec7-0ed5-426a-9de8-754f34d59b39	2020-08-02 10:22:51.881	2020-08-02 21:23:43.84	tot-fox
955	8b53ce82-4b1a-48f0-999d-1774b3719202	2020-08-02 10:22:51.881	2020-08-03 02:23:50.85	oliver-mueller
956	b348c037-eefc-4b81-8edd-dfa96188a97e	2020-08-02 10:22:51.881	2020-08-03 02:23:50.85	lowe-forbes
957	678170e4-0688-436d-a02d-c0467f9af8c0	2020-08-02 10:22:51.881	2020-08-03 04:23:54.25	baby-doyle
958	8cf78b49-d0ca-4703-88e8-4bcad26c44b1	2020-08-02 10:22:51.881	2020-08-03 04:23:54.25	avila-guzman
959	9c3273a0-2711-4958-b716-bfcf60857013	2020-08-02 10:22:51.881	2020-08-03 04:23:54.25	kathy-mathews
960	4f328502-d347-4d2c-8fad-6ae59431d781	2020-08-02 10:22:51.881	2020-08-05 16:21:07.648	stephens-lightner
961	425f3f84-bab0-4cf2-91c1-96e78cf5cd02	2020-08-02 10:22:51.881	2020-08-09 07:23:38.432	luis-acevedo
962	4ed61b18-c1f6-4d71-aea3-caac01470b5c	2020-08-02 10:22:51.881	2020-08-09 07:23:38.432	lenny-marijuana
963	a3947fbc-50ec-45a4-bca4-49ffebb77dbe	2020-08-02 10:22:51.881	2020-08-09 07:23:38.432	chorby-short
964	b5c95dba-2624-41b0-aacd-ac3e1e1fe828	2020-08-02 10:22:51.881	2020-08-09 07:23:38.432	cote-rodgers
965	e3c514ae-f813-470e-9c91-d5baf5ffcf16	2020-08-02 10:22:51.881	2020-08-02 19:09:07.396	tot-clark
1793	ce3fb736-d20e-4e2a-88cb-e136783d3a47	2020-08-09 07:23:37.743	\N	javier-howe
966	cf8e152e-2d27-4dcc-ba2b-68127de4e6a4	2020-08-02 10:22:51.881	2020-08-02 21:23:43.84	hendricks-richardson
967	d5b6b11d-3924-4634-bd50-76553f1f162b	2020-08-02 10:22:51.881	2020-08-02 21:23:43.84	ogden-mendoza
968	c6a277c3-d2b5-4363-839b-950896a5ec5e	2020-08-02 10:22:51.881	2020-08-02 19:09:07.396	mike-townsend
969	f10ba06e-d509-414b-90cd-4d70d43c75f9	2020-08-02 10:22:51.881	2020-08-02 21:23:43.84	hernando-winter
970	bf122660-df52-4fc4-9e70-ee185423ff93	2020-08-02 10:22:51.881	2020-08-03 02:23:50.85	walton-sports
971	efa73de4-af17-4f88-99d6-d0d69ed1d200	2020-08-02 10:22:51.881	2020-08-03 02:23:50.85	antonio-mccall
972	efafe75e-2f00-4418-914c-9b6675d39264	2020-08-02 10:22:51.881	2020-08-03 02:23:50.85	aldon-cashmoney
973	ce58415f-4e62-47e2-a2c9-4d6a85961e1e	2020-08-02 10:22:51.881	2020-08-03 04:23:54.25	schneider-blanco
974	d8ee256f-e3d0-46cb-8c77-b1f88d8c9df9	2020-08-02 10:22:51.881	2020-08-03 04:23:54.25	comfort-septemberish
975	da0bbbe6-d13c-40cc-9594-8c476975d93d	2020-08-02 10:22:51.881	2020-08-03 04:23:54.25	lang-richardson
976	dd0b48fe-2d49-4344-83ed-9f0770b370a8	2020-08-02 10:22:51.881	2020-08-03 04:23:54.25	tillman-wan
977	e376a90b-7ffe-47a2-a934-f36d6806f17d	2020-08-02 10:22:51.881	2020-08-03 04:23:54.25	howell-rocha
978	b88d313f-e546-407e-8bc6-94040499daa5	2020-08-02 10:22:51.881	2020-08-09 07:23:38.432	oliver-loofah
979	dac2fd55-5686-465f-a1b6-6fbed0b417c5	2020-08-02 10:22:51.881	2020-08-09 07:23:38.432	russo-slugger
980	e6114fd4-a11d-4f6c-b823-65691bb2d288	2020-08-02 10:22:51.881	2020-08-09 07:23:38.432	bevan-underbuck
981	ecf19925-dc57-4b89-b114-923d5a714dbe	2020-08-02 10:22:51.881	2020-08-09 07:23:38.432	margarito-bishop
982	73265ee3-bb35-40d1-b696-1f241a6f5966	2020-08-02 10:22:48.089	2020-08-02 19:09:05.571	parker-meng
983	80a2f015-9d40-426b-a4f6-b9911ba3add8	2020-08-02 19:09:05.571	\N	paul-barnes
984	11de4da3-8208-43ff-a1ff-0b3480a0fbf1	2020-08-02 19:09:05.571	2020-08-02 21:23:42.002	don-mitchell
985	11de4da3-8208-43ff-a1ff-0b3480a0fbf1	2020-08-02 10:22:48.089	2020-08-02 19:09:05.571	don-mitchell
986	126fb128-7c53-45b5-ac2b-5dbf9943d71b	2020-08-02 19:09:05.571	2020-08-02 21:23:42.002	sigmund-castillo
987	2b157c5c-9a6a-45a6-858f-bf4cf4cbc0bd	2020-08-02 19:09:05.571	2020-08-02 21:23:42.002	ortiz-lopez
988	43bf6a6d-cc03-4bcf-938d-620e185433e1	2020-08-02 19:09:05.571	2020-08-02 21:23:42.002	miguel-javier
989	58c9e294-bd49-457c-883f-fb3162fc668e	2020-08-02 19:09:05.571	2020-08-02 21:23:42.002	kichiro-guerra
990	bd24e18b-800d-4f15-878d-e334fb4803c4	2020-08-02 19:09:05.571	2020-08-02 21:23:42.002	helga-burton
991	f4a5d734-0ade-4410-abb6-c0cd5a7a1c26	2020-08-02 10:22:51.881	2020-08-02 21:23:43.84	agan-harrison
992	f6342729-a38a-4204-af8d-64b7accb5620	2020-08-02 10:22:51.881	2020-08-02 21:23:43.84	marco-winner
993	f968532a-bf06-478e-89e0-3856b7f4b124	2020-08-02 10:22:51.881	2020-08-02 21:23:43.84	daniel-benedicte
994	3c331c87-1634-46c4-87ce-e4b9c59e2969	2020-08-02 19:09:05.571	2020-08-03 02:23:49.05	yosh-carpenter
995	7c5ae357-e079-4427-a90f-97d164c7262e	2020-08-02 19:09:05.571	2020-08-03 02:23:49.05	milo-brown
996	73265ee3-bb35-40d1-b696-1f241a6f5966	2020-08-02 19:09:05.571	2020-08-09 07:23:36.435	parker-meng
997	f3c07eaf-3d6c-4cc3-9e54-cbecc9c08286	2020-08-02 10:22:51.881	2020-08-09 07:23:38.432	campos-arias
998	f6b38e56-0d98-4e00-a96e-345aaac1e653	2020-08-02 10:22:51.881	2020-08-09 07:23:38.432	leticia-snyder
999	33fbfe23-37bd-4e37-a481-a87eadb8192d	2020-08-02 10:22:48.962	2020-08-02 19:09:05.754	whit-steakknife
1000	88cd6efa-dbf2-4309-aabe-ec1d6f21f98a	2020-08-02 10:22:48.962	2020-08-02 19:09:05.754	hewitt-best
1001	cd417f8a-ce01-4ab2-921d-42e2e445bbe2	2020-08-02 10:22:48.962	2020-08-02 19:09:05.754	eizabeth-guerra
1002	db33a54c-3934-478f-bad4-fc313ac2580e	2020-08-02 10:22:48.089	2020-08-02 19:09:05.571	percival-wheeler
1003	db33a54c-3934-478f-bad4-fc313ac2580e	2020-08-02 19:09:05.571	2020-08-02 21:23:42.002	percival-wheeler
1004	ee55248b-318a-4bfb-8894-1cc70e4e0720	2020-08-02 19:09:05.571	2020-08-02 21:23:42.002	theo-king
1005	b39b5aae-8571-4c90-887a-6a00f2a2f6fd	2020-08-02 19:09:05.754	2020-08-02 21:23:42.155	dickerson-morse
1006	c73d59dd-32a0-49ce-8ab4-b2dbb7dc94ec	2020-08-02 19:09:05.754	2020-08-02 21:23:42.155	eduardo-ingram
1007	18798b8f-6391-4cb2-8a5f-6fb540d646d5	2020-08-02 19:09:05.992	2020-08-02 21:23:42.352	morrow-doyle
1008	198fd9c8-cb75-482d-873e-e6b91d42a446	2020-08-02 19:09:05.992	2020-08-02 21:23:42.352	ren-hunter
1009	33fbfe23-37bd-4e37-a481-a87eadb8192d	2020-08-02 19:09:05.754	2020-08-03 02:23:49.247	whit-steakknife
1010	3af96a6b-866c-4b03-bc14-090acf6ecee5	2020-08-02 19:09:05.754	2020-08-03 02:23:49.247	axel-trololol
1011	64f4cd75-0c1e-42cf-9ff0-e41c4756f22a	2020-08-02 19:09:05.754	2020-08-03 02:23:49.247	grey-alvarado
1012	cd417f8a-ce01-4ab2-921d-42e2e445bbe2	2020-08-02 19:09:05.754	2020-08-03 02:23:49.247	eizabeth-guerra
1013	4b6f0a4e-de18-44ad-b497-03b1f470c43c	2020-08-02 19:09:05.754	2020-08-04 07:31:26.389	rodriguez-internet
1014	d23a1f7e-0071-444e-8361-6ae01f13036f	2020-08-09 07:23:36.831	2020-08-09 19:27:43.22	edric-tosser
1015	493a83de-6bcf-41a1-97dd-cc5e150548a3	2020-08-02 19:09:05.754	2020-08-09 07:23:36.613	boyfriend-monreal
1016	53e701c7-e3c8-4e18-ba05-9b41b4b64cda	2020-08-02 19:09:05.754	2020-08-09 07:23:36.613	marquez-clark
1017	7b0f91aa-4d66-4362-993d-6ff60f7ce0ef	2020-08-02 10:22:49.478	2020-08-02 19:09:05.992	blankenship-fischer
1018	d47dd08e-833c-4302-a965-a391d345455c	2020-08-02 10:22:49.478	2020-08-02 19:09:05.992	stu-trololol
1019	4ca52626-58cd-449d-88bb-f6d631588640	2020-08-02 10:22:49.478	2020-08-02 19:09:05.992	velasquez-alstott
1020	86d4e22b-f107-4bcf-9625-32d387fcb521	2020-08-02 10:22:49.747	2020-08-02 19:09:06.172	york-silk
1021	378c07b0-5645-44b5-869f-497d144c7b35	2020-08-02 10:22:49.929	2020-08-02 19:09:06.375	fynn-doyle
1022	5dbf11c0-994a-4482-bd1e-99379148ee45	2020-08-02 10:22:49.929	2020-08-02 19:09:06.375	conrad-vaughan
1023	ae4acebd-edb5-4d20-bf69-f2d5151312ff	2020-08-02 10:22:49.929	2020-08-02 19:09:06.375	theodore-cervantes
1024	4ca52626-58cd-449d-88bb-f6d631588640	2020-08-02 19:09:05.992	2020-08-02 21:23:42.352	velasquez-alstott
1025	7b0f91aa-4d66-4362-993d-6ff60f7ce0ef	2020-08-02 19:09:05.992	2020-08-02 21:23:42.352	blankenship-fischer
1026	b4505c48-fc75-4f9e-8419-42b28dcc5273	2020-08-02 19:09:05.992	2020-08-02 21:23:42.352	sebastian-townsend
1027	b8ab86c6-9054-4832-9b96-508dbd4eb624	2020-08-02 19:09:05.992	2020-08-02 21:23:42.352	esme-ramsey
1028	bd4c6837-eeaa-4675-ae48-061efa0fd11a	2020-08-02 19:09:05.992	2020-08-02 21:23:42.352	workman-gloom
1029	86d4e22b-f107-4bcf-9625-32d387fcb521	2020-08-02 19:09:06.172	2020-08-02 23:06:56.127	york-silk
1030	413b3ddb-d933-4567-a60e-6d157480239d	2020-08-02 19:09:06.375	2020-08-02 23:06:56.344	winnie-mccall
1031	5dbf11c0-994a-4482-bd1e-99379148ee45	2020-08-02 19:09:06.375	2020-08-02 23:06:56.344	conrad-vaughan
1032	ae4acebd-edb5-4d20-bf69-f2d5151312ff	2020-08-02 19:09:06.375	2020-08-02 23:06:56.344	theodore-cervantes
1033	378c07b0-5645-44b5-869f-497d144c7b35	2020-08-02 19:09:06.375	2020-08-03 04:23:53.241	fynn-doyle
1034	667cb445-c288-4e62-b603-27291c1e475d	2020-08-02 10:22:50.243	2020-08-02 19:09:06.572	dan-holloway
1035	7e9a514a-7850-4ed0-93ab-f3a6e2f41c03	2020-08-02 10:22:51.488	2020-08-02 19:09:06.572	nolanestophia-patterson
1036	06ced607-7f96-41e7-a8cd-b501d11d1a7e	2020-08-02 10:22:50.243	2020-08-02 19:09:06.572	morrow-wilson
1037	1ba715f2-caa3-44c0-9118-b045ea702a34	2020-08-02 19:09:06.572	2020-08-02 21:23:43.024	juan-rangel
1038	26cfccf2-850e-43eb-b085-ff73ad0749b8	2020-08-02 19:09:06.572	2020-08-02 21:23:43.024	beasley-day
1039	9786b2c9-1205-4718-b0f7-fc000ce91106	2020-08-02 19:09:06.572	2020-08-02 21:23:43.024	kevin-dudley
1040	b082ca6e-eb11-4eab-8d6a-30f8be522ec4	2020-08-02 19:09:06.572	2020-08-02 21:23:43.024	nicholas-mora
1041	5ff66eae-7111-4e3b-a9b8-a9579165b0a5	2020-08-02 19:09:06.98	2020-08-02 21:23:43.507	peanutiel-duffy
1042	b1b141fc-e867-40d1-842a-cea30a97ca4f	2020-08-02 19:09:06.375	2020-08-02 23:06:56.344	richardson-games
1043	60026a9d-fc9a-4f5a-94fd-2225398fa3da	2020-08-02 19:09:06.572	2020-08-03 05:23:56.421	bright-zimmerman
1044	667cb445-c288-4e62-b603-27291c1e475d	2020-08-02 19:09:06.572	2020-08-03 05:23:56.421	peanut-holloway
1045	13a05157-6172-4431-947b-a058217b4aa5	2020-08-02 19:09:06.572	2020-08-08 03:30:14.905	spears-taylor
1046	15ae64cd-f698-4b00-9d61-c9fffd037ae2	2020-08-02 19:09:06.572	2020-08-09 07:23:37.743	mickey-woods
1047	1732e623-ffc2-40f0-87ba-fdcf97131f1f	2020-08-02 19:09:06.572	2020-08-09 07:23:37.743	betsy-trombone
1048	66cebbbf-9933-4329-924a-72bd3718f321	2020-08-02 19:09:06.572	2020-08-09 07:23:37.743	kennedy-cena
1049	7e9a514a-7850-4ed0-93ab-f3a6e2f41c03	2020-08-02 19:09:06.572	2020-08-09 07:23:37.743	nolanestophia-patterson
1050	80dff591-2393-448a-8d88-122bd424fa4c	2020-08-02 19:09:06.572	2020-08-09 07:23:37.743	elvis-figueroa
1051	41949d4d-b151-4f46-8bf7-73119a48fac8	2020-08-02 10:22:51.881	2020-08-02 19:09:07.396	ron-monstera
1052	bd9d1d6e-7822-4ad9-bac4-89b8afd8a630	2020-08-02 10:22:51.881	2020-08-02 19:09:07.396	derrick-krueger
1053	9820f2c5-f9da-4a07-b610-c2dd7bee2ef6	2020-08-02 10:22:51.755	2020-08-02 19:09:07.169	dan-bong
1054	0eea4a48-c84b-4538-97e7-3303671934d2	2020-08-02 19:09:05.571	2020-08-02 21:23:42.002	helga-moreno
1055	43bf6a6d-cc03-4bcf-938d-620e185433e1	2020-08-02 21:23:42.002	\N	miguel-javier
1056	0eea4a48-c84b-4538-97e7-3303671934d2	2020-08-02 21:23:42.002	2020-08-03 02:23:49.05	helga-moreno
1057	11de4da3-8208-43ff-a1ff-0b3480a0fbf1	2020-08-02 21:23:42.002	2020-08-03 02:23:49.05	don-mitchell
1058	126fb128-7c53-45b5-ac2b-5dbf9943d71b	2020-08-02 21:23:42.002	2020-08-03 02:23:49.05	sigmund-castillo
1059	e3c514ae-f813-470e-9c91-d5baf5ffcf16	2020-08-02 19:09:07.396	2020-08-03 02:23:50.85	tot-clark
1060	6f9de777-e812-4c84-915c-ef283c9f0cde	2020-08-02 19:09:07.396	2020-08-03 04:23:54.25	arturo-huerta
1061	58c9e294-bd49-457c-883f-fb3162fc668e	2020-08-02 21:23:42.002	2020-08-07 14:13:44.056	kichiro-guerra
1062	0e27df51-ad0c-4546-acf5-96b3cb4d7501	2020-08-02 21:23:42.002	2020-08-09 07:23:36.435	chorby-spoon
1063	10ea5d50-ec88-40a0-ab53-c6e11cc1e479	2020-08-02 21:23:42.002	2020-08-09 07:23:36.435	nicholas-vincent
1064	2b157c5c-9a6a-45a6-858f-bf4cf4cbc0bd	2020-08-02 21:23:42.002	2020-08-09 07:23:36.435	ortiz-lopez
1065	5149c919-48fe-45c6-b7ee-bb8e5828a095	2020-08-02 21:23:42.002	2020-08-09 07:23:36.435	adkins-davis
1066	41949d4d-b151-4f46-8bf7-73119a48fac8	2020-08-02 19:09:07.396	2020-08-09 07:23:38.432	ron-monstera
1067	cbd19e6f-3d08-4734-b23f-585330028665	2020-08-02 21:23:42.002	2020-08-03 02:23:49.05	knight-urlacher
1068	f1185b20-7b4a-4ccc-a977-dc1afdfd4cb9	2020-08-02 21:23:42.002	2020-08-03 02:23:49.05	frazier-tosser
1069	94baa9ac-ff96-4f56-a987-10358e917d91	2020-08-02 21:23:42.155	2020-08-03 02:23:49.247	gabriel-griffith
1070	cbd19e6f-3d08-4734-b23f-585330028665	2020-08-02 19:09:05.571	2020-08-02 21:23:42.002	knight-urlacher
1071	a8a5cf36-d1a9-47d1-8d22-4a665933a7cc	2020-08-02 21:23:42.155	2020-08-03 02:23:49.247	helga-washington
1072	b39b5aae-8571-4c90-887a-6a00f2a2f6fd	2020-08-02 21:23:42.155	2020-08-03 02:23:49.247	dickerson-morse
1073	75f9d874-5e69-438d-900d-a3fcb1d429b3	2020-08-02 21:23:42.002	2020-08-09 07:23:36.435	moses-simmons
1074	937c1a37-4b05-4dc5-a86d-d75226f8490a	2020-08-02 21:23:42.002	2020-08-09 07:23:36.435	pippin-carpenter
1075	bf6a24d1-4e89-4790-a4ba-eeb2870cbf6f	2020-08-02 21:23:42.002	2020-08-09 07:23:36.435	rat-polk
1076	db33a54c-3934-478f-bad4-fc313ac2580e	2020-08-02 21:23:42.002	2020-08-09 07:23:36.435	percival-wheeler
1077	ee55248b-318a-4bfb-8894-1cc70e4e0720	2020-08-02 21:23:42.002	2020-08-09 07:23:36.435	theo-king
1078	f0594932-8ef7-4d70-9894-df4be64875d8	2020-08-02 21:23:42.002	2020-08-09 07:23:36.435	fitzgerald-wanderlust
1079	13cfbadf-b048-4c4f-903d-f9b52616b15c	2020-08-02 21:23:42.155	2020-08-09 07:23:36.613	bennett-bowen
1080	14d88771-7a96-48aa-ba59-07bae1733e96	2020-08-02 21:23:42.155	2020-08-09 07:23:36.613	sebastian-telephone
1081	17397256-c28c-4cad-85f2-a21768c66e67	2020-08-02 21:23:42.155	2020-08-09 07:23:36.613	cory-ross
1082	6e373fca-b8ab-4848-9dcc-50e92cd732b7	2020-08-02 21:23:42.155	2020-08-09 07:23:36.613	conrad-bates
1083	c17a4397-4dcc-440e-8c53-d897e971cae9	2020-08-02 21:23:42.155	2020-08-09 07:23:36.613	august-mina
1084	b4505c48-fc75-4f9e-8419-42b28dcc5273	2020-08-02 21:23:42.352	\N	sebastian-townsend
1085	7b0f91aa-4d66-4362-993d-6ff60f7ce0ef	2020-08-02 21:23:42.352	2020-08-03 02:23:49.449	blankenship-fischer
1086	c73d59dd-32a0-49ce-8ab4-b2dbb7dc94ec	2020-08-02 21:23:42.155	2020-08-04 09:16:44.499	eduardo-ingram
1087	248ccf3d-d5f6-4b69-83d9-40230ca909cd	2020-08-02 19:09:05.992	2020-08-02 21:23:42.352	antonio-wallace
1088	c0177f76-67fc-4316-b650-894159dede45	2020-08-02 21:23:42.352	2020-08-04 14:32:39.166	paula-mason
1089	bd4c6837-eeaa-4675-ae48-061efa0fd11a	2020-08-02 21:23:42.352	2020-08-05 07:04:44.404	workman-gloom
1090	36786f44-9066-4028-98d9-4fa84465ab9e	2020-08-02 21:23:42.352	2020-08-07 08:27:44.286	beasley-gloom
1091	c6bd21a8-7880-4c00-8abe-33560fe84ac5	2020-08-02 21:23:42.155	2020-08-09 07:23:36.613	wendy-cerna
1092	f73009c5-2ede-4dc4-b96d-84ba93c8a429	2020-08-02 21:23:42.155	2020-08-09 07:23:36.613	thomas-kirby
1093	198fd9c8-cb75-482d-873e-e6b91d42a446	2020-08-02 21:23:42.352	2020-08-09 07:23:36.831	ren-hunter
1094	248ccf3d-d5f6-4b69-83d9-40230ca909cd	2020-08-02 21:23:42.352	2020-08-09 07:23:36.831	antonio-wallace
1095	3531c282-cb48-43df-b549-c5276296aaa7	2020-08-02 21:23:42.352	2020-08-09 07:23:36.831	oliver-hess
1096	3c051b92-4a86-4157-988a-e334bf6dc691	2020-08-02 21:23:42.352	2020-08-09 07:23:36.831	tyler-leatherman
1097	4ca52626-58cd-449d-88bb-f6d631588640	2020-08-02 21:23:42.352	2020-08-09 07:23:36.831	velasquez-alstott
1098	54e5f222-fb16-47e0-adf9-21813218dafa	2020-08-02 21:23:42.352	2020-08-09 07:23:36.831	grit-watson
1099	b8ab86c6-9054-4832-9b96-508dbd4eb624	2020-08-02 21:23:42.352	2020-08-09 07:23:36.831	esme-ramsey
1100	c182f33c-aea5-48a2-97ed-dc74fa29b3c0	2020-08-02 21:23:42.352	2020-08-09 07:23:36.831	swamuel-mora
1101	06ced607-7f96-41e7-a8cd-b501d11d1a7e	2020-08-02 19:09:06.572	2020-08-02 21:23:43.024	morrow-wilson
1102	1ba715f2-caa3-44c0-9118-b045ea702a34	2020-08-02 21:23:43.024	\N	juan-rangel
1103	d2f827a5-0133-4d96-b403-85a5e50d49e0	2020-08-02 10:22:50.243	2020-08-02 21:23:43.024	robbins-schmitt
1104	d47dd08e-833c-4302-a965-a391d345455c	2020-08-02 19:09:05.992	2020-08-02 21:23:42.352	stu-trololol
1105	5915b7bb-e532-4036-9009-79f1e80c0e28	2020-08-02 21:23:43.024	2020-08-03 05:23:56.421	rosa-holloway
1106	7dcf6902-632f-48c5-936a-7cf88802b93a	2020-08-02 21:23:43.024	2020-08-03 05:23:56.421	parker-parra
1107	9786b2c9-1205-4718-b0f7-fc000ce91106	2020-08-02 21:23:43.024	2020-08-06 04:07:35.723	kevin-dudley
1108	c8de53a4-d90f-4192-955b-cec1732d920e	2020-08-02 21:23:42.352	2020-08-09 07:23:36.831	tyreek-cain
1109	d46abb00-c546-4952-9218-4f16084e3238	2020-08-02 21:23:42.352	2020-08-09 07:23:36.831	atlas-guerra
1110	e4e4c17d-8128-4704-9e04-f244d4573c4d	2020-08-02 21:23:42.352	2020-08-09 07:23:36.831	wesley-poole
1111	0672a4be-7e00-402c-b8d6-0b813f58ba96	2020-08-02 21:23:43.024	2020-08-09 07:23:37.743	castillo-logan
1112	06ced607-7f96-41e7-a8cd-b501d11d1a7e	2020-08-02 21:23:43.024	2020-08-09 07:23:37.743	morrow-wilson
1113	26cfccf2-850e-43eb-b085-ff73ad0749b8	2020-08-02 21:23:43.024	2020-08-09 07:23:37.743	beasley-day
1114	62111c49-1521-4ca7-8678-cd45dacf0858	2020-08-02 21:23:43.024	2020-08-09 07:23:37.743	bambi-perez
1115	906a5728-5454-44a0-adfe-fd8be15b8d9b	2020-08-02 21:23:43.024	2020-08-09 07:23:37.743	jefferson-delacruz
1116	b082ca6e-eb11-4eab-8d6a-30f8be522ec4	2020-08-02 21:23:43.024	2020-08-09 07:23:37.743	nicholas-mora
1117	d2f827a5-0133-4d96-b403-85a5e50d49e0	2020-08-02 21:23:43.024	2020-08-09 07:23:37.743	robbins-schmitt
1118	6bd4cf6e-fefe-499a-aa7a-890bcc7b53fa	2020-08-02 10:22:51.036	2020-08-02 21:23:43.264	igneus-mcdaniel
1119	df4da81a-917b-434f-b309-f00423ee4967	2020-08-02 10:22:51.036	2020-08-02 21:23:43.264	eugenia-bickle
1120	8e1fd784-99d5-41c1-a6c5-6b947cec6714	2020-08-02 21:23:43.264	2020-08-03 04:23:53.572	velasquez-meadows
1121	4204c2d1-ca48-4af7-b827-e99907f12d61	2020-08-02 10:22:51.036	2020-08-02 21:23:43.264	axel-cardenas
1122	083d09d4-7ed3-4100-b021-8fbe30dd43e8	2020-08-02 21:23:43.507	2020-08-03 04:23:53.763	jessica-telephone
1123	2720559e-9173-4042-aaa0-d3852b72ab2e	2020-08-02 21:23:43.507	2020-08-03 04:23:53.763	hiroto-wilcox
1124	2e86de11-a2dd-4b28-b5fe-f4d0c38cd20b	2020-08-02 21:23:43.507	2020-08-03 04:23:53.763	zion-aliciakeyes
1125	3ebb5361-3895-4a50-801e-e7a0ee61750c	2020-08-02 21:23:43.507	2020-08-03 04:23:53.763	augusto-reddick
1126	dd8a43a4-a024-44e9-a522-785d998b29c3	2020-08-02 21:23:43.024	2020-08-03 05:23:56.421	miguel-peterson
1127	d35ccee1-9559-49a1-aaa4-7809f7b5c46e	2020-08-02 21:23:43.024	2020-08-09 07:23:37.743	forrest-best
1128	4204c2d1-ca48-4af7-b827-e99907f12d61	2020-08-02 21:23:43.264	2020-08-09 07:23:37.896	axel-cardenas
1129	4542f0b0-3409-4a4a-a9e1-e8e8e5d73fcf	2020-08-02 21:23:43.264	2020-08-09 07:23:37.896	brock-watson
1130	7951836f-581a-49d5-ae2f-049c6bcc575e	2020-08-02 21:23:43.264	2020-08-09 07:23:37.896	adkins-gwiffin
1131	8604e861-d784-43f0-b0f8-0d43ea6f7814	2020-08-02 21:23:43.264	2020-08-09 07:23:37.896	randall-marijuana
1132	df4da81a-917b-434f-b309-f00423ee4967	2020-08-02 21:23:43.264	2020-08-09 07:23:37.896	eugenia-bickle
1133	25f3a67c-4ed5-45b6-94b1-ce468d3ead21	2020-08-02 21:23:43.507	2020-08-09 07:23:38.05	hobbs-cain
1134	5ff66eae-7111-4e3b-a9b8-a9579165b0a5	2020-08-02 21:23:43.507	2020-08-09 07:23:38.05	peanutiel-duffy
1135	d74a2473-1f29-40fa-a41e-66fa2281dfca	2020-08-02 21:23:43.507	\N	landry-violence
1136	0cc5bd39-e90d-42f9-9dd8-7e703f316436	2020-08-02 10:22:51.755	2020-08-02 21:23:43.721	don-elliott
1137	d744f534-2352-472b-9e42-cd91fa540f1b	2020-08-02 21:23:43.507	2020-08-03 04:23:53.763	tyler-violet
1138	a691f2ba-9b69-41f8-892c-1acd42c336e4	2020-08-02 10:22:51.488	2020-08-02 21:23:43.507	jenkins-good
1139	32551e28-3a40-47ae-aed1-ff5bc66be879	2020-08-02 21:23:43.721	2020-08-03 04:23:54.117	math-velazquez
1140	64f59d5f-8740-4ebf-91bd-d7697b542a9f	2020-08-02 21:23:43.507	2020-08-09 07:23:38.05	zeke-wallace
1141	77a41c29-8abd-4456-b6e0-a034252700d2	2020-08-02 21:23:43.507	2020-08-09 07:23:38.05	elip-dean
1142	7aeb8e0b-f6fb-4a9e-bba2-335dada5f0a3	2020-08-02 21:23:43.507	2020-08-09 07:23:38.05	dunlap-figueroa
1143	a691f2ba-9b69-41f8-892c-1acd42c336e4	2020-08-02 21:23:43.507	2020-08-09 07:23:38.05	jenkins-good
1144	c3b1b4e5-4b88-4245-b2b1-ae3ade57349e	2020-08-02 21:23:43.507	2020-08-09 07:23:38.05	wall-osborn
1145	d4a10c2a-0c28-466a-9213-38ba3339b65e	2020-08-02 21:23:43.507	2020-08-09 07:23:38.05	richmond-harrison
1146	0cc5bd39-e90d-42f9-9dd8-7e703f316436	2020-08-02 21:23:43.721	2020-08-09 07:23:38.236	don-elliott
1147	0daf04fc-8d0d-4513-8e98-4f610616453b	2020-08-02 21:23:43.721	2020-08-09 07:23:38.236	lee-mist
1148	446a3366-3fe3-41bb-bfdd-d8717f2152a9	2020-08-02 21:23:43.721	2020-08-09 07:23:38.236	marco-escobar
1149	4aa843a4-baa1-4f35-8748-63aa82bd0e03	2020-08-02 21:23:43.721	2020-08-09 07:23:38.236	aureliano-dollie
1150	68462bfa-9006-4637-8830-2e7840d9089a	2020-08-02 21:23:43.721	2020-08-09 07:23:38.236	parker-horseman
1151	8903a74f-f322-41d2-bd75-dbf7563c4abb	2020-08-02 21:23:43.721	2020-08-09 07:23:38.236	francisca-sasquatch
1152	9820f2c5-f9da-4a07-b610-c2dd7bee2ef6	2020-08-02 19:09:07.169	2020-08-02 21:23:43.721	peanut-bong
1153	d5192d95-a547-498a-b4ea-6770dde4b9f5	2020-08-02 10:22:51.755	2020-08-02 21:23:43.721	summers-slugger
1154	9820f2c5-f9da-4a07-b610-c2dd7bee2ef6	2020-08-02 21:23:43.721	2020-08-03 04:23:54.117	peanut-bong
1155	90c6e6ca-77fc-42b7-94d8-d8afd6d299e5	2020-08-02 21:23:43.721	\N	miki-santana
1156	1c73f91e-0562-480d-9543-2aab1d5e5acd	2020-08-02 21:23:43.84	2020-08-03 04:23:54.25	sparks-beans
1157	3de17e21-17db-4a6b-b7ab-0b2f3c154f42	2020-08-02 21:23:43.84	2020-08-03 04:23:54.25	brewer-vapor
1158	495a6bdc-174d-4ad6-8d51-9ee88b1c2e4a	2020-08-02 21:23:43.84	2020-08-03 04:23:54.25	shaquille-torres
1159	97981e86-4a42-4f85-8783-9f29833c192b	2020-08-02 21:23:43.721	2020-08-09 07:23:38.236	daiya-vine
1160	a8530be5-8923-4f74-9675-bf8a1a8f7878	2020-08-02 21:23:43.721	2020-08-09 07:23:38.236	mohammed-picklestein
1161	b7adbbcc-0679-43f3-a939-07f009a393db	2020-08-02 21:23:43.721	2020-08-09 07:23:38.236	jode-crutch
1162	b7c4f986-e62a-4a8f-b5f0-8f30ecc35c5d	2020-08-02 21:23:43.721	2020-08-09 07:23:38.236	oscar-hollywood
1163	d5192d95-a547-498a-b4ea-6770dde4b9f5	2020-08-02 21:23:43.721	2020-08-09 07:23:38.236	summers-slugger
1164	e111a46d-5ada-4311-ac4f-175cca3357da	2020-08-02 21:23:43.721	2020-08-09 07:23:38.236	alexandria-rosales
1165	e972984c-2895-451c-b518-f06a0d8bd375	2020-08-02 21:23:43.721	2020-08-09 07:23:38.236	becker-solis
1166	f0bcf4bb-74b3-412e-a54c-04c12ad28ecb	2020-08-02 21:23:43.721	2020-08-09 07:23:38.236	hahn-fox
1167	5fbf04bb-f5ec-4589-ab19-1d89cda056bd	2020-08-02 21:23:43.84	2020-08-09 07:23:38.432	donia-dollie
1168	864b3be8-e836-426e-ae56-20345b41d03d	2020-08-02 21:23:43.84	2020-08-09 07:23:38.432	goodwin-morin
1169	3064c7d6-91cc-4c2a-a433-1ce1aabc1ad4	2020-08-02 23:06:56.127	\N	jorge-ito
1170	4941976e-31fc-49b5-801a-18abe072178b	2020-08-02 23:06:56.127	\N	sebastian-sunshine
1171	8a6fc67d-a7fe-443b-a084-744294cec647	2020-08-02 10:22:49.747	2020-08-02 23:06:56.127	terrell-bradley
1172	d5b6b11d-3924-4634-bd50-76553f1f162b	2020-08-02 21:23:43.84	\N	ogden-mendoza
1173	b3d518b9-dc68-4902-b68c-0022ceb25aa0	2020-08-02 23:06:56.127	2020-08-03 04:23:53.018	hendricks-rangel
1174	f968532a-bf06-478e-89e0-3856b7f4b124	2020-08-02 21:23:43.84	2020-08-03 04:23:54.25	daniel-benedicte
1175	cf8e152e-2d27-4dcc-ba2b-68127de4e6a4	2020-08-02 21:23:43.84	2020-08-04 05:16:04.416	hendricks-richardson
1176	855775c1-266f-40f6-b07b-3a67ccdf8551	2020-08-02 23:06:56.127	2020-08-05 08:04:54.863	nic-winkler
1177	86d4e22b-f107-4bcf-9625-32d387fcb521	2020-08-02 23:06:56.127	2020-08-09 06:23:26.778	york-silk
1178	62823073-84b8-46c2-8451-28fd10dff250	2020-08-02 23:06:56.127	2020-08-09 07:23:37.02	mckinney-vaughan
1179	805ba480-df4d-4f56-a4cf-0b99959111b5	2020-08-02 23:06:56.127	2020-08-09 07:23:37.02	leticia-lozano
1180	8a6fc67d-a7fe-443b-a084-744294cec647	2020-08-02 23:06:56.127	2020-08-09 07:23:37.02	terrell-bradley
1181	9ac2e7c5-5a34-4738-98d8-9f917bc6d119	2020-08-02 23:06:56.127	2020-08-09 07:23:37.02	christian-combs
1182	a938f586-f5c1-4a35-9e7f-8eaab6de67a6	2020-08-02 23:06:56.127	2020-08-09 07:23:37.02	jasper-destiny
1183	f10ba06e-d509-414b-90cd-4d70d43c75f9	2020-08-02 21:23:43.84	2020-08-09 07:23:38.432	hernando-winter
1184	f6342729-a38a-4204-af8d-64b7accb5620	2020-08-02 21:23:43.84	2020-08-09 07:23:38.432	marco-winner
1185	7310c32f-8f32-40f2-b086-54555a2c0e86	2020-08-02 23:06:56.344	2020-08-03 04:23:53.241	dominic-marijuana
1186	a1628d97-16ca-4a75-b8df-569bae02bef9	2020-08-02 23:06:56.344	2020-08-03 04:23:53.241	chorby-soul
1187	0eea4a48-c84b-4538-97e7-3303671934d2	2020-08-03 02:23:49.05	2020-08-09 07:23:36.435	helga-moreno
1188	0f62c20c-72d0-4c12-a9d7-312ea3d3bcd1	2020-08-03 02:23:49.05	2020-08-09 07:23:36.435	abner-wood
1189	6a869b40-be99-4520-89e5-d382b07e4a3c	2020-08-02 23:06:56.344	2020-08-03 04:23:53.241	jake-swinger
1190	11de4da3-8208-43ff-a1ff-0b3480a0fbf1	2020-08-03 02:23:49.05	2020-08-09 07:23:36.435	don-mitchell
1191	c771abab-f468-46e9-bac5-43db4c5b410f	2020-08-02 23:06:56.127	2020-08-09 07:23:37.02	wade-howe
1192	18af933a-4afa-4cba-bda5-45160f3af99b	2020-08-02 23:06:56.344	2020-08-09 07:23:37.234	felix-garbage
1193	bfd9ff52-9bf6-4aaf-a859-d308d8f29616	2020-08-09 19:27:43.22	2020-09-06 01:40:52.831	declan-suzanne
1194	1ded0384-d290-4ea1-a72b-4f9d220cbe37	2020-08-02 23:06:56.344	2020-08-09 07:23:37.234	juan-murphy
1195	29bf512a-cd8c-4ceb-b25a-d96300c184bb	2020-08-02 23:06:56.344	2020-08-09 07:23:37.234	garcia-soto
1196	413b3ddb-d933-4567-a60e-6d157480239d	2020-08-02 23:06:56.344	2020-08-09 07:23:37.234	winnie-mccall
1197	4e6ad1a1-7c71-49de-8bd5-c286712faf9e	2020-08-02 23:06:56.344	2020-08-09 07:23:37.234	sutton-picklestein
1198	5dbf11c0-994a-4482-bd1e-99379148ee45	2020-08-02 23:06:56.344	2020-08-09 07:23:37.234	conrad-vaughan
1199	945974c5-17d9-43e7-92f6-ba49064bbc59	2020-08-02 23:06:56.344	2020-08-09 07:23:37.234	bates-silk
1200	ac57cf28-556f-47af-9154-6bcea2ace9fc	2020-08-02 23:06:56.344	2020-08-09 07:23:37.234	rey-wooten
1201	ae4acebd-edb5-4d20-bf69-f2d5151312ff	2020-08-02 23:06:56.344	2020-08-09 07:23:37.234	theodore-cervantes
1202	b1b141fc-e867-40d1-842a-cea30a97ca4f	2020-08-02 23:06:56.344	2020-08-09 07:23:37.234	richardson-games
1203	ea44bd36-65b4-4f3b-ac71-78d87a540b48	2020-08-03 02:23:49.05	2020-08-06 10:23:40.055	wanda-pothos
1204	126fb128-7c53-45b5-ac2b-5dbf9943d71b	2020-08-03 02:23:49.05	2020-08-09 07:23:36.435	sigmund-castillo
1205	3c331c87-1634-46c4-87ce-e4b9c59e2969	2020-08-03 02:23:49.05	2020-08-09 07:23:36.435	yosh-carpenter
1206	bd24e18b-800d-4f15-878d-e334fb4803c4	2020-08-02 21:23:42.002	2020-08-03 02:23:49.05	helga-burton
1207	63a31035-2e6d-4922-a3f9-fa6e659b54ad	2020-08-03 02:23:49.05	2020-08-09 07:23:36.435	moody-rodriguez
1208	7c5ae357-e079-4427-a90f-97d164c7262e	2020-08-03 02:23:49.05	2020-08-09 07:23:36.435	milo-brown
1209	9313e41c-3bf7-436d-8bdc-013d3a1ecdeb	2020-08-03 02:23:49.05	2020-08-09 07:23:36.435	sandie-nelson
1210	bd24e18b-800d-4f15-878d-e334fb4803c4	2020-08-03 02:23:49.05	2020-08-09 07:23:36.435	helga-burton
1211	cbd19e6f-3d08-4734-b23f-585330028665	2020-08-03 02:23:49.05	2020-08-09 07:23:36.435	knight-urlacher
1212	e4034192-4dc6-4901-bb30-07fe3cf77b5e	2020-08-03 02:23:49.05	2020-08-09 07:23:36.435	baldwin-breadwinner
1213	66cebbbf-9933-4329-924a-72bd3718f321	2020-09-06 19:06:14.626	2020-09-06 19:21:22.69	kennedy-cena
1214	e749dc27-ca3b-456e-889c-d2ec02ac7f5f	2020-08-03 02:23:49.05	2020-08-09 07:23:36.435	aureliano-estes
1215	f1185b20-7b4a-4ccc-a977-dc1afdfd4cb9	2020-08-03 02:23:49.05	2020-08-09 07:23:36.435	frazier-tosser
1216	33fbfe23-37bd-4e37-a481-a87eadb8192d	2020-08-03 02:23:49.247	2020-08-09 07:23:36.613	whit-steakknife
1217	3af96a6b-866c-4b03-bc14-090acf6ecee5	2020-08-03 02:23:49.247	2020-08-09 07:23:36.613	axel-trololol
1218	6598e40a-d76d-413f-ad06-ac4872875bde	2020-08-03 02:23:49.247	2020-08-09 07:23:36.613	daniel-mendoza
1219	7663c3ca-40a1-4f13-a430-14637dce797a	2020-08-03 02:23:49.247	2020-08-09 07:23:36.613	polkadot-zavala
1220	849e13dc-6eb1-40a8-b55c-d4b4cd160aab	2020-08-03 02:23:49.247	2020-08-09 07:23:36.613	justice-valenzuela
1221	c83f0fe0-44d1-4342-81e8-944bb38f8e23	2020-08-03 02:23:49.247	\N	langley-wheeler
1222	18798b8f-6391-4cb2-8a5f-6fb540d646d5	2020-08-02 21:23:42.352	2020-08-03 02:23:49.449	morrow-doyle
1223	88cd6efa-dbf2-4309-aabe-ec1d6f21f98a	2020-08-02 19:09:05.754	2020-08-03 02:23:49.247	hewitt-best
1224	f2a27a7e-bf04-4d31-86f5-16bfa3addbe7	2020-08-03 02:23:49.247	2020-08-03 05:23:55.538	winnie-hess
1225	88cd6efa-dbf2-4309-aabe-ec1d6f21f98a	2020-08-03 02:23:49.247	2020-08-09 07:23:36.613	hewitt-best
1226	90c8be89-896d-404c-945e-c135d063a74e	2020-08-03 02:23:49.247	2020-08-09 07:23:36.613	james-boy
1227	94baa9ac-ff96-4f56-a987-10358e917d91	2020-08-03 02:23:49.247	2020-08-09 07:23:36.613	gabriel-griffith
1228	a8a5cf36-d1a9-47d1-8d22-4a665933a7cc	2020-08-03 02:23:49.247	2020-08-09 07:23:36.613	helga-washington
1229	a8e757c6-e299-4a2e-a370-4f7c3da98bd1	2020-08-03 02:23:49.247	2020-08-09 07:23:36.613	hendricks-lenny
1230	aae38811-122c-43dd-b59c-d0e203154dbe	2020-08-03 02:23:49.247	2020-08-09 07:23:36.613	sandie-carver
1231	b39b5aae-8571-4c90-887a-6a00f2a2f6fd	2020-08-03 02:23:49.247	2020-08-09 07:23:36.613	dickerson-morse
1232	b7ca8f3f-2fdc-477b-84f4-157f2802e9b5	2020-08-03 02:23:49.247	2020-08-09 07:23:36.613	leach-herman
1233	cd417f8a-ce01-4ab2-921d-42e2e445bbe2	2020-08-03 02:23:49.247	2020-08-09 07:23:36.613	eizabeth-guerra
1234	dd7e710f-da4e-475b-b870-2c29fe9d8c00	2020-08-03 02:23:49.247	2020-08-09 07:23:36.613	itsuki-weeks
1235	03f920cc-411f-44ef-ae66-98a44e883291	2020-08-03 02:23:49.449	2020-08-09 07:23:36.831	cornelius-games
1236	1513aab6-142c-48c6-b43e-fbda65fd64e8	2020-08-03 02:23:49.449	2020-08-09 07:23:36.831	caleb-alvarado
1237	18798b8f-6391-4cb2-8a5f-6fb540d646d5	2020-08-03 02:23:49.449	2020-08-09 07:23:36.831	morrow-doyle
1238	d47dd08e-833c-4302-a965-a391d345455c	2020-08-02 21:23:42.352	2020-08-03 02:23:49.449	stu-trololol
1239	f9c0d3cb-d8be-4f53-94c9-fc53bcbce520	2020-08-03 02:23:49.449	2020-08-05 22:36:49.694	matteo-prestige
1240	7b0f91aa-4d66-4362-993d-6ff60f7ce0ef	2020-08-03 02:23:49.449	\N	blankenship-fischer
1241	bfd9ff52-9bf6-4aaf-a859-d308d8f29616	2020-08-03 02:23:49.449	2020-08-07 02:26:41.534	declan-suzanne
1242	20e13b56-599b-4a22-b752-8059effc81dc	2020-08-03 02:23:49.449	2020-08-09 07:23:36.831	lou-roseheart
1243	2ae8cbfc-2155-4647-9996-3f2591091baf	2020-08-03 02:23:49.449	2020-08-09 07:23:36.831	forrest-bookbaby
1244	43d5da5f-c6a1-42f1-ab7f-50ea956b6cd5	2020-08-03 02:23:49.449	2020-08-09 07:23:36.831	justice-spoon
1245	4bf352d2-6a57-420a-9d45-b23b2b947375	2020-08-03 02:23:49.449	2020-08-09 07:23:36.831	rivers-rosa
1246	5e4dfa16-f1b9-400f-b8ef-a1613c2b026a	2020-08-03 02:23:49.449	2020-08-09 07:23:36.831	snyder-briggs
1247	5f3b5dc2-351a-4dee-a9d6-fa5f44f2a365	2020-08-03 02:23:49.449	2020-08-09 07:23:36.831	alston-england
1248	93502db3-85fa-4393-acae-2a5ff3980dde	2020-08-03 02:23:49.449	2020-08-09 07:23:36.831	rodriguez-sunshine
1249	99e7de75-d2b8-4330-b897-a7334708aff9	2020-08-03 02:23:49.449	2020-08-09 07:23:36.831	winnie-loser
1250	a7edbf19-caf6-45dd-83d5-46496c99aa88	2020-08-03 02:23:49.449	2020-08-09 07:23:36.831	rush-valenzuela
1251	ad8d15f4-e041-4a12-a10e-901e6285fdc5	2020-08-03 02:23:49.449	2020-08-09 07:23:36.831	baby-urlacher
1252	d47dd08e-833c-4302-a965-a391d345455c	2020-08-03 02:23:49.449	2020-08-09 07:23:36.831	stu-trololol
1253	eaaef47e-82cc-4c90-b77d-75c3fb279e83	2020-08-03 02:23:49.449	2020-08-09 07:23:36.831	herring-winfield
1254	f071889c-f10f-4d2f-a1dd-c5dda34b3e2b	2020-08-03 02:23:49.449	2020-08-09 07:23:36.831	zion-facepunch
1255	24f6829e-7bb4-4e1e-8b59-a07514657e72	2020-08-02 23:06:56.127	2020-08-03 04:23:53.018	king-weatherman
1256	2b1cb8a2-9eba-4fce-85cf-5d997ec45714	2020-08-03 04:23:53.018	\N	isaac-rubberman
1257	64b055d1-b691-4e0c-8583-fc08ba663846	2020-08-03 02:23:50.577	\N	theodore-passon
1258	8b53ce82-4b1a-48f0-999d-1774b3719202	2020-08-03 02:23:50.85	2020-08-03 04:23:54.25	oliver-mueller
1259	bf122660-df52-4fc4-9e70-ee185423ff93	2020-08-03 02:23:50.85	2020-08-03 04:23:54.25	walton-sports
1260	e3c514ae-f813-470e-9c91-d5baf5ffcf16	2020-08-03 02:23:50.85	2020-08-03 04:23:54.25	tot-clark
1261	efafe75e-2f00-4418-914c-9b6675d39264	2020-08-03 02:23:50.85	2020-08-03 04:23:54.25	aldon-cashmoney
1794	d2a1e734-60d9-4989-b7d9-6eacda70486b	2020-08-09 07:23:37.743	\N	tiana-takahashi
1262	0bd5a3ec-e14c-45bf-8283-7bc191ae53e4	2020-08-03 04:23:53.018	2020-08-09 07:23:37.02	stephanie-donaldson
1263	1e8b09bd-fbdd-444e-bd7e-10326bd57156	2020-08-03 04:23:53.018	2020-08-09 07:23:37.02	fletcher-yamamoto
1264	24f6829e-7bb4-4e1e-8b59-a07514657e72	2020-08-03 04:23:53.018	2020-08-09 07:23:37.02	king-weatherman
1265	1aec2c01-b766-4018-a271-419e5371bc8f	2020-08-03 02:23:50.577	2020-08-09 07:23:38.236	rush-ito
1266	20be1c34-071d-40c6-8824-dde2af184b4d	2020-08-03 02:23:50.577	2020-08-09 07:23:38.236	qais-dogwalker
1267	285ce77d-e5cd-4daa-9784-801347140d48	2020-08-03 02:23:50.577	2020-08-09 07:23:38.236	son-scotch
1268	bbf9543f-f100-445a-a467-81d7aab12236	2020-08-03 02:23:50.577	2020-08-09 07:23:38.236	farrell-seagull
1269	ef9f8b95-9e73-49cd-be54-60f84858a285	2020-08-03 02:23:50.577	2020-08-09 07:23:38.236	collins-melon
1270	0f61d948-4f0c-4550-8410-ae1c7f9f5613	2020-08-03 02:23:50.85	2020-08-09 07:23:38.432	tamara-crankit
1271	b348c037-eefc-4b81-8edd-dfa96188a97e	2020-08-03 02:23:50.85	2020-08-09 07:23:38.432	lowe-forbes
1272	7a75d626-d4fd-474f-a862-473138d8c376	2020-08-03 04:23:53.018	2020-08-07 06:27:23.699	beck-whitney
1273	ff5a37d9-a6dd-49aa-b6fb-b935fd670820	2020-08-03 04:23:53.018	2020-08-07 06:42:26.296	dunn-keyes
1274	b3d518b9-dc68-4902-b68c-0022ceb25aa0	2020-08-03 04:23:53.018	\N	hendricks-rangel
1275	2f3d7bc7-6ffb-40c3-a94f-5e626be413c9	2020-08-03 04:23:53.018	2020-08-09 07:23:37.02	elijah-valenzuela
1276	3954bdfa-931f-4787-b9ac-f44b72fe09d7	2020-08-03 04:23:53.018	2020-08-09 07:23:37.02	nicholas-nolan
1277	3a96d76a-c508-45a0-94a0-8f64cd6beeb4	2020-08-03 04:23:53.018	2020-08-09 07:23:37.02	thomas-england
1278	3e008f60-6842-42e7-b125-b88c7e5c1a95	2020-08-03 04:23:53.018	2020-08-09 07:23:37.02	zeboriah-wilson
1279	51985516-5033-4ab8-a185-7bda07829bdb	2020-08-03 04:23:53.018	2020-08-09 07:23:37.02	stephanie-schmitt
1280	51c5473a-7545-4a9a-920d-d9b718d0e8d1	2020-08-03 04:23:53.018	2020-08-09 07:23:37.02	jacob-haynes
1281	718dea1a-d9a8-4c2b-933a-f0667b5250e6	2020-08-03 04:23:53.018	2020-08-09 07:23:37.02	margarito-nava
1282	81b25b16-3370-4eb0-9d1b-6d630194c680	2020-08-03 04:23:53.018	2020-08-09 07:23:37.02	zeboriah-whiskey
1283	960f041a-f795-4001-bd88-5ddcf58ee520	2020-08-03 04:23:53.018	2020-08-09 07:23:37.02	mayra-buckley
1284	a647388d-fc59-4c1b-90d3-8c1826e07775	2020-08-03 04:23:53.018	2020-08-09 07:23:37.02	chambers-simmons
1285	a98917bc-e9df-4b0e-bbde-caa6168aa3d7	2020-08-03 04:23:53.018	2020-08-09 07:23:37.02	jenkins-ingram
1286	cd6b102e-1881-4079-9a37-455038bbf10e	2020-08-03 04:23:53.018	2020-08-09 07:23:37.02	caleb-morin
1287	fbb5291c-2438-400e-ab32-30ce1259c600	2020-08-03 04:23:53.018	2020-08-09 07:23:37.02	cory-novak
1288	03b80a57-77ea-4913-9be4-7a85c3594745	2020-08-03 04:23:53.241	2020-08-09 07:23:37.234	halexandrey-walton
1289	a1628d97-16ca-4a75-b8df-569bae02bef9	2020-08-03 04:23:53.241	\N	chorby-soul
1290	190a0f31-d686-4ac4-a7f3-cfc87b72c145	2020-08-03 04:23:53.572	2020-08-05 17:21:15.545	nerd-pacheco
1291	4ffd2e50-bb5b-45d0-b7c4-e24d41b2ff5d	2020-08-02 23:06:56.344	2020-08-03 04:23:53.241	schneider-bendie
1292	378c07b0-5645-44b5-869f-497d144c7b35	2020-08-03 04:23:53.241	2020-08-09 07:23:37.234	fynn-doyle
1293	6a869b40-be99-4520-89e5-d382b07e4a3c	2020-08-03 04:23:53.241	2020-08-09 07:23:37.234	jake-swinger
1294	7310c32f-8f32-40f2-b086-54555a2c0e86	2020-08-03 04:23:53.241	2020-08-09 07:23:37.234	dominic-marijuana
1295	81d7d022-19d6-427d-aafc-031fcb79b29e	2020-08-03 04:23:53.241	2020-08-09 07:23:37.234	patty-fox
1296	8d81b190-d3b8-4cd9-bcec-0e59fdd7f2bc	2020-08-03 04:23:53.241	2020-08-09 07:23:37.234	albert-stink
1297	94f30f21-f889-4a2e-9b94-818475bb1ca0	2020-08-03 04:23:53.241	2020-08-09 07:23:37.234	kirkland-sobremesa
1298	9965eed5-086c-4977-9470-fe410f92d353	2020-08-03 04:23:53.241	2020-08-09 07:23:37.234	bates-bentley
1299	9a031b9a-16f8-4165-a468-5d0e28a81151	2020-08-03 04:23:53.241	2020-08-09 07:23:37.234	tiana-wheeler
1300	a311c089-0df4-46bd-9f5d-8c45c7eb5ae2	2020-08-03 04:23:53.241	2020-08-09 07:23:37.234	mclaughlin-scorpler
1301	a5adc84c-80b8-49e4-9962-8b4ade99a922	2020-08-03 04:23:53.241	2020-08-09 07:23:37.234	richardson-turquoise
1302	ac69dba3-6225-4afd-ab4b-23fc78f730fb	2020-08-03 04:23:53.241	2020-08-09 07:23:37.234	bevan-wise
1303	db53211c-f841-4f33-accf-0c3e167889a0	2020-08-03 04:23:53.241	2020-08-09 07:23:37.234	travis-bendie
1304	089af518-e27c-4256-adc8-62e3f4b30f43	2020-08-03 04:23:53.572	2020-08-09 07:23:37.896	silvia-rugrat
1305	19af0d67-c73b-4ef2-bc84-e923c1336db5	2020-08-03 04:23:53.572	2020-08-09 07:23:37.896	grit-ramos
1306	8e1fd784-99d5-41c1-a6c5-6b947cec6714	2020-08-03 04:23:53.572	\N	velasquez-meadows
1307	2b9f9c25-43ec-4f0b-9937-a5aa23be0d9e	2020-08-03 04:23:53.572	2020-08-09 07:23:37.896	lawrence-horne
1308	4562ac1f-026c-472c-b4e9-ee6ff800d701	2020-08-02 21:23:43.264	2020-08-03 04:23:53.572	chris-koch
1309	4562ac1f-026c-472c-b4e9-ee6ff800d701	2020-08-03 04:23:53.572	2020-08-09 07:23:37.896	chris-koch
1310	6644d767-ab15-4528-a4ce-ae1f8aadb65f	2020-08-03 04:23:53.572	2020-08-09 07:23:37.896	paula-reddick
1311	89f74891-2e25-4b5a-bd99-c95ba3f36aa0	2020-08-03 04:23:53.572	2020-08-09 07:23:37.896	nagomi-nava
1312	aa7ac9cb-e9db-4313-9941-9f3431728dce	2020-08-03 04:23:53.572	2020-08-09 07:23:37.896	matteo-cash
1313	ad1e670a-f346-4bf7-a02f-a91649c41ccb	2020-08-03 04:23:53.572	2020-08-09 07:23:37.896	stephanie-winters
1314	b7267aba-6114-4d53-a519-bf6c99f4e3a9	2020-08-03 04:23:53.572	2020-08-09 07:23:37.896	sosa-hayes
1315	bd8778e5-02e8-4d1f-9c31-7b63942cc570	2020-08-03 04:23:53.572	2020-08-09 07:23:37.896	cell-barajas
1316	e4f1f358-ee1f-4466-863e-f329766279d0	2020-08-03 04:23:53.572	2020-08-09 07:23:37.896	ronan-combs
1317	f4ca437c-c31c-4508-afe7-6dae4330d717	2020-08-03 04:23:53.572	2020-08-09 07:23:37.896	fran-beans
1318	2720559e-9173-4042-aaa0-d3852b72ab2e	2020-08-03 04:23:53.763	2020-08-09 07:23:38.05	hiroto-wilcox
1319	27faa5a7-d3a8-4d2d-8e62-47cfeba74ff0	2020-08-03 04:23:53.763	2020-08-09 07:23:38.05	spears-nolan
1320	2e86de11-a2dd-4b28-b5fe-f4d0c38cd20b	2020-08-03 04:23:53.763	2020-08-09 07:23:38.05	zion-aliciakeyes
1321	338694b7-6256-4724-86b6-3884299a5d9e	2020-08-03 04:23:53.763	2020-08-09 07:23:38.05	polkadot-patterson
1322	37efef78-2df4-4c76-800c-43d4faf07737	2020-08-03 04:23:53.763	2020-08-09 07:23:38.05	lenix-ren
1323	afc90398-b891-4cdf-9dea-af8a3a79d793	2020-08-02 21:23:43.507	2020-08-03 04:23:53.763	yazmin-mason
1324	d744f534-2352-472b-9e42-cd91fa540f1b	2020-08-03 04:23:53.763	\N	tyler-violet
1325	5b9727f7-6a20-47d2-93d9-779f0a85c4ee	2020-08-03 04:23:53.763	\N	kennedy-alstott
1326	889c9ef9-d521-4436-b41c-9021b81b4dfb	2020-08-03 02:23:50.577	2020-08-03 04:23:54.117	liam-snail
1327	97ec5a2f-ac1a-4cde-86b7-897c030a1fa8	2020-08-02 21:23:43.721	2020-08-03 04:23:54.117	alston-woods
1328	3ebb5361-3895-4a50-801e-e7a0ee61750c	2020-08-03 04:23:53.763	2020-08-09 07:23:38.05	augusto-reddick
1329	51cba429-13e8-487e-9568-847b7b8b9ac5	2020-08-03 04:23:53.763	2020-08-09 07:23:38.05	collins-mina
1330	695daf02-113d-4e76-b802-0862df16afbd	2020-08-03 04:23:53.763	2020-08-09 07:23:38.05	pacheco-weeks
1331	8f11ad58-e0b9-465c-9442-f46991274557	2020-08-03 04:23:53.763	2020-08-09 07:23:38.05	amos-melon
1332	9abe02fb-2b5a-432f-b0af-176be6bd62cf	2020-08-03 04:23:53.763	2020-08-09 07:23:38.05	nagomi-meng
1333	9be56060-3b01-47aa-a090-d072ef109fbf	2020-08-03 04:23:53.763	2020-08-09 07:23:38.05	jesus-koch
1334	afc90398-b891-4cdf-9dea-af8a3a79d793	2020-08-03 04:23:53.763	2020-08-09 07:23:38.05	yazmin-mason
1335	ceb5606d-ea3f-4471-9ca7-3d2e71a50dde	2020-08-03 04:23:53.763	2020-08-09 07:23:38.05	london-simmons
1336	d8742d68-8fce-4d52-9a49-f4e33bd2a6fc	2020-08-03 04:23:53.763	2020-08-09 07:23:38.05	ortiz-morse
1337	2ca0c790-e1d5-4a14-ab3c-e9241c87fc23	2020-08-03 04:23:54.117	2020-08-09 07:23:38.236	murray-pony
1338	32551e28-3a40-47ae-aed1-ff5bc66be879	2020-08-03 04:23:54.117	2020-08-09 07:23:38.236	math-velazquez
1339	889c9ef9-d521-4436-b41c-9021b81b4dfb	2020-08-03 04:23:54.117	2020-08-09 07:23:38.236	liam-snail
1340	97ec5a2f-ac1a-4cde-86b7-897c030a1fa8	2020-08-03 04:23:54.117	2020-08-09 07:23:38.236	alston-woods
1341	1301ee81-406e-43d9-b2bb-55ca6e0f7765	2020-08-03 04:23:54.25	2020-08-09 07:23:38.432	malik-destiny
1342	03097200-0d48-4236-a3d2-8bdb153aa8f7	2020-08-03 04:23:54.25	\N	bennett-browning
1343	495a6bdc-174d-4ad6-8d51-9ee88b1c2e4a	2020-08-03 04:23:54.25	\N	shaquille-torres
1344	1c73f91e-0562-480d-9543-2aab1d5e5acd	2020-08-03 04:23:54.25	2020-08-09 07:23:38.432	sparks-beans
1345	3de17e21-17db-4a6b-b7ab-0b2f3c154f42	2020-08-03 04:23:54.25	2020-08-09 07:23:38.432	brewer-vapor
1346	678170e4-0688-436d-a02d-c0467f9af8c0	2020-08-03 04:23:54.25	2020-08-09 07:23:38.432	baby-doyle
1347	6f9de777-e812-4c84-915c-ef283c9f0cde	2020-08-03 04:23:54.25	2020-08-09 07:23:38.432	arturo-huerta
1348	8b53ce82-4b1a-48f0-999d-1774b3719202	2020-08-03 04:23:54.25	2020-08-09 07:23:38.432	oliver-mueller
1349	8cf78b49-d0ca-4703-88e8-4bcad26c44b1	2020-08-03 04:23:54.25	2020-08-09 07:23:38.432	avila-guzman
1350	90c2cec7-0ed5-426a-9de8-754f34d59b39	2020-08-03 04:23:54.25	2020-08-09 07:23:38.432	tot-fox
1351	9c3273a0-2711-4958-b716-bfcf60857013	2020-08-03 04:23:54.25	2020-08-09 07:23:38.432	kathy-mathews
1352	bf122660-df52-4fc4-9e70-ee185423ff93	2020-08-03 04:23:54.25	2020-08-09 07:23:38.432	walton-sports
1353	ce58415f-4e62-47e2-a2c9-4d6a85961e1e	2020-08-03 04:23:54.25	2020-08-09 07:23:38.432	schneider-blanco
1354	d8ee256f-e3d0-46cb-8c77-b1f88d8c9df9	2020-08-03 04:23:54.25	2020-08-09 07:23:38.432	comfort-septemberish
1355	da0bbbe6-d13c-40cc-9594-8c476975d93d	2020-08-03 04:23:54.25	2020-08-09 07:23:38.432	lang-richardson
1356	dd0b48fe-2d49-4344-83ed-9f0770b370a8	2020-08-03 04:23:54.25	2020-08-09 07:23:38.432	tillman-wan
1357	e376a90b-7ffe-47a2-a934-f36d6806f17d	2020-08-03 04:23:54.25	2020-08-09 07:23:38.432	howell-rocha
1358	87e6ae4b-67de-4973-aa56-0fc9835a1e1e	2020-08-03 02:23:49.247	2020-08-03 05:23:55.538	marco-stink
1359	093af82c-84aa-4bd6-ad1a-401fae1fce44	2020-08-02 10:22:50.243	2020-08-03 05:23:56.421	elijah-glover
1360	814bae61-071a-449b-981e-e7afc839d6d6	2020-08-02 19:09:06.572	2020-08-03 05:23:56.421	ruslan-greatness
1361	82d1b7b4-ce00-4536-8631-a025f05150ce	2020-08-03 05:23:55.538	2020-08-09 07:23:36.613	sam-scandal
1362	f2a27a7e-bf04-4d31-86f5-16bfa3addbe7	2020-08-03 05:23:55.538	2020-08-09 07:23:36.613	winnie-hess
1363	093af82c-84aa-4bd6-ad1a-401fae1fce44	2020-08-03 05:23:56.421	2020-08-09 07:23:37.743	elijah-glover
1364	1ffb1153-909d-44c7-9df1-6ed3a9a45bbd	2020-08-03 05:23:56.421	2020-08-09 07:23:37.743	montgomery-bullock
1365	20395b48-279d-44ff-b5bf-7cf2624a2d30	2020-08-03 05:23:56.421	2020-08-09 07:23:37.743	adrian-melon
1366	4ecee7be-93e4-4f04-b114-6b333e0e6408	2020-08-03 05:23:56.421	2020-08-09 07:23:37.743	sutton-dreamy
1367	5915b7bb-e532-4036-9009-79f1e80c0e28	2020-08-03 05:23:56.421	2020-08-09 07:23:37.743	rosa-holloway
1368	60026a9d-fc9a-4f5a-94fd-2225398fa3da	2020-08-03 05:23:56.421	2020-08-09 07:23:37.743	bright-zimmerman
1369	667cb445-c288-4e62-b603-27291c1e475d	2020-08-03 05:23:56.421	2020-08-09 07:23:37.743	peanut-holloway
1370	7dcf6902-632f-48c5-936a-7cf88802b93a	2020-08-03 05:23:56.421	2020-08-09 07:23:37.743	parker-parra
1371	7e160e9f-2c79-4e08-8b76-b816de388a98	2020-08-03 05:23:56.421	2020-08-09 07:23:37.743	thomas-marsh
1372	90cc0211-cd04-4cac-bdac-646c792773fc	2020-08-03 05:23:56.421	2020-08-09 07:23:37.743	case-lancaster
1373	efafe75e-2f00-4418-914c-9b6675d39264	2020-08-03 04:23:54.25	2020-08-09 07:23:38.432	aldon-cashmoney
1374	f968532a-bf06-478e-89e0-3856b7f4b124	2020-08-03 04:23:54.25	2020-08-09 07:23:38.432	daniel-benedicte
1375	2b5f5dd7-e31f-4829-bec5-546652103bc0	2020-08-03 17:24:29.813	2020-08-03 22:24:33.548	dudley-mueller
1376	87e6ae4b-67de-4973-aa56-0fc9835a1e1e	2020-08-03 05:23:55.538	2020-08-03 23:24:35.411	marco-stink
1377	f2c477fb-28ea-4fcb-943a-9fab22df3da0	2020-08-03 23:24:35.077	2020-08-04 00:24:38.416	sandford-garner
1378	87e6ae4b-67de-4973-aa56-0fc9835a1e1e	2020-08-03 23:24:35.411	2020-08-04 00:24:38.628	marco-stink
1379	2175cda0-a427-40fd-b497-347edcc1cd61	2020-08-03 23:24:35.915	2020-08-04 00:24:39.091	hotbox-sato
1380	32810dca-825c-4dbc-8b65-0702794c424e	2020-08-03 23:24:36.267	2020-08-04 00:24:39.531	eduardo-woodman
1381	32810dca-825c-4dbc-8b65-0702794c424e	2020-08-04 00:24:39.531	2020-08-04 02:24:43.108	eduardo-woodman
1382	a38ada0a-aeac-4a3d-b9a5-968687ccd2f9	2020-08-04 00:24:40.365	2020-08-05 00:03:52.563	sixpack-santiago
1383	c675fcdf-6117-49a6-ac32-99a89a3a88aa	2020-08-03 05:23:56.421	2020-08-08 03:15:12.414	valentine-games
1384	f2c477fb-28ea-4fcb-943a-9fab22df3da0	2020-08-04 00:24:38.416	2020-08-09 07:23:36.435	sandford-garner
1385	2175cda0-a427-40fd-b497-347edcc1cd61	2020-08-04 00:24:39.091	2020-08-09 07:23:37.02	hotbox-sato
1386	d2a1e734-60d9-4989-b7d9-6eacda70486b	2020-08-03 05:23:56.421	2020-08-09 07:23:37.743	tiana-takahashi
1387	d6c69d2d-9344-4b19-85a4-6cfcbaead5d2	2020-08-03 05:23:56.421	2020-08-09 07:23:37.743	joshua-watson
1388	dd8a43a4-a024-44e9-a522-785d998b29c3	2020-08-03 05:23:56.421	2020-08-09 07:23:37.743	miguel-peterson
1389	f70dd57b-55c4-4a62-a5ea-7cc4bf9d8ac1	2020-08-03 05:23:56.421	2020-08-09 07:23:37.743	tillman-henderson
1390	f8c20693-f439-4a29-a421-05ed92749f10	2020-08-03 05:23:56.421	2020-08-09 07:23:37.743	combs-duende
1391	2b5f5dd7-e31f-4829-bec5-546652103bc0	2020-08-03 22:24:33.548	2020-08-09 07:23:37.896	dudley-mueller
1392	3d4545ed-6217-4d7a-9c4a-209265eb6404	2020-08-03 22:24:34.137	2020-08-04 00:24:40.548	tiana-cash
1393	3d4545ed-6217-4d7a-9c4a-209265eb6404	2020-08-04 00:24:40.548	\N	tiana-cash
1394	020ed630-8bae-4441-95cc-0e4ecc27253b	2020-08-03 04:23:53.763	2020-08-04 02:24:43.462	simon-haley
1395	64f4cd75-0c1e-42cf-9ff0-e41c4756f22a	2020-08-03 02:23:49.247	2020-08-04 07:31:26.389	grey-alvarado
1396	089af518-e27c-4256-adc8-62e3f4b30f43	2020-09-06 19:21:24.759	\N	silvia-rugrat
1397	4ffd2e50-bb5b-45d0-b7c4-e24d41b2ff5d	2020-08-03 04:23:53.241	2020-08-04 09:31:47.673	schneider-bendie
1398	69196296-f652-42ff-b2ca-0d9b50bd9b7b	2020-08-03 02:23:49.449	2020-08-04 14:17:36.57	joshua-butt
1399	23110c0f-2cf9-4d9c-ab2d-634f2f18867e	2020-08-04 05:31:05.183	2020-08-05 00:03:50.965	kennedy-meh
1400	69196296-f652-42ff-b2ca-0d9b50bd9b7b	2020-08-04 14:17:36.57	2020-08-05 00:03:51.382	joshua-butt
1401	d23a1f7e-0071-444e-8361-6ae01f13036f	2020-08-04 14:17:36.57	2020-08-05 00:03:51.382	edric-tosser
1402	4ffd2e50-bb5b-45d0-b7c4-e24d41b2ff5d	2020-08-04 09:31:47.673	2020-08-05 00:03:51.767	schneider-bendie
1403	766dfd1e-11c3-42b6-a167-9b2d568b5dc0	2020-08-04 08:16:34.829	2020-08-05 00:03:51.767	sandie-turner
1404	32810dca-825c-4dbc-8b65-0702794c424e	2020-08-04 02:24:43.108	2020-08-05 00:03:51.963	eduardo-woodman
1405	020ed630-8bae-4441-95cc-0e4ecc27253b	2020-08-04 02:24:43.462	2020-08-05 00:03:52.363	simon-haley
1406	9f85676a-7411-444a-8ae2-c7f8f73c285c	2020-08-04 13:32:29.815	2020-08-05 00:03:52.363	lachlan-shelton
1407	4b6f0a4e-de18-44ad-b497-03b1f470c43c	2020-08-04 07:31:26.389	2020-08-05 00:48:54.708	rodriguez-internet
1408	64f4cd75-0c1e-42cf-9ff0-e41c4756f22a	2020-08-04 07:31:26.389	2020-08-05 00:48:54.708	grey-alvarado
1409	c73d59dd-32a0-49ce-8ab4-b2dbb7dc94ec	2020-08-04 09:16:44.499	2020-08-05 00:48:54.708	eduardo-ingram
1410	21d52455-6c2c-4ee4-8673-ab46b4b926b4	2020-08-04 10:16:54.582	2020-08-05 00:03:50.965	emmett-owens
1411	cf8e152e-2d27-4dcc-ba2b-68127de4e6a4	2020-08-04 05:16:04.416	2020-08-05 00:48:56.388	hendricks-richardson
1412	c0177f76-67fc-4316-b650-894159dede45	2020-08-04 14:32:39.166	2020-08-05 00:03:51.382	paula-mason
1413	c9e4a49e-e35a-4034-a4c7-293896b40c58	2020-08-04 17:18:06.399	2020-08-05 00:03:52.164	alexander-horne
1414	2e6d4fa9-f930-47bd-971a-dd54a3cf7db1	2020-08-04 20:18:31.843	2020-08-05 00:03:52.563	raul-leal
1415	a38ada0a-aeac-4a3d-b9a5-968687ccd2f9	2020-08-05 00:03:52.563	2020-08-07 09:12:53.265	sixpack-santiago
1416	21d52455-6c2c-4ee4-8673-ab46b4b926b4	2020-08-05 00:03:50.965	2020-08-09 07:23:36.435	emmett-owens
1417	23110c0f-2cf9-4d9c-ab2d-634f2f18867e	2020-08-05 00:03:50.965	2020-08-09 07:23:36.435	kennedy-meh
1418	4b6f0a4e-de18-44ad-b497-03b1f470c43c	2020-08-05 00:48:54.708	2020-08-09 07:23:36.613	rodriguez-internet
1419	69196296-f652-42ff-b2ca-0d9b50bd9b7b	2020-08-05 00:03:51.382	2020-08-09 07:23:36.831	joshua-butt
1420	c0177f76-67fc-4316-b650-894159dede45	2020-08-05 00:03:51.382	2020-08-09 07:23:36.831	paula-mason
1421	d23a1f7e-0071-444e-8361-6ae01f13036f	2020-08-05 00:03:51.382	2020-08-09 07:23:36.831	edric-tosser
1422	4ffd2e50-bb5b-45d0-b7c4-e24d41b2ff5d	2020-08-05 00:03:51.767	2020-08-09 07:23:37.234	schneider-bendie
1423	766dfd1e-11c3-42b6-a167-9b2d568b5dc0	2020-08-05 00:03:51.767	2020-08-09 07:23:37.234	sandie-turner
1424	32810dca-825c-4dbc-8b65-0702794c424e	2020-08-05 00:03:51.963	2020-08-09 07:23:37.743	eduardo-woodman
1425	c9e4a49e-e35a-4034-a4c7-293896b40c58	2020-08-05 00:03:52.164	2020-08-09 07:23:37.896	alexander-horne
1426	020ed630-8bae-4441-95cc-0e4ecc27253b	2020-08-05 00:03:52.363	2020-08-09 07:23:38.05	simon-haley
1427	9f85676a-7411-444a-8ae2-c7f8f73c285c	2020-08-05 00:03:52.363	2020-08-09 07:23:38.05	lachlan-shelton
1428	ae81e172-801a-4236-929a-b990fc7190ce	2020-08-04 17:18:07.022	2020-08-05 00:48:56.388	august-sky
1429	2e6d4fa9-f930-47bd-971a-dd54a3cf7db1	2020-08-05 00:03:52.563	2020-08-09 07:23:38.236	raul-leal
1430	d1a7c13f-8e78-4d2e-9cae-ebf3a5fcdb5d	2020-08-03 04:23:53.763	2020-08-05 01:34:01.755	elijah-bates
1431	c0732e36-3731-4f1a-abdc-daa9563b6506	2020-08-03 04:23:53.018	2020-08-05 04:19:20.774	nagomi-mcdaniel
1432	c0732e36-3731-4f1a-abdc-daa9563b6506	2020-08-05 04:19:20.774	2020-08-05 06:04:34.295	nagomi-mcdaniel
1433	d1a7c13f-8e78-4d2e-9cae-ebf3a5fcdb5d	2020-08-05 01:34:01.755	2020-08-05 06:04:35.074	elijah-bates
1434	5a26fc61-d75d-4c01-9ce2-1880ffb5550f	2020-08-05 04:34:24.62	2020-08-05 06:04:35.274	randy-dennis
1435	f44a8b27-85c1-44de-b129-1b0f60bcb99c	2020-08-05 10:20:17.859	\N	atlas-jonbois
1436	15d3a844-df6b-4193-a8f5-9ab129312d8d	2020-08-05 14:05:51.875	2020-08-06 01:22:06.539	sebastian-woodman
1437	bd4c6837-eeaa-4675-ae48-061efa0fd11a	2020-08-05 07:04:44.404	2020-08-06 01:22:06.539	workman-gloom
1438	855775c1-266f-40f6-b07b-3a67ccdf8551	2020-08-05 08:04:54.863	2020-08-06 01:22:06.75	nic-winkler
1439	4f328502-d347-4d2c-8fad-6ae59431d781	2020-08-05 16:21:07.648	2020-08-06 01:22:07.991	stephens-lightner
1440	64f4cd75-0c1e-42cf-9ff0-e41c4756f22a	2020-08-05 00:48:54.708	2020-08-09 07:23:36.613	grey-alvarado
1441	c73d59dd-32a0-49ce-8ab4-b2dbb7dc94ec	2020-08-05 00:48:54.708	2020-08-09 07:23:36.613	eduardo-ingram
1442	c0732e36-3731-4f1a-abdc-daa9563b6506	2020-08-05 06:04:34.295	2020-08-09 07:23:37.02	nagomi-mcdaniel
1443	d1a7c13f-8e78-4d2e-9cae-ebf3a5fcdb5d	2020-08-05 06:04:35.074	2020-08-09 07:23:38.05	elijah-bates
1444	5a26fc61-d75d-4c01-9ce2-1880ffb5550f	2020-08-05 06:04:35.274	2020-08-09 07:23:38.236	randy-dennis
1445	ae81e172-801a-4236-929a-b990fc7190ce	2020-08-05 00:48:56.388	2020-08-09 07:23:38.432	august-sky
1446	8c8cc584-199b-4b76-b2cd-eaa9a74965e5	2020-08-05 14:20:55.447	2020-08-05 18:06:21.544	ziwa-mueller
1447	cf8e152e-2d27-4dcc-ba2b-68127de4e6a4	2020-08-05 00:48:56.388	2020-08-09 07:23:38.432	hendricks-richardson
1448	f9c0d3cb-d8be-4f53-94c9-fc53bcbce520	2020-08-05 22:36:49.694	2020-08-06 01:22:06.539	matteo-prestige
1449	f9c0d3cb-d8be-4f53-94c9-fc53bcbce520	2020-08-06 01:22:06.539	\N	matteo-prestige
1450	26f01324-9d1c-470b-8eaa-1b9bfbcd8b65	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	nerd-james
1451	f7715b05-ee69-43e5-a0e5-8e3d34270c82	2020-08-05 17:21:14.975	2020-08-06 01:22:06.75	caligula-lotus
1452	190a0f31-d686-4ac4-a7f3-cfc87b72c145	2020-08-05 17:21:15.545	2020-08-06 01:22:07.315	nerd-pacheco
1453	8c8cc584-199b-4b76-b2cd-eaa9a74965e5	2020-08-05 18:06:21.544	2020-08-06 01:22:07.537	ziwa-mueller
1454	6c346d8b-d186-4228-9adb-ae919d7131dd	2020-08-05 17:06:13.505	2020-08-06 01:22:07.991	greer-gwiffin
1455	34267632-8c32-4a8b-b5e6-ce1568bb0639	2020-08-06 04:07:35.137	2020-08-06 22:25:32.298	gunther-obrian
1456	9786b2c9-1205-4718-b0f7-fc000ce91106	2020-08-06 04:07:35.723	2020-08-06 22:25:32.913	kevin-dudley
1457	15d3a844-df6b-4193-a8f5-9ab129312d8d	2020-08-06 01:22:06.539	2020-08-09 07:23:36.831	sebastian-woodman
1458	bd4c6837-eeaa-4675-ae48-061efa0fd11a	2020-08-06 01:22:06.539	2020-08-09 07:23:36.831	workman-gloom
1459	855775c1-266f-40f6-b07b-3a67ccdf8551	2020-08-06 01:22:06.75	2020-08-09 07:23:37.02	nic-winkler
1460	f7715b05-ee69-43e5-a0e5-8e3d34270c82	2020-08-06 01:22:06.75	2020-08-09 07:23:37.02	caligula-lotus
1461	190a0f31-d686-4ac4-a7f3-cfc87b72c145	2020-08-06 01:22:07.315	2020-08-09 07:23:37.896	nerd-pacheco
1462	8c8cc584-199b-4b76-b2cd-eaa9a74965e5	2020-08-06 01:22:07.537	2020-08-09 07:23:38.05	ziwa-mueller
1463	4f328502-d347-4d2c-8fad-6ae59431d781	2020-08-06 01:22:07.991	2020-08-09 07:23:38.432	stephens-lightner
1464	5ca7e854-dc00-4955-9235-d7fcd732ddcf	2020-08-06 09:08:27.052	2020-08-06 22:25:31.898	taiga-quitter
1465	ea44bd36-65b4-4f3b-ac71-78d87a540b48	2020-08-06 10:23:40.055	2020-08-06 22:25:31.898	wanda-pothos
1466	a5f8ce83-02b2-498c-9e48-533a1d81aebf	2020-08-06 14:24:22.241	2020-08-06 22:25:32.518	evelton-mcblase
1467	f7847de2-df43-4236-8dbe-ae403f5f3ab3	2020-08-07 00:26:19.794	2020-08-07 00:56:25.391	blood-hamburger
1468	21cbbfaa-100e-48c5-9cea-7118b0d08a34	2020-08-07 01:11:28.191	2020-08-07 20:31:03.27	juice-collins
1469	c755efce-d04d-4e00-b5c1-d801070d3808	2020-08-07 01:11:28.191	2020-08-07 20:31:03.27	basilio-fig
1470	8ecea7e0-b1fb-4b74-8c8c-3271cb54f659	2020-08-07 01:26:32.163	2020-08-07 20:31:04.244	fitzgerald-blackburn
1471	c6e2e389-ed04-4626-a5ba-fe398fe89568	2020-08-07 05:27:14.493	2020-08-07 20:31:04.523	henry-marshallow
1472	5ca7e854-dc00-4955-9235-d7fcd732ddcf	2020-08-06 22:25:31.898	2020-08-09 07:23:36.435	taiga-quitter
1473	ea44bd36-65b4-4f3b-ac71-78d87a540b48	2020-08-06 22:25:31.898	2020-08-09 07:23:36.435	wanda-pothos
1474	34267632-8c32-4a8b-b5e6-ce1568bb0639	2020-08-06 22:25:32.298	2020-08-09 07:23:36.831	gunther-obrian
1475	a5f8ce83-02b2-498c-9e48-533a1d81aebf	2020-08-06 22:25:32.518	2020-08-09 07:23:37.02	evelton-mcblase
1476	9786b2c9-1205-4718-b0f7-fc000ce91106	2020-08-06 22:25:32.913	2020-08-09 07:23:37.743	kevin-dudley
1477	c31d874c-1b4d-40f2-a1b3-42542e934047	2020-08-06 22:25:33.674	2020-08-09 07:23:38.432	cedric-spliff
1478	58c9e294-bd49-457c-883f-fb3162fc668e	2020-08-07 14:13:44.056	2020-08-07 20:31:02.673	kichiro-guerra
1479	69196296-f652-42ff-b2ca-0d9b50bd9b7b	2020-08-09 07:23:36.831	2020-08-09 19:27:43.22	joshua-butt
1480	36786f44-9066-4028-98d9-4fa84465ab9e	2020-08-07 08:27:44.286	2020-08-07 20:31:03.063	beasley-gloom
1481	bfd9ff52-9bf6-4aaf-a859-d308d8f29616	2020-08-07 02:26:41.534	2020-08-07 20:31:03.063	declan-suzanne
1482	2e13249e-38ff-46a2-a55e-d15fa692468a	2020-08-07 07:12:31.428	2020-08-07 20:31:03.27	vito-kravitz
1483	7a75d626-d4fd-474f-a862-473138d8c376	2020-08-07 06:27:23.699	2020-08-07 20:31:03.27	beck-whitney
1484	ff5a37d9-a6dd-49aa-b6fb-b935fd670820	2020-08-07 06:42:26.296	2020-08-07 20:31:03.27	dunn-keyes
1795	d2f827a5-0133-4d96-b403-85a5e50d49e0	2020-08-09 07:23:37.743	\N	robbins-schmitt
1485	a38ada0a-aeac-4a3d-b9a5-968687ccd2f9	2020-08-07 09:12:53.265	2020-08-07 20:31:04.244	sixpack-santiago
1486	58c9e294-bd49-457c-883f-fb3162fc668e	2020-08-07 20:31:02.673	2020-08-09 07:23:36.435	kichiro-guerra
1487	36786f44-9066-4028-98d9-4fa84465ab9e	2020-08-07 20:31:03.063	2020-08-09 07:23:36.831	beasley-gloom
1488	bfd9ff52-9bf6-4aaf-a859-d308d8f29616	2020-08-07 20:31:03.063	2020-08-09 07:23:36.831	declan-suzanne
1489	21cbbfaa-100e-48c5-9cea-7118b0d08a34	2020-08-07 20:31:03.27	2020-08-09 07:23:37.02	juice-collins
1490	2e13249e-38ff-46a2-a55e-d15fa692468a	2020-08-07 20:31:03.27	2020-08-09 07:23:37.02	vito-kravitz
1491	7a75d626-d4fd-474f-a862-473138d8c376	2020-08-07 20:31:03.27	2020-08-09 07:23:37.02	beck-whitney
1492	c755efce-d04d-4e00-b5c1-d801070d3808	2020-08-07 20:31:03.27	2020-08-09 07:23:37.02	basilio-fig
1493	ff5a37d9-a6dd-49aa-b6fb-b935fd670820	2020-08-07 20:31:03.27	2020-08-09 07:23:37.02	dunn-keyes
1494	8ecea7e0-b1fb-4b74-8c8c-3271cb54f659	2020-08-07 20:31:04.244	2020-08-09 07:23:38.236	fitzgerald-blackburn
1495	a38ada0a-aeac-4a3d-b9a5-968687ccd2f9	2020-08-07 20:31:04.244	2020-08-09 07:23:38.236	sixpack-santiago
1496	97f5a9cd-72f0-413e-9e68-a6ee6a663489	2020-08-08 16:32:30.83	2020-08-08 22:20:14.979	kline-greenlemon
1497	c6e2e389-ed04-4626-a5ba-fe398fe89568	2020-08-07 20:31:04.523	2020-08-09 07:23:38.432	henry-marshallow
1498	13a05157-6172-4431-947b-a058217b4aa5	2020-08-08 03:30:14.905	2020-08-08 22:20:15.896	spears-taylor
1499	c675fcdf-6117-49a6-ac32-99a89a3a88aa	2020-08-08 03:15:12.414	2020-08-08 22:20:15.896	valentine-games
1500	fa477c92-39b6-4a52-b065-40af2f29840a	2020-08-08 03:15:12.948	2020-08-08 22:20:16.478	howell-franklin
1501	0e27df51-ad0c-4546-acf5-96b3cb4d7501	2020-08-09 07:23:36.435	\N	chorby-spoon
1502	0eea4a48-c84b-4538-97e7-3303671934d2	2020-08-09 07:23:36.435	\N	helga-moreno
1503	0f62c20c-72d0-4c12-a9d7-312ea3d3bcd1	2020-08-09 07:23:36.435	\N	abner-wood
1504	97f5a9cd-72f0-413e-9e68-a6ee6a663489	2020-08-08 22:20:14.979	2020-08-09 07:23:36.613	kline-greenlemon
1505	13a05157-6172-4431-947b-a058217b4aa5	2020-08-08 22:20:15.896	2020-08-09 07:23:37.743	spears-taylor
1506	c675fcdf-6117-49a6-ac32-99a89a3a88aa	2020-08-08 22:20:15.896	2020-08-09 07:23:37.743	valentine-games
1507	5bcfb3ff-5786-4c6c-964c-5c325fcc48d7	2020-08-09 00:20:37.531	2020-08-09 07:23:38.05	paula-turnip
1508	0bb35615-63f2-4492-80ec-b6b322dc5450	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	sexton-wheeler
1509	0d5300f6-0966-430f-903f-a4c2338abf00	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	lee-davenport
1510	0ecf6190-f869-421a-b339-29195d30d37c	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	mcbaseball-clembons
1511	10ea5d50-ec88-40a0-ab53-c6e11cc1e479	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	nicholas-vincent
1512	2e6d4fa9-f930-47bd-971a-dd54a3cf7db1	2020-08-09 07:23:38.236	2020-08-09 19:27:45.771	raul-leal
1513	23110c0f-2cf9-4d9c-ab2d-634f2f18867e	2020-08-09 07:23:36.435	\N	kennedy-meh
1514	11de4da3-8208-43ff-a1ff-0b3480a0fbf1	2020-08-09 07:23:36.435	2020-09-05 17:20:26.613	don-mitchell
1515	23e78d92-ee2d-498a-a99c-f40bc4c5fe99	2020-08-09 07:23:36.435	\N	annie-williams
1516	26f01324-9d1c-470b-8eaa-1b9bfbcd8b65	2020-08-09 07:23:36.435	\N	nerd-james
1517	2b157c5c-9a6a-45a6-858f-bf4cf4cbc0bd	2020-08-09 07:23:36.435	\N	ortiz-lopez
1518	3be2c730-b351-43f7-a832-a5294fe8468f	2020-08-09 07:23:36.435	\N	amaya-jackson
1519	6192daab-3318-44b5-953f-14d68cdb2722	2020-08-02 10:22:48.089	2020-08-09 07:23:36.435	justin-alstott
1520	21d52455-6c2c-4ee4-8673-ab46b4b926b4	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	emmett-owens
1521	3db02423-92af-485f-b30f-78256721dcc6	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	son-jensen
1522	5149c919-48fe-45c6-b7ee-bb8e5828a095	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	adkins-davis
1523	5ca7e854-dc00-4955-9235-d7fcd732ddcf	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	taiga-quitter
1524	6192daab-3318-44b5-953f-14d68cdb2722	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	justin-alstott
1525	63a31035-2e6d-4922-a3f9-fa6e659b54ad	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	moody-rodriguez
1526	63df8701-1871-4987-87d7-b55d4f1df2e9	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	mcdowell-sasquatch
1527	58c9e294-bd49-457c-883f-fb3162fc668e	2020-08-09 07:23:36.435	2020-08-30 19:18:19.465	kichiro-guerra
1528	3c331c87-1634-46c4-87ce-e4b9c59e2969	2020-08-09 07:23:36.435	2020-08-30 19:18:19.465	yosh-carpenter
1529	73265ee3-bb35-40d1-b696-1f241a6f5966	2020-08-09 07:23:36.435	2020-08-30 19:18:19.465	parker-meng
1530	7c5ae357-e079-4427-a90f-97d164c7262e	2020-08-09 07:23:36.435	\N	milo-brown
1531	126fb128-7c53-45b5-ac2b-5dbf9943d71b	2020-08-09 07:23:36.435	2020-09-08 20:08:20.992	sigmund-castillo
1532	9313e41c-3bf7-436d-8bdc-013d3a1ecdeb	2020-08-09 07:23:36.435	\N	sandie-nelson
1533	9f6d06d6-c616-4599-996b-ec4eefcff8b8	2020-08-09 07:23:36.435	\N	silvia-winner
1534	b390b28c-df96-443e-b81f-f0104bd37860	2020-08-09 07:23:36.435	\N	karato-rangel
1535	bd24e18b-800d-4f15-878d-e334fb4803c4	2020-08-09 07:23:36.435	\N	helga-burton
1536	cbd19e6f-3d08-4734-b23f-585330028665	2020-08-09 07:23:36.435	\N	knight-urlacher
1537	d97835fd-2e92-4698-8900-1f5abea0a3b6	2020-08-09 07:23:36.435	\N	king-roland
1538	db33a54c-3934-478f-bad4-fc313ac2580e	2020-08-09 07:23:36.435	\N	percival-wheeler
1539	e16c3f28-eecd-4571-be1a-606bbac36b2b	2020-08-02 10:22:48.089	2020-08-09 07:23:36.435	comfort-glover
1540	937c1a37-4b05-4dc5-a86d-d75226f8490a	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	pippin-carpenter
1541	a1ed3396-114a-40bc-9ff0-54d7e1ad1718	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	patel-beyonce
1542	bf6a24d1-4e89-4790-a4ba-eeb2870cbf6f	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	rat-polk
1543	d81ce662-07b6-4a73-baa4-acbbb41f9dc5	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	yummy-elliott
1544	d8758c1b-afbb-43a5-b00b-6004d419e2c5	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	ortiz-nelson
1545	dfe3bc1b-fca8-47eb-965f-6cf947c35447	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	linus-haley
1546	e16c3f28-eecd-4571-be1a-606bbac36b2b	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	comfort-glover
1547	e749dc27-ca3b-456e-889c-d2ec02ac7f5f	2020-08-09 07:23:36.435	\N	aureliano-estes
1548	e4034192-4dc6-4901-bb30-07fe3cf77b5e	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	baldwin-breadwinner
1549	ee55248b-318a-4bfb-8894-1cc70e4e0720	2020-08-09 07:23:36.435	\N	theo-king
1550	f1185b20-7b4a-4ccc-a977-dc1afdfd4cb9	2020-08-09 07:23:36.435	\N	frazier-tosser
1551	042962c8-4d8b-44a6-b854-6ccef3d82716	2020-08-09 07:23:36.613	\N	ronan-jaylee
1552	05bd08d5-7d9f-450b-abfa-1788b8ee8b91	2020-08-02 21:23:42.155	2020-08-09 07:23:36.613	stevenson-monstera
1553	05bd08d5-7d9f-450b-abfa-1788b8ee8b91	2020-08-09 07:23:36.613	\N	stevenson-monstera
1554	113f47b2-3111-4abb-b25e-18f7889e2d44	2020-08-09 07:23:36.613	\N	adkins-swagger
1555	138fccc3-e66f-4b07-8327-d4b6f372f654	2020-08-03 02:23:49.247	2020-08-09 07:23:36.613	oscar-vaughan
1556	13cfbadf-b048-4c4f-903d-f9b52616b15c	2020-08-09 07:23:36.613	\N	bennett-bowen
1557	17397256-c28c-4cad-85f2-a21768c66e67	2020-08-09 07:23:36.613	\N	cory-ross
1558	35d5b43f-8322-4666-aab1-d466b4a5a388	2020-08-09 07:23:36.613	\N	jordan-boone
1559	f0594932-8ef7-4d70-9894-df4be64875d8	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	fitzgerald-wanderlust
1560	f741dc01-2bae-4459-bfc0-f97536193eea	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	alejandro-leaf
1561	138fccc3-e66f-4b07-8327-d4b6f372f654	2020-08-09 07:23:36.613	2020-08-09 19:27:42.24	oscar-vaughan
1562	33fbfe23-37bd-4e37-a481-a87eadb8192d	2020-08-09 07:23:36.613	2020-08-09 19:27:42.24	whit-steakknife
1563	f2c477fb-28ea-4fcb-943a-9fab22df3da0	2020-08-09 07:23:36.435	2020-08-30 19:18:19.465	sandford-garner
1564	3f08f8cd-6418-447a-84d3-22a981c68f16	2020-08-09 07:23:36.613	\N	pollard-beard
1565	14d88771-7a96-48aa-ba59-07bae1733e96	2020-08-09 07:23:36.613	2020-08-30 19:18:20.089	sebastian-telephone
1566	4fe28bc1-f690-4ad6-ad09-1b2e984bf30b	2020-08-09 07:23:36.613	\N	cell-longarms
1567	6598e40a-d76d-413f-ad06-ac4872875bde	2020-08-09 07:23:36.613	\N	daniel-mendoza
1568	6b8d128f-ed51-496d-a965-6614476f8256	2020-08-09 07:23:36.613	\N	orville-manco
1569	6e373fca-b8ab-4848-9dcc-50e92cd732b7	2020-08-09 07:23:36.613	\N	conrad-bates
1570	721fb947-7548-49ea-8cbe-7721b0ed49e0	2020-08-02 10:22:48.962	2020-08-09 07:23:36.613	tamara-lopez
1571	721fb947-7548-49ea-8cbe-7721b0ed49e0	2020-08-09 07:23:36.613	\N	tamara-lopez
1572	732899a3-2082-4d9f-b1c2-74c8b75e15fb	2020-08-09 07:23:36.613	\N	minato-ito
1573	740d5fef-d59f-4dac-9a75-739ec07f91cf	2020-08-09 07:23:36.613	\N	conner-haley
1574	81a0889a-4606-4f49-b419-866b57331383	2020-08-09 07:23:36.613	\N	summers-pony
1575	82d1b7b4-ce00-4536-8631-a025f05150ce	2020-08-09 07:23:36.613	\N	sam-scandal
1576	849e13dc-6eb1-40a8-b55c-d4b4cd160aab	2020-08-09 07:23:36.613	\N	justice-valenzuela
1577	4b6f0a4e-de18-44ad-b497-03b1f470c43c	2020-08-09 07:23:36.613	2020-08-09 19:27:42.24	rodriguez-internet
1578	53e701c7-e3c8-4e18-ba05-9b41b4b64cda	2020-08-09 07:23:36.613	2020-08-09 19:27:42.24	marquez-clark
1579	64f4cd75-0c1e-42cf-9ff0-e41c4756f22a	2020-08-09 07:23:36.613	2020-08-09 19:27:42.24	grey-alvarado
1580	7663c3ca-40a1-4f13-a430-14637dce797a	2020-08-09 07:23:36.613	2020-08-09 19:27:42.24	polkadot-zavala
1581	87e6ae4b-67de-4973-aa56-0fc9835a1e1e	2020-08-04 00:24:38.628	2020-08-09 07:23:36.613	marco-stink
1582	3af96a6b-866c-4b03-bc14-090acf6ecee5	2020-08-09 07:23:36.613	2020-08-09 19:27:43.22	axel-trololol
1583	90c8be89-896d-404c-945e-c135d063a74e	2020-08-09 07:23:36.613	\N	james-boy
1584	94baa9ac-ff96-4f56-a987-10358e917d91	2020-08-09 07:23:36.613	\N	gabriel-griffith
1585	97f5a9cd-72f0-413e-9e68-a6ee6a663489	2020-08-09 07:23:36.613	\N	kline-greenlemon
1586	9fd1f392-d492-4c48-8d46-27fb4283b2db	2020-08-09 07:23:36.613	\N	lucas-petty
1587	a8a5cf36-d1a9-47d1-8d22-4a665933a7cc	2020-08-09 07:23:36.613	\N	helga-washington
1588	a8e757c6-e299-4a2e-a370-4f7c3da98bd1	2020-08-09 07:23:36.613	\N	hendricks-lenny
1589	aae38811-122c-43dd-b59c-d0e203154dbe	2020-08-09 07:23:36.613	\N	sandie-carver
1590	c17a4397-4dcc-440e-8c53-d897e971cae9	2020-08-09 07:23:36.613	\N	august-mina
1591	c6bd21a8-7880-4c00-8abe-33560fe84ac5	2020-08-09 07:23:36.613	\N	wendy-cerna
1592	d796d287-77ef-49f0-89ef-87bcdeb280ee	2020-08-09 07:23:36.613	\N	izuki-clark
1593	a199a681-decf-4433-b6ab-5454450bbe5e	2020-08-09 07:23:36.613	2020-08-09 19:27:42.24	leach-ingram
1594	b39b5aae-8571-4c90-887a-6a00f2a2f6fd	2020-08-09 07:23:36.613	2020-08-09 19:27:42.24	dickerson-morse
1595	c73d59dd-32a0-49ce-8ab4-b2dbb7dc94ec	2020-08-09 07:23:36.613	2020-08-09 19:27:42.24	eduardo-ingram
1596	cd417f8a-ce01-4ab2-921d-42e2e445bbe2	2020-08-09 07:23:36.613	2020-08-09 19:27:42.24	eizabeth-guerra
1597	87e6ae4b-67de-4973-aa56-0fc9835a1e1e	2020-08-09 07:23:36.613	2020-08-12 20:25:33.308	marco-stink
1598	dd7e710f-da4e-475b-b870-2c29fe9d8c00	2020-08-09 07:23:36.613	\N	itsuki-weeks
1599	b7ca8f3f-2fdc-477b-84f4-157f2802e9b5	2020-08-09 07:23:36.613	2020-08-30 19:18:20.089	leach-herman
1600	de52d5c0-cba4-4ace-8308-e2ed3f8799d0	2020-08-09 07:23:36.613	\N	jose-mitchell
1601	ebf2da50-7711-46ba-9e49-341ce3487e00	2020-08-09 07:23:36.613	\N	baldwin-jones
1602	fa5b54d2-b488-47cd-a529-592831e4813d	2020-08-09 07:23:36.613	\N	kina-larsen
1603	fdfd36c7-e0c1-4fce-98f7-921c3d17eafe	2020-08-02 10:22:48.962	2020-08-09 07:23:36.613	reese-harrington
1604	fdfd36c7-e0c1-4fce-98f7-921c3d17eafe	2020-08-09 07:23:36.613	\N	reese-harrington
1605	16aff709-e855-47c8-8818-b9ba66e90fe8	2020-08-03 02:23:49.449	2020-08-09 07:23:36.831	mullen-peterson
1606	1513aab6-142c-48c6-b43e-fbda65fd64e8	2020-08-09 07:23:36.831	2020-08-09 19:27:43.22	caleb-alvarado
1607	16aff709-e855-47c8-8818-b9ba66e90fe8	2020-08-09 07:23:36.831	2020-08-09 19:27:43.22	mullen-peterson
1608	20e13b56-599b-4a22-b752-8059effc81dc	2020-08-09 07:23:36.831	2020-08-09 19:27:43.22	lou-roseheart
1609	18798b8f-6391-4cb2-8a5f-6fb540d646d5	2020-08-09 07:23:36.831	2020-08-27 02:15:44.985	morrow-doyle
1610	248ccf3d-d5f6-4b69-83d9-40230ca909cd	2020-08-09 07:23:36.831	2020-08-30 19:18:22.136	antonio-wallace
1611	15d3a844-df6b-4193-a8f5-9ab129312d8d	2020-08-09 07:23:36.831	2020-08-30 19:18:22.136	sebastian-woodman
1612	03f920cc-411f-44ef-ae66-98a44e883291	2020-08-09 07:23:36.831	2020-08-30 19:18:22.136	cornelius-games
1613	2b157c5c-9a6a-45a6-858f-bf4cf4cbc0bd	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	ortiz-lopez
1614	198fd9c8-cb75-482d-873e-e6b91d42a446	2020-08-09 07:23:36.831	2020-08-30 19:18:23.156	ren-hunter
1615	2ae8cbfc-2155-4647-9996-3f2591091baf	2020-08-09 07:23:36.831	2020-09-06 19:06:14.626	forrest-bookbaby
1616	2d22f026-2873-410b-a45f-3b1dac665ffd	2020-08-09 07:23:36.831	\N	donia-johnson
1617	f73009c5-2ede-4dc4-b96d-84ba93c8a429	2020-08-09 07:23:36.613	2020-09-06 19:06:17.18	thomas-kirby
1618	3531c282-cb48-43df-b549-c5276296aaa7	2020-08-09 07:23:36.831	\N	oliver-hess
1619	3c051b92-4a86-4157-988a-e334bf6dc691	2020-08-09 07:23:36.831	\N	tyler-leatherman
1620	50154d56-c58a-461f-976d-b06a4ae467f9	2020-08-09 07:23:36.831	\N	carter-oconnor
1621	520e6066-b14b-45cf-985c-0a6ee2dc3f7a	2020-08-09 07:23:36.831	\N	zi-sliders
1622	54e5f222-fb16-47e0-adf9-21813218dafa	2020-08-09 07:23:36.831	\N	grit-watson
1623	5b3f0a43-45e7-44e7-9496-512c24c040f0	2020-08-09 07:23:36.831	\N	rhys-rivera
1624	5b5bcc6c-d011-490f-b084-6fdc2c52f958	2020-08-09 07:23:36.831	\N	simba-davis
1625	5f3b5dc2-351a-4dee-a9d6-fa5f44f2a365	2020-08-09 07:23:36.831	\N	alston-england
1626	64aaa3cb-7daf-47e3-89a8-e565a3715b5d	2020-08-02 10:22:49.478	2020-08-09 07:23:36.831	travis-nakamura
1627	64aaa3cb-7daf-47e3-89a8-e565a3715b5d	2020-08-09 07:23:36.831	\N	travis-nakamura
1628	4bf352d2-6a57-420a-9d45-b23b2b947375	2020-08-09 07:23:36.831	2020-08-09 19:27:43.22	rivers-rosa
1629	68f98a04-204f-4675-92a7-8823f2277075	2020-08-09 07:23:36.831	2020-08-09 19:27:43.22	isaac-johnson
1630	34267632-8c32-4a8b-b5e6-ce1568bb0639	2020-08-09 07:23:36.831	2020-08-30 19:18:22.136	gunther-obrian
1631	4ca52626-58cd-449d-88bb-f6d631588640	2020-08-09 07:23:36.831	2020-08-30 19:18:22.136	velasquez-alstott
1632	36786f44-9066-4028-98d9-4fa84465ab9e	2020-08-09 07:23:36.831	2020-08-30 19:18:22.136	beasley-gloom
1633	7e4f012e-828c-43bb-8b8a-6c33bdfd7e3f	2020-08-09 07:23:36.831	\N	patel-olive
1634	5e4dfa16-f1b9-400f-b8ef-a1613c2b026a	2020-08-09 07:23:36.831	2020-08-30 19:18:22.136	snyder-briggs
1635	88ca603e-b2e5-4916-bef5-d6bba03235f5	2020-08-02 21:23:42.352	2020-08-09 07:23:36.831	clare-mccall
1636	88ca603e-b2e5-4916-bef5-d6bba03235f5	2020-08-09 07:23:36.831	\N	clare-mccall
1637	93502db3-85fa-4393-acae-2a5ff3980dde	2020-08-09 07:23:36.831	\N	rodriguez-sunshine
1640	b056a825-b629-4856-856b-53a15ad34acb	2020-08-02 10:22:49.478	2020-08-09 07:23:36.831	bennett-takahashi
1641	b056a825-b629-4856-856b-53a15ad34acb	2020-08-09 07:23:36.831	\N	bennett-takahashi
1642	bd4c6837-eeaa-4675-ae48-061efa0fd11a	2020-08-09 07:23:36.831	\N	workman-gloom
1643	c8de53a4-d90f-4192-955b-cec1732d920e	2020-08-09 07:23:36.831	\N	tyreek-cain
1644	ce0a156b-ba7b-4313-8fea-75807b4bc77f	2020-08-09 07:23:36.831	\N	conrad-twelve
1645	d002946f-e7ed-4ce4-a405-63bdaf5eabb5	2020-08-09 07:23:36.831	\N	jorge-owens
1646	bfd9ff52-9bf6-4aaf-a859-d308d8f29616	2020-08-09 07:23:36.831	2020-08-09 19:27:43.22	declan-suzanne
1647	c0177f76-67fc-4316-b650-894159dede45	2020-08-09 07:23:36.831	2020-08-09 19:27:43.22	paula-mason
1648	d46abb00-c546-4952-9218-4f16084e3238	2020-08-09 07:23:36.831	2020-08-30 19:18:20.089	atlas-guerra
1649	b8ab86c6-9054-4832-9b96-508dbd4eb624	2020-08-09 07:23:36.831	2020-08-30 19:18:22.136	esme-ramsey
1650	d6e9a211-7b33-45d9-8f09-6d1a1a7a3c78	2020-08-09 07:23:36.831	\N	william-boone
1651	eaaef47e-82cc-4c90-b77d-75c3fb279e83	2020-08-09 07:23:36.831	\N	herring-winfield
1652	f071889c-f10f-4d2f-a1dd-c5dda34b3e2b	2020-08-09 07:23:36.831	\N	zion-facepunch
1653	f7847de2-df43-4236-8dbe-ae403f5f3ab3	2020-08-07 00:56:25.391	2020-08-09 07:23:36.831	blood-hamburger
1654	03d06163-6f06-4817-abe5-0d14c3154236	2020-08-02 10:22:49.747	2020-08-09 07:23:37.02	garcia-tabby
1655	03d06163-6f06-4817-abe5-0d14c3154236	2020-08-09 07:23:37.02	\N	garcia-tabby
1656	0bd5a3ec-e14c-45bf-8283-7bc191ae53e4	2020-08-09 07:23:37.02	\N	stephanie-donaldson
1657	24f6829e-7bb4-4e1e-8b59-a07514657e72	2020-08-09 07:23:37.02	\N	king-weatherman
1658	2cadc28c-88a5-4e25-a6eb-cdab60dd446d	2020-08-09 07:23:37.02	\N	elijah-bookbaby
1659	2e13249e-38ff-46a2-a55e-d15fa692468a	2020-08-09 07:23:37.02	2020-08-30 19:18:19.465	vito-kravitz
1660	2f3d7bc7-6ffb-40c3-a94f-5e626be413c9	2020-08-09 07:23:37.02	2020-08-30 19:18:21.602	elijah-valenzuela
1661	21cbbfaa-100e-48c5-9cea-7118b0d08a34	2020-08-09 07:23:37.02	2020-08-30 19:18:21.602	juice-collins
1662	1e8b09bd-fbdd-444e-bd7e-10326bd57156	2020-08-09 07:23:37.02	2020-08-30 19:18:21.602	fletcher-yamamoto
1663	167751d5-210c-4a6e-9568-e92d61bab185	2020-08-09 07:23:37.02	2020-08-30 19:18:21.602	jacob-winner
1664	f7847de2-df43-4236-8dbe-ae403f5f3ab3	2020-08-09 07:23:36.831	2020-08-30 19:18:22.136	blood-hamburger
1665	2175cda0-a427-40fd-b497-347edcc1cd61	2020-08-09 07:23:37.02	2020-08-30 19:18:22.136	hotbox-sato
1666	d47dd08e-833c-4302-a965-a391d345455c	2020-08-09 07:23:36.831	2020-08-30 19:18:22.136	stu-trololol
1667	3954bdfa-931f-4787-b9ac-f44b72fe09d7	2020-08-09 07:23:37.02	\N	nicholas-nolan
1668	3e008f60-6842-42e7-b125-b88c7e5c1a95	2020-08-09 07:23:37.02	\N	zeboriah-wilson
1669	4b73367f-b2bb-4df6-b2eb-2a0dd373eead	2020-08-09 07:23:37.02	\N	tristin-crankit
1670	51985516-5033-4ab8-a185-7bda07829bdb	2020-08-09 07:23:37.02	\N	stephanie-schmitt
1671	527c1f6e-a7e4-4447-a824-703b662bae4e	2020-08-09 07:23:37.02	\N	melton-campbell
1672	62823073-84b8-46c2-8451-28fd10dff250	2020-08-09 07:23:37.02	\N	mckinney-vaughan
1673	718dea1a-d9a8-4c2b-933a-f0667b5250e6	2020-08-09 07:23:37.02	\N	margarito-nava
1674	7a75d626-d4fd-474f-a862-473138d8c376	2020-08-09 07:23:37.02	\N	beck-whitney
1675	7b55d484-6ea9-4670-8145-986cb9e32412	2020-08-02 10:22:49.747	2020-08-09 07:23:37.02	stevenson-heat
1676	805ba480-df4d-4f56-a4cf-0b99959111b5	2020-08-09 07:23:37.02	\N	leticia-lozano
1677	81b25b16-3370-4eb0-9d1b-6d630194c680	2020-08-09 07:23:37.02	\N	zeboriah-whiskey
1678	855775c1-266f-40f6-b07b-3a67ccdf8551	2020-08-09 07:23:37.02	\N	nic-winkler
1679	86d4e22b-f107-4bcf-9625-32d387fcb521	2020-08-09 06:23:26.778	2020-08-09 07:23:37.02	york-silk
1680	86d4e22b-f107-4bcf-9625-32d387fcb521	2020-08-09 07:23:37.02	2020-08-30 07:25:59.724	york-silk
1681	7b55d484-6ea9-4670-8145-986cb9e32412	2020-08-09 07:23:37.02	2020-08-30 19:18:21.602	stevenson-heat
1682	7158d158-e7bf-4e9b-9259-62e5b25e3de8	2020-08-09 07:23:37.02	2020-08-30 19:18:21.602	karato-bean
1683	51c5473a-7545-4a9a-920d-d9b718d0e8d1	2020-08-09 07:23:37.02	2020-09-09 00:41:38.455	jacob-haynes
1684	960f041a-f795-4001-bd88-5ddcf58ee520	2020-08-09 07:23:37.02	\N	mayra-buckley
1685	98f26a25-905f-4850-8960-b741b0c583a4	2020-08-09 07:23:37.02	\N	stu-mcdaniel
1686	a2483925-697f-468f-931c-bcd0071394e5	2020-08-09 07:23:37.02	\N	timmy-manco
1687	a938f586-f5c1-4a35-9e7f-8eaab6de67a6	2020-08-09 07:23:37.02	\N	jasper-destiny
1688	a98917bc-e9df-4b0e-bbde-caa6168aa3d7	2020-08-09 07:23:37.02	\N	jenkins-ingram
1689	ab9eb213-0917-4374-a259-458295045021	2020-08-09 07:23:37.02	\N	matheo-carpenter
1690	c771abab-f468-46e9-bac5-43db4c5b410f	2020-08-09 07:23:37.02	\N	wade-howe
1691	ccc99f2f-2feb-4f32-a9b9-c289f619d84c	2020-08-09 07:23:37.02	\N	itsuki-winner
1692	cd6b102e-1881-4079-9a37-455038bbf10e	2020-08-09 07:23:37.02	\N	caleb-morin
1693	d9a072f5-1cbb-45ce-87fb-b138e4d8f769	2020-08-02 10:22:49.747	2020-08-09 07:23:37.02	francisco-object
1694	d9a072f5-1cbb-45ce-87fb-b138e4d8f769	2020-08-09 07:23:37.02	\N	francisco-object
1695	c755efce-d04d-4e00-b5c1-d801070d3808	2020-08-09 07:23:37.02	2020-08-25 15:12:22.222	basilio-fig
1696	8a6fc67d-a7fe-443b-a084-744294cec647	2020-08-09 07:23:37.02	2020-08-30 19:18:21.602	terrell-bradley
1697	9ac2e7c5-5a34-4738-98d8-9f917bc6d119	2020-08-09 07:23:37.02	2020-08-30 19:18:21.602	christian-combs
1698	a5f8ce83-02b2-498c-9e48-533a1d81aebf	2020-08-09 07:23:37.02	2020-08-30 19:18:21.602	evelton-mcblase
1699	89ec77d8-c186-4027-bd45-f407b4800c2c	2020-08-09 07:23:37.02	2020-08-30 19:18:21.602	james-mora
1700	a647388d-fc59-4c1b-90d3-8c1826e07775	2020-08-09 07:23:37.02	2020-08-30 19:18:22.136	chambers-simmons
1701	de67b585-9bf4-4e49-b410-101483ca2fbc	2020-08-09 07:23:37.02	\N	shaquille-sunshine
1702	defbc540-a36d-460b-afd8-07da2375ee63	2020-08-09 07:23:37.02	\N	castillo-turner
1703	dfd5ccbb-90ed-4bfe-83e0-dae9cc763f10	2020-08-09 07:23:37.02	\N	owen-picklestein
1704	e3e1d190-2b94-40c0-8e88-baa3fd198d0f	2020-08-03 04:23:53.018	2020-08-09 07:23:37.02	chambers-kennedy
1705	e3e1d190-2b94-40c0-8e88-baa3fd198d0f	2020-08-09 07:23:37.02	\N	chambers-kennedy
1706	f7715b05-ee69-43e5-a0e5-8e3d34270c82	2020-08-09 07:23:37.02	\N	caligula-lotus
1707	fbb5291c-2438-400e-ab32-30ce1259c600	2020-08-09 07:23:37.02	\N	cory-novak
1708	1af239ae-7e12-42be-9120-feff90453c85	2020-08-09 07:23:37.234	\N	melton-telephone
1709	1ded0384-d290-4ea1-a72b-4f9d220cbe37	2020-08-09 07:23:37.234	\N	juan-murphy
1710	1e229fe5-a191-48ef-a7dd-6f6e13d6d73f	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	erickson-fischer
1711	1e229fe5-a191-48ef-a7dd-6f6e13d6d73f	2020-08-09 07:23:37.234	\N	erickson-fischer
1712	1e7b02b7-6981-427a-b249-8e9bd35f3882	2020-08-09 07:23:37.234	\N	nora-reddick
1713	17392be2-7344-48a0-b4db-8a040a7fb532	2020-08-09 07:23:37.234	2020-08-30 19:18:22.658	washer-barajas
1714	03b80a57-77ea-4913-9be4-7a85c3594745	2020-08-09 07:23:37.234	2020-08-30 19:18:22.658	halexandrey-walton
1715	09f2787a-3352-41a6-8810-d80e97b253b5	2020-08-09 07:23:37.234	2020-08-30 19:18:22.658	curry-aliciakeyes
1716	0c83e3b6-360e-4b7d-85e3-d906633c9ca0	2020-08-09 07:23:37.234	2020-08-30 19:18:23.156	penelope-mathews
1717	18af933a-4afa-4cba-bda5-45160f3af99b	2020-08-09 07:23:37.234	2020-08-30 19:18:23.156	felix-garbage
1718	29bf512a-cd8c-4ceb-b25a-d96300c184bb	2020-08-09 07:23:37.234	\N	garcia-soto
1719	450e6483-d116-41d8-933b-1b541d5f0026	2020-08-09 07:23:37.234	\N	england-voorhees
1720	5c60f834-a133-4dc6-9c07-392fb37b3e6a	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	ramirez-winters
1721	5c60f834-a133-4dc6-9c07-392fb37b3e6a	2020-08-09 07:23:37.234	\N	ramirez-winters
1722	6a869b40-be99-4520-89e5-d382b07e4a3c	2020-08-09 07:23:37.234	\N	jake-swinger
1723	82733eb4-103d-4be1-843e-6eb6df35ecd7	2020-08-09 07:23:37.234	\N	adkins-tosser
1724	44c92d97-bb39-469d-a13b-f2dd9ae644d1	2020-08-09 07:23:37.234	2020-08-30 19:18:22.658	francisco-preston
1725	63512571-2eca-4bc4-8ad9-a5308a22ae22	2020-08-09 07:23:37.234	2020-08-30 19:18:22.658	oscar-dollie
1726	2da49de2-34e5-49d0-b752-af2a2ee061be	2020-08-09 07:23:37.234	2020-08-30 19:18:22.658	cory-twelve
1727	7310c32f-8f32-40f2-b086-54555a2c0e86	2020-08-09 07:23:37.234	2020-08-30 19:18:23.156	dominic-marijuana
1728	5dbf11c0-994a-4482-bd1e-99379148ee45	2020-08-09 07:23:37.234	2020-08-30 19:18:23.156	conrad-vaughan
1729	4b3e8e9b-6de1-4840-8751-b1fb45dc5605	2020-08-09 07:23:37.234	2020-08-30 19:18:23.156	thomas-dracaena
1730	4ffd2e50-bb5b-45d0-b7c4-e24d41b2ff5d	2020-08-09 07:23:37.234	2020-08-30 19:18:23.156	schneider-bendie
1731	413b3ddb-d933-4567-a60e-6d157480239d	2020-08-09 07:23:37.234	2020-08-30 19:18:23.156	winnie-mccall
1732	766dfd1e-11c3-42b6-a167-9b2d568b5dc0	2020-08-09 07:23:37.234	2020-08-30 19:18:23.156	sandie-turner
1733	81d7d022-19d6-427d-aafc-031fcb79b29e	2020-08-09 07:23:37.234	2020-08-30 19:18:23.156	patty-fox
1734	378c07b0-5645-44b5-869f-497d144c7b35	2020-08-09 07:23:37.234	2020-08-30 19:18:23.156	fynn-doyle
1735	8d81b190-d3b8-4cd9-bcec-0e59fdd7f2bc	2020-08-09 07:23:37.234	\N	albert-stink
1736	9397ed91-608e-4b13-98ea-e94c795f651e	2020-08-02 23:06:56.344	2020-08-09 07:23:37.234	yeongho-garcia
1737	945974c5-17d9-43e7-92f6-ba49064bbc59	2020-08-09 07:23:37.234	\N	bates-silk
1738	94d772c7-0254-4f08-814c-f6fc58fcfb9b	2020-08-09 07:23:37.234	\N	fletcher-peck
1739	94f30f21-f889-4a2e-9b94-818475bb1ca0	2020-08-09 07:23:37.234	\N	kirkland-sobremesa
1740	9a031b9a-16f8-4165-a468-5d0e28a81151	2020-08-09 07:23:37.234	\N	tiana-wheeler
1741	9e724d9a-92a0-436e-bde1-da0b2af85d8f	2020-08-09 07:23:37.234	\N	hatfield-suzuki
1742	ab9b2592-a64a-4913-bf6c-3ae5bd5d26a5	2020-08-09 07:23:37.234	\N	beau-huerta
1743	ac57cf28-556f-47af-9154-6bcea2ace9fc	2020-08-09 07:23:37.234	\N	rey-wooten
1744	ac69dba3-6225-4afd-ab4b-23fc78f730fb	2020-08-09 07:23:37.234	2020-08-30 19:18:22.658	bevan-wise
1745	a5adc84c-80b8-49e4-9962-8b4ade99a922	2020-08-09 07:23:37.234	2020-08-30 19:18:22.658	richardson-turquoise
1746	aa6c2662-75f8-4506-aa06-9a0993313216	2020-08-09 07:23:37.234	2020-08-30 19:18:22.658	eizabeth-elliott
1747	9397ed91-608e-4b13-98ea-e94c795f651e	2020-08-09 07:23:37.234	2020-08-30 19:18:22.658	yeongho-garcia
1748	8adb084b-19fe-4295-bcd2-f92afdb62bd7	2020-08-09 07:23:37.234	2020-08-30 19:18:22.658	logan-rodriguez
1749	9965eed5-086c-4977-9470-fe410f92d353	2020-08-09 07:23:37.234	2020-08-30 19:18:23.156	bates-bentley
1750	ae4acebd-edb5-4d20-bf69-f2d5151312ff	2020-08-09 07:23:37.234	2020-08-30 19:18:23.156	theodore-cervantes
1751	a311c089-0df4-46bd-9f5d-8c45c7eb5ae2	2020-08-09 07:23:37.234	2020-08-30 19:18:24.173	mclaughlin-scorpler
1752	b77dffaa-e0f5-408f-b9f2-1894ed26e744	2020-08-03 04:23:53.241	2020-08-09 07:23:37.234	tucker-lenny
1753	b77dffaa-e0f5-408f-b9f2-1894ed26e744	2020-08-09 07:23:37.234	\N	tucker-lenny
1754	b7cdb93b-6f9d-468a-ae00-54cbc324ee84	2020-08-02 10:22:49.929	2020-08-09 07:23:37.234	ruslan-duran
1755	b7cdb93b-6f9d-468a-ae00-54cbc324ee84	2020-08-09 07:23:37.234	\N	ruslan-duran
1756	c4951cae-0b47-468b-a3ac-390cc8e9fd05	2020-08-09 07:23:37.234	\N	timmy-vine
1757	c6146c45-3d9b-4749-9f03-d4faae61e2c3	2020-08-09 07:23:37.234	\N	atlas-diaz
1758	db53211c-f841-4f33-accf-0c3e167889a0	2020-08-09 07:23:37.234	\N	travis-bendie
1759	0672a4be-7e00-402c-b8d6-0b813f58ba96	2020-08-09 07:23:37.743	\N	castillo-logan
1760	093af82c-84aa-4bd6-ad1a-401fae1fce44	2020-08-09 07:23:37.743	\N	elijah-glover
1761	20395b48-279d-44ff-b5bf-7cf2624a2d30	2020-08-09 07:23:37.743	\N	adrian-melon
1762	b6aa8ce8-2587-4627-83c1-2a48d44afaee	2020-08-09 07:23:37.234	2020-08-30 19:18:22.658	inky-rutledge
1763	1732e623-ffc2-40f0-87ba-fdcf97131f1f	2020-08-09 07:23:37.743	2020-08-30 19:18:22.658	betsy-trombone
1764	f967d064-0eaf-4445-b225-daed700e044b	2020-08-09 07:23:37.234	2020-08-30 19:18:23.156	wesley-dudley
1765	13a05157-6172-4431-947b-a058217b4aa5	2020-08-09 07:23:37.743	2020-08-30 19:18:24.173	spears-taylor
1766	15ae64cd-f698-4b00-9d61-c9fffd037ae2	2020-08-09 07:23:37.743	2020-09-06 19:06:14.626	mickey-woods
1767	1a93a2d2-b5b6-479b-a595-703e4a2f3885	2020-08-09 07:23:37.743	2020-09-06 19:06:15.653	pedro-davids
1768	1ffb1153-909d-44c7-9df1-6ed3a9a45bbd	2020-08-09 07:23:37.743	2020-09-06 19:06:15.653	montgomery-bullock
1769	34e1b683-ecd5-477f-b9e3-dd4bca76db45	2020-08-09 07:23:37.743	\N	alexandria-hess
1770	4e63cb5d-4fce-441b-b9e4-dc6a467cf2fd	2020-08-09 07:23:37.743	\N	axel-campbell
1771	5915b7bb-e532-4036-9009-79f1e80c0e28	2020-08-09 07:23:37.743	\N	rosa-holloway
1772	62111c49-1521-4ca7-8678-cd45dacf0858	2020-08-09 07:23:37.743	\N	bambi-perez
1773	7afedcd8-870d-4655-9659-3bdfb2e17730	2020-08-09 07:23:37.743	\N	pierre-haley
1774	7e160e9f-2c79-4e08-8b76-b816de388a98	2020-08-09 07:23:37.743	\N	thomas-marsh
1775	7f379b72-f4f0-4d8f-b88b-63211cf50ba6	2020-08-02 10:22:50.243	2020-08-09 07:23:37.743	jesus-rodriguez
1776	7f379b72-f4f0-4d8f-b88b-63211cf50ba6	2020-08-09 07:23:37.743	\N	jesus-rodriguez
1777	542af915-79c5-431c-a271-f7185e37c6ae	2020-08-09 07:23:37.743	2020-08-30 19:18:23.156	oliver-notarobot
1778	32810dca-825c-4dbc-8b65-0702794c424e	2020-08-09 07:23:37.743	2020-09-06 19:06:14.626	eduardo-woodman
1779	26cfccf2-850e-43eb-b085-ff73ad0749b8	2020-08-09 07:23:37.743	2020-09-06 19:06:14.626	beasley-day
1780	667cb445-c288-4e62-b603-27291c1e475d	2020-08-09 07:23:37.743	2020-09-06 19:06:14.626	peanut-holloway
1781	7e9a514a-7850-4ed0-93ab-f3a6e2f41c03	2020-08-09 07:23:37.743	2020-09-06 19:06:14.626	nolanestophia-patterson
1782	60026a9d-fc9a-4f5a-94fd-2225398fa3da	2020-08-09 07:23:37.743	2020-09-06 19:06:14.626	bright-zimmerman
1783	80dff591-2393-448a-8d88-122bd424fa4c	2020-08-09 07:23:37.743	2020-09-06 19:06:14.626	elvis-figueroa
1784	4ecee7be-93e4-4f04-b114-6b333e0e6408	2020-08-09 07:23:37.743	2020-09-06 19:06:15.653	sutton-dreamy
1785	7dcf6902-632f-48c5-936a-7cf88802b93a	2020-08-09 07:23:37.743	2020-09-06 19:06:15.653	parker-parra
1786	814bae61-071a-449b-981e-e7afc839d6d6	2020-08-03 05:23:56.421	2020-08-09 07:23:37.743	ruslan-greatness
1787	906a5728-5454-44a0-adfe-fd8be15b8d9b	2020-08-09 07:23:37.743	\N	jefferson-delacruz
1788	90cc0211-cd04-4cac-bdac-646c792773fc	2020-08-09 07:23:37.743	\N	case-lancaster
1789	97dfc1f6-ac94-4cdc-b0d5-1cb9f8984aa5	2020-08-02 21:23:43.024	2020-08-09 07:23:37.743	brock-forbes
1790	a7b0bef3-ee3c-42d4-9e6d-683cd9f5ed84	2020-08-09 07:23:37.743	\N	haruta-byrd
1791	b85161da-7f4c-42a8-b7f6-19789cf6861d	2020-08-09 07:23:37.743	\N	javier-lotus
1792	cd5494b4-05d0-4b2e-8578-357f0923ff4c	2020-08-09 07:23:37.743	\N	mcfarland-vargas
1796	817dee99-9ccf-4f41-84e3-dc9773237bc8	2020-08-09 07:23:37.743	2020-08-30 19:18:18.939	holden-stanton
1797	9786b2c9-1205-4718-b0f7-fc000ce91106	2020-08-09 07:23:37.743	2020-08-30 19:18:22.136	kevin-dudley
1798	b082ca6e-eb11-4eab-8d6a-30f8be522ec4	2020-08-09 07:23:37.743	2020-09-06 19:06:14.626	nicholas-mora
1799	814bae61-071a-449b-981e-e7afc839d6d6	2020-08-09 07:23:37.743	2020-09-06 19:06:14.626	ruslan-greatness
1800	84a2b5f6-4955-4007-9299-3d35ae7135d3	2020-08-09 07:23:37.743	2020-09-06 19:06:15.653	kennedy-loser
1801	97dfc1f6-ac94-4cdc-b0d5-1cb9f8984aa5	2020-08-09 07:23:37.743	2020-09-06 19:06:15.653	brock-forbes
1802	d0d7b8fe-bad8-481f-978e-cb659304ed49	2020-08-09 07:23:37.743	2020-09-06 19:06:15.653	adalberto-tosser
1803	d8bc482e-9309-4230-abcb-2c5a6412446d	2020-08-09 07:23:37.743	\N	august-obrien
1804	dd6ba7f1-a97a-4374-a3a7-b3596e286bb3	2020-08-09 07:23:37.743	\N	matheo-tanaka
1805	dd8a43a4-a024-44e9-a522-785d998b29c3	2020-08-09 07:23:37.743	\N	miguel-peterson
1806	e1e33aab-df8c-4f53-b30a-ca1cea9f046e	2020-08-09 07:23:37.743	\N	joyner-rugrat
1807	f8c20693-f439-4a29-a421-05ed92749f10	2020-08-09 07:23:37.743	\N	combs-duende
1808	088884af-f38d-4914-9d67-b319287481b4	2020-08-09 07:23:37.896	\N	liam-petty
1809	094ad9a1-e2c7-49a0-af18-da0e3eb656ba	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	erickson-sato
1810	094ad9a1-e2c7-49a0-af18-da0e3eb656ba	2020-08-09 07:23:37.896	\N	erickson-sato
1811	14bfad43-2638-41ec-8964-8351f22e9c4f	2020-08-09 07:23:37.896	\N	baby-sliders
1812	1750de38-8f5f-426a-9e23-2899a15a2031	2020-08-09 07:23:37.896	\N	kline-nightmare
1813	190a0f31-d686-4ac4-a7f3-cfc87b72c145	2020-08-09 07:23:37.896	\N	nerd-pacheco
1814	19af0d67-c73b-4ef2-bc84-e923c1336db5	2020-08-09 07:23:37.896	\N	grit-ramos
1815	206bd649-4f5f-4707-ad85-92784be4eb95	2020-08-09 07:23:37.896	\N	newton-underbuck
1816	20fd71e7-4fa0-4132-9f47-06a314ed539a	2020-08-09 07:23:37.896	\N	lars-taylor
1817	d35ccee1-9559-49a1-aaa4-7809f7b5c46e	2020-08-09 07:23:37.743	2020-09-06 19:06:15.653	forrest-best
1818	f70dd57b-55c4-4a62-a5ea-7cc4bf9d8ac1	2020-08-09 07:23:37.743	2020-09-06 19:06:15.653	tillman-henderson
1819	089af518-e27c-4256-adc8-62e3f4b30f43	2020-08-09 07:23:37.896	2020-09-06 19:06:16.157	silvia-rugrat
1820	2b5f5dd7-e31f-4829-bec5-546652103bc0	2020-08-09 07:23:37.896	\N	dudley-mueller
1821	333067fd-c2b4-4045-a9a4-e87a8d0332d0	2020-08-09 07:23:37.896	\N	miguel-james
1822	3d3be7b8-1cbf-450d-8503-fce0daf46cbf	2020-08-09 07:23:37.896	\N	zack-sanders
1823	3dd85c20-a251-4903-8a3b-1b96941c07b7	2020-08-09 07:23:37.896	\N	tot-best
1824	4542f0b0-3409-4a4a-a9e1-e8e8e5d73fcf	2020-08-09 07:23:37.896	\N	brock-watson
1825	4562ac1f-026c-472c-b4e9-ee6ff800d701	2020-08-09 07:23:37.896	\N	chris-koch
1826	459f7700-521e-40da-9483-4d111119d659	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	comfort-monreal
1827	459f7700-521e-40da-9483-4d111119d659	2020-08-09 07:23:37.896	\N	comfort-monreal
1828	5703141c-25d9-46d0-b680-0cf9cfbf4777	2020-08-09 07:23:37.896	\N	sandoval-crossing
1829	6644d767-ab15-4528-a4ce-ae1f8aadb65f	2020-08-09 07:23:37.896	\N	paula-reddick
1830	6bd4cf6e-fefe-499a-aa7a-890bcc7b53fa	2020-08-02 21:23:43.264	2020-08-09 07:23:37.896	igneus-mcdaniel
1831	6bd4cf6e-fefe-499a-aa7a-890bcc7b53fa	2020-08-09 07:23:37.896	\N	igneus-mcdaniel
1832	4f69e8c2-b2a1-4e98-996a-ccf35ac844c5	2020-08-09 07:23:37.896	2020-08-30 19:18:23.664	igneus-delacruz
1833	65273615-22d5-4df1-9a73-707b23e828d5	2020-08-09 07:23:37.896	2020-08-30 19:18:24.173	burke-gonzales
1834	2b9f9c25-43ec-4f0b-9937-a5aa23be0d9e	2020-08-09 07:23:37.896	2020-09-06 19:06:16.157	lawrence-horne
1835	4204c2d1-ca48-4af7-b827-e99907f12d61	2020-08-09 07:23:37.896	2020-09-06 19:06:16.157	axel-cardenas
1836	316abea7-9890-4fb8-aaea-86b35e24d9be	2020-08-09 07:23:37.896	2020-09-06 19:06:16.157	kennedy-rodgers
1837	7951836f-581a-49d5-ae2f-049c6bcc575e	2020-08-09 07:23:37.896	\N	adkins-gwiffin
1838	8b0d717f-ae42-4492-b2ed-106912e2b530	2020-08-09 07:23:37.896	\N	avila-baker
1839	aa7ac9cb-e9db-4313-9941-9f3431728dce	2020-08-09 07:23:37.896	\N	matteo-cash
1840	b69aa26f-71f7-4e17-bc36-49c875872cc1	2020-08-09 07:23:37.896	\N	francisca-burton
1841	c9e4a49e-e35a-4034-a4c7-293896b40c58	2020-08-09 07:23:37.896	\N	alexander-horne
1842	ca709205-226d-4d92-8be6-5f7871f48e26	2020-08-09 07:23:37.896	\N	rivers-javier
1843	cd68d3a6-7fbc-445d-90f1-970c955e32f4	2020-08-02 10:22:51.036	2020-08-09 07:23:37.896	miguel-wheeler
1844	ceac785e-55fd-4a4e-9bc8-17a662a58a38	2020-08-09 07:23:37.896	\N	best-cerna
1845	8604e861-d784-43f0-b0f8-0d43ea6f7814	2020-08-09 07:23:37.896	2020-08-30 19:18:23.664	randall-marijuana
1846	89f74891-2e25-4b5a-bd99-c95ba3f36aa0	2020-08-09 07:23:37.896	2020-08-30 19:18:23.664	nagomi-nava
1847	bd8d58b6-f37f-48e6-9919-8e14ec91f92a	2020-08-09 07:23:37.896	2020-08-30 19:18:24.173	jose-haley
1848	b7267aba-6114-4d53-a519-bf6c99f4e3a9	2020-08-09 07:23:37.896	2020-09-06 19:06:16.157	sosa-hayes
1849	bd8778e5-02e8-4d1f-9c31-7b63942cc570	2020-08-09 07:23:37.896	2020-09-06 19:06:16.157	cell-barajas
1850	ce0e57a7-89f5-41ea-80f9-6e649dd54089	2020-08-09 07:23:37.896	2020-09-06 19:06:16.157	yong-wright
1851	cd68d3a6-7fbc-445d-90f1-970c955e32f4	2020-08-09 07:23:37.896	2020-09-06 19:06:16.157	miguel-wheeler
1852	ad1e670a-f346-4bf7-a02f-a91649c41ccb	2020-08-09 07:23:37.896	2020-09-06 19:06:16.157	stephanie-winters
1853	7007cbd3-7c7b-44fd-9d6b-393e82b1c06e	2020-08-09 07:23:37.896	2020-09-06 19:06:16.157	rafael-davids
1854	e3c06405-0564-47ce-bbbd-552bee4dd66f	2020-08-09 07:23:37.896	\N	scrap-weeks
1855	e919dfae-91c3-475c-b5d5-8b0c14940c41	2020-08-09 07:23:37.896	\N	famous-meng
1856	f4ca437c-c31c-4508-afe7-6dae4330d717	2020-08-09 07:23:37.896	\N	fran-beans
1857	f56657d3-3bdc-4840-a20c-91aca9cc360e	2020-08-09 07:23:37.896	\N	malik-romayne
1858	f883269f-117e-45ec-bb1e-fa8dbcf40d3e	2020-08-09 07:23:37.896	\N	jayden-wright
1859	04f955fe-9cc9-4482-a4d2-07fe033b59ee	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	zane-vapor
1860	04f955fe-9cc9-4482-a4d2-07fe033b59ee	2020-08-09 07:23:38.05	\N	zane-vapor
1861	083d09d4-7ed3-4100-b021-8fbe30dd43e8	2020-08-03 04:23:53.763	2020-08-09 07:23:38.05	jessica-telephone
1862	24cb35c1-c24c-45ca-ac0b-f99a2e650d89	2020-08-09 07:23:38.05	\N	tyreek-peterson
1863	2727215d-3714-438d-b1ba-2ed15ec481c0	2020-08-09 07:23:38.05	\N	dominic-woman
1864	1f145436-b25d-49b9-a1e3-2d3c91626211	2020-08-09 07:23:38.05	2020-08-09 19:27:45.1	joe-voorhees
1865	25f3a67c-4ed5-45b6-94b1-ce468d3ead21	2020-08-09 07:23:38.05	2020-08-09 19:27:45.1	hobbs-cain
1866	083d09d4-7ed3-4100-b021-8fbe30dd43e8	2020-08-09 07:23:38.05	2020-08-25 04:20:30.968	jessica-telephone
1867	df4da81a-917b-434f-b309-f00423ee4967	2020-08-09 07:23:37.896	2020-08-30 19:18:23.664	eugenia-bickle
1868	e4f1f358-ee1f-4466-863e-f329766279d0	2020-08-09 07:23:37.896	2020-08-30 19:18:24.173	ronan-combs
1869	2720559e-9173-4042-aaa0-d3852b72ab2e	2020-08-09 07:23:38.05	2020-08-30 19:18:24.173	hiroto-wilcox
1870	f2468055-e880-40bf-8ac6-a0763d846eb2	2020-08-09 07:23:37.896	2020-09-08 14:33:57.869	alaynabella-hollywood
1871	27faa5a7-d3a8-4d2d-8e62-47cfeba74ff0	2020-08-09 07:23:38.05	\N	spears-nolan
1872	338694b7-6256-4724-86b6-3884299a5d9e	2020-08-09 07:23:38.05	\N	polkadot-patterson
1873	37efef78-2df4-4c76-800c-43d4faf07737	2020-08-09 07:23:38.05	\N	lenix-ren
1874	3ebb5361-3895-4a50-801e-e7a0ee61750c	2020-08-09 07:23:38.05	\N	augusto-reddick
1875	51cba429-13e8-487e-9568-847b7b8b9ac5	2020-08-09 07:23:38.05	\N	collins-mina
1876	58fca5fa-e559-4f5e-ac87-dc99dd19e410	2020-08-09 07:23:38.05	\N	sullivan-septemberish
1877	5fc4713c-45e1-4593-a968-7defeb00a0d4	2020-08-09 07:23:38.05	\N	percival-bendie
1878	64f59d5f-8740-4ebf-91bd-d7697b542a9f	2020-08-09 07:23:38.05	\N	zeke-wallace
1879	6524e9e0-828a-46c4-935d-0ee2edeb7e9a	2020-08-09 07:23:38.05	\N	carter-turnip
1880	695daf02-113d-4e76-b802-0862df16afbd	2020-08-09 07:23:38.05	\N	pacheco-weeks
1881	6e744b21-c4fa-4fa8-b4ea-e0e97f68ded5	2020-08-09 07:23:38.05	\N	daniel-koch
1882	70ccff1e-6b53-40e2-8844-0a28621cb33e	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	moody-cookbook
1883	77a41c29-8abd-4456-b6e0-a034252700d2	2020-08-09 07:23:38.05	\N	elip-dean
1884	5ff66eae-7111-4e3b-a9b8-a9579165b0a5	2020-08-09 07:23:38.05	2020-08-30 19:18:24.173	peanutiel-duffy
1885	70ccff1e-6b53-40e2-8844-0a28621cb33e	2020-08-09 07:23:38.05	2020-08-30 19:18:24.173	moody-cookbook
1886	32c9bce6-6e52-40fa-9f64-3629b3d026a8	2020-08-09 07:23:38.05	2020-08-30 19:18:24.173	ren-morin
1887	2e86de11-a2dd-4b28-b5fe-f4d0c38cd20b	2020-08-09 07:23:38.05	2020-08-30 19:18:24.173	zion-aliciakeyes
1888	7853aa8c-e86d-4483-927d-c1d14ea3a34d	2020-08-09 07:23:38.05	\N	tucker-flores
1889	7cf83bdc-f95f-49d3-b716-06f2cf60a78d	2020-08-09 07:23:38.05	\N	matteo-urlacher
1890	8f11ad58-e0b9-465c-9442-f46991274557	2020-08-09 07:23:38.05	\N	amos-melon
1891	9ba361a1-16d5-4f30-b590-fc4fc2fb53d2	2020-08-09 07:23:38.05	\N	mooney-doctor
1892	a73427b3-e96a-4156-a9ab-844edc696fed	2020-08-02 10:22:51.488	2020-08-09 07:23:38.05	wesley-vodka
1893	a73427b3-e96a-4156-a9ab-844edc696fed	2020-08-09 07:23:38.05	\N	wesley-vodka
1894	c3b1b4e5-4b88-4245-b2b1-ae3ade57349e	2020-08-09 07:23:38.05	\N	wall-osborn
1895	90768354-957e-4b4c-bb6d-eab6bbda0ba3	2020-08-09 07:23:38.05	2020-08-09 19:27:45.1	eugenia-garbage
1896	9be56060-3b01-47aa-a090-d072ef109fbf	2020-08-09 07:23:38.05	2020-08-09 19:27:45.1	jesus-koch
1897	9f85676a-7411-444a-8ae2-c7f8f73c285c	2020-08-09 07:23:38.05	2020-08-09 19:27:45.1	lachlan-shelton
1898	afc90398-b891-4cdf-9dea-af8a3a79d793	2020-08-09 07:23:38.05	2020-08-09 19:27:45.1	yazmin-mason
1899	80de2b05-e0d4-4d33-9297-9951b2b5c950	2020-08-09 07:23:38.05	2020-08-30 19:18:22.658	alyssa-harrell
1900	a691f2ba-9b69-41f8-892c-1acd42c336e4	2020-08-09 07:23:38.05	2020-08-30 19:18:23.664	jenkins-good
1901	7932c7c7-babb-4245-b9f5-cdadb97c99fb	2020-08-09 07:23:38.05	2020-08-30 19:18:24.173	randy-castillo
1902	9abe02fb-2b5a-432f-b0af-176be6bd62cf	2020-08-09 07:23:38.05	2020-08-30 19:18:24.173	nagomi-meng
1903	7aeb8e0b-f6fb-4a9e-bba2-335dada5f0a3	2020-08-09 07:23:38.05	2020-08-30 19:18:24.173	dunlap-figueroa
1904	b3e512df-c411-4100-9544-0ceadddb28cf	2020-08-09 07:23:38.05	2020-08-30 19:18:24.173	famous-owens
1905	c57222fd-df55-464c-a44e-b15443e61b70	2020-08-09 07:23:38.05	\N	natha-spruce
1906	ceb5606d-ea3f-4471-9ca7-3d2e71a50dde	2020-08-09 07:23:38.05	\N	london-simmons
1907	db3ff6f0-1045-4223-b3a8-a016ca987af9	2020-08-09 07:23:38.05	\N	murphy-thibault
1908	e6502bc7-5b76-4939-9fb8-132057390b30	2020-08-09 07:23:38.05	\N	greer-lott
1909	07ac91e9-0269-4e2c-a62d-a87ef61e3bbe	2020-08-09 07:23:38.236	\N	eduardo-perez
1910	0daf04fc-8d0d-4513-8e98-4f610616453b	2020-08-09 07:23:38.236	\N	lee-mist
1911	0eddd056-9d72-4804-bd60-53144b785d5c	2020-08-03 02:23:50.577	2020-08-09 07:23:38.236	caleb-novak
1912	1aec2c01-b766-4018-a271-419e5371bc8f	2020-08-09 07:23:38.236	\N	rush-ito
1913	d1a7c13f-8e78-4d2e-9cae-ebf3a5fcdb5d	2020-08-09 07:23:38.05	2020-08-09 19:27:45.1	elijah-bates
1914	0eddd056-9d72-4804-bd60-53144b785d5c	2020-08-09 07:23:38.236	2020-08-09 19:27:45.771	caleb-novak
1915	12577256-bc4e-4955-81d6-b422d895fb12	2020-08-09 07:23:38.236	2020-08-09 19:27:45.771	jasmine-washington
1916	2ca0c790-e1d5-4a14-ab3c-e9241c87fc23	2020-08-09 07:23:38.236	2020-08-09 19:27:45.771	murray-pony
1917	0cc5bd39-e90d-42f9-9dd8-7e703f316436	2020-08-09 07:23:38.236	2020-08-30 19:18:18.412	don-elliott
1918	20be1c34-071d-40c6-8824-dde2af184b4d	2020-08-09 07:23:38.236	2020-08-30 19:18:18.412	qais-dogwalker
1919	285ce77d-e5cd-4daa-9784-801347140d48	2020-08-09 07:23:38.236	2020-08-30 19:18:18.412	son-scotch
1920	d89da2d2-674c-4b85-8959-a4bd406f760a	2020-08-09 07:23:38.05	2020-08-30 19:18:24.173	fish-summer
1921	d8742d68-8fce-4d52-9a49-f4e33bd2a6fc	2020-08-09 07:23:38.05	2020-09-08 05:12:37.473	ortiz-morse
1922	30218684-7fa1-41a5-a3b3-5d9cd97dd36b	2020-08-02 10:22:51.755	2020-08-09 07:23:38.236	jordan-hildebert
1923	4aa843a4-baa1-4f35-8748-63aa82bd0e03	2020-08-09 07:23:38.236	\N	aureliano-dollie
1924	57b4827b-26b0-4384-a431-9f63f715bc5b	2020-08-02 21:23:43.721	2020-08-09 07:23:38.236	aureliano-cerna
1925	57b4827b-26b0-4384-a431-9f63f715bc5b	2020-08-09 07:23:38.236	\N	aureliano-cerna
1926	68462bfa-9006-4637-8830-2e7840d9089a	2020-08-09 07:23:38.236	\N	parker-horseman
1927	6bac62ad-7117-4e41-80f9-5a155a434856	2020-08-09 07:23:38.236	\N	grit-freeman
1928	7dca7137-b872-46f5-8e59-8c9c996e9d22	2020-08-02 10:22:51.755	2020-08-09 07:23:38.236	emmett-tabby
1929	7dca7137-b872-46f5-8e59-8c9c996e9d22	2020-08-09 07:23:38.236	\N	emmett-tabby
1930	7fed72df-87de-407d-8253-2295a2b60d3b	2020-08-09 07:23:38.236	\N	stout-schmitt
1931	889c9ef9-d521-4436-b41c-9021b81b4dfb	2020-08-09 07:23:38.236	\N	liam-snail
1932	32551e28-3a40-47ae-aed1-ff5bc66be879	2020-08-09 07:23:38.236	2020-08-30 19:18:18.412	math-velazquez
1933	3a8c52d7-4124-4a65-a20d-d51abcbe6540	2020-08-09 07:23:38.236	2020-08-30 19:18:18.412	theodore-holloway
1934	30218684-7fa1-41a5-a3b3-5d9cd97dd36b	2020-08-09 07:23:38.236	2020-08-30 19:18:18.412	jordan-hildebert
1935	8903a74f-f322-41d2-bd75-dbf7563c4abb	2020-08-09 07:23:38.236	2020-08-30 19:18:18.412	francisca-sasquatch
1936	503a235f-9fa6-41b5-8514-9475c944273f	2020-08-09 07:23:38.236	2020-08-30 19:18:18.412	reese-clark
1937	8ecea7e0-b1fb-4b74-8c8c-3271cb54f659	2020-08-09 07:23:38.236	2020-08-30 19:18:18.412	fitzgerald-blackburn
1938	446a3366-3fe3-41bb-bfdd-d8717f2152a9	2020-08-09 07:23:38.236	2020-08-30 19:18:18.412	marco-escobar
1939	97981e86-4a42-4f85-8783-9f29833c192b	2020-08-09 07:23:38.236	\N	daiya-vine
1940	97ec5a2f-ac1a-4cde-86b7-897c030a1fa8	2020-08-09 07:23:38.236	\N	alston-woods
1941	9820f2c5-f9da-4a07-b610-c2dd7bee2ef6	2020-08-03 04:23:54.117	2020-08-09 07:23:38.236	peanut-bong
1942	a8530be5-8923-4f74-9675-bf8a1a8f7878	2020-08-09 07:23:38.236	\N	mohammed-picklestein
1943	b019fb2b-9f4b-4deb-bf78-6bee2f16d98d	2020-08-09 07:23:38.236	\N	gloria-bentley
1944	b7adbbcc-0679-43f3-a939-07f009a393db	2020-08-09 07:23:38.236	\N	jode-crutch
1945	b7c1ddda-945c-4b2e-8831-ad9f2ec4a608	2020-08-09 07:23:38.236	\N	nolan-violet
1946	b7c4f986-e62a-4a8f-b5f0-8f30ecc35c5d	2020-08-09 07:23:38.236	\N	oscar-hollywood
1947	c4418663-7aa4-4c9f-ae73-0e81e442e8a2	2020-08-09 07:23:38.236	\N	chris-thibault
1948	d5192d95-a547-498a-b4ea-6770dde4b9f5	2020-08-09 07:23:38.236	\N	summers-slugger
1949	bbf9543f-f100-445a-a467-81d7aab12236	2020-08-09 07:23:38.236	2020-08-09 19:27:45.771	farrell-seagull
1950	c22e3af5-9001-465f-b450-864d7db2b4a0	2020-08-09 07:23:38.236	2020-08-09 19:27:45.771	logan-horseman
1951	af6b3edc-ed52-4edc-b0c9-14e0a5ae0ee3	2020-08-09 07:23:38.236	2020-08-12 20:25:34.726	rivers-clembons
1952	d2d76815-cbdc-4c4b-9c9e-32ebf2297cc7	2020-08-09 07:23:38.236	2020-08-30 19:18:18.412	denzel-scott
1953	ceb8f8cd-80b2-47f0-b43e-4d885fa48aa4	2020-08-09 07:23:38.236	2020-08-30 19:18:18.412	donia-bailey
1954	9820f2c5-f9da-4a07-b610-c2dd7bee2ef6	2020-08-09 07:23:38.236	2020-08-30 19:18:18.412	peanut-bong
1955	e111a46d-5ada-4311-ac4f-175cca3357da	2020-08-09 07:23:38.236	2020-08-30 19:18:18.412	alexandria-rosales
1956	e972984c-2895-451c-b518-f06a0d8bd375	2020-08-09 07:23:38.236	\N	becker-solis
1957	ecb8d2f5-4ff5-4890-9693-5654e00055f6	2020-08-02 21:23:43.721	2020-08-09 07:23:38.236	yeongho-benitez
1958	fa477c92-39b6-4a52-b065-40af2f29840a	2020-08-08 22:20:16.478	2020-08-09 07:23:38.236	howell-franklin
1959	fcbe1d14-04c4-4331-97ad-46e170610633	2020-08-02 10:22:51.755	2020-08-09 07:23:38.236	jode-preston
1960	fcbe1d14-04c4-4331-97ad-46e170610633	2020-08-09 07:23:38.236	\N	jode-preston
1961	061b209a-9cda-44e8-88ce-6a4a37251970	2020-08-09 07:23:38.432	\N	mcdowell-karim
1962	16a59f5f-ef0f-4ada-8682-891ad571a0b6	2020-08-09 07:23:38.432	\N	boyfriend-berger
1963	1c73f91e-0562-480d-9543-2aab1d5e5acd	2020-08-09 07:23:38.432	\N	sparks-beans
1964	3de17e21-17db-4a6b-b7ab-0b2f3c154f42	2020-08-09 07:23:38.432	\N	brewer-vapor
1965	0f61d948-4f0c-4550-8410-ae1c7f9f5613	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	tamara-crankit
1966	1068f44b-34a0-42d8-a92e-2be748681a6f	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	allison-abbott
1967	1301ee81-406e-43d9-b2bb-55ca6e0f7765	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	malik-destiny
1968	41949d4d-b151-4f46-8bf7-73119a48fac8	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	ron-monstera
1969	f38c5d80-093f-46eb-99d6-942aa45cd921	2020-08-09 07:23:38.236	2020-08-30 19:18:18.412	andrew-solis
1970	ef9f8b95-9e73-49cd-be54-60f84858a285	2020-08-09 07:23:38.236	2020-08-30 19:18:18.412	collins-melon
1971	fa477c92-39b6-4a52-b065-40af2f29840a	2020-08-09 07:23:38.236	2020-08-30 19:18:18.412	howell-franklin
1972	ecb8d2f5-4ff5-4890-9693-5654e00055f6	2020-08-09 07:23:38.236	2020-09-06 19:06:14.626	yeongho-benitez
1973	4ed61b18-c1f6-4d71-aea3-caac01470b5c	2020-08-09 07:23:38.432	\N	lenny-marijuana
1974	52cfebfb-8008-4b9f-a566-72a30e0b64bf	2020-08-02 10:22:51.881	2020-08-09 07:23:38.432	spears-rogers
1975	52cfebfb-8008-4b9f-a566-72a30e0b64bf	2020-08-09 07:23:38.432	\N	spears-rogers
1976	5fbf04bb-f5ec-4589-ab19-1d89cda056bd	2020-08-09 07:23:38.432	\N	donia-dollie
1977	6c346d8b-d186-4228-9adb-ae919d7131dd	2020-08-06 01:22:07.991	2020-08-09 07:23:38.432	greer-gwiffin
1978	864b3be8-e836-426e-ae56-20345b41d03d	2020-08-09 07:23:38.432	\N	goodwin-morin
1979	a3947fbc-50ec-45a4-bca4-49ffebb77dbe	2020-08-09 07:23:38.432	\N	chorby-short
1980	4f328502-d347-4d2c-8fad-6ae59431d781	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	stephens-lightner
1981	678170e4-0688-436d-a02d-c0467f9af8c0	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	baby-doyle
1982	6c346d8b-d186-4228-9adb-ae919d7131dd	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	greer-gwiffin
1983	6f9de777-e812-4c84-915c-ef283c9f0cde	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	arturo-huerta
1984	8b53ce82-4b1a-48f0-999d-1774b3719202	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	oliver-mueller
1985	8cf78b49-d0ca-4703-88e8-4bcad26c44b1	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	avila-guzman
1986	90c2cec7-0ed5-426a-9de8-754f34d59b39	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	tot-fox
1987	9c3273a0-2711-4958-b716-bfcf60857013	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	kathy-mathews
1988	b348c037-eefc-4b81-8edd-dfa96188a97e	2020-08-09 07:23:38.432	2020-08-30 19:18:18.939	lowe-forbes
1989	ae81e172-801a-4236-929a-b990fc7190ce	2020-08-09 07:23:38.432	2020-08-30 19:18:18.939	august-sky
1990	b5c95dba-2624-41b0-aacd-ac3e1e1fe828	2020-08-09 07:23:38.432	\N	cote-rodgers
1991	b88d313f-e546-407e-8bc6-94040499daa5	2020-08-09 07:23:38.432	\N	oliver-loofah
1992	b9293beb-d199-4b46-add9-c02f9362d802	2020-08-02 10:22:51.881	2020-08-09 07:23:38.432	bauer-zimmerman
1993	b9293beb-d199-4b46-add9-c02f9362d802	2020-08-09 07:23:38.432	\N	bauer-zimmerman
1994	c6a277c3-d2b5-4363-839b-950896a5ec5e	2020-08-02 19:09:07.396	2020-08-09 07:23:38.432	mike-townsend
1995	ce58415f-4e62-47e2-a2c9-4d6a85961e1e	2020-08-09 07:23:38.432	\N	schneider-blanco
1996	dac2fd55-5686-465f-a1b6-6fbed0b417c5	2020-08-09 07:23:38.432	\N	russo-slugger
1997	dd0b48fe-2d49-4344-83ed-9f0770b370a8	2020-08-09 07:23:38.432	\N	tillman-wan
1998	e376a90b-7ffe-47a2-a934-f36d6806f17d	2020-08-09 07:23:38.432	\N	howell-rocha
1999	e3c514ae-f813-470e-9c91-d5baf5ffcf16	2020-08-03 04:23:54.25	2020-08-09 07:23:38.432	tot-clark
2000	c6a277c3-d2b5-4363-839b-950896a5ec5e	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	mike-townsend
2001	c6e2e389-ed04-4626-a5ba-fe398fe89568	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	henry-marshallow
2002	cf8e152e-2d27-4dcc-ba2b-68127de4e6a4	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	hendricks-richardson
2003	d8ee256f-e3d0-46cb-8c77-b1f88d8c9df9	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	comfort-septemberish
2004	da0bbbe6-d13c-40cc-9594-8c476975d93d	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	lang-richardson
2005	e3c514ae-f813-470e-9c91-d5baf5ffcf16	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	tot-clark
2006	bf122660-df52-4fc4-9e70-ee185423ff93	2020-08-09 07:23:38.432	2020-08-30 19:18:18.939	walton-sports
2007	ecf19925-dc57-4b89-b114-923d5a714dbe	2020-08-09 07:23:38.432	\N	margarito-bishop
2008	efa73de4-af17-4f88-99d6-d0d69ed1d200	2020-08-03 02:23:50.85	2020-08-09 07:23:38.432	antonio-mccall
2009	1f159bab-923a-4811-b6fa-02bfde50925a	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	wyatt-mason
2010	efa73de4-af17-4f88-99d6-d0d69ed1d200	2020-08-09 07:23:38.432	\N	antonio-mccall
2011	f10ba06e-d509-414b-90cd-4d70d43c75f9	2020-08-09 07:23:38.432	\N	hernando-winter
2012	f3ddfd87-73a2-4681-96fe-829476c97886	2020-08-02 10:22:51.881	2020-08-09 07:23:38.432	theodore-duende
2013	f4a5d734-0ade-4410-abb6-c0cd5a7a1c26	2020-08-02 21:23:43.84	2020-08-09 07:23:38.432	agan-harrison
2014	f6342729-a38a-4204-af8d-64b7accb5620	2020-08-09 07:23:38.432	\N	marco-winner
2015	f6b38e56-0d98-4e00-a96e-345aaac1e653	2020-08-09 07:23:38.432	\N	leticia-snyder
2016	f968532a-bf06-478e-89e0-3856b7f4b124	2020-08-09 07:23:38.432	\N	daniel-benedicte
2017	ea44bd36-65b4-4f3b-ac71-78d87a540b48	2020-08-09 07:23:36.435	2020-08-09 16:40:13.596	wanda-pothos
2018	24ad200d-a45f-4286-bfa5-48909f98a1f7	2020-08-09 07:23:38.236	2020-08-09 16:40:15.198	nicholas-summer
2019	24ad200d-a45f-4286-bfa5-48909f98a1f7	2020-08-09 16:40:15.198	\N	nicholas-summer
2020	e6114fd4-a11d-4f6c-b823-65691bb2d288	2020-08-09 07:23:38.432	2020-08-09 19:27:43.784	bevan-underbuck
2021	efafe75e-2f00-4418-914c-9b6675d39264	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	aldon-cashmoney
2022	f3ddfd87-73a2-4681-96fe-829476c97886	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	theodore-duende
2023	f3c07eaf-3d6c-4cc3-9e54-cbecc9c08286	2020-08-09 07:23:38.432	2020-08-30 19:18:18.939	campos-arias
2024	f4a5d734-0ade-4410-abb6-c0cd5a7a1c26	2020-08-09 07:23:38.432	2020-08-30 19:18:18.939	agan-harrison
2025	27c68d7f-5e40-4afa-8b6f-9df47b79e7dd	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	basilio-preston
2026	3db02423-92af-485f-b30f-78256721dcc6	2020-08-09 19:27:41.958	\N	son-jensen
2027	5149c919-48fe-45c6-b7ee-bb8e5828a095	2020-08-09 19:27:41.958	\N	adkins-davis
2028	6192daab-3318-44b5-953f-14d68cdb2722	2020-08-09 19:27:41.958	\N	justin-alstott
2029	63a31035-2e6d-4922-a3f9-fa6e659b54ad	2020-08-09 19:27:41.958	\N	moody-rodriguez
2030	75f9d874-5e69-438d-900d-a3fcb1d429b3	2020-08-09 07:23:36.435	2020-08-09 19:27:41.958	moses-simmons
2031	937c1a37-4b05-4dc5-a86d-d75226f8490a	2020-08-09 19:27:41.958	\N	pippin-carpenter
2032	d8758c1b-afbb-43a5-b00b-6004d419e2c5	2020-08-09 19:27:41.958	\N	ortiz-nelson
2033	dfe3bc1b-fca8-47eb-965f-6cf947c35447	2020-08-09 19:27:41.958	\N	linus-haley
2034	ea44bd36-65b4-4f3b-ac71-78d87a540b48	2020-08-09 16:40:13.596	2020-08-09 19:27:41.958	wanda-pothos
2035	f0594932-8ef7-4d70-9894-df4be64875d8	2020-08-09 19:27:41.958	\N	fitzgerald-wanderlust
2036	33fbfe23-37bd-4e37-a481-a87eadb8192d	2020-08-09 19:27:42.24	\N	whit-steakknife
2037	493a83de-6bcf-41a1-97dd-cc5e150548a3	2020-08-09 07:23:36.613	2020-08-09 19:27:42.24	boyfriend-monreal
2038	88cd6efa-dbf2-4309-aabe-ec1d6f21f98a	2020-08-09 07:23:36.613	2020-08-09 19:27:42.24	hewitt-best
2039	4b6f0a4e-de18-44ad-b497-03b1f470c43c	2020-08-09 19:27:42.24	2020-08-30 19:18:20.089	rodriguez-internet
2040	138fccc3-e66f-4b07-8327-d4b6f372f654	2020-08-09 19:27:42.24	2020-08-30 19:18:20.089	oscar-vaughan
2041	7663c3ca-40a1-4f13-a430-14637dce797a	2020-08-09 19:27:42.24	2020-08-30 19:18:20.089	polkadot-zavala
2042	64f4cd75-0c1e-42cf-9ff0-e41c4756f22a	2020-08-09 19:27:42.24	2020-09-06 19:06:12.368	grey-alvarado
2043	493a83de-6bcf-41a1-97dd-cc5e150548a3	2020-08-09 19:27:42.24	2020-09-06 19:06:12.368	boyfriend-monreal
2044	53e701c7-e3c8-4e18-ba05-9b41b4b64cda	2020-08-09 19:27:42.24	2020-09-06 19:06:12.368	marquez-clark
2045	c73d59dd-32a0-49ce-8ab4-b2dbb7dc94ec	2020-08-09 19:27:42.24	\N	eduardo-ingram
2046	f2a27a7e-bf04-4d31-86f5-16bfa3addbe7	2020-08-09 07:23:36.613	2020-08-09 19:27:42.24	winnie-hess
2047	43d5da5f-c6a1-42f1-ab7f-50ea956b6cd5	2020-08-09 07:23:36.831	2020-08-09 19:27:43.22	justice-spoon
2048	ad8d15f4-e041-4a12-a10e-901e6285fdc5	2020-08-09 07:23:36.831	2020-08-09 19:27:43.22	baby-urlacher
2049	a199a681-decf-4433-b6ab-5454450bbe5e	2020-08-09 19:27:42.24	2020-08-30 19:18:20.089	leach-ingram
2050	f2a27a7e-bf04-4d31-86f5-16bfa3addbe7	2020-08-09 19:27:42.24	2020-08-30 19:18:20.089	winnie-hess
2051	43d5da5f-c6a1-42f1-ab7f-50ea956b6cd5	2020-08-09 19:27:43.22	2020-08-30 19:18:21.602	justice-spoon
2052	88cd6efa-dbf2-4309-aabe-ec1d6f21f98a	2020-08-09 19:27:42.24	2020-09-06 19:06:12.368	hewitt-best
2053	b39b5aae-8571-4c90-887a-6a00f2a2f6fd	2020-08-09 19:27:42.24	2020-09-06 19:06:12.368	dickerson-morse
2054	cd417f8a-ce01-4ab2-921d-42e2e445bbe2	2020-08-09 19:27:42.24	2020-09-06 19:06:12.368	eizabeth-guerra
2055	ad8d15f4-e041-4a12-a10e-901e6285fdc5	2020-08-09 19:27:43.22	2020-09-06 19:06:17.18	baby-urlacher
2056	68f98a04-204f-4675-92a7-8823f2277075	2020-08-09 19:27:43.22	2020-09-06 19:06:17.18	isaac-johnson
2057	69196296-f652-42ff-b2ca-0d9b50bd9b7b	2020-08-09 19:27:43.22	2020-09-06 19:06:17.18	joshua-butt
2058	20e13b56-599b-4a22-b752-8059effc81dc	2020-08-09 19:27:43.22	2020-09-06 19:06:17.18	lou-roseheart
2059	1513aab6-142c-48c6-b43e-fbda65fd64e8	2020-08-09 19:27:43.22	2020-09-06 19:06:17.18	caleb-alvarado
2060	4bf352d2-6a57-420a-9d45-b23b2b947375	2020-08-09 19:27:43.22	2020-09-06 19:06:17.18	rivers-rosa
2061	16aff709-e855-47c8-8818-b9ba66e90fe8	2020-08-09 19:27:43.22	2020-09-06 19:06:17.18	mullen-peterson
2062	c0177f76-67fc-4316-b650-894159dede45	2020-08-09 19:27:43.22	\N	paula-mason
2063	c182f33c-aea5-48a2-97ed-dc74fa29b3c0	2020-08-09 07:23:36.831	2020-08-09 19:27:43.22	swamuel-mora
2064	e4e4c17d-8128-4704-9e04-f244d4573c4d	2020-08-09 07:23:36.831	2020-08-09 19:27:43.22	wesley-poole
2065	c0732e36-3731-4f1a-abdc-daa9563b6506	2020-08-09 07:23:37.02	2020-08-09 19:27:44.725	nagomi-mcdaniel
2066	020ed630-8bae-4441-95cc-0e4ecc27253b	2020-08-09 07:23:38.05	2020-08-09 19:27:45.1	simon-haley
2067	020ed630-8bae-4441-95cc-0e4ecc27253b	2020-08-09 19:27:45.1	\N	simon-haley
2068	25f3a67c-4ed5-45b6-94b1-ce468d3ead21	2020-08-09 19:27:45.1	\N	hobbs-cain
2069	8c8cc584-199b-4b76-b2cd-eaa9a74965e5	2020-08-09 07:23:38.05	2020-08-09 19:27:45.1	ziwa-mueller
2070	8c8cc584-199b-4b76-b2cd-eaa9a74965e5	2020-08-09 19:27:45.1	\N	ziwa-mueller
2071	90768354-957e-4b4c-bb6d-eab6bbda0ba3	2020-08-09 19:27:45.1	\N	eugenia-garbage
2072	e6114fd4-a11d-4f6c-b823-65691bb2d288	2020-08-09 19:27:43.784	2020-08-30 19:18:21.602	bevan-underbuck
2073	1f145436-b25d-49b9-a1e3-2d3c91626211	2020-08-09 19:27:45.1	2020-08-30 19:18:22.136	joe-voorhees
2074	9be56060-3b01-47aa-a090-d072ef109fbf	2020-08-09 19:27:45.1	2020-08-30 19:18:23.664	jesus-koch
2075	c0732e36-3731-4f1a-abdc-daa9563b6506	2020-08-09 19:27:44.725	2020-09-06 19:06:11.853	nagomi-mcdaniel
2076	e4e4c17d-8128-4704-9e04-f244d4573c4d	2020-08-09 19:27:43.22	2020-09-06 19:06:17.18	wesley-poole
2077	c182f33c-aea5-48a2-97ed-dc74fa29b3c0	2020-08-09 19:27:43.22	2020-09-06 19:06:17.18	swamuel-mora
2078	d4a10c2a-0c28-466a-9213-38ba3339b65e	2020-08-09 07:23:38.05	2020-08-09 19:27:45.1	richmond-harrison
2079	d1a7c13f-8e78-4d2e-9cae-ebf3a5fcdb5d	2020-08-09 19:27:45.1	\N	elijah-bates
2080	5a26fc61-d75d-4c01-9ce2-1880ffb5550f	2020-08-09 07:23:38.236	2020-08-09 19:27:45.771	randy-dennis
2081	a38ada0a-aeac-4a3d-b9a5-968687ccd2f9	2020-08-09 07:23:38.236	2020-08-09 19:27:45.771	sixpack-santiago
2082	f0bcf4bb-74b3-412e-a54c-04c12ad28ecb	2020-08-09 07:23:38.236	2020-08-09 19:27:45.771	hahn-fox
2083	5a26fc61-d75d-4c01-9ce2-1880ffb5550f	2020-08-09 19:27:45.771	2020-08-30 19:18:18.412	randy-dennis
2084	2ca0c790-e1d5-4a14-ab3c-e9241c87fc23	2020-08-09 19:27:45.771	2020-08-30 19:18:18.412	murray-pony
2085	c22e3af5-9001-465f-b450-864d7db2b4a0	2020-08-09 19:27:45.771	2020-08-30 19:18:18.412	logan-horseman
2086	f0bcf4bb-74b3-412e-a54c-04c12ad28ecb	2020-08-09 19:27:45.771	2020-08-30 19:18:18.412	hahn-fox
2087	2e6d4fa9-f930-47bd-971a-dd54a3cf7db1	2020-08-09 19:27:45.771	2020-08-30 19:18:18.412	raul-leal
2088	a38ada0a-aeac-4a3d-b9a5-968687ccd2f9	2020-08-09 19:27:45.771	2020-08-30 19:18:18.412	sixpack-santiago
2089	bbf9543f-f100-445a-a467-81d7aab12236	2020-08-09 19:27:45.771	2020-08-30 19:18:18.939	farrell-seagull
2090	1068f44b-34a0-42d8-a92e-2be748681a6f	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	allison-abbott
2091	0f61d948-4f0c-4550-8410-ae1c7f9f5613	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	tamara-crankit
2092	afc90398-b891-4cdf-9dea-af8a3a79d793	2020-08-09 19:27:45.1	2020-08-30 19:18:24.173	yazmin-mason
2093	d4a10c2a-0c28-466a-9213-38ba3339b65e	2020-08-09 19:27:45.1	2020-09-08 10:30:58.945	richmond-harrison
2094	9f85676a-7411-444a-8ae2-c7f8f73c285c	2020-08-09 19:27:45.1	2020-09-08 14:34:00.969	lachlan-shelton
2095	c31d874c-1b4d-40f2-a1b3-42542e934047	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	cedric-spliff
2096	425f3f84-bab0-4cf2-91c1-96e78cf5cd02	2020-08-09 07:23:38.432	2020-08-09 19:27:46.717	luis-acevedo
2097	8cf78b49-d0ca-4703-88e8-4bcad26c44b1	2020-08-09 19:27:46.717	2020-08-30 19:18:18.412	avila-guzman
2098	c6a277c3-d2b5-4363-839b-950896a5ec5e	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	mike-townsend
2099	1301ee81-406e-43d9-b2bb-55ca6e0f7765	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	malik-destiny
2100	425f3f84-bab0-4cf2-91c1-96e78cf5cd02	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	luis-acevedo
2101	c31d874c-1b4d-40f2-a1b3-42542e934047	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	cedric-spliff
2102	8b53ce82-4b1a-48f0-999d-1774b3719202	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	oliver-mueller
2103	6c346d8b-d186-4228-9adb-ae919d7131dd	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	greer-gwiffin
2104	6f9de777-e812-4c84-915c-ef283c9f0cde	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	arturo-huerta
2105	41949d4d-b151-4f46-8bf7-73119a48fac8	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	ron-monstera
2106	c6e2e389-ed04-4626-a5ba-fe398fe89568	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	henry-marshallow
2107	d8ee256f-e3d0-46cb-8c77-b1f88d8c9df9	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	comfort-septemberish
2108	cf8e152e-2d27-4dcc-ba2b-68127de4e6a4	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	hendricks-richardson
2109	678170e4-0688-436d-a02d-c0467f9af8c0	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	baby-doyle
2110	4f328502-d347-4d2c-8fad-6ae59431d781	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	stephens-lightner
2111	9c3273a0-2711-4958-b716-bfcf60857013	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	kathy-mathews
2112	80e474a3-7d2b-431d-8192-2f1e27162607	2020-08-09 07:23:37.896	2020-08-12 20:25:34.306	summers-preston
2113	87e6ae4b-67de-4973-aa56-0fc9835a1e1e	2020-08-12 20:25:33.308	2020-08-12 20:40:35.88	wyatts-mason
2114	87e6ae4b-67de-4973-aa56-0fc9835a1e1e	2020-08-12 20:40:35.88	\N	marco-stink
2115	af6b3edc-ed52-4edc-b0c9-14e0a5ae0ee3	2020-08-12 20:25:34.726	2020-08-12 20:40:37.281	wyatt-masons
2116	a1ed3396-114a-40bc-9ff0-54d7e1ad1718	2020-08-12 20:55:38.256	\N	patel-beyonce
2117	75f9d874-5e69-438d-900d-a3fcb1d429b3	2020-08-12 21:10:40.842	\N	moses-mason
2118	f3ddfd87-73a2-4681-96fe-829476c97886	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	theodore-duende
2119	da0bbbe6-d13c-40cc-9594-8c476975d93d	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	lang-richardson
2120	e3c514ae-f813-470e-9c91-d5baf5ffcf16	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	tot-clark
2121	efafe75e-2f00-4418-914c-9b6675d39264	2020-08-09 19:27:46.717	2020-08-30 19:18:18.939	aldon-cashmoney
2122	3af96a6b-866c-4b03-bc14-090acf6ecee5	2020-08-10 18:47:01.611	2020-08-30 20:18:56.326	axel-trololol
2123	e16c3f28-eecd-4571-be1a-606bbac36b2b	2020-08-12 20:55:38.256	2020-09-04 17:34:50.167	wyatt-glover
2124	80e474a3-7d2b-431d-8192-2f1e27162607	2020-08-12 20:40:36.879	2020-09-06 19:06:16.157	summers-preston
2125	27c68d7f-5e40-4afa-8b6f-9df47b79e7dd	2020-08-12 21:25:43.399	\N	basilio-mason
2126	f741dc01-2bae-4459-bfc0-f97536193eea	2020-08-12 21:25:43.399	\N	alejandro-leaf
2127	bf6a24d1-4e89-4790-a4ba-eeb2870cbf6f	2020-08-12 21:40:45.977	\N	rat-mason
2128	ea44bd36-65b4-4f3b-ac71-78d87a540b48	2020-08-12 21:40:45.977	\N	wyatt-pothos
2129	0d5300f6-0966-430f-903f-a4c2338abf00	2020-08-12 21:55:48.749	\N	wyatt-dovenpart
2130	63df8701-1871-4987-87d7-b55d4f1df2e9	2020-08-12 22:10:51.203	\N	mcdowell-mason
2131	e4034192-4dc6-4901-bb30-07fe3cf77b5e	2020-08-12 21:25:43.399	2020-08-12 22:10:51.203	wyatt-breadwinner
2132	46721a07-7cd2-4839-982e-7046df6e8b66	2020-08-25 05:21:09.031	2020-08-25 17:59:47.095	stew-briggs
2133	c755efce-d04d-4e00-b5c1-d801070d3808	2020-08-25 15:12:22.222	2020-08-25 17:59:47.095	basilio-fig
2134	c755efce-d04d-4e00-b5c1-d801070d3808	2020-08-25 17:59:47.095	\N	basilio-fig
2135	083d09d4-7ed3-4100-b021-8fbe30dd43e8	2020-08-25 04:20:30.968	2020-08-25 17:59:57.824	jessica-telephone
2136	e4034192-4dc6-4901-bb30-07fe3cf77b5e	2020-08-12 22:10:51.203	2020-08-28 15:19:34.297	baldwin-breadwinner
2137	0bb35615-63f2-4492-80ec-b6b322dc5450	2020-08-12 21:25:43.399	2020-08-30 19:18:19.465	sexton-wheerer
2138	46721a07-7cd2-4839-982e-7046df6e8b66	2020-08-25 17:59:47.095	2020-09-06 19:06:12.368	stew-briggs
2139	21d52455-6c2c-4ee4-8673-ab46b4b926b4	2020-08-12 21:25:43.399	2020-09-08 09:45:27.06	wyatt-owens
2140	0295c6c2-b33c-47dd-affa-349da7fa1760	2020-08-26 21:18:34.638	\N	combs-estes
2141	0295c6c2-b33c-47dd-affa-349da7fa1760	2020-08-26 17:15:07.862	2020-08-26 21:18:34.638	combs-estes
2142	c09e64b6-8248-407e-b3af-1931b880dbee	2020-08-26 22:19:32.777	2020-08-27 00:44:43.505	lenny-spruce
2143	18798b8f-6391-4cb2-8a5f-6fb540d646d5	2020-08-27 02:15:44.985	\N	morrow-doyle
2144	8cd06abf-be10-4a35-a3ab-1a408a329147	2020-08-27 02:15:44.985	2020-08-27 02:46:00.565	gloria-bugsnax
2145	8cd06abf-be10-4a35-a3ab-1a408a329147	2020-08-27 02:46:00.565	\N	gloria-bugsnax
2146	f9930cb1-7ed2-4b9a-bf4f-7e35f2586d71	2020-08-27 16:04:25.835	2020-08-28 00:40:18.752	finn-james
2149	e4034192-4dc6-4901-bb30-07fe3cf77b5e	2020-08-28 15:19:34.297	2020-08-28 19:54:23.418	baldwin-breadwinner
2150	3a96d76a-c508-45a0-94a0-8f64cd6beeb4	2020-08-09 07:23:37.02	2020-08-28 19:54:23.418	thomas-england
2151	3a96d76a-c508-45a0-94a0-8f64cd6beeb4	2020-08-28 19:54:23.418	2020-08-28 21:02:34.226	sixpack-dogwalker
2152	3a96d76a-c508-45a0-94a0-8f64cd6beeb4	2020-08-28 21:02:34.226	2020-08-30 07:25:59.724	sixpack-dogwalker
2153	083d09d4-7ed3-4100-b021-8fbe30dd43e8	2020-08-25 17:59:57.824	2020-08-30 07:26:00.713	jessica-telephone
2154	e4034192-4dc6-4901-bb30-07fe3cf77b5e	2020-08-28 19:54:23.418	2020-08-30 19:18:21.602	baldwin-breadwinner
2155	c09e64b6-8248-407e-b3af-1931b880dbee	2020-08-27 00:44:43.505	2020-09-06 19:06:12.368	lenny-spruce
2156	f9930cb1-7ed2-4b9a-bf4f-7e35f2586d71	2020-08-28 00:40:18.752	2020-09-06 19:06:15.653	finn-james
2157	90c2cec7-0ed5-426a-9de8-754f34d59b39	2020-08-09 19:27:46.717	2020-08-30 07:26:01.225	tot-fox
2158	28964497-0efe-420c-9c1d-8574f224a4e9	2020-08-29 06:24:33.303	2020-08-29 21:34:45.811	inez-owens
2159	f38c5d80-093f-46eb-99d6-942aa45cd921	2020-08-30 19:18:18.412	\N	andrew-solis
2160	d2d76815-cbdc-4c4b-9c9e-32ebf2297cc7	2020-08-30 19:18:18.412	\N	denzel-scott
2161	3a8c52d7-4124-4a65-a20d-d51abcbe6540	2020-08-30 19:18:18.412	\N	theodore-holloway
2162	30218684-7fa1-41a5-a3b3-5d9cd97dd36b	2020-08-30 19:18:18.412	\N	jordan-hildebert
2163	ceb8f8cd-80b2-47f0-b43e-4d885fa48aa4	2020-08-30 19:18:18.412	\N	donia-bailey
2164	0eddd056-9d72-4804-bd60-53144b785d5c	2020-08-09 19:27:45.771	2020-08-30 19:18:18.412	caleb-novak
2165	0eddd056-9d72-4804-bd60-53144b785d5c	2020-08-30 19:18:18.412	\N	caleb-novak
2166	5a26fc61-d75d-4c01-9ce2-1880ffb5550f	2020-08-30 19:18:18.412	\N	randy-dennis
2167	12577256-bc4e-4955-81d6-b422d895fb12	2020-08-09 19:27:45.771	2020-08-30 19:18:18.412	jasmine-washington
2168	3a96d76a-c508-45a0-94a0-8f64cd6beeb4	2020-08-30 07:25:59.724	2020-08-30 19:18:21.602	sixpack-dogwalker
2169	28964497-0efe-420c-9c1d-8574f224a4e9	2020-08-29 21:34:45.811	2020-08-30 19:18:22.136	inez-owens
2170	32551e28-3a40-47ae-aed1-ff5bc66be879	2020-08-30 19:18:18.412	2020-08-30 20:49:10.544	math-velazquez
2171	12577256-bc4e-4955-81d6-b422d895fb12	2020-08-30 19:18:18.412	2020-08-30 20:49:10.544	jasmine-washington
2172	083d09d4-7ed3-4100-b021-8fbe30dd43e8	2020-08-30 07:26:00.713	2020-09-06 19:06:14.626	jessica-telephone
2173	90c2cec7-0ed5-426a-9de8-754f34d59b39	2020-08-30 07:26:01.225	2020-09-06 19:06:15.653	tot-fox
2174	c22e3af5-9001-465f-b450-864d7db2b4a0	2020-08-30 19:18:18.412	\N	logan-horseman
2175	2ca0c790-e1d5-4a14-ab3c-e9241c87fc23	2020-08-30 19:18:18.412	\N	murray-pony
2176	f0bcf4bb-74b3-412e-a54c-04c12ad28ecb	2020-08-30 19:18:18.412	\N	hahn-fox
2177	2e6d4fa9-f930-47bd-971a-dd54a3cf7db1	2020-08-30 19:18:18.412	\N	raul-leal
2178	af6b3edc-ed52-4edc-b0c9-14e0a5ae0ee3	2020-08-12 20:40:37.281	2020-08-30 19:18:18.412	rivers-clembons
2179	9820f2c5-f9da-4a07-b610-c2dd7bee2ef6	2020-08-30 19:18:18.412	\N	peanut-bong
2180	0cc5bd39-e90d-42f9-9dd8-7e703f316436	2020-08-30 19:18:18.412	\N	don-elliott
2181	20be1c34-071d-40c6-8824-dde2af184b4d	2020-08-30 19:18:18.412	\N	qais-dogwalker
2182	a38ada0a-aeac-4a3d-b9a5-968687ccd2f9	2020-08-30 19:18:18.412	\N	sixpack-santiago
2183	8cf78b49-d0ca-4703-88e8-4bcad26c44b1	2020-08-30 19:18:18.412	\N	avila-guzman
2184	503a235f-9fa6-41b5-8514-9475c944273f	2020-08-30 19:18:18.412	\N	reese-clark
2185	8ecea7e0-b1fb-4b74-8c8c-3271cb54f659	2020-08-30 19:18:18.412	\N	fitzgerald-blackburn
2186	fa477c92-39b6-4a52-b065-40af2f29840a	2020-08-30 19:18:18.412	\N	howell-franklin
2187	285ce77d-e5cd-4daa-9784-801347140d48	2020-08-30 19:18:18.412	\N	son-scotch
2188	e111a46d-5ada-4311-ac4f-175cca3357da	2020-08-30 19:18:18.412	\N	alexandria-rosales
2189	af6b3edc-ed52-4edc-b0c9-14e0a5ae0ee3	2020-08-30 19:18:18.412	2020-08-30 20:49:10.544	rivers-clembons
2190	8903a74f-f322-41d2-bd75-dbf7563c4abb	2020-08-30 19:18:18.412	2020-09-08 09:45:27.577	francisca-sasquatch
2191	06ced607-7f96-41e7-a8cd-b501d11d1a7e	2020-08-30 19:18:18.412	\N	morrow-wilson
2192	06ced607-7f96-41e7-a8cd-b501d11d1a7e	2020-08-09 07:23:37.743	2020-08-30 19:18:18.412	morrow-wilson
2193	bf122660-df52-4fc4-9e70-ee185423ff93	2020-08-30 19:18:18.939	\N	walton-sports
2194	c6a277c3-d2b5-4363-839b-950896a5ec5e	2020-08-30 19:18:18.939	\N	mike-townsend
2195	f3ddfd87-73a2-4681-96fe-829476c97886	2020-08-30 19:18:18.939	\N	theodore-duende
2196	bbf9543f-f100-445a-a467-81d7aab12236	2020-08-30 19:18:18.939	\N	farrell-seagull
2197	425f3f84-bab0-4cf2-91c1-96e78cf5cd02	2020-08-30 19:18:18.939	\N	luis-acevedo
2198	c31d874c-1b4d-40f2-a1b3-42542e934047	2020-08-30 19:18:18.939	\N	cedric-spliff
2199	8b53ce82-4b1a-48f0-999d-1774b3719202	2020-08-30 19:18:18.939	\N	oliver-mueller
2200	1068f44b-34a0-42d8-a92e-2be748681a6f	2020-08-30 19:18:18.939	\N	allison-abbott
2201	6c346d8b-d186-4228-9adb-ae919d7131dd	2020-08-30 19:18:18.939	\N	greer-gwiffin
2202	e3c514ae-f813-470e-9c91-d5baf5ffcf16	2020-08-30 19:18:18.939	\N	tot-clark
2203	6f9de777-e812-4c84-915c-ef283c9f0cde	2020-08-30 19:18:18.939	\N	arturo-huerta
2204	c6e2e389-ed04-4626-a5ba-fe398fe89568	2020-08-30 19:18:18.939	\N	henry-marshallow
2205	1301ee81-406e-43d9-b2bb-55ca6e0f7765	2020-08-30 19:18:18.939	2020-08-30 20:49:11.089	malik-destiny
2206	41949d4d-b151-4f46-8bf7-73119a48fac8	2020-08-30 19:18:18.939	2020-08-30 20:49:11.089	ron-monstera
2207	da0bbbe6-d13c-40cc-9594-8c476975d93d	2020-08-30 19:18:18.939	2020-09-08 17:21:21.506	lang-richardson
2208	c675fcdf-6117-49a6-ac32-99a89a3a88aa	2020-08-09 07:23:37.743	2020-08-30 19:18:18.939	valentine-games
2209	0f61d948-4f0c-4550-8410-ae1c7f9f5613	2020-08-30 19:18:18.939	\N	tamara-crankit
2210	efafe75e-2f00-4418-914c-9b6675d39264	2020-08-30 19:18:18.939	\N	aldon-cashmoney
2211	4f328502-d347-4d2c-8fad-6ae59431d781	2020-08-30 19:18:18.939	\N	stephens-lightner
2212	817dee99-9ccf-4f41-84e3-dc9773237bc8	2020-08-30 19:18:18.939	\N	holden-stanton
2213	b348c037-eefc-4b81-8edd-dfa96188a97e	2020-08-30 19:18:18.939	\N	lowe-forbes
2214	ae81e172-801a-4236-929a-b990fc7190ce	2020-08-30 19:18:18.939	\N	august-sky
2215	f4a5d734-0ade-4410-abb6-c0cd5a7a1c26	2020-08-30 19:18:18.939	\N	agan-harrison
2216	3c331c87-1634-46c4-87ce-e4b9c59e2969	2020-08-30 19:18:19.465	\N	yosh-carpenter
2217	f2c477fb-28ea-4fcb-943a-9fab22df3da0	2020-08-30 19:18:19.465	\N	sandford-garner
2218	f3c07eaf-3d6c-4cc3-9e54-cbecc9c08286	2020-08-30 19:18:18.939	2020-08-30 20:49:11.089	campos-arias
2219	58c9e294-bd49-457c-883f-fb3162fc668e	2020-08-30 19:18:19.465	2020-08-30 20:49:11.749	kichiro-guerra
2220	73265ee3-bb35-40d1-b696-1f241a6f5966	2020-08-30 19:18:19.465	2020-08-30 20:49:11.749	parker-meng
2221	c675fcdf-6117-49a6-ac32-99a89a3a88aa	2020-08-30 19:18:18.939	2020-09-08 13:33:08.53	valentine-games
2222	678170e4-0688-436d-a02d-c0467f9af8c0	2020-08-30 19:18:18.939	2020-09-08 14:33:56.207	baby-doyle
2223	d8ee256f-e3d0-46cb-8c77-b1f88d8c9df9	2020-08-30 19:18:18.939	2020-09-09 08:47:50.862	comfort-septemberish
2224	cf8e152e-2d27-4dcc-ba2b-68127de4e6a4	2020-08-30 19:18:18.939	2020-09-09 11:35:09.353	hendricks-richardson
2225	86d4e22b-f107-4bcf-9625-32d387fcb521	2020-08-30 07:25:59.724	2020-08-30 19:18:21.602	york-silk
2226	d23a1f7e-0071-444e-8361-6ae01f13036f	2020-08-09 19:27:43.22	2020-08-30 19:18:21.602	edric-tosser
2227	138fccc3-e66f-4b07-8327-d4b6f372f654	2020-08-30 19:18:20.089	2020-08-30 20:49:11.749	oscar-vaughan
2228	2e13249e-38ff-46a2-a55e-d15fa692468a	2020-08-30 19:18:19.465	2020-08-30 20:49:12.286	vito-kravitz
2229	0bb35615-63f2-4492-80ec-b6b322dc5450	2020-08-30 19:18:19.465	2020-08-30 20:49:12.286	sexton-wheerer
2230	14d88771-7a96-48aa-ba59-07bae1733e96	2020-08-30 19:18:20.089	2020-08-30 20:49:12.286	sebastian-telephone
2231	b7ca8f3f-2fdc-477b-84f4-157f2802e9b5	2020-08-30 19:18:20.089	2020-08-30 20:49:12.286	leach-herman
2232	d23a1f7e-0071-444e-8361-6ae01f13036f	2020-08-30 19:18:21.602	2020-08-30 20:49:12.779	edric-tosser
2233	43d5da5f-c6a1-42f1-ab7f-50ea956b6cd5	2020-08-30 19:18:21.602	2020-08-30 20:49:12.779	justice-spoon
2234	f2a27a7e-bf04-4d31-86f5-16bfa3addbe7	2020-08-30 19:18:20.089	2020-09-06 19:06:12.368	winnie-hess
2235	d46abb00-c546-4952-9218-4f16084e3238	2020-08-30 19:18:20.089	2020-09-06 19:06:12.368	atlas-guerra
2236	7663c3ca-40a1-4f13-a430-14637dce797a	2020-08-30 19:18:20.089	2020-09-06 19:06:12.368	polkadot-zavala
2237	a199a681-decf-4433-b6ab-5454450bbe5e	2020-08-30 19:18:20.089	2020-09-06 19:06:12.368	leach-ingram
2238	21cbbfaa-100e-48c5-9cea-7118b0d08a34	2020-08-30 19:18:21.602	2020-09-06 19:06:15.117	juice-collins
2239	2f3d7bc7-6ffb-40c3-a94f-5e626be413c9	2020-08-30 19:18:21.602	2020-09-06 19:06:15.117	elijah-valenzuela
2240	86d4e22b-f107-4bcf-9625-32d387fcb521	2020-08-30 19:18:21.602	2020-09-06 19:06:15.117	york-silk
2241	e4034192-4dc6-4901-bb30-07fe3cf77b5e	2020-08-30 19:18:21.602	2020-09-06 19:06:15.117	baldwin-breadwinner
2242	f7847de2-df43-4236-8dbe-ae403f5f3ab3	2020-08-30 19:18:22.136	\N	blood-hamburger
2243	b8ab86c6-9054-4832-9b96-508dbd4eb624	2020-08-30 19:18:22.136	\N	esme-ramsey
2244	2175cda0-a427-40fd-b497-347edcc1cd61	2020-08-30 19:18:22.136	\N	hotbox-sato
2245	b1b141fc-e867-40d1-842a-cea30a97ca4f	2020-08-09 07:23:37.234	2020-08-30 19:18:22.136	richardson-games
2246	b1b141fc-e867-40d1-842a-cea30a97ca4f	2020-08-30 19:18:22.136	\N	richardson-games
2247	4ca52626-58cd-449d-88bb-f6d631588640	2020-08-30 19:18:22.136	\N	velasquez-alstott
2248	7b55d484-6ea9-4670-8145-986cb9e32412	2020-08-30 19:18:21.602	2020-08-30 20:49:12.779	stevenson-heat
2249	1e8b09bd-fbdd-444e-bd7e-10326bd57156	2020-08-30 19:18:21.602	2020-09-06 19:06:15.117	fletcher-yamamoto
2250	167751d5-210c-4a6e-9568-e92d61bab185	2020-08-30 19:18:21.602	2020-09-06 19:06:15.117	jacob-winner
2251	9ac2e7c5-5a34-4738-98d8-9f917bc6d119	2020-08-30 19:18:21.602	2020-09-06 19:06:15.117	christian-combs
2252	e6114fd4-a11d-4f6c-b823-65691bb2d288	2020-08-30 19:18:21.602	2020-09-06 19:06:15.117	bevan-underbuck
2253	89ec77d8-c186-4027-bd45-f407b4800c2c	2020-08-30 19:18:21.602	2020-09-06 19:06:15.117	james-mora
2254	3a96d76a-c508-45a0-94a0-8f64cd6beeb4	2020-08-30 19:18:21.602	2020-09-06 19:06:15.117	sixpack-dogwalker
2255	a5f8ce83-02b2-498c-9e48-533a1d81aebf	2020-08-30 19:18:21.602	2020-09-06 19:06:15.117	evelton-mcblase
2256	7158d158-e7bf-4e9b-9259-62e5b25e3de8	2020-08-30 19:18:21.602	2020-09-06 19:06:15.117	karato-bean
2257	34267632-8c32-4a8b-b5e6-ce1568bb0639	2020-08-30 19:18:22.136	2020-09-06 19:06:17.18	gunther-obrian
2258	248ccf3d-d5f6-4b69-83d9-40230ca909cd	2020-08-30 19:18:22.136	2020-09-08 14:33:56.752	antonio-wallace
2259	1f145436-b25d-49b9-a1e3-2d3c91626211	2020-08-30 19:18:22.136	\N	joe-voorhees
2260	15d3a844-df6b-4193-a8f5-9ab129312d8d	2020-08-30 19:18:22.136	\N	sebastian-woodman
2261	03f920cc-411f-44ef-ae66-98a44e883291	2020-08-30 19:18:22.136	\N	cornelius-games
2262	ff5a37d9-a6dd-49aa-b6fb-b935fd670820	2020-08-09 07:23:37.02	2020-08-30 19:18:22.136	dunn-keyes
2263	a647388d-fc59-4c1b-90d3-8c1826e07775	2020-08-30 19:18:22.136	\N	chambers-simmons
2264	66cebbbf-9933-4329-924a-72bd3718f321	2020-08-09 07:23:37.743	2020-08-30 19:18:22.658	kennedy-cena
2265	4e6ad1a1-7c71-49de-8bd5-c286712faf9e	2020-08-09 07:23:37.234	2020-08-30 19:18:22.658	sutton-picklestein
2266	5e4dfa16-f1b9-400f-b8ef-a1613c2b026a	2020-08-30 19:18:22.136	2020-08-30 20:49:13.305	snyder-briggs
2267	28964497-0efe-420c-9c1d-8574f224a4e9	2020-08-30 19:18:22.136	2020-08-30 20:49:13.305	inez-owens
2268	ff5a37d9-a6dd-49aa-b6fb-b935fd670820	2020-08-30 19:18:22.136	2020-08-30 20:49:13.305	dunn-keyes
2269	66cebbbf-9933-4329-924a-72bd3718f321	2020-08-30 19:18:22.658	2020-08-30 20:49:13.821	kennedy-cena
2270	17392be2-7344-48a0-b4db-8a040a7fb532	2020-08-30 19:18:22.658	2020-09-02 04:16:32.667	washer-barajas
2271	4e6ad1a1-7c71-49de-8bd5-c286712faf9e	2020-08-30 19:18:22.658	2020-09-06 19:06:15.653	sutton-picklestein
2272	44c92d97-bb39-469d-a13b-f2dd9ae644d1	2020-08-30 19:18:22.658	2020-09-06 19:06:15.653	francisco-preston
2273	ac69dba3-6225-4afd-ab4b-23fc78f730fb	2020-08-30 19:18:22.658	2020-09-06 19:06:15.653	bevan-wise
2274	9786b2c9-1205-4718-b0f7-fc000ce91106	2020-08-30 19:18:22.136	2020-09-06 19:06:17.18	kevin-dudley
2275	36786f44-9066-4028-98d9-4fa84465ab9e	2020-08-30 19:18:22.136	2020-09-06 19:06:17.18	beasley-gloom
2276	9965eed5-086c-4977-9470-fe410f92d353	2020-08-30 19:18:23.156	\N	bates-bentley
2277	a5adc84c-80b8-49e4-9962-8b4ade99a922	2020-08-30 19:18:22.658	\N	richardson-turquoise
2278	7310c32f-8f32-40f2-b086-54555a2c0e86	2020-08-30 19:18:23.156	\N	dominic-marijuana
2279	0c83e3b6-360e-4b7d-85e3-d906633c9ca0	2020-08-30 19:18:23.156	\N	penelope-mathews
2280	4b3e8e9b-6de1-4840-8751-b1fb45dc5605	2020-08-30 19:18:23.156	\N	thomas-dracaena
2281	4ffd2e50-bb5b-45d0-b7c4-e24d41b2ff5d	2020-08-30 19:18:23.156	\N	schneider-bendie
2282	9397ed91-608e-4b13-98ea-e94c795f651e	2020-08-30 19:18:22.658	2020-08-30 20:49:13.821	yeongho-garcia
2283	1732e623-ffc2-40f0-87ba-fdcf97131f1f	2020-08-30 19:18:22.658	2020-08-30 20:49:13.821	betsy-trombone
2284	f967d064-0eaf-4445-b225-daed700e044b	2020-08-30 19:18:23.156	2020-08-30 20:49:14.35	wesley-dudley
2285	03b80a57-77ea-4913-9be4-7a85c3594745	2020-08-30 19:18:22.658	2020-09-04 17:34:48.475	halexandrey-walton
2286	aa6c2662-75f8-4506-aa06-9a0993313216	2020-08-30 19:18:22.658	2020-09-06 19:06:15.653	eizabeth-elliott
2287	63512571-2eca-4bc4-8ad9-a5308a22ae22	2020-08-30 19:18:22.658	2020-09-06 19:06:15.653	oscar-dollie
2288	8adb084b-19fe-4295-bcd2-f92afdb62bd7	2020-08-30 19:18:22.658	2020-09-06 19:06:15.653	logan-rodriguez
2289	b6aa8ce8-2587-4627-83c1-2a48d44afaee	2020-08-30 19:18:22.658	2020-09-06 19:06:15.653	inky-rutledge
2290	09f2787a-3352-41a6-8810-d80e97b253b5	2020-08-30 19:18:22.658	2020-09-06 19:06:15.653	curry-aliciakeyes
2291	2da49de2-34e5-49d0-b752-af2a2ee061be	2020-08-30 19:18:22.658	2020-09-06 19:06:15.653	cory-twelve
2292	5dbf11c0-994a-4482-bd1e-99379148ee45	2020-08-30 19:18:23.156	2020-09-08 13:33:05.362	conrad-vaughan
2293	413b3ddb-d933-4567-a60e-6d157480239d	2020-08-30 19:18:23.156	\N	winnie-mccall
2294	198fd9c8-cb75-482d-873e-e6b91d42a446	2020-08-30 19:18:23.156	\N	ren-hunter
2295	766dfd1e-11c3-42b6-a167-9b2d568b5dc0	2020-08-30 19:18:23.156	\N	sandie-turner
2296	ae4acebd-edb5-4d20-bf69-f2d5151312ff	2020-08-30 19:18:23.156	\N	theodore-cervantes
2297	81d7d022-19d6-427d-aafc-031fcb79b29e	2020-08-30 19:18:23.156	\N	patty-fox
2298	18af933a-4afa-4cba-bda5-45160f3af99b	2020-08-30 19:18:23.156	\N	felix-garbage
2299	d6c69d2d-9344-4b19-85a4-6cfcbaead5d2	2020-08-09 07:23:37.743	2020-08-30 19:18:23.156	joshua-watson
2300	25376b55-bb6f-48a7-9381-7b8210842fad	2020-08-09 07:23:37.896	2020-08-30 19:18:23.664	emmett-internet
2301	542af915-79c5-431c-a271-f7185e37c6ae	2020-08-30 19:18:23.156	2020-08-30 20:49:14.35	oliver-notarobot
2302	d6c69d2d-9344-4b19-85a4-6cfcbaead5d2	2020-08-30 19:18:23.156	2020-08-30 20:49:14.35	joshua-watson
2303	8604e861-d784-43f0-b0f8-0d43ea6f7814	2020-08-30 19:18:23.664	2020-08-30 20:49:14.864	randall-marijuana
2304	25376b55-bb6f-48a7-9381-7b8210842fad	2020-08-30 19:18:23.664	2020-08-30 20:49:14.864	emmett-internet
2305	4f69e8c2-b2a1-4e98-996a-ccf35ac844c5	2020-08-30 19:18:23.664	2020-08-30 20:49:14.864	igneus-delacruz
2306	89f74891-2e25-4b5a-bd99-c95ba3f36aa0	2020-08-30 19:18:23.664	2020-08-30 20:49:14.864	nagomi-nava
2307	df4da81a-917b-434f-b309-f00423ee4967	2020-08-30 19:18:23.664	2020-08-30 20:49:14.864	eugenia-bickle
2308	9be56060-3b01-47aa-a090-d072ef109fbf	2020-08-30 19:18:23.664	2020-08-30 20:49:14.864	jesus-koch
2309	a691f2ba-9b69-41f8-892c-1acd42c336e4	2020-08-30 19:18:23.664	2020-08-30 20:49:14.864	jenkins-good
2310	5bcfb3ff-5786-4c6c-964c-5c325fcc48d7	2020-08-30 19:18:24.173	\N	paula-turnip
2311	5bcfb3ff-5786-4c6c-964c-5c325fcc48d7	2020-08-09 07:23:38.05	2020-08-30 19:18:24.173	paula-turnip
2312	13a05157-6172-4431-947b-a058217b4aa5	2020-08-30 19:18:24.173	\N	spears-taylor
2313	5ff66eae-7111-4e3b-a9b8-a9579165b0a5	2020-08-30 19:18:24.173	\N	peanutiel-duffy
2314	32c9bce6-6e52-40fa-9f64-3629b3d026a8	2020-08-30 19:18:24.173	\N	ren-morin
2315	2e86de11-a2dd-4b28-b5fe-f4d0c38cd20b	2020-08-30 19:18:24.173	\N	zion-aliciakeyes
2316	7932c7c7-babb-4245-b9f5-cdadb97c99fb	2020-08-30 19:18:24.173	\N	randy-castillo
2317	9abe02fb-2b5a-432f-b0af-176be6bd62cf	2020-08-30 19:18:24.173	\N	nagomi-meng
2318	2720559e-9173-4042-aaa0-d3852b72ab2e	2020-08-30 19:18:24.173	\N	hiroto-wilcox
2319	7aeb8e0b-f6fb-4a9e-bba2-335dada5f0a3	2020-08-30 19:18:24.173	\N	dunlap-figueroa
2320	b3e512df-c411-4100-9544-0ceadddb28cf	2020-08-30 19:18:24.173	\N	famous-owens
2321	65273615-22d5-4df1-9a73-707b23e828d5	2020-08-30 19:18:24.173	2020-08-30 20:49:15.37	burke-gonzales
2322	70ccff1e-6b53-40e2-8844-0a28621cb33e	2020-08-30 19:18:24.173	2020-08-30 20:49:15.37	moody-cookbook
2323	afc90398-b891-4cdf-9dea-af8a3a79d793	2020-08-30 19:18:24.173	2020-08-30 20:49:15.37	yazmin-mason
2324	bd8d58b6-f37f-48e6-9919-8e14ec91f92a	2020-08-30 19:18:24.173	2020-09-06 19:06:16.157	jose-haley
2325	a311c089-0df4-46bd-9f5d-8c45c7eb5ae2	2020-08-30 19:18:24.173	2020-09-06 19:06:16.67	mclaughlin-scorpler
2326	d89da2d2-674c-4b85-8959-a4bd406f760a	2020-08-30 19:18:24.173	2020-09-08 10:30:52.878	fish-summer
2327	ef9f8b95-9e73-49cd-be54-60f84858a285	2020-08-30 19:18:18.412	2020-08-30 20:49:10.544	collins-melon
2328	3af96a6b-866c-4b03-bc14-090acf6ecee5	2020-08-30 20:18:56.326	\N	axel-trololol
2329	446a3366-3fe3-41bb-bfdd-d8717f2152a9	2020-08-30 19:18:18.412	2020-08-30 20:49:10.544	marco-escobar
2330	446a3366-3fe3-41bb-bfdd-d8717f2152a9	2020-08-30 20:49:10.544	\N	marco-escobar
2331	32551e28-3a40-47ae-aed1-ff5bc66be879	2020-08-30 20:49:10.544	\N	math-velazquez
2332	12577256-bc4e-4955-81d6-b422d895fb12	2020-08-30 20:49:10.544	\N	jasmine-washington
2333	af6b3edc-ed52-4edc-b0c9-14e0a5ae0ee3	2020-08-30 20:49:10.544	\N	rivers-clembons
2334	1301ee81-406e-43d9-b2bb-55ca6e0f7765	2020-08-30 20:49:11.089	\N	malik-destiny
2335	41949d4d-b151-4f46-8bf7-73119a48fac8	2020-08-30 20:49:11.089	\N	ron-monstera
2336	9c3273a0-2711-4958-b716-bfcf60857013	2020-08-30 19:18:18.939	2020-08-30 20:49:11.089	kathy-mathews
2337	9c3273a0-2711-4958-b716-bfcf60857013	2020-08-30 20:49:11.089	\N	kathy-mathews
2338	f3c07eaf-3d6c-4cc3-9e54-cbecc9c08286	2020-08-30 20:49:11.089	\N	campos-arias
2339	4b6f0a4e-de18-44ad-b497-03b1f470c43c	2020-08-30 19:18:20.089	2020-08-30 20:49:11.749	rodriguez-internet
2340	58c9e294-bd49-457c-883f-fb3162fc668e	2020-08-30 20:49:11.749	\N	kichiro-guerra
2341	73265ee3-bb35-40d1-b696-1f241a6f5966	2020-08-30 20:49:11.749	\N	parker-meng
2342	138fccc3-e66f-4b07-8327-d4b6f372f654	2020-08-30 20:49:11.749	2020-09-06 19:06:12.368	oscar-vaughan
2343	ef9f8b95-9e73-49cd-be54-60f84858a285	2020-08-30 20:49:10.544	2020-09-09 08:47:48.751	collins-melon
2344	0bb35615-63f2-4492-80ec-b6b322dc5450	2020-08-30 20:49:12.286	\N	sexton-wheerer
2345	2e13249e-38ff-46a2-a55e-d15fa692468a	2020-08-30 20:49:12.286	\N	vito-kravitz
2346	14d88771-7a96-48aa-ba59-07bae1733e96	2020-08-30 20:49:12.286	\N	sebastian-telephone
2347	b7ca8f3f-2fdc-477b-84f4-157f2802e9b5	2020-08-30 20:49:12.286	\N	leach-herman
2348	8a6fc67d-a7fe-443b-a084-744294cec647	2020-08-30 19:18:21.602	2020-08-30 20:49:12.779	terrell-bradley
2349	d47dd08e-833c-4302-a965-a391d345455c	2020-08-30 19:18:22.136	2020-08-30 20:49:13.305	stu-trololol
2350	d47dd08e-833c-4302-a965-a391d345455c	2020-08-30 20:49:13.305	\N	stu-trololol
2351	28964497-0efe-420c-9c1d-8574f224a4e9	2020-08-30 20:49:13.305	\N	inez-owens
2352	ff5a37d9-a6dd-49aa-b6fb-b935fd670820	2020-08-30 20:49:13.305	\N	dunn-keyes
2353	80de2b05-e0d4-4d33-9297-9951b2b5c950	2020-08-30 19:18:22.658	2020-08-30 20:49:13.821	alyssa-harrell
2354	8a6fc67d-a7fe-443b-a084-744294cec647	2020-08-30 20:49:12.779	2020-09-06 19:06:15.117	terrell-bradley
2355	7b55d484-6ea9-4670-8145-986cb9e32412	2020-08-30 20:49:12.779	2020-09-06 19:06:15.117	stevenson-heat
2356	80de2b05-e0d4-4d33-9297-9951b2b5c950	2020-08-30 20:49:13.821	2020-09-06 19:06:15.653	alyssa-harrell
2357	9397ed91-608e-4b13-98ea-e94c795f651e	2020-08-30 20:49:13.821	2020-09-06 19:06:15.653	yeongho-garcia
2358	43d5da5f-c6a1-42f1-ab7f-50ea956b6cd5	2020-08-30 20:49:12.779	2020-09-06 19:06:17.18	justice-spoon
2359	d23a1f7e-0071-444e-8361-6ae01f13036f	2020-08-30 20:49:12.779	2020-09-06 19:06:17.18	edric-tosser
2360	5e4dfa16-f1b9-400f-b8ef-a1613c2b026a	2020-08-30 20:49:13.305	2020-09-06 19:06:17.18	snyder-briggs
2361	378c07b0-5645-44b5-869f-497d144c7b35	2020-08-30 19:18:23.156	2020-08-30 20:49:14.35	fynn-doyle
2362	f967d064-0eaf-4445-b225-daed700e044b	2020-08-30 20:49:14.35	\N	wesley-dudley
2363	4f69e8c2-b2a1-4e98-996a-ccf35ac844c5	2020-08-30 20:49:14.864	\N	igneus-delacruz
2364	89f74891-2e25-4b5a-bd99-c95ba3f36aa0	2020-08-30 20:49:14.864	\N	nagomi-nava
2365	df4da81a-917b-434f-b309-f00423ee4967	2020-08-30 20:49:14.864	\N	eugenia-bickle
2366	9be56060-3b01-47aa-a090-d072ef109fbf	2020-08-30 20:49:14.864	\N	jesus-koch
2367	a691f2ba-9b69-41f8-892c-1acd42c336e4	2020-08-30 20:49:14.864	\N	jenkins-good
2368	e4f1f358-ee1f-4466-863e-f329766279d0	2020-08-30 19:18:24.173	2020-08-30 20:49:15.37	ronan-combs
2369	70ccff1e-6b53-40e2-8844-0a28621cb33e	2020-08-30 20:49:15.37	\N	moody-cookbook
2370	afc90398-b891-4cdf-9dea-af8a3a79d793	2020-08-30 20:49:15.37	\N	yazmin-mason
2371	66cebbbf-9933-4329-924a-72bd3718f321	2020-08-30 20:49:13.821	2020-09-06 19:06:14.626	kennedy-cena
2372	542af915-79c5-431c-a271-f7185e37c6ae	2020-08-30 20:49:14.35	2020-09-06 19:06:15.653	oliver-notarobot
2373	e4f1f358-ee1f-4466-863e-f329766279d0	2020-08-30 20:49:15.37	2020-09-06 19:06:16.157	ronan-combs
2374	65273615-22d5-4df1-9a73-707b23e828d5	2020-08-30 20:49:15.37	2020-09-06 19:06:16.157	burke-gonzales
2375	d6c69d2d-9344-4b19-85a4-6cfcbaead5d2	2020-08-30 20:49:14.35	2020-09-06 19:06:17.18	joshua-watson
2376	378c07b0-5645-44b5-869f-497d144c7b35	2020-08-30 20:49:14.35	2020-09-08 14:33:58.923	fynn-doyle
2377	8604e861-d784-43f0-b0f8-0d43ea6f7814	2020-08-30 20:49:14.864	2020-09-09 11:35:07.754	randall-marijuana
2378	4f7d7490-7281-4f8f-b62e-37e99a7c46a0	2020-09-02 07:33:20.885	2020-09-02 21:48:48.522	annie-roland
2379	17392be2-7344-48a0-b4db-8a040a7fb532	2020-09-02 04:16:32.667	2020-09-02 21:48:48.522	washer-barajas
2380	25376b55-bb6f-48a7-9381-7b8210842fad	2020-08-30 20:49:14.864	2020-09-04 10:30:22.111	emmett-internet
2381	25376b55-bb6f-48a7-9381-7b8210842fad	2020-09-04 10:30:22.111	\N	emmett-internet
2382	03b80a57-77ea-4913-9be4-7a85c3594745	2020-09-04 17:34:48.475	\N	halexandrey-walton
2383	5eac7fd9-0d19-4bf4-a013-994acc0c40c0	2020-09-04 10:45:33.293	2020-09-04 22:08:27.197	sutton-bishop
2384	5eac7fd9-0d19-4bf4-a013-994acc0c40c0	2020-09-04 22:08:27.197	\N	sutton-bishop
2385	11de4da3-8208-43ff-a1ff-0b3480a0fbf1	2020-09-05 17:20:26.613	2020-09-05 18:05:51.882	don-mitchell
2386	bfd9ff52-9bf6-4aaf-a859-d308d8f29616	2020-09-06 01:40:52.831	2020-09-06 06:59:03.384	declan-suzanne
2387	88cd6efa-dbf2-4309-aabe-ec1d6f21f98a	2020-09-06 19:06:12.368	\N	hewitt-best
2388	64f4cd75-0c1e-42cf-9ff0-e41c4756f22a	2020-09-06 19:06:12.368	\N	grey-alvarado
2389	4f7d7490-7281-4f8f-b62e-37e99a7c46a0	2020-09-02 21:48:48.522	2020-09-06 19:06:15.653	annie-roland
2390	e16c3f28-eecd-4571-be1a-606bbac36b2b	2020-09-04 17:34:50.167	2020-09-06 19:06:15.653	wyatt-glover
2391	bfd9ff52-9bf6-4aaf-a859-d308d8f29616	2020-09-06 06:59:03.384	2020-09-06 19:06:17.18	declan-suzanne
2392	c0732e36-3731-4f1a-abdc-daa9563b6506	2020-09-06 19:06:11.853	2020-09-06 19:21:20.316	nagomi-mcdaniel
2393	b39b5aae-8571-4c90-887a-6a00f2a2f6fd	2020-09-06 19:06:12.368	2020-09-08 05:12:37.985	dickerson-morse
2394	11de4da3-8208-43ff-a1ff-0b3480a0fbf1	2020-09-05 18:05:51.882	2020-09-09 00:41:36.121	don-mitchell
2395	4b6f0a4e-de18-44ad-b497-03b1f470c43c	2020-09-06 19:06:12.368	\N	rodriguez-internet
2396	4b6f0a4e-de18-44ad-b497-03b1f470c43c	2020-08-30 20:49:11.749	2020-09-06 19:06:12.368	rodriguez-internet
2397	cd417f8a-ce01-4ab2-921d-42e2e445bbe2	2020-09-06 19:06:12.368	\N	eizabeth-guerra
2398	493a83de-6bcf-41a1-97dd-cc5e150548a3	2020-09-06 19:06:12.368	\N	boyfriend-monreal
2399	f2a27a7e-bf04-4d31-86f5-16bfa3addbe7	2020-09-06 19:06:12.368	\N	winnie-hess
2400	d46abb00-c546-4952-9218-4f16084e3238	2020-09-06 19:06:12.368	\N	atlas-guerra
2401	46721a07-7cd2-4839-982e-7046df6e8b66	2020-09-06 19:06:12.368	\N	stew-briggs
2402	7663c3ca-40a1-4f13-a430-14637dce797a	2020-09-06 19:06:12.368	\N	polkadot-zavala
2403	c09e64b6-8248-407e-b3af-1931b880dbee	2020-09-06 19:06:12.368	\N	lenny-spruce
2404	53e701c7-e3c8-4e18-ba05-9b41b4b64cda	2020-09-06 19:06:12.368	\N	marquez-clark
2405	a199a681-decf-4433-b6ab-5454450bbe5e	2020-09-06 19:06:12.368	\N	leach-ingram
2406	138fccc3-e66f-4b07-8327-d4b6f372f654	2020-09-06 19:06:12.368	\N	oscar-vaughan
2407	26cfccf2-850e-43eb-b085-ff73ad0749b8	2020-09-06 19:06:14.626	2020-09-06 19:21:22.69	beasley-day
2483	e4e4c17d-8128-4704-9e04-f244d4573c4d	2020-09-06 19:06:17.18	\N	wesley-poole
2408	083d09d4-7ed3-4100-b021-8fbe30dd43e8	2020-09-06 19:06:14.626	2020-09-06 19:21:22.69	jessica-telephone
2409	2ae8cbfc-2155-4647-9996-3f2591091baf	2020-09-06 19:06:14.626	2020-09-06 19:21:22.69	forrest-bookbaby
2410	667cb445-c288-4e62-b603-27291c1e475d	2020-09-06 19:06:14.626	2020-09-06 19:21:22.69	peanut-holloway
2411	15ae64cd-f698-4b00-9d61-c9fffd037ae2	2020-09-06 19:06:14.626	2020-09-06 19:21:22.69	mickey-woods
2412	ecb8d2f5-4ff5-4890-9693-5654e00055f6	2020-09-06 19:06:14.626	2020-09-06 19:21:22.69	yeongho-benitez
2413	1732e623-ffc2-40f0-87ba-fdcf97131f1f	2020-08-30 20:49:13.821	2020-09-06 19:06:14.626	betsy-trombone
2414	1732e623-ffc2-40f0-87ba-fdcf97131f1f	2020-09-06 19:06:14.626	2020-09-06 19:21:22.69	betsy-trombone
2415	b082ca6e-eb11-4eab-8d6a-30f8be522ec4	2020-09-06 19:06:14.626	2020-09-06 19:21:22.69	nicholas-mora
2416	60026a9d-fc9a-4f5a-94fd-2225398fa3da	2020-09-06 19:06:14.626	2020-09-06 19:21:22.69	bright-zimmerman
2417	814bae61-071a-449b-981e-e7afc839d6d6	2020-09-06 19:06:14.626	2020-09-06 19:21:22.69	ruslan-greatness
2418	80dff591-2393-448a-8d88-122bd424fa4c	2020-09-06 19:06:14.626	2020-09-06 19:21:22.69	elvis-figueroa
2419	1e8b09bd-fbdd-444e-bd7e-10326bd57156	2020-09-06 19:06:15.117	2020-09-06 19:21:23.205	fletcher-yamamoto
2420	167751d5-210c-4a6e-9568-e92d61bab185	2020-09-06 19:06:15.117	2020-09-06 19:21:23.205	jacob-winner
2421	21cbbfaa-100e-48c5-9cea-7118b0d08a34	2020-09-06 19:06:15.117	2020-09-06 19:21:23.205	juice-collins
2422	2f3d7bc7-6ffb-40c3-a94f-5e626be413c9	2020-09-06 19:06:15.117	2020-09-06 19:21:23.205	elijah-valenzuela
2423	86d4e22b-f107-4bcf-9625-32d387fcb521	2020-09-06 19:06:15.117	2020-09-06 19:21:23.205	york-silk
2424	e4034192-4dc6-4901-bb30-07fe3cf77b5e	2020-09-06 19:06:15.117	2020-09-06 19:21:23.205	baldwin-breadwinner
2425	8a6fc67d-a7fe-443b-a084-744294cec647	2020-09-06 19:06:15.117	2020-09-06 19:21:23.205	terrell-bradley
2426	9ac2e7c5-5a34-4738-98d8-9f917bc6d119	2020-09-06 19:06:15.117	2020-09-06 19:21:23.205	christian-combs
2427	e6114fd4-a11d-4f6c-b823-65691bb2d288	2020-09-06 19:06:15.117	2020-09-06 19:21:23.205	bevan-underbuck
2428	3a96d76a-c508-45a0-94a0-8f64cd6beeb4	2020-09-06 19:06:15.117	2020-09-06 19:21:23.205	sixpack-dogwalker
2429	a5f8ce83-02b2-498c-9e48-533a1d81aebf	2020-09-06 19:06:15.117	2020-09-06 19:21:23.205	evelton-mcblase
2430	17392be2-7344-48a0-b4db-8a040a7fb532	2020-09-02 21:48:48.522	2020-09-06 19:06:15.653	washer-barajas
2431	ac69dba3-6225-4afd-ab4b-23fc78f730fb	2020-09-06 19:06:15.653	2020-09-06 19:21:24.252	bevan-wise
2432	7158d158-e7bf-4e9b-9259-62e5b25e3de8	2020-09-06 19:06:15.117	2020-09-06 19:21:23.205	karato-bean
2433	7b55d484-6ea9-4670-8145-986cb9e32412	2020-09-06 19:06:15.117	2020-09-06 19:21:23.205	stevenson-heat
2434	90c2cec7-0ed5-426a-9de8-754f34d59b39	2020-09-06 19:06:15.653	2020-09-06 19:21:23.752	tot-fox
2435	d35ccee1-9559-49a1-aaa4-7809f7b5c46e	2020-09-06 19:06:15.653	2020-09-06 19:21:23.752	forrest-best
2436	84a2b5f6-4955-4007-9299-3d35ae7135d3	2020-09-06 19:06:15.653	2020-09-06 19:21:23.752	kennedy-loser
2437	542af915-79c5-431c-a271-f7185e37c6ae	2020-09-06 19:06:15.653	2020-09-06 19:21:23.752	oliver-notarobot
2438	4ecee7be-93e4-4f04-b114-6b333e0e6408	2020-09-06 19:06:15.653	2020-09-06 19:21:23.752	sutton-dreamy
2439	1a93a2d2-b5b6-479b-a595-703e4a2f3885	2020-09-06 19:06:15.653	2020-09-06 19:21:23.752	pedro-davids
2440	97dfc1f6-ac94-4cdc-b0d5-1cb9f8984aa5	2020-09-06 19:06:15.653	2020-09-06 19:21:23.752	brock-forbes
2441	1ffb1153-909d-44c7-9df1-6ed3a9a45bbd	2020-09-06 19:06:15.653	2020-09-06 19:21:23.752	montgomery-bullock
2442	17392be2-7344-48a0-b4db-8a040a7fb532	2020-09-06 19:06:15.653	2020-09-06 19:21:24.252	washer-barajas
2443	4e6ad1a1-7c71-49de-8bd5-c286712faf9e	2020-09-06 19:06:15.653	2020-09-06 19:21:24.252	sutton-picklestein
2444	d0d7b8fe-bad8-481f-978e-cb659304ed49	2020-09-06 19:06:15.653	2020-09-06 19:21:23.752	adalberto-tosser
2445	f9930cb1-7ed2-4b9a-bf4f-7e35f2586d71	2020-09-06 19:06:15.653	2020-09-06 19:21:23.752	finn-james
2446	f70dd57b-55c4-4a62-a5ea-7cc4bf9d8ac1	2020-09-06 19:06:15.653	2020-09-06 19:21:23.752	tillman-henderson
2447	4f7d7490-7281-4f8f-b62e-37e99a7c46a0	2020-09-06 19:06:15.653	2020-09-06 19:21:24.252	annie-roland
2448	80de2b05-e0d4-4d33-9297-9951b2b5c950	2020-09-06 19:06:15.653	2020-09-06 19:21:24.252	alyssa-harrell
2449	aa6c2662-75f8-4506-aa06-9a0993313216	2020-09-06 19:06:15.653	2020-09-06 19:21:24.252	eizabeth-elliott
2450	63512571-2eca-4bc4-8ad9-a5308a22ae22	2020-09-06 19:06:15.653	2020-09-06 19:21:24.252	oscar-dollie
2451	9397ed91-608e-4b13-98ea-e94c795f651e	2020-09-06 19:06:15.653	2020-09-06 19:21:24.252	yeongho-garcia
2452	8adb084b-19fe-4295-bcd2-f92afdb62bd7	2020-09-06 19:06:15.653	2020-09-06 19:21:24.252	logan-rodriguez
2453	b6aa8ce8-2587-4627-83c1-2a48d44afaee	2020-09-06 19:06:15.653	2020-09-06 19:21:24.252	inky-rutledge
2454	09f2787a-3352-41a6-8810-d80e97b253b5	2020-09-06 19:06:15.653	2020-09-06 19:21:24.252	curry-aliciakeyes
2455	2da49de2-34e5-49d0-b752-af2a2ee061be	2020-09-06 19:06:15.653	2020-09-06 19:21:24.252	cory-twelve
2456	e16c3f28-eecd-4571-be1a-606bbac36b2b	2020-09-06 19:06:15.653	2020-09-06 19:21:24.252	wyatt-glover
2457	e4f1f358-ee1f-4466-863e-f329766279d0	2020-09-06 19:06:16.157	2020-09-06 19:21:24.759	ronan-combs
2458	bd8d58b6-f37f-48e6-9919-8e14ec91f92a	2020-09-06 19:06:16.157	2020-09-06 19:21:24.759	jose-haley
2459	65273615-22d5-4df1-9a73-707b23e828d5	2020-09-06 19:06:16.157	2020-09-06 19:21:24.759	burke-gonzales
2460	089af518-e27c-4256-adc8-62e3f4b30f43	2020-09-06 19:06:16.157	2020-09-06 19:21:24.759	silvia-rugrat
2461	ad8d15f4-e041-4a12-a10e-901e6285fdc5	2020-09-06 19:06:17.18	\N	baby-urlacher
2462	43d5da5f-c6a1-42f1-ab7f-50ea956b6cd5	2020-09-06 19:06:17.18	\N	justice-spoon
2463	a311c089-0df4-46bd-9f5d-8c45c7eb5ae2	2020-09-06 19:06:16.67	\N	mclaughlin-scorpler
2464	68f98a04-204f-4675-92a7-8823f2277075	2020-09-06 19:06:17.18	\N	isaac-johnson
2465	69196296-f652-42ff-b2ca-0d9b50bd9b7b	2020-09-06 19:06:17.18	\N	joshua-butt
2466	bfd9ff52-9bf6-4aaf-a859-d308d8f29616	2020-09-06 19:06:17.18	\N	declan-suzanne
2467	d23a1f7e-0071-444e-8361-6ae01f13036f	2020-09-06 19:06:17.18	\N	edric-tosser
2468	b7267aba-6114-4d53-a519-bf6c99f4e3a9	2020-09-06 19:06:16.157	2020-09-06 19:21:24.759	sosa-hayes
2469	bd8778e5-02e8-4d1f-9c31-7b63942cc570	2020-09-06 19:06:16.157	2020-09-06 19:21:24.759	cell-barajas
2470	ce0e57a7-89f5-41ea-80f9-6e649dd54089	2020-09-06 19:06:16.157	2020-09-06 19:21:24.759	yong-wright
2471	4204c2d1-ca48-4af7-b827-e99907f12d61	2020-09-06 19:06:16.157	2020-09-06 19:21:24.759	axel-cardenas
2472	80e474a3-7d2b-431d-8192-2f1e27162607	2020-09-06 19:06:16.157	2020-09-06 19:21:24.759	summers-preston
2473	cd68d3a6-7fbc-445d-90f1-970c955e32f4	2020-09-06 19:06:16.157	2020-09-06 19:21:24.759	miguel-wheeler
2474	316abea7-9890-4fb8-aaea-86b35e24d9be	2020-09-06 19:06:16.157	2020-09-06 19:21:24.759	kennedy-rodgers
2475	ad1e670a-f346-4bf7-a02f-a91649c41ccb	2020-09-06 19:06:16.157	2020-09-06 19:21:24.759	stephanie-winters
2476	7007cbd3-7c7b-44fd-9d6b-393e82b1c06e	2020-09-06 19:06:16.157	2020-09-06 19:21:24.759	rafael-davids
2477	d6c69d2d-9344-4b19-85a4-6cfcbaead5d2	2020-09-06 19:06:17.18	2020-09-06 19:21:25.329	joshua-watson
2478	34267632-8c32-4a8b-b5e6-ce1568bb0639	2020-09-06 19:06:17.18	\N	gunther-obrian
2479	5e4dfa16-f1b9-400f-b8ef-a1613c2b026a	2020-09-06 19:06:17.18	\N	snyder-briggs
2480	9786b2c9-1205-4718-b0f7-fc000ce91106	2020-09-06 19:06:17.18	\N	kevin-dudley
2481	20e13b56-599b-4a22-b752-8059effc81dc	2020-09-06 19:06:17.18	\N	lou-roseheart
2482	f73009c5-2ede-4dc4-b96d-84ba93c8a429	2020-09-06 19:06:17.18	\N	thomas-kirby
2484	1513aab6-142c-48c6-b43e-fbda65fd64e8	2020-09-06 19:06:17.18	\N	caleb-alvarado
2485	4bf352d2-6a57-420a-9d45-b23b2b947375	2020-09-06 19:06:17.18	\N	rivers-rosa
2486	16aff709-e855-47c8-8818-b9ba66e90fe8	2020-09-06 19:06:17.18	\N	mullen-peterson
2487	c182f33c-aea5-48a2-97ed-dc74fa29b3c0	2020-09-06 19:06:17.18	\N	swamuel-mora
2488	32810dca-825c-4dbc-8b65-0702794c424e	2020-09-06 19:06:14.626	2020-09-06 19:21:22.69	eduardo-woodman
2489	32810dca-825c-4dbc-8b65-0702794c424e	2020-09-06 19:21:22.69	\N	eduardo-woodman
2490	26cfccf2-850e-43eb-b085-ff73ad0749b8	2020-09-06 19:21:22.69	\N	beasley-day
2491	083d09d4-7ed3-4100-b021-8fbe30dd43e8	2020-09-06 19:21:22.69	\N	jessica-telephone
2492	2ae8cbfc-2155-4647-9996-3f2591091baf	2020-09-06 19:21:22.69	\N	forrest-bookbaby
2493	667cb445-c288-4e62-b603-27291c1e475d	2020-09-06 19:21:22.69	\N	peanut-holloway
2494	36786f44-9066-4028-98d9-4fa84465ab9e	2020-09-06 19:06:17.18	2020-09-09 10:18:48.789	beasley-gloom
2495	7e9a514a-7850-4ed0-93ab-f3a6e2f41c03	2020-09-06 19:06:14.626	2020-09-06 19:21:22.69	nolanestophia-patterson
2496	7e9a514a-7850-4ed0-93ab-f3a6e2f41c03	2020-09-06 19:21:22.69	\N	nolanestophia-patterson
2497	15ae64cd-f698-4b00-9d61-c9fffd037ae2	2020-09-06 19:21:22.69	\N	mickey-woods
2498	ecb8d2f5-4ff5-4890-9693-5654e00055f6	2020-09-06 19:21:22.69	\N	yeongho-benitez
2499	1732e623-ffc2-40f0-87ba-fdcf97131f1f	2020-09-06 19:21:22.69	\N	betsy-trombone
2500	b082ca6e-eb11-4eab-8d6a-30f8be522ec4	2020-09-06 19:21:22.69	\N	nicholas-mora
2501	60026a9d-fc9a-4f5a-94fd-2225398fa3da	2020-09-06 19:21:22.69	\N	bright-zimmerman
2502	814bae61-071a-449b-981e-e7afc839d6d6	2020-09-06 19:21:22.69	\N	ruslan-greatness
2503	80dff591-2393-448a-8d88-122bd424fa4c	2020-09-06 19:21:22.69	\N	elvis-figueroa
2504	1e8b09bd-fbdd-444e-bd7e-10326bd57156	2020-09-06 19:21:23.205	\N	fletcher-yamamoto
2505	167751d5-210c-4a6e-9568-e92d61bab185	2020-09-06 19:21:23.205	\N	jacob-winner
2506	21cbbfaa-100e-48c5-9cea-7118b0d08a34	2020-09-06 19:21:23.205	\N	juice-collins
2507	2f3d7bc7-6ffb-40c3-a94f-5e626be413c9	2020-09-06 19:21:23.205	\N	elijah-valenzuela
2508	86d4e22b-f107-4bcf-9625-32d387fcb521	2020-09-06 19:21:23.205	\N	york-silk
2509	e4034192-4dc6-4901-bb30-07fe3cf77b5e	2020-09-06 19:21:23.205	\N	baldwin-breadwinner
2510	8a6fc67d-a7fe-443b-a084-744294cec647	2020-09-06 19:21:23.205	\N	terrell-bradley
2511	9ac2e7c5-5a34-4738-98d8-9f917bc6d119	2020-09-06 19:21:23.205	\N	christian-combs
2512	89ec77d8-c186-4027-bd45-f407b4800c2c	2020-09-06 19:06:15.117	2020-09-06 19:21:23.205	james-mora
2513	89ec77d8-c186-4027-bd45-f407b4800c2c	2020-09-06 19:21:23.205	\N	james-mora
2514	e6114fd4-a11d-4f6c-b823-65691bb2d288	2020-09-06 19:21:23.205	\N	bevan-underbuck
2515	3a96d76a-c508-45a0-94a0-8f64cd6beeb4	2020-09-06 19:21:23.205	\N	sixpack-dogwalker
2516	a5f8ce83-02b2-498c-9e48-533a1d81aebf	2020-09-06 19:21:23.205	\N	evelton-mcblase
2517	7158d158-e7bf-4e9b-9259-62e5b25e3de8	2020-09-06 19:21:23.205	\N	karato-bean
2518	7b55d484-6ea9-4670-8145-986cb9e32412	2020-09-06 19:21:23.205	\N	stevenson-heat
2519	90c2cec7-0ed5-426a-9de8-754f34d59b39	2020-09-06 19:21:23.752	\N	tot-fox
2520	d35ccee1-9559-49a1-aaa4-7809f7b5c46e	2020-09-06 19:21:23.752	\N	forrest-best
2521	84a2b5f6-4955-4007-9299-3d35ae7135d3	2020-09-06 19:21:23.752	\N	kennedy-loser
2522	542af915-79c5-431c-a271-f7185e37c6ae	2020-09-06 19:21:23.752	\N	oliver-notarobot
2523	4ecee7be-93e4-4f04-b114-6b333e0e6408	2020-09-06 19:21:23.752	\N	sutton-dreamy
2524	1a93a2d2-b5b6-479b-a595-703e4a2f3885	2020-09-06 19:21:23.752	\N	pedro-davids
2525	7dcf6902-632f-48c5-936a-7cf88802b93a	2020-09-06 19:06:15.653	2020-09-06 19:21:23.752	parker-parra
2526	7dcf6902-632f-48c5-936a-7cf88802b93a	2020-09-06 19:21:23.752	\N	parker-parra
2527	f70dd57b-55c4-4a62-a5ea-7cc4bf9d8ac1	2020-09-06 19:21:23.752	\N	tillman-henderson
2528	1ffb1153-909d-44c7-9df1-6ed3a9a45bbd	2020-09-06 19:21:23.752	2020-09-08 14:33:59.438	montgomery-bullock
2529	f9930cb1-7ed2-4b9a-bf4f-7e35f2586d71	2020-09-06 19:21:23.752	\N	finn-james
2530	17392be2-7344-48a0-b4db-8a040a7fb532	2020-09-06 19:21:24.252	\N	washer-barajas
2531	d0d7b8fe-bad8-481f-978e-cb659304ed49	2020-09-06 19:21:23.752	\N	adalberto-tosser
2532	44c92d97-bb39-469d-a13b-f2dd9ae644d1	2020-09-06 19:06:15.653	2020-09-06 19:21:24.252	francisco-preston
2533	44c92d97-bb39-469d-a13b-f2dd9ae644d1	2020-09-06 19:21:24.252	\N	francisco-preston
2534	ac69dba3-6225-4afd-ab4b-23fc78f730fb	2020-09-06 19:21:24.252	\N	bevan-wise
2535	aa6c2662-75f8-4506-aa06-9a0993313216	2020-09-06 19:21:24.252	\N	eizabeth-elliott
2536	63512571-2eca-4bc4-8ad9-a5308a22ae22	2020-09-06 19:21:24.252	\N	oscar-dollie
2537	8adb084b-19fe-4295-bcd2-f92afdb62bd7	2020-09-06 19:21:24.252	\N	logan-rodriguez
2538	b6aa8ce8-2587-4627-83c1-2a48d44afaee	2020-09-06 19:21:24.252	\N	inky-rutledge
2539	09f2787a-3352-41a6-8810-d80e97b253b5	2020-09-06 19:21:24.252	\N	curry-aliciakeyes
2540	2da49de2-34e5-49d0-b752-af2a2ee061be	2020-09-06 19:21:24.252	\N	cory-twelve
2541	e16c3f28-eecd-4571-be1a-606bbac36b2b	2020-09-06 19:21:24.252	\N	wyatt-glover
2542	e4f1f358-ee1f-4466-863e-f329766279d0	2020-09-06 19:21:24.759	\N	ronan-combs
2543	9397ed91-608e-4b13-98ea-e94c795f651e	2020-09-06 19:21:24.252	2020-09-08 17:21:23.599	yeongho-garcia
2544	4e6ad1a1-7c71-49de-8bd5-c286712faf9e	2020-09-06 19:21:24.252	2020-09-09 05:14:47.884	sutton-picklestein
2545	80de2b05-e0d4-4d33-9297-9951b2b5c950	2020-09-06 19:21:24.252	2020-09-09 07:31:41.084	alyssa-harrell
2546	bd8d58b6-f37f-48e6-9919-8e14ec91f92a	2020-09-06 19:21:24.759	\N	jose-haley
2547	65273615-22d5-4df1-9a73-707b23e828d5	2020-09-06 19:21:24.759	\N	burke-gonzales
2548	2f3d7bc7-6ffb-40c3-a94f-5e626be413c9	2020-07-29 08:12:22.438	2020-08-02 10:22:49.747	elijah-valenzuela
2549	2b9f9c25-43ec-4f0b-9937-a5aa23be0d9e	2020-09-06 19:06:16.157	2020-09-06 19:21:24.759	lawrence-horne
2550	b7267aba-6114-4d53-a519-bf6c99f4e3a9	2020-09-06 19:21:24.759	\N	sosa-hayes
2551	bd8778e5-02e8-4d1f-9c31-7b63942cc570	2020-09-06 19:21:24.759	\N	cell-barajas
2552	4204c2d1-ca48-4af7-b827-e99907f12d61	2020-09-06 19:21:24.759	\N	axel-cardenas
2553	80e474a3-7d2b-431d-8192-2f1e27162607	2020-09-06 19:21:24.759	\N	summers-preston
2554	cd68d3a6-7fbc-445d-90f1-970c955e32f4	2020-09-06 19:21:24.759	\N	miguel-wheeler
2555	316abea7-9890-4fb8-aaea-86b35e24d9be	2020-09-06 19:21:24.759	\N	kennedy-rodgers
2556	ad1e670a-f346-4bf7-a02f-a91649c41ccb	2020-09-06 19:21:24.759	\N	stephanie-winters
2557	7007cbd3-7c7b-44fd-9d6b-393e82b1c06e	2020-09-06 19:21:24.759	\N	rafael-davids
2558	d6c69d2d-9344-4b19-85a4-6cfcbaead5d2	2020-09-06 19:21:25.329	\N	joshua-watson
2559	97dfc1f6-ac94-4cdc-b0d5-1cb9f8984aa5	2020-09-06 19:21:23.752	2020-09-07 16:19:15.208	brock-forbes
2560	4f7d7490-7281-4f8f-b62e-37e99a7c46a0	2020-09-06 19:21:24.252	2020-09-07 16:19:15.208	annie-roland
2561	2b9f9c25-43ec-4f0b-9937-a5aa23be0d9e	2020-09-06 19:21:24.759	2020-09-09 10:18:48.274	lawrence-horne
2562	4f7d7490-7281-4f8f-b62e-37e99a7c46a0	2020-09-07 19:06:05.309	\N	annie-roland
2563	97dfc1f6-ac94-4cdc-b0d5-1cb9f8984aa5	2020-09-07 16:19:15.208	2020-09-07 19:06:07.026	brock-forbes
2564	97dfc1f6-ac94-4cdc-b0d5-1cb9f8984aa5	2020-09-07 19:06:07.026	\N	brock-forbes
2565	4f7d7490-7281-4f8f-b62e-37e99a7c46a0	2020-09-07 16:19:15.208	2020-09-07 19:06:05.309	annie-roland
2566	d8742d68-8fce-4d52-9a49-f4e33bd2a6fc	2020-09-08 05:12:37.473	\N	ortiz-morse
2567	b39b5aae-8571-4c90-887a-6a00f2a2f6fd	2020-09-08 05:12:37.985	\N	dickerson-morse
2568	21d52455-6c2c-4ee4-8673-ab46b4b926b4	2020-09-08 09:45:27.06	\N	wyatt-owens
2569	8903a74f-f322-41d2-bd75-dbf7563c4abb	2020-09-08 09:45:27.577	\N	francisca-sasquatch
2570	d89da2d2-674c-4b85-8959-a4bd406f760a	2020-09-08 10:30:52.878	\N	fish-summer
2571	d4a10c2a-0c28-466a-9213-38ba3339b65e	2020-09-08 10:30:58.945	\N	richmond-harrison
2572	5dbf11c0-994a-4482-bd1e-99379148ee45	2020-09-08 13:33:05.362	\N	conrad-vaughan
2573	c675fcdf-6117-49a6-ac32-99a89a3a88aa	2020-09-08 13:33:08.53	\N	valentine-games
2574	678170e4-0688-436d-a02d-c0467f9af8c0	2020-09-08 14:33:56.207	\N	baby-doyle
2575	248ccf3d-d5f6-4b69-83d9-40230ca909cd	2020-09-08 14:33:56.752	\N	antonio-wallace
2576	f2468055-e880-40bf-8ac6-a0763d846eb2	2020-09-08 14:33:57.869	\N	alaynabella-hollywood
2577	8604e861-d784-43f0-b0f8-0d43ea6f7814	2020-09-09 11:35:07.754	\N	randall-marijuana
2578	cf8e152e-2d27-4dcc-ba2b-68127de4e6a4	2020-09-09 11:35:09.353	\N	hendricks-richardson
2579	0bb35615-63f2-4492-80ec-b6b322dc5450	2020-08-09 19:27:41.958	2020-08-12 21:25:43.399	wyatt-mason-2
2580	21d52455-6c2c-4ee4-8673-ab46b4b926b4	2020-08-09 19:27:41.958	2020-08-12 21:25:43.399	wyatt-mason-4
2581	27c68d7f-5e40-4afa-8b6f-9df47b79e7dd	2020-08-09 19:27:41.958	2020-08-12 21:25:43.399	wyatt-mason-5
2582	1f159bab-923a-4811-b6fa-02bfde50925a	2020-08-06 10:08:37.49	2020-08-06 22:25:31.898	wyatt-mason
2583	1f159bab-923a-4811-b6fa-02bfde50925a	2020-08-06 22:25:31.898	2020-08-09 07:23:36.435	wyatt-mason
2584	378c07b0-5645-44b5-869f-497d144c7b35	2020-09-08 14:33:58.923	\N	fynn-doyle
2585	1ffb1153-909d-44c7-9df1-6ed3a9a45bbd	2020-09-08 14:33:59.438	\N	montgomery-bullock
2586	9f85676a-7411-444a-8ae2-c7f8f73c285c	2020-09-08 14:34:00.969	\N	lachlan-shelton
2587	c0732e36-3731-4f1a-abdc-daa9563b6506	2020-09-06 19:21:20.316	2020-09-08 20:08:20.992	nagomi-mcdaniel
2588	c0732e36-3731-4f1a-abdc-daa9563b6506	2020-09-08 20:08:20.992	\N	nagomi-mcdaniel
2589	126fb128-7c53-45b5-ac2b-5dbf9943d71b	2020-09-08 20:08:20.992	\N	sigmund-castillo
2590	11de4da3-8208-43ff-a1ff-0b3480a0fbf1	2020-09-09 00:41:36.121	\N	don-mitchell
2591	51c5473a-7545-4a9a-920d-d9b718d0e8d1	2020-09-09 00:41:38.455	\N	jacob-haynes
2592	da0bbbe6-d13c-40cc-9594-8c476975d93d	2020-09-08 17:21:21.506	2020-09-09 00:56:45.187	lang-richardson
2593	da0bbbe6-d13c-40cc-9594-8c476975d93d	2020-09-09 00:56:45.187	\N	lang-richardson
2594	d51f1fe8-4ab8-411e-b836-5bba92984d32	2020-09-08 22:09:44.927	2020-09-09 00:56:46.69	hiroto-cerna
2595	d51f1fe8-4ab8-411e-b836-5bba92984d32	2020-09-09 00:56:46.69	\N	hiroto-cerna
2596	9397ed91-608e-4b13-98ea-e94c795f651e	2020-09-08 17:21:23.599	2020-09-09 00:56:47.179	yeongho-garcia
2597	9397ed91-608e-4b13-98ea-e94c795f651e	2020-09-09 00:56:47.179	\N	yeongho-garcia
2598	611d18e0-b972-4cdd-afc2-793c56bfe5a9	2020-09-08 12:17:15.194	2020-09-09 00:56:49.26	alston-cerveza
2599	611d18e0-b972-4cdd-afc2-793c56bfe5a9	2020-09-09 00:56:49.26	\N	alston-cerveza
2600	4e6ad1a1-7c71-49de-8bd5-c286712faf9e	2020-09-09 05:14:47.884	\N	sutton-picklestein
2601	80de2b05-e0d4-4d33-9297-9951b2b5c950	2020-09-09 07:31:41.084	\N	alyssa-harrell
2602	66cebbbf-9933-4329-924a-72bd3718f321	2020-09-06 19:21:22.69	2020-09-09 07:32:12.772	kennedy-cena
2603	66cebbbf-9933-4329-924a-72bd3718f321	2020-09-09 07:32:12.772	\N	kennedy-cena
2604	ef9f8b95-9e73-49cd-be54-60f84858a285	2020-09-09 08:47:48.751	\N	collins-melon
2605	d8ee256f-e3d0-46cb-8c77-b1f88d8c9df9	2020-09-09 08:47:50.862	\N	comfort-septemberish
2606	2b9f9c25-43ec-4f0b-9937-a5aa23be0d9e	2020-09-09 10:18:48.274	\N	lawrence-horne
2607	0f62c20c-72d0-4c12-a9d7-312ea3d3bcd1	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	abner-wood
2608	11de4da3-8208-43ff-a1ff-0b3480a0fbf1	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	don-mitchell
2609	126fb128-7c53-45b5-ac2b-5dbf9943d71b	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	sigmund-castillo
2610	23e78d92-ee2d-498a-a99c-f40bc4c5fe99	2020-07-29 08:12:22.438	2020-08-02 10:22:48.089	annie-williams
2611	ce0e57a7-89f5-41ea-80f9-6e649dd54089	2020-09-06 19:21:24.759	\N	yong-wright
2147	bc4187fa-459a-4c06-bbf2-4e0e013d27ce	2020-08-28 15:19:34.297	2020-08-28 16:35:18.176	sixpack-dogwalker-deprecated
2148	bc4187fa-459a-4c06-bbf2-4e0e013d27ce	2020-08-28 16:35:18.176	\N	sixpack-dogwalker-deprecated
\.


--
-- Data for Name: position_types; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.position_types (position_type_id, position_type) FROM stdin;
0	BATTER
1	PITCHER
2	BULLPEN
3	BENCH
\.


--
-- Data for Name: team_divine_favor; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.team_divine_favor (team_divine_favor_id, team_id, valid_from, valid_until, divine_favor) FROM stdin;
1	b72f3061-f573-40d7-832a-5ad475bd7909	2020-07-29 08:12:22.438	2020-08-03 07:59:00	1
2	878c1bf6-0d21-4659-bfee-916c8314d69c	2020-07-29 08:12:22.438	2020-08-03 07:59:00	2
3	b024e975-1c4a-4575-8936-a3754a08806a	2020-07-29 08:12:22.438	2020-08-03 07:59:00	3
5	ca3f1c8c-c025-4d8e-8eef-5be6accbeb16	2020-07-29 08:12:22.438	2020-08-03 07:59:00	5
6	bfd38797-8404-4b38-8b82-341da28b1f83	2020-07-29 08:12:22.438	2020-08-03 07:59:00	6
7	3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e	2020-07-29 08:12:22.438	2020-08-03 07:59:00	7
8	979aee4a-6d80-4863-bf1c-ee1a78e06024	2020-07-29 08:12:22.438	2020-08-03 07:59:00	8
9	7966eb04-efcc-499b-8f03-d13916330531	2020-07-29 08:12:22.438	2020-08-03 07:59:00	9
11	8d87c468-699a-47a8-b40d-cfb73a5660ad	2020-07-29 08:12:22.438	2020-08-03 07:59:00	11
12	23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7	2020-07-29 08:12:22.438	2020-08-03 07:59:00	12
13	f02aeae2-5e6a-4098-9842-02d2273f25c7	2020-07-29 08:12:22.438	2020-08-03 07:59:00	13
14	57ec08cc-0411-4643-b304-0e80dbc15ac7	2020-07-29 08:12:22.438	2020-08-03 07:59:00	14
15	747b8e4a-7e50-4638-a973-ea7950a3e739	2020-07-29 08:12:22.438	2020-08-03 07:59:00	15
16	eb67ae5e-c4bf-46ca-bbbc-425cd34182ff	2020-07-29 08:12:22.438	2020-08-03 07:59:00	16
17	9debc64f-74b7-4ae1-a4d6-fce0144b6ea5	2020-07-29 08:12:22.438	2020-08-03 07:59:00	17
18	b63be8c2-576a-4d6e-8daf-814f8bcea96f	2020-07-29 08:12:22.438	2020-08-03 07:59:00	18
19	105bc3ff-1320-4e37-8ef0-8d595cb95dd0	2020-07-29 08:12:22.438	2020-08-03 07:59:00	19
4	adc5b394-8f76-416d-9ce9-813706877b84	2020-07-29 08:12:22.438	2020-08-03 07:59:00	4
10	36569151-a2fb-43c1-9df7-2df512424c82	2020-07-29 08:12:22.438	2020-08-03 07:59:00	10
20	a37f9158-7f82-46bc-908c-c9e2dda7c33b	2020-07-29 08:12:22.438	2020-08-03 07:59:00	20
60	ca3f1c8c-c025-4d8e-8eef-5be6accbeb16	2020-09-14 07:59:00	\N	1
61	a37f9158-7f82-46bc-908c-c9e2dda7c33b	2020-09-14 07:59:00	\N	2
62	b63be8c2-576a-4d6e-8daf-814f8bcea96f	2020-09-14 07:59:00	\N	3
63	979aee4a-6d80-4863-bf1c-ee1a78e06024	2020-09-14 07:59:00	\N	4
64	bfd38797-8404-4b38-8b82-341da28b1f83	2020-09-14 07:59:00	\N	5
65	b72f3061-f573-40d7-832a-5ad475bd7909	2020-09-14 07:59:00	\N	6
66	23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7	2020-09-14 07:59:00	\N	7
67	747b8e4a-7e50-4638-a973-ea7950a3e739	2020-09-14 07:59:00	\N	8
68	105bc3ff-1320-4e37-8ef0-8d595cb95dd0	2020-09-14 07:59:00	\N	9
69	f02aeae2-5e6a-4098-9842-02d2273f25c7	2020-09-14 07:59:00	\N	10
70	36569151-a2fb-43c1-9df7-2df512424c82	2020-09-14 07:59:00	\N	11
71	9debc64f-74b7-4ae1-a4d6-fce0144b6ea5	2020-09-14 07:59:00	\N	12
72	adc5b394-8f76-416d-9ce9-813706877b84	2020-09-14 07:59:00	\N	13
73	7966eb04-efcc-499b-8f03-d13916330531	2020-09-14 07:59:00	\N	14
74	b024e975-1c4a-4575-8936-a3754a08806a	2020-09-14 07:59:00	\N	15
75	8d87c468-699a-47a8-b40d-cfb73a5660ad	2020-09-14 07:59:00	\N	16
76	57ec08cc-0411-4643-b304-0e80dbc15ac7	2020-09-14 07:59:00	\N	17
77	3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e	2020-09-14 07:59:00	\N	18
78	eb67ae5e-c4bf-46ca-bbbc-425cd34182ff	2020-09-14 07:59:00	\N	19
79	878c1bf6-0d21-4659-bfee-916c8314d69c	2020-09-14 07:59:00	\N	20
21	23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7	2020-08-03 07:59:00	2020-09-14 07:59:00	1
41	b72f3061-f573-40d7-832a-5ad475bd7909	2020-08-03 07:59:00	2020-09-14 07:59:00	2
42	878c1bf6-0d21-4659-bfee-916c8314d69c	2020-08-03 07:59:00	2020-09-14 07:59:00	3
43	b024e975-1c4a-4575-8936-a3754a08806a	2020-08-03 07:59:00	2020-09-14 07:59:00	4
44	ca3f1c8c-c025-4d8e-8eef-5be6accbeb16	2020-08-03 07:59:00	2020-09-14 07:59:00	6
45	bfd38797-8404-4b38-8b82-341da28b1f83	2020-08-03 07:59:00	2020-09-14 07:59:00	7
46	3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e	2020-08-03 07:59:00	2020-09-14 07:59:00	8
47	979aee4a-6d80-4863-bf1c-ee1a78e06024	2020-08-03 07:59:00	2020-09-14 07:59:00	9
48	7966eb04-efcc-499b-8f03-d13916330531	2020-08-03 07:59:00	2020-09-14 07:59:00	10
49	8d87c468-699a-47a8-b40d-cfb73a5660ad	2020-08-03 07:59:00	2020-09-14 07:59:00	12
50	f02aeae2-5e6a-4098-9842-02d2273f25c7	2020-08-03 07:59:00	2020-09-14 07:59:00	13
51	57ec08cc-0411-4643-b304-0e80dbc15ac7	2020-08-03 07:59:00	2020-09-14 07:59:00	14
52	747b8e4a-7e50-4638-a973-ea7950a3e739	2020-08-03 07:59:00	2020-09-14 07:59:00	15
53	eb67ae5e-c4bf-46ca-bbbc-425cd34182ff	2020-08-03 07:59:00	2020-09-14 07:59:00	16
54	9debc64f-74b7-4ae1-a4d6-fce0144b6ea5	2020-08-03 07:59:00	2020-09-14 07:59:00	17
55	b63be8c2-576a-4d6e-8daf-814f8bcea96f	2020-08-03 07:59:00	2020-09-14 07:59:00	18
56	105bc3ff-1320-4e37-8ef0-8d595cb95dd0	2020-08-03 07:59:00	2020-09-14 07:59:00	19
57	adc5b394-8f76-416d-9ce9-813706877b84	2020-08-03 07:59:00	2020-09-14 07:59:00	5
58	36569151-a2fb-43c1-9df7-2df512424c82	2020-08-03 07:59:00	2020-09-14 07:59:00	11
59	a37f9158-7f82-46bc-908c-c9e2dda7c33b	2020-08-03 07:59:00	2020-09-14 07:59:00	20
\.


--
-- Data for Name: vibe_to_arrows; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.vibe_to_arrows (vibe_to_arrow_id, arrow_count, min_vibe, max_vibe) FROM stdin;
1	3	0.8	999
2	2	0.4	0.8
3	1	0.1	0.4
6	0	-0.1	0.1
7	-1	-0.4	-0.1
8	-2	-0.8	-0.4
9	0	-999	-0.8
\.


--
-- Data for Name: weather; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.weather (weather_id, weather_text) FROM stdin;
0	Void
1	Sunny
2	Overcast
3	Rainy
4	Sandstorm
5	Snowy
6	Acidic
7	Solar Eclipse
8	Glitter
9	Blooddrain
10	Peanuts
11	Birds
12	Feedback
13	Reverb
\.


--
-- Name: game_event_base_runners_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.game_event_base_runners_id_seq', 313082, true);


--
-- Name: game_events_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.game_events_id_seq', 359300, true);


--
-- Name: imported_logs_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.imported_logs_id_seq', 2090, true);


--
-- Name: player_events_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.player_events_id_seq', 256, true);


--
-- Name: player_modifications_player_modifications_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.player_modifications_player_modifications_id_seq', 158, true);


--
-- Name: players_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.players_id_seq', 3570, true);


--
-- Name: team_modifications_team_modifications_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.team_modifications_team_modifications_id_seq', 1, false);


--
-- Name: team_positions_team_position_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.team_positions_team_position_id_seq', 794, true);


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.teams_id_seq', 27, true);


--
-- Name: time_map_time_map_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.time_map_time_map_id_seq', 359300, true);


--
-- Name: attributes_attribute_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.attributes_attribute_id_seq', 64, true);


--
-- Name: change_types_change_type_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.change_types_change_type_id_seq', 3, true);


--
-- Name: division_teams_division_teams_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.division_teams_division_teams_id_seq', 40, true);


--
-- Name: divisions_division_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.divisions_division_id_seq', 8, true);


--
-- Name: event_types_event_type_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.event_types_event_type_id_seq', 28, true);


--
-- Name: leagues_league_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.leagues_league_id_seq', 4, true);


--
-- Name: player_url_slugs_player_url_slug_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.player_url_slugs_player_url_slug_id_seq', 2611, true);


--
-- Name: team_divine_favor_team_divine_favor_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.team_divine_favor_team_divine_favor_id_seq', 79, true);


--
-- Name: vibe_to_arrows_vibe_to_arrow_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.vibe_to_arrows_vibe_to_arrow_id_seq', 13, true);


--
-- Name: game_event_base_runners game_event_base_runners_pkey; Type: CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.game_event_base_runners
    ADD CONSTRAINT game_event_base_runners_pkey PRIMARY KEY (id);


--
-- Name: game_events game_events_pkey; Type: CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.game_events
    ADD CONSTRAINT game_events_pkey PRIMARY KEY (id);


--
-- Name: games game_pkey; Type: CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.games
    ADD CONSTRAINT game_pkey PRIMARY KEY (game_id);


--
-- Name: imported_logs imported_logs_pkey; Type: CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.imported_logs
    ADD CONSTRAINT imported_logs_pkey PRIMARY KEY (id);


--
-- Name: outcomes player_events_pkey; Type: CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.outcomes
    ADD CONSTRAINT player_events_pkey PRIMARY KEY (id);


--
-- Name: player_modifications player_modifications_pkey; Type: CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.player_modifications
    ADD CONSTRAINT player_modifications_pkey PRIMARY KEY (player_modifications_id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: time_map season_day_unique; Type: CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.time_map
    ADD CONSTRAINT season_day_unique UNIQUE (season, day);


--
-- Name: team_modifications team_modifications_pkey; Type: CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.team_modifications
    ADD CONSTRAINT team_modifications_pkey PRIMARY KEY (team_modifications_id);


--
-- Name: team_roster team_roster_pkey; Type: CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.team_roster
    ADD CONSTRAINT team_roster_pkey PRIMARY KEY (team_roster_id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: time_map time_map_pkey; Type: CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.time_map
    ADD CONSTRAINT time_map_pkey PRIMARY KEY (time_map_id);


--
-- Name: attributes attributes_pkey; Type: CONSTRAINT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.attributes
    ADD CONSTRAINT attributes_pkey PRIMARY KEY (attribute_id);


--
-- Name: event_types event_types_pkey; Type: CONSTRAINT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.event_types
    ADD CONSTRAINT event_types_pkey PRIMARY KEY (event_type_id);


--
-- Name: team_roster_idx; Type: INDEX; Schema: data; Owner: -
--

CREATE INDEX team_roster_idx ON data.team_roster USING btree (valid_until NULLS FIRST, team_id, position_id, position_type_id) INCLUDE (team_id, position_id, valid_until, position_type_id);


--
-- Name: game_event_base_runners game_event_base_runners_game_event_id_fkey; Type: FK CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.game_event_base_runners
    ADD CONSTRAINT game_event_base_runners_game_event_id_fkey FOREIGN KEY (game_event_id) REFERENCES data.game_events(id) ON DELETE CASCADE;


--
-- Name: game_events game_events_game_id_fkey; Type: FK CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.game_events
    ADD CONSTRAINT game_events_game_id_fkey FOREIGN KEY (game_id) REFERENCES data.games(game_id) ON DELETE CASCADE;


--
-- Name: outcomes player_events_game_event_id_fkey; Type: FK CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.outcomes
    ADD CONSTRAINT player_events_game_event_id_fkey FOREIGN KEY (game_event_id) REFERENCES data.game_events(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

