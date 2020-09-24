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
DROP INDEX IF EXISTS data.game_events_indx_event_type;
ALTER TABLE IF EXISTS ONLY taxa.event_types DROP CONSTRAINT IF EXISTS event_types_pkey;
ALTER TABLE IF EXISTS ONLY taxa.event_types DROP CONSTRAINT IF EXISTS event_types_event_type_key;
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
DROP TABLE IF EXISTS taxa.pitch_types;
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
DROP VIEW IF EXISTS data.running_stats_vs_pitcher_season;
DROP VIEW IF EXISTS data.running_stats_vs_pitcher_playoffs_season;
DROP VIEW IF EXISTS data.running_stats_vs_pitcher_playoffs_lifetime;
DROP VIEW IF EXISTS data.running_stats_vs_pitcher_lifetime;
DROP VIEW IF EXISTS data.running_stats_player_season;
DROP VIEW IF EXISTS data.running_stats_player_playoffs_season;
DROP VIEW IF EXISTS data.running_stats_player_playoffs_lifetime;
DROP VIEW IF EXISTS data.running_stats_player_lifetime;
DROP VIEW IF EXISTS data.running_stats_all_events;
DROP VIEW IF EXISTS data.rosters_extended_current;
DROP VIEW IF EXISTS data.rosters_current;
DROP VIEW IF EXISTS data.players_info_super_expanded_all_details;
DROP VIEW IF EXISTS data.players_info_expanded_all;
DROP SEQUENCE IF EXISTS data.players_id_seq;
DROP VIEW IF EXISTS data.players_current;
DROP SEQUENCE IF EXISTS data.player_modifications_player_modifications_id_seq;
DROP TABLE IF EXISTS data.player_modifications;
DROP SEQUENCE IF EXISTS data.player_events_id_seq;
DROP VIEW IF EXISTS data.pitching_stats_player_season_team;
DROP VIEW IF EXISTS data.pitching_stats_player_season;
DROP VIEW IF EXISTS data.pitching_stats_player_playoffs_season;
DROP VIEW IF EXISTS data.pitching_stats_player_playoffs_lifetime;
DROP VIEW IF EXISTS data.pitching_stats_player_lifetime;
DROP VIEW IF EXISTS data.pitching_stats_all_appearances;
DROP TABLE IF EXISTS data.outcomes;
DROP SEQUENCE IF EXISTS data.imported_logs_id_seq;
DROP TABLE IF EXISTS data.imported_logs;
DROP SEQUENCE IF EXISTS data.game_events_id_seq;
DROP SEQUENCE IF EXISTS data.game_event_base_runners_id_seq;
DROP VIEW IF EXISTS data.fielder_stats_season;
DROP VIEW IF EXISTS data.fielder_stats_playoffs_season;
DROP VIEW IF EXISTS data.fielder_stats_playoffs_lifetime;
DROP VIEW IF EXISTS data.fielder_stats_lifetime;
DROP VIEW IF EXISTS data.fielder_stats_all_events;
DROP VIEW IF EXISTS data.batting_stats_player_vs_team_season;
DROP VIEW IF EXISTS data.batting_stats_player_vs_team_playoffs_season;
DROP VIEW IF EXISTS data.batting_stats_player_vs_team_playoffs_lifetime;
DROP VIEW IF EXISTS data.batting_stats_player_vs_team_lifetime;
DROP VIEW IF EXISTS data.batting_stats_player_vs_pitcher_season;
DROP VIEW IF EXISTS data.batting_stats_player_vs_pitcher_playoffs_season;
DROP VIEW IF EXISTS data.batting_stats_player_vs_pitcher_playoffs_lifetime;
DROP VIEW IF EXISTS data.batting_stats_player_vs_pitcher_lifetime;
DROP VIEW IF EXISTS data.batting_stats_player_season_team;
DROP VIEW IF EXISTS data.batting_stats_player_season;
DROP VIEW IF EXISTS data.batting_stats_player_playoffs_season;
DROP VIEW IF EXISTS data.batting_stats_player_playoffs_lifetime;
DROP VIEW IF EXISTS data.batting_stats_player_lifetime;
DROP VIEW IF EXISTS data.players_extended_current;
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
DROP FUNCTION IF EXISTS data.timestamp_from_gameday(in_season integer, in_gameday integer);
DROP FUNCTION IF EXISTS data.teams_from_timestamp(in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.slugging(in_total_bases_from_hits bigint, in_at_bats bigint);
DROP FUNCTION IF EXISTS data.season_timespan(in_season integer);
DROP FUNCTION IF EXISTS data.round_half_even(val numeric, prec integer);
DROP FUNCTION IF EXISTS data.rosters_from_timestamp(in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.rating_to_star(in_rating numeric);
DROP FUNCTION IF EXISTS data.players_from_timestamp(in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.player_mods_from_timestamp(in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.player_day_vibe(in_player_id character varying, in_gameday integer, in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.pitching_rating_raw(in_unthwackability numeric, in_ruthlessness numeric, in_overpowerment numeric, in_shakespearianism numeric, in_coldness numeric);
DROP FUNCTION IF EXISTS data.pitching_rating(in_player_id character varying, in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.pitcher_idol_coins(in_player_id character varying, in_season integer);
DROP FUNCTION IF EXISTS data.on_base_percentage(in_hits bigint, in_raw_at_bats bigint, in_walks bigint, in_sacs bigint);
DROP FUNCTION IF EXISTS data.last_position_in_string(in_string text, in_search text);
DROP FUNCTION IF EXISTS data.innings_from_outs(in_outs numeric);
DROP FUNCTION IF EXISTS data.gameday_from_timestamp(in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.earned_run_average(in_runs numeric, in_outs numeric);
DROP FUNCTION IF EXISTS data.defense_rating_raw(in_omniscience numeric, in_tenaciousness numeric, in_watchfulness numeric, in_anticapitalism numeric, in_chasiness numeric);
DROP FUNCTION IF EXISTS data.defense_rating(in_player_id character varying, in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.current_season();
DROP FUNCTION IF EXISTS data.current_gameday();
DROP FUNCTION IF EXISTS data.batting_rating_raw(in_tragicness numeric, in_patheticism numeric, in_thwackability numeric, in_divinity numeric, in_moxie numeric, in_musclitude numeric, in_martyrdom numeric);
DROP FUNCTION IF EXISTS data.batting_rating(in_player_id character varying, in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.batting_average(in_hits bigint, in_raw_at_bats bigint);
DROP FUNCTION IF EXISTS data.batter_idol_coins(in_player_id character varying, in_season integer);
DROP FUNCTION IF EXISTS data.baserunning_rating_raw(in_laserlikeness numeric, in_continuation numeric, in_base_thirst numeric, in_indulgence numeric, in_ground_friction numeric);
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
	round(power(p.laserlikeness,0.5) *
   	power(p.continuation * p.base_thirst * p.indulgence * p.ground_friction, 0.1),15)
FROM data.players_from_timestamp(in_timestamp) p

WHERE p.player_id = in_player_id
$$;


--
-- Name: baserunning_rating_raw(numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.baserunning_rating_raw(in_laserlikeness numeric, in_continuation numeric, in_base_thirst numeric, in_indulgence numeric, in_ground_friction numeric) RETURNS numeric
    LANGUAGE sql
    AS $$
SELECT 
	round(power(in_laserlikeness,0.5) *
	power(in_continuation * in_base_thirst * in_indulgence * in_ground_friction, 0.1),15);
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
   round(power((1 - p.tragicness),0.01) * 
   power((1 - p.patheticism),0.05) *
   power((p.thwackability * p.divinity),0.35) *
   power((p.moxie * p.musclitude),0.075) * 
   power(p.martyrdom,0.02),15)
FROM data.players_from_timestamp(in_timestamp) p
WHERE player_id = in_player_id;
$$;


--
-- Name: batting_rating_raw(numeric, numeric, numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.batting_rating_raw(in_tragicness numeric, in_patheticism numeric, in_thwackability numeric, in_divinity numeric, in_moxie numeric, in_musclitude numeric, in_martyrdom numeric) RETURNS numeric
    LANGUAGE sql
    AS $$
SELECT 
   round(power((1 - in_tragicness),0.01) * 
   power((1 - in_patheticism),0.05) *
   power((in_thwackability * in_divinity),0.35) *
   power((in_moxie * in_musclitude),0.075) * 
   power(in_martyrdom,0.02),15);
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
	round(power((p.omniscience * p.tenaciousness),0.2) *
   	power((p.watchfulness * p.anticapitalism * p.chasiness),0.1),15)
FROM data.players_from_timestamp(in_timestamp) p
WHERE p.player_id = in_player_id;
$$;


--
-- Name: defense_rating_raw(numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.defense_rating_raw(in_omniscience numeric, in_tenaciousness numeric, in_watchfulness numeric, in_anticapitalism numeric, in_chasiness numeric) RETURNS numeric
    LANGUAGE sql
    AS $$
SELECT 
	round(power((in_omniscience * in_tenaciousness),0.2) *
   	power((in_watchfulness * in_anticapitalism * in_chasiness),0.1),15);
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
  			SELECT season FROM data.time_map WHERE first_time = 
			(
				SELECT max(first_time)
				FROM data.time_map 
				WHERE first_time < in_timestamp
			)	
		)
	,0)
),(
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
	SELECT coalesce(SUM(shutout),0) FROM
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
round(
power(p.unthwackability,0.5) * 
power(p.ruthlessness,0.4) *
power(p.overpowerment,0.15) * 
power(p.shakespearianism,0.1) * 
power(p.coldness,0.025),15)
FROM data.players_from_timestamp(in_timestamp) p
WHERE 
p.player_id = in_player_id;
$$;


--
-- Name: pitching_rating_raw(numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.pitching_rating_raw(in_unthwackability numeric, in_ruthlessness numeric, in_overpowerment numeric, in_shakespearianism numeric, in_coldness numeric) RETURNS numeric
    LANGUAGE sql
    AS $$
SELECT 
round(
	power(in_unthwackability,0.5) * 
	power(in_ruthlessness,0.4) *
	power(in_overpowerment,0.15) * 
	power(in_shakespearianism,0.1) * 
	power(in_coldness,0.025),15);
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
-- Name: player_mods_from_timestamp(timestamp without time zone); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.player_mods_from_timestamp(in_timestamp timestamp without time zone) RETURNS TABLE(player_modifications_id integer, player_id character varying, modification character varying, valid_from timestamp without time zone, valid_until timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
begin
	return query 
	select *
	from data.player_modifications m
	where m.valid_from <= in_timestamp 
	and in_timestamp < coalesce(m.valid_until,NOW()+ (INTERVAL '1 millisecond'));

end;
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
	where p.valid_from <= in_timestamp + (INTERVAL '1 millisecond')
	and in_timestamp < coalesce(p.valid_until,NOW() + (INTERVAL '1 millisecond'));
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

CREATE FUNCTION data.rosters_from_timestamp(in_timestamp timestamp without time zone) RETURNS TABLE(team_roster_id integer, team_id character varying, position_id integer, valid_from timestamp without time zone, valid_until timestamp without time zone, player_id character varying, position_type_id numeric)
    LANGUAGE plpgsql
    AS $$
begin
	return query 
	
	select *
	from data.team_roster r
	where r.valid_from <= in_timestamp 
	and in_timestamp < coalesce(r.valid_until,NOW()+ (INTERVAL '1 millisecond'));

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
		where t.valid_from <= in_timestamp 
		and in_timestamp < coalesce(t.valid_until,NOW()+ (INTERVAL '1 millisecond'));
end;
$$;


--
-- Name: timestamp_from_gameday(integer, integer); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.timestamp_from_gameday(in_season integer, in_gameday integer) RETURNS timestamp without time zone
    LANGUAGE sql
    AS $$
SELECT first_time FROM data.time_map where season = in_season and day = in_gameday;
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
    runner_scored boolean DEFAULT false
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
    home_strike_count smallint DEFAULT '3'::smallint,
    away_strike_count smallint DEFAULT '3'::smallint,
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
    fixed_error_list text[],
    home_ball_count integer DEFAULT 4,
    away_ball_count integer DEFAULT 4,
    away_base_count integer DEFAULT 4,
    home_base_count integer DEFAULT 4
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
    statsheet_id character varying(36),
    winning_pitcher_id character varying,
    losing_pitcher_id character varying
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
            WHEN (ge.top_of_inning AND ((ge.away_base_count - COALESCE(geb.max_base_before, ge.away_base_count)) > 1)) THEN xe.at_bat
            WHEN ((NOT ge.top_of_inning) AND ((ge.home_base_count - COALESCE(geb.max_base_before, ge.home_base_count)) > 1)) THEN xe.at_bat
            ELSE 0
        END AS at_bat_risp,
        CASE
            WHEN (ge.top_of_inning AND ((ge.away_base_count - COALESCE(geb.max_base_before, ge.away_base_count)) > 1)) THEN xe.hit
            WHEN ((NOT ge.top_of_inning) AND ((ge.home_base_count - COALESCE(geb.max_base_before, ge.home_base_count)) > 1)) THEN xe.hit
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
    ga.is_postseason,
    ga.weather AS weather_id
   FROM (((data.game_events ge
     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
     JOIN data.games ga ON (((ge.game_id)::text = (ga.game_id)::text)))
     LEFT JOIN ( SELECT max(game_event_base_runners.base_before_play) AS max_base_before,
            game_event_base_runners.game_event_id
           FROM data.game_event_base_runners
          GROUP BY game_event_base_runners.game_event_id) geb ON ((ge.id = geb.game_event_id)))
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
    player_url_slug character varying,
    player_name character varying
);


--
-- Name: position_types; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.position_types (
    position_type_id integer,
    position_type character varying
);


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
-- Name: batting_stats_player_lifetime; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_player_lifetime AS
 SELECT p.player_name,
    a.player_id,
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
   FROM (data.batting_stats_all_events a
     JOIN data.players_extended_current p ON (((a.player_id)::text = (p.player_id)::text)))
  WHERE (NOT a.is_postseason)
  GROUP BY a.player_id, p.player_name;


--
-- Name: batting_stats_player_playoffs_lifetime; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_player_playoffs_lifetime AS
 SELECT p.player_name,
    a.player_id,
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
   FROM (data.batting_stats_all_events a
     JOIN data.players_extended_current p ON (((a.player_id)::text = (p.player_id)::text)))
  WHERE a.is_postseason
  GROUP BY a.player_id, p.player_name;


--
-- Name: batting_stats_player_playoffs_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_player_playoffs_season AS
 SELECT p.player_name,
    a.player_id,
    a.batter_team_id AS team_id,
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
   FROM (data.batting_stats_all_events a
     JOIN data.players_extended_current p ON (((a.player_id)::text = (p.player_id)::text)))
  WHERE a.is_postseason
  GROUP BY a.player_id, p.player_name, a.batter_team_id;


--
-- Name: batting_stats_player_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_player_season AS
 SELECT p.player_name,
    a.player_id,
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
   FROM (data.batting_stats_all_events a
     JOIN data.players_extended_current p ON (((a.player_id)::text = (p.player_id)::text)))
  WHERE (NOT a.is_postseason)
  GROUP BY a.player_id, p.player_name, a.season;


--
-- Name: batting_stats_player_season_team; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_player_season_team AS
 SELECT p.player_name,
    a.player_id,
    a.batter_team_id AS team_id,
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
   FROM (data.batting_stats_all_events a
     JOIN data.players_extended_current p ON (((a.player_id)::text = (p.player_id)::text)))
  WHERE (NOT a.is_postseason)
  GROUP BY a.player_id, p.player_name, a.season, a.batter_team_id;


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
     JOIN data.players_extended_current p ON (((a.player_id)::text = (p.player_id)::text)))
     JOIN data.players_extended_current v ON (((a.pitcher_id)::text = (v.player_id)::text)))
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
     JOIN data.players_extended_current p ON (((a.player_id)::text = (p.player_id)::text)))
     JOIN data.players_extended_current v ON (((a.pitcher_id)::text = (v.player_id)::text)))
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
     JOIN data.players_extended_current p ON (((a.player_id)::text = (p.player_id)::text)))
     JOIN data.players_extended_current v ON (((a.pitcher_id)::text = (v.player_id)::text)))
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
     JOIN data.players_extended_current p ON (((a.player_id)::text = (p.player_id)::text)))
     JOIN data.players_extended_current v ON (((a.pitcher_id)::text = (v.player_id)::text)))
  WHERE (NOT a.is_postseason)
  GROUP BY v.player_name, a.player_id, p.player_name, a.pitcher_id, a.season;


--
-- Name: batting_stats_player_vs_team_lifetime; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_player_vs_team_lifetime AS
 SELECT p.player_name,
    a.player_id,
    a.pitcher_team_id AS opponent_team_id,
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
   FROM (data.batting_stats_all_events a
     JOIN data.players_extended_current p ON (((a.player_id)::text = (p.player_id)::text)))
  WHERE (NOT a.is_postseason)
  GROUP BY a.player_id, p.player_name, a.pitcher_team_id;


--
-- Name: batting_stats_player_vs_team_playoffs_lifetime; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_player_vs_team_playoffs_lifetime AS
 SELECT p.player_name,
    a.player_id,
    a.pitcher_team_id AS opponent_team_id,
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
   FROM (data.batting_stats_all_events a
     JOIN data.players_extended_current p ON (((a.player_id)::text = (p.player_id)::text)))
  WHERE a.is_postseason
  GROUP BY a.player_id, p.player_name, a.pitcher_team_id;


--
-- Name: batting_stats_player_vs_team_playoffs_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_player_vs_team_playoffs_season AS
 SELECT p.player_name,
    a.player_id,
    a.pitcher_team_id AS opponent_team_id,
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
   FROM (data.batting_stats_all_events a
     JOIN data.players_extended_current p ON (((a.player_id)::text = (p.player_id)::text)))
  WHERE a.is_postseason
  GROUP BY a.player_id, p.player_name, a.pitcher_team_id, a.season;


--
-- Name: batting_stats_player_vs_team_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_player_vs_team_season AS
 SELECT p.player_name,
    a.player_id,
    a.pitcher_team_id AS opponent_team_id,
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
   FROM (data.batting_stats_all_events a
     JOIN data.players_extended_current p ON (((a.player_id)::text = (p.player_id)::text)))
  WHERE (NOT a.is_postseason)
  GROUP BY a.player_id, p.player_name, a.pitcher_team_id, a.season;


--
-- Name: fielder_stats_all_events; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.fielder_stats_all_events AS
 SELECT d.batter,
    d.batter_id,
    d.season,
    d.day,
    d.inning,
    d.batted_ball_type,
    d.fielder AS player_name,
    pd.player_id,
    d.game_id,
    d.weather_id
   FROM (( SELECT p.player_name AS batter,
            p.player_id AS batter_id,
            ge.season,
            ge.day,
            ge.inning,
            ge.batted_ball_type,
            ge.game_id,
            ga.weather AS weather_id,
                CASE
                    WHEN (ge.batted_ball_type = 'GROUNDER'::text) THEN replace("substring"((ge.event_text)::text, '.*ground out to \s*([^.]*)'::text), '''s Shell'::text, ''::text)
                    WHEN (ge.batted_ball_type = 'FLY'::text) THEN replace("substring"((ge.event_text)::text, '.*flyout to \s*([^.]*)'::text), '''s Shell'::text, ''::text)
                    ELSE NULL::text
                END AS fielder
           FROM ((data.game_events ge
             JOIN data.players_extended_current p ON (((p.player_id)::text = (ge.batter_id)::text)))
             JOIN data.games ga ON (((ge.game_id)::text = (ga.game_id)::text)))
          WHERE ((ge.batted_ball_type = ANY (ARRAY['FLY'::text, 'GROUNDER'::text])) AND (ge.event_type = 'OUT'::text))) d
     JOIN data.players_extended_current pd ON ((d.fielder = (pd.player_name)::text)));


--
-- Name: fielder_stats_lifetime; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.fielder_stats_lifetime AS
 SELECT f.player_name,
    f.player_id,
    count(1) AS plays
   FROM data.fielder_stats_all_events f
  WHERE (f.day < 99)
  GROUP BY f.player_name, f.player_id;


--
-- Name: fielder_stats_playoffs_lifetime; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.fielder_stats_playoffs_lifetime AS
 SELECT f.player_name,
    f.player_id,
    count(1) AS plays
   FROM data.fielder_stats_all_events f
  WHERE (f.day >= 99)
  GROUP BY f.player_name, f.player_id;


--
-- Name: fielder_stats_playoffs_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.fielder_stats_playoffs_season AS
 SELECT f.player_name,
    f.player_id,
    f.season,
    count(1) AS plays
   FROM data.fielder_stats_all_events f
  WHERE (f.day >= 99)
  GROUP BY f.player_name, f.player_id, f.season;


--
-- Name: fielder_stats_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.fielder_stats_season AS
 SELECT f.player_name,
    f.player_id,
    f.season,
    count(1) AS plays
   FROM data.fielder_stats_all_events f
  WHERE (f.day < 99)
  GROUP BY f.player_name, f.player_id, f.season;


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
-- Name: pitching_stats_all_appearances; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.pitching_stats_all_appearances AS
 SELECT ge.game_id,
    ge.pitcher_id AS player_id,
    ge.pitcher_team_id AS team_id,
    ge.season,
    ge.day,
        CASE
            WHEN ((ga.winning_pitcher_id)::text = (ge.pitcher_id)::text) THEN 1
            ELSE 0
        END AS win,
        CASE
            WHEN ((ga.losing_pitcher_id)::text = (ge.pitcher_id)::text) THEN 1
            ELSE 0
        END AS loss,
    sum(array_length(ge.pitches, 1)) AS pitch_count,
    ge.top_of_inning,
    sum(ge.outs_on_play) AS outs_recorded,
    sum(ge.runs_batted_in) AS runs_allowed,
    sum(
        CASE
            WHEN (ge.event_type = 'STRIKEOUT'::text) THEN 1
            ELSE 0
        END) AS strikeouts,
    sum(
        CASE
            WHEN (ge.event_type = 'WALK'::text) THEN 1
            ELSE 0
        END) AS walks,
    sum(
        CASE
            WHEN (ge.event_type = 'HOME_RUN'::text) THEN 1
            ELSE 0
        END) AS hrs_allowed,
    sum(xe.hit) AS hits_allowed,
    ga.weather AS weather_id,
    ga.is_postseason
   FROM (((data.game_events ge
     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
     JOIN data.games ga ON (((ge.game_id)::text = (ga.game_id)::text)))
     JOIN ( SELECT max(game_events.home_score) AS home_final,
            max(game_events.away_score) AS away_final,
            game_events.game_id
           FROM data.game_events
          GROUP BY game_events.game_id) fs ON (((ge.game_id)::text = (fs.game_id)::text)))
  GROUP BY ge.season, ge.day, ge.game_id, ge.pitcher_id, ga.winning_pitcher_id, ga.losing_pitcher_id, ge.pitcher_team_id, ge.top_of_inning, fs.home_final, fs.away_final, ga.weather, ga.is_postseason;


--
-- Name: pitching_stats_player_lifetime; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.pitching_stats_player_lifetime AS
 SELECT p.player_id,
    count(1) AS games,
    sum(p.pitch_count) AS pitch_count,
    sum(p.outs_recorded) AS outs_recorded,
    round((sum(p.outs_recorded) / (3)::numeric), 2) AS innings,
    sum(p.runs_allowed) AS runs_allowed,
    round((((9)::numeric * sum(p.runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS era,
    sum(p.strikeouts) AS strikeouts,
    round(((sum(p.strikeouts) * (9)::numeric) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS k_per_9,
    sum(p.walks) AS walks,
    sum(p.hrs_allowed) AS hrs_allowed,
    sum(p.hits_allowed) AS hits_allowed
   FROM data.pitching_stats_all_appearances p
  WHERE (NOT p.is_postseason)
  GROUP BY p.player_id;


--
-- Name: pitching_stats_player_playoffs_lifetime; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.pitching_stats_player_playoffs_lifetime AS
 SELECT p.player_id,
    count(1) AS games,
    sum(p.pitch_count) AS pitch_count,
    sum(p.outs_recorded) AS outs_recorded,
    round((sum(p.outs_recorded) / (3)::numeric), 2) AS innings,
    sum(p.runs_allowed) AS runs_allowed,
    round((((9)::numeric * sum(p.runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS era,
    sum(p.strikeouts) AS strikeouts,
    round(((sum(p.strikeouts) * (9)::numeric) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS k_per_9,
    sum(p.walks) AS walks,
    sum(p.hrs_allowed) AS hrs_allowed,
    sum(p.hits_allowed) AS hits_allowed
   FROM data.pitching_stats_all_appearances p
  WHERE p.is_postseason
  GROUP BY p.player_id;


--
-- Name: pitching_stats_player_playoffs_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.pitching_stats_player_playoffs_season AS
 SELECT p.player_id,
    p.season,
    count(1) AS games,
    sum(p.pitch_count) AS pitch_count,
    sum(p.outs_recorded) AS outs_recorded,
    round((sum(p.outs_recorded) / (3)::numeric), 2) AS innings,
    sum(p.runs_allowed) AS runs_allowed,
    round((((9)::numeric * sum(p.runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS era,
    sum(p.strikeouts) AS strikeouts,
    round(((sum(p.strikeouts) * (9)::numeric) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS k_per_9,
    sum(p.walks) AS walks,
    sum(p.hrs_allowed) AS hrs_allowed,
    sum(p.hits_allowed) AS hits_allowed
   FROM data.pitching_stats_all_appearances p
  WHERE p.is_postseason
  GROUP BY p.player_id, p.season;


--
-- Name: pitching_stats_player_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.pitching_stats_player_season AS
 SELECT p.player_id,
    p.season,
    count(1) AS games,
    sum(p.pitch_count) AS pitch_count,
    sum(p.outs_recorded) AS outs_recorded,
    round((sum(p.outs_recorded) / (3)::numeric), 2) AS innings,
    sum(p.runs_allowed) AS runs_allowed,
    round((((9)::numeric * sum(p.runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS era,
    sum(p.strikeouts) AS strikeouts,
    round(((sum(p.strikeouts) * (9)::numeric) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS k_per_9,
    sum(p.walks) AS walks,
    sum(p.hrs_allowed) AS hrs_allowed,
    sum(p.hits_allowed) AS hits_allowed
   FROM data.pitching_stats_all_appearances p
  WHERE (NOT p.is_postseason)
  GROUP BY p.player_id, p.season;


--
-- Name: pitching_stats_player_season_team; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.pitching_stats_player_season_team AS
 SELECT p.player_id,
    p.team_id,
    p.season,
    count(1) AS games,
    sum(p.pitch_count) AS pitch_count,
    sum(p.outs_recorded) AS outs_recorded,
    round((sum(p.outs_recorded) / (3)::numeric), 2) AS innings,
    sum(p.runs_allowed) AS runs_allowed,
    round((((9)::numeric * sum(p.runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS era,
    sum(p.strikeouts) AS strikeouts,
    round(((sum(p.strikeouts) * (9)::numeric) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS k_per_9,
    sum(p.walks) AS walks,
    sum(p.hrs_allowed) AS hrs_allowed,
    sum(p.hits_allowed) AS hits_allowed
   FROM data.pitching_stats_all_appearances p
  WHERE (NOT p.is_postseason)
  GROUP BY p.player_id, p.team_id, p.season;


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
    ( SELECT rosters_from_timestamp.team_id
           FROM data.rosters_from_timestamp(COALESCE(p.valid_from, (now())::timestamp without time zone)) rosters_from_timestamp(team_roster_id, team_id, position_id, valid_from, valid_until, player_id, position_type_id)
          WHERE ((rosters_from_timestamp.player_id)::text = (p.player_id)::text)) AS team_id,
    ( SELECT t.nickname
           FROM (data.rosters_from_timestamp(COALESCE(p.valid_from, (now())::timestamp without time zone)) r(team_roster_id, team_id, position_id, valid_from, valid_until, player_id, position_type_id)
             JOIN data.teams_current t ON (((r.team_id)::text = (t.team_id)::text)))
          WHERE ((r.player_id)::text = (p.player_id)::text)) AS team,
    ( SELECT gameday_from_timestamp.season
           FROM data.gameday_from_timestamp(COALESCE(p.valid_from, (now())::timestamp without time zone)) gameday_from_timestamp(season, gameday)) AS season_from,
    ( SELECT gameday_from_timestamp.gameday
           FROM data.gameday_from_timestamp(COALESCE(p.valid_from, (now())::timestamp without time zone)) gameday_from_timestamp(season, gameday)) AS gameday_from,
    p.deceased,
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
    data.batting_rating(p.player_id, COALESCE(p.valid_from, (now())::timestamp without time zone)) AS batting_rating,
    data.baserunning_rating(p.player_id, COALESCE(p.valid_from, (now())::timestamp without time zone)) AS baserunning_rating,
    data.defense_rating(p.player_id, COALESCE(p.valid_from, (now())::timestamp without time zone)) AS defense_rating,
    data.pitching_rating(p.player_id, COALESCE(p.valid_from, (now())::timestamp without time zone)) AS pitching_rating,
    data.rating_to_star(data.batting_rating(p.player_id, COALESCE(p.valid_from, (now())::timestamp without time zone))) AS batting_stars,
    data.rating_to_star(data.baserunning_rating(p.player_id, COALESCE(p.valid_from, (now())::timestamp without time zone))) AS baserunning_stars,
    data.rating_to_star(data.defense_rating(p.player_id, COALESCE(p.valid_from, (now())::timestamp without time zone))) AS defense_stars,
    data.rating_to_star(data.pitching_rating(p.player_id, COALESCE(p.valid_from, (now())::timestamp without time zone))) AS pitching_stars
   FROM data.players p;


--
-- Name: players_info_super_expanded_all_details; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.players_info_super_expanded_all_details AS
 SELECT y.player_id,
    y.timestampd AS valid_from,
    lead(y.timestampd) OVER (PARTITION BY y.player_id ORDER BY y.timestampd) AS valid_until,
    ( SELECT gg.gameday
           FROM data.gameday_from_timestamp(y.timestampd) gg(season, gameday)) AS gameday_from,
    ( SELECT gs.season
           FROM data.gameday_from_timestamp(y.timestampd) gs(season, gameday)) AS season_from,
    p.player_name,
    p.deceased,
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
    p.peanut_allergy AS lean,
    p.armor,
    p.bat,
    p.ritual,
    p.coffee,
    p.blood,
    data.batting_rating_raw(p.tragicness, p.patheticism, p.thwackability, p.divinity, p.moxie, p.musclitude, p.martyrdom) AS batting_rating,
    data.baserunning_rating_raw(p.laserlikeness, p.continuation, p.base_thirst, p.indulgence, p.ground_friction) AS baserunning_rating,
    data.defense_rating_raw(p.omniscience, p.tenaciousness, p.watchfulness, p.anticapitalism, p.chasiness) AS defense_rating,
    data.pitching_rating_raw(p.unthwackability, p.ruthlessness, p.overpowerment, p.shakespearianism, p.coldness) AS pitching_rating,
    data.rating_to_star(data.batting_rating_raw(p.tragicness, p.patheticism, p.thwackability, p.divinity, p.moxie, p.musclitude, p.martyrdom)) AS batting_stars,
    data.rating_to_star(data.baserunning_rating_raw(p.laserlikeness, p.continuation, p.base_thirst, p.indulgence, p.ground_friction)) AS baserunning_stars,
    data.rating_to_star(data.defense_rating_raw(p.omniscience, p.tenaciousness, p.watchfulness, p.anticapitalism, p.chasiness)) AS defense_stars,
    data.rating_to_star(data.pitching_rating_raw(p.unthwackability, p.ruthlessness, p.overpowerment, p.shakespearianism, p.coldness)) AS pitching_stars,
    ( SELECT array_agg(DISTINCT pm.modification) AS array_agg
           FROM data.player_mods_from_timestamp(y.timestampd) pm(player_modifications_id, player_id, modification, valid_from, valid_until)
          WHERE ((pm.player_id)::text = (y.player_id)::text)
          GROUP BY pm.player_id) AS modifications_array,
    xp.position_type,
    r.position_id,
    t.nickname AS team
   FROM ((((( SELECT DISTINCT x.player_id,
            (unnest(x.a))::timestamp without time zone AS timestampd
           FROM ( SELECT DISTINCT players.player_id,
                    ARRAY[(players.valid_from)::timestamp with time zone, COALESCE((players.valid_until)::timestamp with time zone, now())] AS a
                   FROM data.players
                UNION
                 SELECT DISTINCT player_modifications.player_id,
                    ARRAY[(player_modifications.valid_from)::timestamp with time zone, COALESCE((player_modifications.valid_until)::timestamp with time zone, now())] AS a
                   FROM data.player_modifications
                UNION
                 SELECT DISTINCT team_roster.player_id,
                    ARRAY[(team_roster.valid_from)::timestamp with time zone, COALESCE((team_roster.valid_until)::timestamp with time zone, now())] AS a
                   FROM data.team_roster) x) y
     JOIN data.players p ON ((((y.player_id)::text = (p.player_id)::text) AND (p.valid_from <= (y.timestampd + '00:00:00.001'::interval)) AND (y.timestampd < COALESCE((p.valid_until)::timestamp with time zone, (now() + '00:00:00.001'::interval))))))
     LEFT JOIN data.team_roster r ON ((((y.player_id)::text = (r.player_id)::text) AND (r.valid_from <= (y.timestampd + '00:00:00.001'::interval)) AND (y.timestampd < COALESCE((r.valid_until)::timestamp with time zone, (now() + '00:00:00.001'::interval))))))
     LEFT JOIN data.teams_current t ON (((r.team_id)::text = (t.team_id)::text)))
     LEFT JOIN taxa.position_types xp ON ((r.position_type_id = (xp.position_type_id)::numeric)));


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
-- Name: running_stats_all_events; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.running_stats_all_events AS
 SELECT geb.runner_id AS player_id,
    ge.batter_team_id AS team_id,
    geb.responsible_pitcher_id,
    ge.pitcher_team_id AS responsible_team_id,
    ge.season,
    ge.day,
    ge.game_id,
    (geb.was_base_stolen)::integer AS was_base_stolen,
    (geb.was_caught_stealing)::integer AS was_caught_stealing,
    (geb.runner_scored)::integer AS runner_scored,
    geb.base_before_play,
    geb.base_after_play,
    ga.weather AS weather_id
   FROM ((data.game_event_base_runners geb
     JOIN data.game_events ge ON ((geb.game_event_id = ge.id)))
     JOIN data.games ga ON (((ge.game_id)::text = (ga.game_id)::text)));


--
-- Name: running_stats_player_lifetime; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.running_stats_player_lifetime AS
 SELECT rs.player_id,
    p.player_name,
    sum(rs.was_base_stolen) AS stolen_bases,
    sum(rs.was_caught_stealing) AS caught_stealing,
    sum(rs.runner_scored) AS runs
   FROM (data.running_stats_all_events rs
     JOIN data.players_extended_current p ON (((rs.player_id)::text = (p.player_id)::text)))
  WHERE (rs.day < 99)
  GROUP BY rs.player_id, p.player_name;


--
-- Name: running_stats_player_playoffs_lifetime; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.running_stats_player_playoffs_lifetime AS
 SELECT rs.player_id,
    p.player_name,
    sum(rs.was_base_stolen) AS stolen_bases,
    sum(rs.was_caught_stealing) AS caught_stealing,
    sum(rs.runner_scored) AS runs
   FROM (data.running_stats_all_events rs
     JOIN data.players_extended_current p ON (((rs.player_id)::text = (p.player_id)::text)))
  WHERE (rs.day >= 99)
  GROUP BY rs.player_id, p.player_name;


--
-- Name: running_stats_player_playoffs_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.running_stats_player_playoffs_season AS
 SELECT rs.player_id,
    p.player_name,
    rs.season,
    sum(rs.was_base_stolen) AS stolen_bases,
    sum(rs.was_caught_stealing) AS caught_stealing,
    sum(rs.runner_scored) AS runs
   FROM (data.running_stats_all_events rs
     JOIN data.players_extended_current p ON (((rs.player_id)::text = (p.player_id)::text)))
  WHERE (rs.day >= 99)
  GROUP BY rs.player_id, rs.season, p.player_name;


--
-- Name: running_stats_player_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.running_stats_player_season AS
 SELECT rs.player_id,
    p.player_name,
    rs.season,
    sum(rs.was_base_stolen) AS stolen_bases,
    sum(rs.was_caught_stealing) AS caught_stealing,
    sum(rs.runner_scored) AS runs
   FROM (data.running_stats_all_events rs
     JOIN data.players_extended_current p ON (((rs.player_id)::text = (p.player_id)::text)))
  WHERE (rs.day < 99)
  GROUP BY rs.player_id, rs.season, p.player_name;


--
-- Name: running_stats_vs_pitcher_lifetime; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.running_stats_vs_pitcher_lifetime AS
 SELECT p.player_id,
    p.player_name,
    sum(rs.was_base_stolen) AS stolen_bases,
    sum(rs.was_caught_stealing) AS caught_stealing,
    sum(rs.runner_scored) AS runs
   FROM (data.running_stats_all_events rs
     JOIN data.players_extended_current p ON (((rs.responsible_pitcher_id)::text = (p.player_id)::text)))
  WHERE (rs.day < 99)
  GROUP BY p.player_id, p.player_name;


--
-- Name: running_stats_vs_pitcher_playoffs_lifetime; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.running_stats_vs_pitcher_playoffs_lifetime AS
 SELECT p.player_id,
    p.player_name,
    sum(rs.was_base_stolen) AS stolen_bases,
    sum(rs.was_caught_stealing) AS caught_stealing,
    sum(rs.runner_scored) AS runs
   FROM (data.running_stats_all_events rs
     JOIN data.players_extended_current p ON (((rs.player_id)::text = (p.player_id)::text)))
  WHERE (rs.day >= 99)
  GROUP BY p.player_id, p.player_name;


--
-- Name: running_stats_vs_pitcher_playoffs_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.running_stats_vs_pitcher_playoffs_season AS
 SELECT p.player_id,
    p.player_name,
    rs.season,
    sum(rs.was_base_stolen) AS stolen_bases,
    sum(rs.was_caught_stealing) AS caught_stealing,
    sum(rs.runner_scored) AS runs
   FROM (data.running_stats_all_events rs
     JOIN data.players_extended_current p ON (((rs.player_id)::text = (p.player_id)::text)))
  WHERE (rs.day >= 99)
  GROUP BY p.player_id, rs.season, p.player_name;


--
-- Name: running_stats_vs_pitcher_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.running_stats_vs_pitcher_season AS
 SELECT p.player_id,
    p.player_name,
    rs.season,
    sum(rs.was_base_stolen) AS stolen_bases,
    sum(rs.was_caught_stealing) AS caught_stealing,
    sum(rs.runner_scored) AS runs
   FROM (data.running_stats_all_events rs
     JOIN data.players_extended_current p ON (((rs.player_id)::text = (p.player_id)::text)))
  WHERE (rs.day < 99)
  GROUP BY p.player_id, rs.season, p.player_name;


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
-- Name: pitch_types; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.pitch_types (
    pitch_type character varying(1),
    pitch character varying,
    is_ball integer DEFAULT 0,
    is_strike integer DEFAULT 0
);


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

COPY data.game_event_base_runners (id, game_event_id, runner_id, responsible_pitcher_id, base_before_play, base_after_play, was_base_stolen, was_caught_stealing, was_picked_off, runner_scored) FROM stdin;
\.


--
-- Data for Name: game_events; Type: TABLE DATA; Schema: data; Owner: -
--

COPY data.game_events (id, perceived_at, game_id, event_type, event_index, inning, top_of_inning, outs_before_play, batter_id, batter_team_id, pitcher_id, pitcher_team_id, home_score, away_score, home_strike_count, away_strike_count, batter_count, pitches, total_strikes, total_balls, total_fouls, is_leadoff, is_pinch_hit, lineup_position, is_last_event_for_plate_appearance, bases_hit, runs_batted_in, is_sacrifice_hit, is_sacrifice_fly, outs_on_play, is_double_play, is_triple_play, is_wild_pitch, batted_ball_type, is_bunt, errors_on_play, batter_base_after_play, is_last_game_event, event_text, additional_context, season, day, parsing_error, parsing_error_list, fixed_error, fixed_error_list, home_ball_count, away_ball_count, away_base_count, home_base_count) FROM stdin;
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: data; Owner: -
--

COPY data.games (game_id, day, season, last_game_event, home_odds, away_odds, weather, series_index, series_length, is_postseason, home_team, away_team, home_score, away_score, number_of_innings, ended_on_top_of_inning, ended_in_shame, terminology_id, rules_id, statsheet_id, winning_pitcher_id, losing_pitcher_id) FROM stdin;
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
28	5_HOME_RUN	1	1	1	5	0
4	FIELDERS_CHOICE	1	1	0	0	1
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
-- Data for Name: pitch_types; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.pitch_types (pitch_type, pitch, is_ball, is_strike) FROM stdin;
F	Foul Ball	0	0
X	Ball in play	0	0
A	Ball - Assumed	1	0
B	Ball	1	0
C	Called Strike	0	1
K	Strike - Assumed	0	1
S	Swinging Strike	0	1
\.


--
-- Data for Name: player_url_slugs; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.player_url_slugs (player_url_slug_id, player_id, player_url_slug, player_name) FROM stdin;
2612	020ed630-8bae-4441-95cc-0e4ecc27253b	simon-haley	\N
2613	0295c6c2-b33c-47dd-affa-349da7fa1760	combs-estes	\N
2614	03097200-0d48-4236-a3d2-8bdb153aa8f7	bennett-browning	\N
2615	03b80a57-77ea-4913-9be4-7a85c3594745	halexandrey-walton	\N
2616	03d06163-6f06-4817-abe5-0d14c3154236	garcia-tabby	\N
2617	03f920cc-411f-44ef-ae66-98a44e883291	cornelius-games	\N
2618	042962c8-4d8b-44a6-b854-6ccef3d82716	ronan-jaylee	\N
2619	04f955fe-9cc9-4482-a4d2-07fe033b59ee	zane-vapor	\N
2620	05bd08d5-7d9f-450b-abfa-1788b8ee8b91	stevenson-monstera	\N
2621	061b209a-9cda-44e8-88ce-6a4a37251970	mcdowell-karim	\N
2622	0672a4be-7e00-402c-b8d6-0b813f58ba96	castillo-logan	\N
2623	06ced607-7f96-41e7-a8cd-b501d11d1a7e	morrow-wilson	\N
2624	07ac91e9-0269-4e2c-a62d-a87ef61e3bbe	eduardo-perez	\N
2625	083d09d4-7ed3-4100-b021-8fbe30dd43e8	jessica-telephone	\N
2626	088884af-f38d-4914-9d67-b319287481b4	liam-petty	\N
2627	089af518-e27c-4256-adc8-62e3f4b30f43	silvia-rugrat	\N
2628	093af82c-84aa-4bd6-ad1a-401fae1fce44	elijah-glover	\N
2629	094ad9a1-e2c7-49a0-af18-da0e3eb656ba	erickson-sato	\N
2630	09f2787a-3352-41a6-8810-d80e97b253b5	curry-aliciakeyes	\N
2631	0bb35615-63f2-4492-80ec-b6b322dc5450	sexton-wheerer	\N
2632	0bb35615-63f2-4492-80ec-b6b322dc5450	sexton-wheeler	\N
2633	0bb35615-63f2-4492-80ec-b6b322dc5450	wyatt-mason-2	\N
2634	0bd5a3ec-e14c-45bf-8283-7bc191ae53e4	stephanie-donaldson	\N
2635	0c83e3b6-360e-4b7d-85e3-d906633c9ca0	penelope-mathews	\N
2636	0cc5bd39-e90d-42f9-9dd8-7e703f316436	don-elliott	\N
2637	0d5300f6-0966-430f-903f-a4c2338abf00	wyatt-mason-3	\N
2638	0d5300f6-0966-430f-903f-a4c2338abf00	wyatt-dovenpart	\N
2639	0d5300f6-0966-430f-903f-a4c2338abf00	lee-davenport	\N
2640	0daf04fc-8d0d-4513-8e98-4f610616453b	lee-mist	\N
2641	0e27df51-ad0c-4546-acf5-96b3cb4d7501	chorby-spoon	\N
2642	0ecf6190-f869-421a-b339-29195d30d37c	mcbaseball-clembons	\N
2643	0eddd056-9d72-4804-bd60-53144b785d5c	caleb-novak	\N
2644	0eea4a48-c84b-4538-97e7-3303671934d2	helga-moreno	\N
2645	0f61d948-4f0c-4550-8410-ae1c7f9f5613	tamara-crankit	\N
2646	0f62c20c-72d0-4c12-a9d7-312ea3d3bcd1	abner-wood	\N
2647	0fe896e1-108c-4ce9-97be-3470dde73c21	bryanayah-chang	\N
2648	1068f44b-34a0-42d8-a92e-2be748681a6f	allison-abbott	\N
2649	10ea5d50-ec88-40a0-ab53-c6e11cc1e479	nicholas-vincent	\N
2650	113f47b2-3111-4abb-b25e-18f7889e2d44	adkins-swagger	\N
2651	11de4da3-8208-43ff-a1ff-0b3480a0fbf1	don-mitchell	\N
2652	12577256-bc4e-4955-81d6-b422d895fb12	jasmine-washington	\N
2653	126fb128-7c53-45b5-ac2b-5dbf9943d71b	sigmund-castillo	\N
2654	1301ee81-406e-43d9-b2bb-55ca6e0f7765	malik-destiny	\N
2655	138fccc3-e66f-4b07-8327-d4b6f372f654	oscar-vaughan	\N
2656	13a05157-6172-4431-947b-a058217b4aa5	spears-taylor	\N
2657	13cfbadf-b048-4c4f-903d-f9b52616b15c	bennett-bowen	\N
2658	14bfad43-2638-41ec-8964-8351f22e9c4f	baby-sliders	\N
2659	14d88771-7a96-48aa-ba59-07bae1733e96	sebastian-telephone	\N
2660	1513aab6-142c-48c6-b43e-fbda65fd64e8	caleb-alvarado	\N
2661	15ae64cd-f698-4b00-9d61-c9fffd037ae2	mickey-woods	\N
2662	15d3a844-df6b-4193-a8f5-9ab129312d8d	sebastian-woodman	\N
2663	167751d5-210c-4a6e-9568-e92d61bab185	jacob-winner	\N
2664	16a59f5f-ef0f-4ada-8682-891ad571a0b6	boyfriend-berger	\N
2665	16aff709-e855-47c8-8818-b9ba66e90fe8	mullen-peterson	\N
2666	1732e623-ffc2-40f0-87ba-fdcf97131f1f	betsy-trombone	\N
2667	17392be2-7344-48a0-b4db-8a040a7fb532	washer-barajas	\N
2668	17397256-c28c-4cad-85f2-a21768c66e67	cory-ross	\N
2669	1750de38-8f5f-426a-9e23-2899a15a2031	kline-nightmare	\N
2670	18798b8f-6391-4cb2-8a5f-6fb540d646d5	morrow-doyle	\N
2671	18af933a-4afa-4cba-bda5-45160f3af99b	felix-garbage	\N
2672	190a0f31-d686-4ac4-a7f3-cfc87b72c145	nerd-pacheco	\N
2673	198fd9c8-cb75-482d-873e-e6b91d42a446	ren-hunter	\N
2674	19af0d67-c73b-4ef2-bc84-e923c1336db5	grit-ramos	\N
2675	1a93a2d2-b5b6-479b-a595-703e4a2f3885	pedro-davids	\N
2676	1aec2c01-b766-4018-a271-419e5371bc8f	rush-ito	\N
2677	1af239ae-7e12-42be-9120-feff90453c85	melton-telephone	\N
2678	1ba715f2-caa3-44c0-9118-b045ea702a34	juan-rangel	\N
2679	1c73f91e-0562-480d-9543-2aab1d5e5acd	sparks-beans	\N
2680	1ded0384-d290-4ea1-a72b-4f9d220cbe37	juan-murphy	\N
2681	1e229fe5-a191-48ef-a7dd-6f6e13d6d73f	erickson-fischer	\N
2682	1e7b02b7-6981-427a-b249-8e9bd35f3882	nora-reddick	\N
2683	1e8b09bd-fbdd-444e-bd7e-10326bd57156	fletcher-yamamoto	\N
2684	1f145436-b25d-49b9-a1e3-2d3c91626211	joe-voorhees	\N
2685	1f159bab-923a-4811-b6fa-02bfde50925a	nan	\N
2686	1f159bab-923a-4811-b6fa-02bfde50925a	wyatt-mason	\N
2687	1ffb1153-909d-44c7-9df1-6ed3a9a45bbd	montgomery-bullock	\N
2688	20395b48-279d-44ff-b5bf-7cf2624a2d30	adrian-melon	\N
2689	206bd649-4f5f-4707-ad85-92784be4eb95	newton-underbuck	\N
2690	20be1c34-071d-40c6-8824-dde2af184b4d	qais-dogwalker	\N
2691	20e13b56-599b-4a22-b752-8059effc81dc	lou-roseheart	\N
2692	20fd71e7-4fa0-4132-9f47-06a314ed539a	lars-taylor	\N
2693	2175cda0-a427-40fd-b497-347edcc1cd61	hotbox-sato	\N
2694	21cbbfaa-100e-48c5-9cea-7118b0d08a34	juice-collins	\N
2695	21d52455-6c2c-4ee4-8673-ab46b4b926b4	wyatt-owens	\N
2696	21d52455-6c2c-4ee4-8673-ab46b4b926b4	emmett-owens	\N
2697	21d52455-6c2c-4ee4-8673-ab46b4b926b4	wyatt-mason-4	\N
2698	23110c0f-2cf9-4d9c-ab2d-634f2f18867e	kennedy-meh	\N
2699	23e78d92-ee2d-498a-a99c-f40bc4c5fe99	annie-williams	\N
2700	248ccf3d-d5f6-4b69-83d9-40230ca909cd	antonio-wallace	\N
2701	24ad200d-a45f-4286-bfa5-48909f98a1f7	nicholas-summer	\N
2702	24cb35c1-c24c-45ca-ac0b-f99a2e650d89	tyreek-peterson	\N
2703	24f6829e-7bb4-4e1e-8b59-a07514657e72	king-weatherman	\N
2704	25376b55-bb6f-48a7-9381-7b8210842fad	emmett-internet	\N
2705	25f3a67c-4ed5-45b6-94b1-ce468d3ead21	hobbs-cain	\N
2706	262c49c6-8301-487d-8356-747023fa46a9	alexandria-dracaena	\N
2707	26cfccf2-850e-43eb-b085-ff73ad0749b8	beasley-day	\N
2708	26f01324-9d1c-470b-8eaa-1b9bfbcd8b65	nerd-james	\N
2709	2720559e-9173-4042-aaa0-d3852b72ab2e	hiroto-wilcox	\N
2710	2727215d-3714-438d-b1ba-2ed15ec481c0	dominic-woman	\N
2711	27c68d7f-5e40-4afa-8b6f-9df47b79e7dd	wyatt-mason-5	\N
2712	27c68d7f-5e40-4afa-8b6f-9df47b79e7dd	basilio-mason	\N
2713	27c68d7f-5e40-4afa-8b6f-9df47b79e7dd	basilio-preston	\N
2714	27faa5a7-d3a8-4d2d-8e62-47cfeba74ff0	spears-nolan	\N
2715	285ce77d-e5cd-4daa-9784-801347140d48	son-scotch	\N
2716	28964497-0efe-420c-9c1d-8574f224a4e9	inez-owens	\N
2717	29bf512a-cd8c-4ceb-b25a-d96300c184bb	garcia-soto	\N
2718	2ae8cbfc-2155-4647-9996-3f2591091baf	forrest-bookbaby	\N
2719	2b157c5c-9a6a-45a6-858f-bf4cf4cbc0bd	ortiz-lopez	\N
2720	2b1cb8a2-9eba-4fce-85cf-5d997ec45714	isaac-rubberman	\N
2721	2b5f5dd7-e31f-4829-bec5-546652103bc0	dudley-mueller	\N
2722	2b9f9c25-43ec-4f0b-9937-a5aa23be0d9e	lawrence-horne	\N
2723	2ca0c790-e1d5-4a14-ab3c-e9241c87fc23	murray-pony	\N
2724	2cadc28c-88a5-4e25-a6eb-cdab60dd446d	elijah-bookbaby	\N
2725	2d22f026-2873-410b-a45f-3b1dac665ffd	donia-johnson	\N
2726	2da49de2-34e5-49d0-b752-af2a2ee061be	cory-twelve	\N
2727	2e13249e-38ff-46a2-a55e-d15fa692468a	vito-kravitz	\N
2728	2e6d4fa9-f930-47bd-971a-dd54a3cf7db1	raul-leal	\N
2729	2e86de11-a2dd-4b28-b5fe-f4d0c38cd20b	zion-aliciakeyes	\N
2730	2f3d7bc7-6ffb-40c3-a94f-5e626be413c9	elijah-valenzuela	\N
2731	30218684-7fa1-41a5-a3b3-5d9cd97dd36b	jordan-hildebert	\N
2732	3064c7d6-91cc-4c2a-a433-1ce1aabc1ad4	jorge-ito	\N
2733	316abea7-9890-4fb8-aaea-86b35e24d9be	kennedy-rodgers	\N
2734	32551e28-3a40-47ae-aed1-ff5bc66be879	math-velazquez	\N
2735	32810dca-825c-4dbc-8b65-0702794c424e	eduardo-woodman	\N
2736	32c9bce6-6e52-40fa-9f64-3629b3d026a8	ren-morin	\N
2737	333067fd-c2b4-4045-a9a4-e87a8d0332d0	miguel-james	\N
2738	338694b7-6256-4724-86b6-3884299a5d9e	polkadot-patterson	\N
2739	33fbfe23-37bd-4e37-a481-a87eadb8192d	whit-steakknife	\N
2740	34267632-8c32-4a8b-b5e6-ce1568bb0639	gunther-obrian	\N
2741	34e1b683-ecd5-477f-b9e3-dd4bca76db45	alexandria-hess	\N
2742	3531c282-cb48-43df-b549-c5276296aaa7	oliver-hess	\N
2743	35d5b43f-8322-4666-aab1-d466b4a5a388	jordan-boone	\N
2744	36786f44-9066-4028-98d9-4fa84465ab9e	beasley-gloom	\N
2745	378c07b0-5645-44b5-869f-497d144c7b35	fynn-doyle	\N
2746	37efef78-2df4-4c76-800c-43d4faf07737	lenix-ren	\N
2747	3954bdfa-931f-4787-b9ac-f44b72fe09d7	nicholas-nolan	\N
2748	3a8c52d7-4124-4a65-a20d-d51abcbe6540	theodore-holloway	\N
2749	3a96d76a-c508-45a0-94a0-8f64cd6beeb4	thomas-england	\N
2750	3a96d76a-c508-45a0-94a0-8f64cd6beeb4	sixpack-dogwalker	\N
2751	3af96a6b-866c-4b03-bc14-090acf6ecee5	axel-trololol	\N
2752	3afb30c1-1b12-466a-968a-5a9a21458c7f	dickerson-greatness	\N
2753	3be2c730-b351-43f7-a832-a5294fe8468f	amaya-jackson	\N
2754	3c051b92-4a86-4157-988a-e334bf6dc691	tyler-leatherman	\N
2755	3c331c87-1634-46c4-87ce-e4b9c59e2969	yosh-carpenter	\N
2756	3d3be7b8-1cbf-450d-8503-fce0daf46cbf	zack-sanders	\N
2757	3d4545ed-6217-4d7a-9c4a-209265eb6404	tiana-cash	\N
2758	3db02423-92af-485f-b30f-78256721dcc6	son-jensen	\N
2759	3dd85c20-a251-4903-8a3b-1b96941c07b7	tot-best	\N
2760	3de17e21-17db-4a6b-b7ab-0b2f3c154f42	brewer-vapor	\N
2761	3e008f60-6842-42e7-b125-b88c7e5c1a95	zeboriah-wilson	\N
2762	3ebb5361-3895-4a50-801e-e7a0ee61750c	augusto-reddick	\N
2763	3f08f8cd-6418-447a-84d3-22a981c68f16	pollard-beard	\N
2764	40db1b0b-6d04-4851-adab-dd6320ad2ed9	scrap-murphy	\N
2765	413b3ddb-d933-4567-a60e-6d157480239d	winnie-mccall	\N
2766	41949d4d-b151-4f46-8bf7-73119a48fac8	ron-monstera	\N
2767	4204c2d1-ca48-4af7-b827-e99907f12d61	axel-cardenas	\N
2768	425f3f84-bab0-4cf2-91c1-96e78cf5cd02	luis-acevedo	\N
2769	43bf6a6d-cc03-4bcf-938d-620e185433e1	miguel-javier	\N
2770	43d5da5f-c6a1-42f1-ab7f-50ea956b6cd5	justice-spoon	\N
2771	446a3366-3fe3-41bb-bfdd-d8717f2152a9	marco-escobar	\N
2772	44c92d97-bb39-469d-a13b-f2dd9ae644d1	francisco-preston	\N
2773	450e6483-d116-41d8-933b-1b541d5f0026	england-voorhees	\N
2774	4542f0b0-3409-4a4a-a9e1-e8e8e5d73fcf	brock-watson	\N
2775	4562ac1f-026c-472c-b4e9-ee6ff800d701	chris-koch	\N
2776	459f7700-521e-40da-9483-4d111119d659	comfort-monreal	\N
2777	46721a07-7cd2-4839-982e-7046df6e8b66	stew-briggs	\N
2778	472f50c0-ef98-4d05-91d0-d6359eec3946	rhys-trombone	\N
2779	493a83de-6bcf-41a1-97dd-cc5e150548a3	boyfriend-monreal	\N
2780	4941976e-31fc-49b5-801a-18abe072178b	sebastian-sunshine	\N
2781	495a6bdc-174d-4ad6-8d51-9ee88b1c2e4a	shaquille-torres	\N
2782	4aa843a4-baa1-4f35-8748-63aa82bd0e03	aureliano-dollie	\N
2783	4b3e8e9b-6de1-4840-8751-b1fb45dc5605	thomas-dracaena	\N
2784	4b6f0a4e-de18-44ad-b497-03b1f470c43c	rodriguez-internet	\N
2785	4b73367f-b2bb-4df6-b2eb-2a0dd373eead	tristin-crankit	\N
2786	4bda6584-6c21-4185-8895-47d07e8ad0c0	aldon-anthony	\N
2787	4bf352d2-6a57-420a-9d45-b23b2b947375	rivers-rosa	\N
2788	4ca52626-58cd-449d-88bb-f6d631588640	velasquez-alstott	\N
2789	4e63cb5d-4fce-441b-b9e4-dc6a467cf2fd	axel-campbell	\N
2790	4e6ad1a1-7c71-49de-8bd5-c286712faf9e	sutton-picklestein	\N
2791	4ecee7be-93e4-4f04-b114-6b333e0e6408	sutton-dreamy	\N
2792	4ed61b18-c1f6-4d71-aea3-caac01470b5c	lenny-marijuana	\N
2793	4f328502-d347-4d2c-8fad-6ae59431d781	stephens-lightner	\N
2794	4f69e8c2-b2a1-4e98-996a-ccf35ac844c5	igneus-delacruz	\N
2795	4f7d7490-7281-4f8f-b62e-37e99a7c46a0	annie-roland	\N
2796	4fe28bc1-f690-4ad6-ad09-1b2e984bf30b	cell-longarms	\N
2797	4ffd2e50-bb5b-45d0-b7c4-e24d41b2ff5d	schneider-bendie	\N
2798	50154d56-c58a-461f-976d-b06a4ae467f9	carter-oconnor	\N
2799	503a235f-9fa6-41b5-8514-9475c944273f	reese-clark	\N
2800	5149c919-48fe-45c6-b7ee-bb8e5828a095	adkins-davis	\N
2801	51985516-5033-4ab8-a185-7bda07829bdb	stephanie-schmitt	\N
2802	51c5473a-7545-4a9a-920d-d9b718d0e8d1	jacob-haynes	\N
2803	51cba429-13e8-487e-9568-847b7b8b9ac5	collins-mina	\N
2804	520e6066-b14b-45cf-985c-0a6ee2dc3f7a	zi-sliders	\N
2805	527c1f6e-a7e4-4447-a824-703b662bae4e	melton-campbell	\N
2806	52cfebfb-8008-4b9f-a566-72a30e0b64bf	spears-rogers	\N
2807	53e701c7-e3c8-4e18-ba05-9b41b4b64cda	marquez-clark	\N
2808	542af915-79c5-431c-a271-f7185e37c6ae	oliver-notarobot	\N
2809	54e5f222-fb16-47e0-adf9-21813218dafa	grit-watson	\N
2810	5703141c-25d9-46d0-b680-0cf9cfbf4777	sandoval-crossing	\N
2811	57448b62-f952-40e2-820c-48d8afe0f64d	jessi-wise	\N
2812	57b4827b-26b0-4384-a431-9f63f715bc5b	aureliano-cerna	\N
2813	58c9e294-bd49-457c-883f-fb3162fc668e	kichiro-guerra	\N
2814	58fca5fa-e559-4f5e-ac87-dc99dd19e410	sullivan-septemberish	\N
2815	5915b7bb-e532-4036-9009-79f1e80c0e28	rosa-holloway	\N
2816	5a26fc61-d75d-4c01-9ce2-1880ffb5550f	randy-dennis	\N
2817	5b3f0a43-45e7-44e7-9496-512c24c040f0	rhys-rivera	\N
2818	5b5bcc6c-d011-490f-b084-6fdc2c52f958	simba-davis	\N
2819	5b9727f7-6a20-47d2-93d9-779f0a85c4ee	kennedy-alstott	\N
2820	5bcfb3ff-5786-4c6c-964c-5c325fcc48d7	paula-turnip	\N
2821	5c60f834-a133-4dc6-9c07-392fb37b3e6a	ramirez-winters	\N
2822	5ca7e854-dc00-4955-9235-d7fcd732ddcf	wyatt-quitter	\N
2823	5ca7e854-dc00-4955-9235-d7fcd732ddcf	taiga-quitter	\N
2824	5ca7e854-dc00-4955-9235-d7fcd732ddcf	wyatt-mason-6	\N
2825	5dbf11c0-994a-4482-bd1e-99379148ee45	conrad-vaughan	\N
2826	5e4dfa16-f1b9-400f-b8ef-a1613c2b026a	snyder-briggs	\N
2827	5eac7fd9-0d19-4bf4-a013-994acc0c40c0	sutton-bishop	\N
2828	5f3b5dc2-351a-4dee-a9d6-fa5f44f2a365	alston-england	\N
2829	5fbf04bb-f5ec-4589-ab19-1d89cda056bd	donia-dollie	\N
2830	5fc4713c-45e1-4593-a968-7defeb00a0d4	percival-bendie	\N
2831	5ff66eae-7111-4e3b-a9b8-a9579165b0a5	peanutiel-duffy	\N
2832	5ff66eae-7111-4e3b-a9b8-a9579165b0a5	daniel-duffy	\N
2833	60026a9d-fc9a-4f5a-94fd-2225398fa3da	bright-zimmerman	\N
2834	611d18e0-b972-4cdd-afc2-793c56bfe5a9	alston-cerveza	\N
2835	6192daab-3318-44b5-953f-14d68cdb2722	justin-alstott	\N
2836	62111c49-1521-4ca7-8678-cd45dacf0858	bambi-perez	\N
2837	62823073-84b8-46c2-8451-28fd10dff250	mckinney-vaughan	\N
2838	63512571-2eca-4bc4-8ad9-a5308a22ae22	oscar-dollie	\N
2839	63a31035-2e6d-4922-a3f9-fa6e659b54ad	moody-rodriguez	\N
2840	63df8701-1871-4987-87d7-b55d4f1df2e9	mcdowell-mason	\N
2841	63df8701-1871-4987-87d7-b55d4f1df2e9	mcdowell-sasquatch	\N
2842	63df8701-1871-4987-87d7-b55d4f1df2e9	wyatt-mason-7	\N
2843	64aaa3cb-7daf-47e3-89a8-e565a3715b5d	travis-nakamura	\N
2844	64b055d1-b691-4e0c-8583-fc08ba663846	theodore-passon	\N
2845	64f4cd75-0c1e-42cf-9ff0-e41c4756f22a	grey-alvarado	\N
2846	64f59d5f-8740-4ebf-91bd-d7697b542a9f	zeke-wallace	\N
2847	6524e9e0-828a-46c4-935d-0ee2edeb7e9a	carter-turnip	\N
2848	65273615-22d5-4df1-9a73-707b23e828d5	burke-gonzales	\N
2849	6598e40a-d76d-413f-ad06-ac4872875bde	daniel-mendoza	\N
2850	6644d767-ab15-4528-a4ce-ae1f8aadb65f	paula-reddick	\N
2851	667cb445-c288-4e62-b603-27291c1e475d	peanut-holloway	\N
2852	667cb445-c288-4e62-b603-27291c1e475d	dan-holloway	\N
2853	66cebbbf-9933-4329-924a-72bd3718f321	kennedy-cena	\N
2854	678170e4-0688-436d-a02d-c0467f9af8c0	baby-doyle	\N
2855	68462bfa-9006-4637-8830-2e7840d9089a	parker-horseman	\N
2856	68f98a04-204f-4675-92a7-8823f2277075	isaac-johnson	\N
2857	69196296-f652-42ff-b2ca-0d9b50bd9b7b	joshua-butt	\N
2858	695daf02-113d-4e76-b802-0862df16afbd	pacheco-weeks	\N
2859	6a869b40-be99-4520-89e5-d382b07e4a3c	jake-swinger	\N
2860	6b8d128f-ed51-496d-a965-6614476f8256	orville-manco	\N
2861	6bac62ad-7117-4e41-80f9-5a155a434856	grit-freeman	\N
2862	6bd4cf6e-fefe-499a-aa7a-890bcc7b53fa	igneus-mcdaniel	\N
2863	6c346d8b-d186-4228-9adb-ae919d7131dd	greer-gwiffin	\N
2864	6e373fca-b8ab-4848-9dcc-50e92cd732b7	conrad-bates	\N
2865	6e744b21-c4fa-4fa8-b4ea-e0e97f68ded5	daniel-koch	\N
2866	6f9de777-e812-4c84-915c-ef283c9f0cde	arturo-huerta	\N
2867	6fc3689f-bb7d-4382-98a2-cf6ddc76909d	cedric-gonzalez	\N
2868	7007cbd3-7c7b-44fd-9d6b-393e82b1c06e	rafael-davids	\N
2869	70a458ed-25ca-4ff8-97fc-21cbf58f2c2a	trevino-merritt	\N
2870	70ccff1e-6b53-40e2-8844-0a28621cb33e	moody-cookbook	\N
2871	7158d158-e7bf-4e9b-9259-62e5b25e3de8	karato-bean	\N
2872	718dea1a-d9a8-4c2b-933a-f0667b5250e6	margarito-nava	\N
2873	721fb947-7548-49ea-8cbe-7721b0ed49e0	tamara-lopez	\N
2874	7310c32f-8f32-40f2-b086-54555a2c0e86	dominic-marijuana	\N
2875	73265ee3-bb35-40d1-b696-1f241a6f5966	parker-meng	\N
2876	732899a3-2082-4d9f-b1c2-74c8b75e15fb	minato-ito	\N
2877	740d5fef-d59f-4dac-9a75-739ec07f91cf	conner-haley	\N
2878	75f9d874-5e69-438d-900d-a3fcb1d429b3	wyatt-mason-8	\N
2879	75f9d874-5e69-438d-900d-a3fcb1d429b3	moses-mason	\N
2880	75f9d874-5e69-438d-900d-a3fcb1d429b3	moses-simmons	\N
2881	7663c3ca-40a1-4f13-a430-14637dce797a	polkadot-zavala	\N
2882	766dfd1e-11c3-42b6-a167-9b2d568b5dc0	sandie-turner	\N
2883	76c4853b-7fbc-4688-8cda-c5b8de1724e4	lars-mendoza	\N
2884	773712f6-d76d-4caa-8a9b-56fe1d1a5a68	natha-kath	\N
2885	77a41c29-8abd-4456-b6e0-a034252700d2	elip-dean	\N
2886	7853aa8c-e86d-4483-927d-c1d14ea3a34d	tucker-flores	\N
2887	7932c7c7-babb-4245-b9f5-cdadb97c99fb	randy-castillo	\N
2888	7951836f-581a-49d5-ae2f-049c6bcc575e	adkins-gwiffin	\N
2889	7a75d626-d4fd-474f-a862-473138d8c376	beck-whitney	\N
2890	7aeb8e0b-f6fb-4a9e-bba2-335dada5f0a3	dunlap-figueroa	\N
2891	7afedcd8-870d-4655-9659-3bdfb2e17730	pierre-haley	\N
2892	7b0f91aa-4d66-4362-993d-6ff60f7ce0ef	blankenship-fischer	\N
2893	7b55d484-6ea9-4670-8145-986cb9e32412	stevenson-heat	\N
2894	7c5ae357-e079-4427-a90f-97d164c7262e	milo-brown	\N
2895	7cf83bdc-f95f-49d3-b716-06f2cf60a78d	matteo-urlacher	\N
2896	7dca7137-b872-46f5-8e59-8c9c996e9d22	emmett-tabby	\N
2897	7dcf6902-632f-48c5-936a-7cf88802b93a	parker-parra	\N
2898	7e160e9f-2c79-4e08-8b76-b816de388a98	thomas-marsh	\N
2899	7e4f012e-828c-43bb-8b8a-6c33bdfd7e3f	patel-olive	\N
2900	7e9a514a-7850-4ed0-93ab-f3a6e2f41c03	nolanestophia-patterson	\N
2901	7f379b72-f4f0-4d8f-b88b-63211cf50ba6	jesus-rodriguez	\N
2902	7fed72df-87de-407d-8253-2295a2b60d3b	stout-schmitt	\N
2903	805ba480-df4d-4f56-a4cf-0b99959111b5	leticia-lozano	\N
2904	80a2f015-9d40-426b-a4f6-b9911ba3add8	paul-barnes	\N
2905	80de2b05-e0d4-4d33-9297-9951b2b5c950	alyssa-harrell	\N
2906	80dff591-2393-448a-8d88-122bd424fa4c	elvis-figueroa	\N
2907	80e474a3-7d2b-431d-8192-2f1e27162607	summers-preston	\N
2908	80e474a3-7d2b-431d-8192-2f1e27162607	wyatt-mason-15	\N
2909	814bae61-071a-449b-981e-e7afc839d6d6	ruslan-greatness	\N
2910	817dee99-9ccf-4f41-84e3-dc9773237bc8	holden-stanton	\N
2911	81a0889a-4606-4f49-b419-866b57331383	summers-pony	\N
2912	81b25b16-3370-4eb0-9d1b-6d630194c680	zeboriah-whiskey	\N
2913	81d7d022-19d6-427d-aafc-031fcb79b29e	patty-fox	\N
2914	82733eb4-103d-4be1-843e-6eb6df35ecd7	adkins-tosser	\N
2915	82d1b7b4-ce00-4536-8631-a025f05150ce	sam-scandal	\N
2916	849e13dc-6eb1-40a8-b55c-d4b4cd160aab	justice-valenzuela	\N
2917	84a2b5f6-4955-4007-9299-3d35ae7135d3	kennedy-loser	\N
2918	855775c1-266f-40f6-b07b-3a67ccdf8551	nic-winkler	\N
2919	8604e861-d784-43f0-b0f8-0d43ea6f7814	randall-marijuana	\N
2920	864b3be8-e836-426e-ae56-20345b41d03d	goodwin-morin	\N
2921	86d4e22b-f107-4bcf-9625-32d387fcb521	york-silk	\N
2922	87e6ae4b-67de-4973-aa56-0fc9835a1e1e	marco-stink	\N
2923	87e6ae4b-67de-4973-aa56-0fc9835a1e1e	wyatts-mason	\N
2924	889c9ef9-d521-4436-b41c-9021b81b4dfb	liam-snail	\N
2925	88ca603e-b2e5-4916-bef5-d6bba03235f5	clare-mccall	\N
2926	88cd6efa-dbf2-4309-aabe-ec1d6f21f98a	hewitt-best	\N
2927	8903a74f-f322-41d2-bd75-dbf7563c4abb	francisca-sasquatch	\N
2928	89ec77d8-c186-4027-bd45-f407b4800c2c	james-mora	\N
2929	89f74891-2e25-4b5a-bd99-c95ba3f36aa0	nagomi-nava	\N
2930	8a6fc67d-a7fe-443b-a084-744294cec647	terrell-bradley	\N
2931	8adb084b-19fe-4295-bcd2-f92afdb62bd7	logan-rodriguez	\N
2932	8b0d717f-ae42-4492-b2ed-106912e2b530	avila-baker	\N
2933	8b53ce82-4b1a-48f0-999d-1774b3719202	oliver-mueller	\N
2934	8c8cc584-199b-4b76-b2cd-eaa9a74965e5	ziwa-mueller	\N
2935	8cd06abf-be10-4a35-a3ab-1a408a329147	gloria-bugsnax	\N
2936	8cf78b49-d0ca-4703-88e8-4bcad26c44b1	avila-guzman	\N
2937	8d81b190-d3b8-4cd9-bcec-0e59fdd7f2bc	albert-stink	\N
2938	8e1fd784-99d5-41c1-a6c5-6b947cec6714	velasquez-meadows	\N
2939	8ecea7e0-b1fb-4b74-8c8c-3271cb54f659	fitzgerald-blackburn	\N
2940	8f11ad58-e0b9-465c-9442-f46991274557	amos-melon	\N
2941	906a5728-5454-44a0-adfe-fd8be15b8d9b	jefferson-delacruz	\N
2942	90768354-957e-4b4c-bb6d-eab6bbda0ba3	eugenia-garbage	\N
2943	90c2cec7-0ed5-426a-9de8-754f34d59b39	tot-fox	\N
2944	90c6e6ca-77fc-42b7-94d8-d8afd6d299e5	miki-santana	\N
2945	90c8be89-896d-404c-945e-c135d063a74e	james-boy	\N
2946	90cc0211-cd04-4cac-bdac-646c792773fc	case-lancaster	\N
2947	9313e41c-3bf7-436d-8bdc-013d3a1ecdeb	sandie-nelson	\N
2948	93502db3-85fa-4393-acae-2a5ff3980dde	rodriguez-sunshine	\N
2949	937c1a37-4b05-4dc5-a86d-d75226f8490a	pippin-carpenter	\N
2950	9397ed91-608e-4b13-98ea-e94c795f651e	yeongho-garcia	\N
2951	945974c5-17d9-43e7-92f6-ba49064bbc59	bates-silk	\N
2952	94baa9ac-ff96-4f56-a987-10358e917d91	gabriel-griffith	\N
2953	94d772c7-0254-4f08-814c-f6fc58fcfb9b	fletcher-peck	\N
2954	94f30f21-f889-4a2e-9b94-818475bb1ca0	kirkland-sobremesa	\N
2955	960f041a-f795-4001-bd88-5ddcf58ee520	mayra-buckley	\N
2956	9786b2c9-1205-4718-b0f7-fc000ce91106	kevin-dudley	\N
2957	97981e86-4a42-4f85-8783-9f29833c192b	daiya-vine	\N
2958	97dfc1f6-ac94-4cdc-b0d5-1cb9f8984aa5	brock-forbes	\N
2959	97ec5a2f-ac1a-4cde-86b7-897c030a1fa8	alston-woods	\N
2960	97f5a9cd-72f0-413e-9e68-a6ee6a663489	kline-greenlemon	\N
2961	9820f2c5-f9da-4a07-b610-c2dd7bee2ef6	dan-bong	\N
2962	9820f2c5-f9da-4a07-b610-c2dd7bee2ef6	peanut-bong	\N
2963	98f26a25-905f-4850-8960-b741b0c583a4	stu-mcdaniel	\N
2964	9965eed5-086c-4977-9470-fe410f92d353	bates-bentley	\N
2965	99e7de75-d2b8-4330-b897-a7334708aff9	winnie-loser	\N
2966	9a031b9a-16f8-4165-a468-5d0e28a81151	tiana-wheeler	\N
2967	9abe02fb-2b5a-432f-b0af-176be6bd62cf	nagomi-meng	\N
2968	9ac2e7c5-5a34-4738-98d8-9f917bc6d119	christian-combs	\N
2969	9ba361a1-16d5-4f30-b590-fc4fc2fb53d2	mooney-doctor	\N
2970	9be56060-3b01-47aa-a090-d072ef109fbf	jesus-koch	\N
2971	9c3273a0-2711-4958-b716-bfcf60857013	kathy-mathews	\N
2972	9e724d9a-92a0-436e-bde1-da0b2af85d8f	hatfield-suzuki	\N
2973	9f6d06d6-c616-4599-996b-ec4eefcff8b8	silvia-winner	\N
2974	9f85676a-7411-444a-8ae2-c7f8f73c285c	lachlan-shelton	\N
2975	9fd1f392-d492-4c48-8d46-27fb4283b2db	lucas-petty	\N
2976	a1628d97-16ca-4a75-b8df-569bae02bef9	chorby-soul	\N
2977	a199a681-decf-4433-b6ab-5454450bbe5e	leach-ingram	\N
2978	a1ed3396-114a-40bc-9ff0-54d7e1ad1718	wyatt-mason-9	\N
2979	a1ed3396-114a-40bc-9ff0-54d7e1ad1718	patel-beyonce	\N
2980	a2483925-697f-468f-931c-bcd0071394e5	timmy-manco	\N
2981	a311c089-0df4-46bd-9f5d-8c45c7eb5ae2	mclaughlin-scorpler	\N
2982	a38ada0a-aeac-4a3d-b9a5-968687ccd2f9	sixpack-santiago	\N
2983	a3947fbc-50ec-45a4-bca4-49ffebb77dbe	chorby-short	\N
2984	a5adc84c-80b8-49e4-9962-8b4ade99a922	richardson-turquoise	\N
2985	a5f8ce83-02b2-498c-9e48-533a1d81aebf	evelton-mcblase	\N
2986	a647388d-fc59-4c1b-90d3-8c1826e07775	chambers-simmons	\N
2987	a691f2ba-9b69-41f8-892c-1acd42c336e4	jenkins-good	\N
2988	a73427b3-e96a-4156-a9ab-844edc696fed	wesley-vodka	\N
2989	a7b0bef3-ee3c-42d4-9e6d-683cd9f5ed84	haruta-byrd	\N
2990	a7edbf19-caf6-45dd-83d5-46496c99aa88	rush-valenzuela	\N
2991	a8530be5-8923-4f74-9675-bf8a1a8f7878	mohammed-picklestein	\N
2992	a8a5cf36-d1a9-47d1-8d22-4a665933a7cc	helga-washington	\N
2993	a8e757c6-e299-4a2e-a370-4f7c3da98bd1	hendricks-lenny	\N
2994	a938f586-f5c1-4a35-9e7f-8eaab6de67a6	jasper-destiny	\N
2995	a98917bc-e9df-4b0e-bbde-caa6168aa3d7	jenkins-ingram	\N
2996	aa6c2662-75f8-4506-aa06-9a0993313216	eizabeth-elliott	\N
2997	aa7ac9cb-e9db-4313-9941-9f3431728dce	matteo-cash	\N
2998	aae38811-122c-43dd-b59c-d0e203154dbe	sandie-carver	\N
2999	ab9b2592-a64a-4913-bf6c-3ae5bd5d26a5	beau-huerta	\N
3000	ab9eb213-0917-4374-a259-458295045021	matheo-carpenter	\N
3001	ac57cf28-556f-47af-9154-6bcea2ace9fc	rey-wooten	\N
3002	ac69dba3-6225-4afd-ab4b-23fc78f730fb	bevan-wise	\N
3003	ad1e670a-f346-4bf7-a02f-a91649c41ccb	stephanie-winters	\N
3004	ad8d15f4-e041-4a12-a10e-901e6285fdc5	baby-urlacher	\N
3005	ae4acebd-edb5-4d20-bf69-f2d5151312ff	theodore-cervantes	\N
3006	ae81e172-801a-4236-929a-b990fc7190ce	august-sky	\N
3007	af6b3edc-ed52-4edc-b0c9-14e0a5ae0ee3	rivers-clembons	\N
3008	af6b3edc-ed52-4edc-b0c9-14e0a5ae0ee3	wyatt-masons	\N
3009	afc90398-b891-4cdf-9dea-af8a3a79d793	yazmin-mason	\N
3010	b019fb2b-9f4b-4deb-bf78-6bee2f16d98d	gloria-bentley	\N
3011	b056a825-b629-4856-856b-53a15ad34acb	bennett-takahashi	\N
3012	b082ca6e-eb11-4eab-8d6a-30f8be522ec4	nicholas-mora	\N
3013	b1b141fc-e867-40d1-842a-cea30a97ca4f	richardson-games	\N
3014	b348c037-eefc-4b81-8edd-dfa96188a97e	lowe-forbes	\N
3015	b390b28c-df96-443e-b81f-f0104bd37860	karato-rangel	\N
3016	b39b5aae-8571-4c90-887a-6a00f2a2f6fd	dickerson-morse	\N
3017	b3d518b9-dc68-4902-b68c-0022ceb25aa0	hendricks-rangel	\N
3018	b3e512df-c411-4100-9544-0ceadddb28cf	famous-owens	\N
3019	b4505c48-fc75-4f9e-8419-42b28dcc5273	sebastian-townsend	\N
3020	b5c95dba-2624-41b0-aacd-ac3e1e1fe828	cote-rodgers	\N
3021	b69aa26f-71f7-4e17-bc36-49c875872cc1	francisca-burton	\N
3022	b6aa8ce8-2587-4627-83c1-2a48d44afaee	inky-rutledge	\N
3023	b7267aba-6114-4d53-a519-bf6c99f4e3a9	sosa-hayes	\N
3024	b77dffaa-e0f5-408f-b9f2-1894ed26e744	tucker-lenny	\N
3025	b7adbbcc-0679-43f3-a939-07f009a393db	jode-crutch	\N
3026	b7c1ddda-945c-4b2e-8831-ad9f2ec4a608	nolan-violet	\N
3027	b7c4f986-e62a-4a8f-b5f0-8f30ecc35c5d	oscar-hollywood	\N
3028	b7ca8f3f-2fdc-477b-84f4-157f2802e9b5	leach-herman	\N
3029	b7cdb93b-6f9d-468a-ae00-54cbc324ee84	ruslan-duran	\N
3030	b85161da-7f4c-42a8-b7f6-19789cf6861d	javier-lotus	\N
3031	b86237bb-ade6-4b1d-9199-a3cc354118d9	hurley-pacheco	\N
3032	b88d313f-e546-407e-8bc6-94040499daa5	oliver-loofah	\N
3033	b8ab86c6-9054-4832-9b96-508dbd4eb624	esme-ramsey	\N
3034	b9293beb-d199-4b46-add9-c02f9362d802	bauer-zimmerman	\N
3035	bbf9543f-f100-445a-a467-81d7aab12236	farrell-seagull	\N
3036	bc4187fa-459a-4c06-bbf2-4e0e013d27ce	sixpack-dogwalker-deprecated	\N
3037	bca38809-81de-42ff-94e3-1c0ebfb1e797	famous-oconnor	\N
3038	bd24e18b-800d-4f15-878d-e334fb4803c4	helga-burton	\N
3039	bd4c6837-eeaa-4675-ae48-061efa0fd11a	workman-gloom	\N
3040	bd549bfe-b395-4dc0-8546-5c04c08e24a5	sam-solis	\N
3041	bd8778e5-02e8-4d1f-9c31-7b63942cc570	cell-barajas	\N
3042	bd8d58b6-f37f-48e6-9919-8e14ec91f92a	jose-haley	\N
3043	bd9d1d6e-7822-4ad9-bac4-89b8afd8a630	derrick-krueger	\N
3044	bf122660-df52-4fc4-9e70-ee185423ff93	walton-sports	\N
3045	bf6a24d1-4e89-4790-a4ba-eeb2870cbf6f	wyatt-mason-10	\N
3046	bf6a24d1-4e89-4790-a4ba-eeb2870cbf6f	rat-polk	\N
3047	bf6a24d1-4e89-4790-a4ba-eeb2870cbf6f	rat-mason	\N
3048	bfd9ff52-9bf6-4aaf-a859-d308d8f29616	declan-suzanne	\N
3049	c0177f76-67fc-4316-b650-894159dede45	paula-mason	\N
3050	c0732e36-3731-4f1a-abdc-daa9563b6506	nagomi-mcdaniel	\N
3051	c09e64b6-8248-407e-b3af-1931b880dbee	lenny-spruce	\N
3052	c17a4397-4dcc-440e-8c53-d897e971cae9	august-mina	\N
3053	c182f33c-aea5-48a2-97ed-dc74fa29b3c0	swamuel-mora	\N
3054	c22e3af5-9001-465f-b450-864d7db2b4a0	logan-horseman	\N
3055	c31d874c-1b4d-40f2-a1b3-42542e934047	cedric-spliff	\N
3056	c3b1b4e5-4b88-4245-b2b1-ae3ade57349e	wall-osborn	\N
3057	c4418663-7aa4-4c9f-ae73-0e81e442e8a2	chris-thibault	\N
3058	c4951cae-0b47-468b-a3ac-390cc8e9fd05	timmy-vine	\N
3059	c57222fd-df55-464c-a44e-b15443e61b70	natha-spruce	\N
3060	c6146c45-3d9b-4749-9f03-d4faae61e2c3	atlas-diaz	\N
3061	c675fcdf-6117-49a6-ac32-99a89a3a88aa	valentine-games	\N
3062	c6a277c3-d2b5-4363-839b-950896a5ec5e	mike-townsend	\N
3063	c6bd21a8-7880-4c00-8abe-33560fe84ac5	wendy-cerna	\N
3064	c6e2e389-ed04-4626-a5ba-fe398fe89568	henry-marshallow	\N
3065	c73d59dd-32a0-49ce-8ab4-b2dbb7dc94ec	eduardo-ingram	\N
3066	c755efce-d04d-4e00-b5c1-d801070d3808	basilio-fig	\N
3067	c771abab-f468-46e9-bac5-43db4c5b410f	wade-howe	\N
3068	c83a13f6-ee66-4b1c-9747-faa67395a6f1	zi-delacruz	\N
3069	c83f0fe0-44d1-4342-81e8-944bb38f8e23	langley-wheeler	\N
3070	c86b5add-6c9a-40e0-aa43-e4fd7dd4f2c7	sosa-elftower	\N
3071	c8de53a4-d90f-4192-955b-cec1732d920e	tyreek-cain	\N
3072	c9e4a49e-e35a-4034-a4c7-293896b40c58	alexander-horne	\N
3073	ca709205-226d-4d92-8be6-5f7871f48e26	rivers-javier	\N
3074	cbd19e6f-3d08-4734-b23f-585330028665	knight-urlacher	\N
3075	ccc99f2f-2feb-4f32-a9b9-c289f619d84c	itsuki-winner	\N
3076	cd417f8a-ce01-4ab2-921d-42e2e445bbe2	eizabeth-guerra	\N
3077	cd5494b4-05d0-4b2e-8578-357f0923ff4c	mcfarland-vargas	\N
3078	cd68d3a6-7fbc-445d-90f1-970c955e32f4	miguel-wheeler	\N
3079	cd6b102e-1881-4079-9a37-455038bbf10e	caleb-morin	\N
3080	ce0a156b-ba7b-4313-8fea-75807b4bc77f	conrad-twelve	\N
3081	ce0e57a7-89f5-41ea-80f9-6e649dd54089	yong-wright	\N
3082	ce3fb736-d20e-4e2a-88cb-e136783d3a47	javier-howe	\N
3083	ce58415f-4e62-47e2-a2c9-4d6a85961e1e	schneider-blanco	\N
3084	ceac785e-55fd-4a4e-9bc8-17a662a58a38	best-cerna	\N
3085	ceb5606d-ea3f-4471-9ca7-3d2e71a50dde	london-simmons	\N
3086	ceb8f8cd-80b2-47f0-b43e-4d885fa48aa4	donia-bailey	\N
3087	cf8e152e-2d27-4dcc-ba2b-68127de4e6a4	hendricks-richardson	\N
3088	d002946f-e7ed-4ce4-a405-63bdaf5eabb5	jorge-owens	\N
3089	d0d7b8fe-bad8-481f-978e-cb659304ed49	adalberto-tosser	\N
3090	d1a7c13f-8e78-4d2e-9cae-ebf3a5fcdb5d	elijah-bates	\N
3091	d23a1f7e-0071-444e-8361-6ae01f13036f	edric-tosser	\N
3092	d2a1e734-60d9-4989-b7d9-6eacda70486b	tiana-takahashi	\N
3093	d2d76815-cbdc-4c4b-9c9e-32ebf2297cc7	denzel-scott	\N
3094	d2f827a5-0133-4d96-b403-85a5e50d49e0	robbins-schmitt	\N
3095	d35ccee1-9559-49a1-aaa4-7809f7b5c46e	forrest-best	\N
3096	d46abb00-c546-4952-9218-4f16084e3238	atlas-guerra	\N
3097	d47dd08e-833c-4302-a965-a391d345455c	stu-trololol	\N
3098	d4a10c2a-0c28-466a-9213-38ba3339b65e	richmond-harrison	\N
3099	d5192d95-a547-498a-b4ea-6770dde4b9f5	summers-slugger	\N
3100	d51f1fe8-4ab8-411e-b836-5bba92984d32	hiroto-cerna	\N
3101	d5b6b11d-3924-4634-bd50-76553f1f162b	ogden-mendoza	\N
3102	d6c69d2d-9344-4b19-85a4-6cfcbaead5d2	joshua-watson	\N
3103	d6e9a211-7b33-45d9-8f09-6d1a1a7a3c78	william-boone	\N
3104	d744f534-2352-472b-9e42-cd91fa540f1b	tyler-violet	\N
3105	d74a2473-1f29-40fa-a41e-66fa2281dfca	landry-violence	\N
3106	d796d287-77ef-49f0-89ef-87bcdeb280ee	izuki-clark	\N
3107	d81ce662-07b6-4a73-baa4-acbbb41f9dc5	yummy-elliott	\N
3108	d8742d68-8fce-4d52-9a49-f4e33bd2a6fc	ortiz-morse	\N
3109	d8758c1b-afbb-43a5-b00b-6004d419e2c5	ortiz-nelson	\N
3110	d89da2d2-674c-4b85-8959-a4bd406f760a	fish-summer	\N
3111	d8bc482e-9309-4230-abcb-2c5a6412446d	august-obrien	\N
3112	d8ee256f-e3d0-46cb-8c77-b1f88d8c9df9	comfort-septemberish	\N
3113	d97835fd-2e92-4698-8900-1f5abea0a3b6	king-roland	\N
3114	d9a072f5-1cbb-45ce-87fb-b138e4d8f769	francisco-object	\N
3115	da0bbbe6-d13c-40cc-9594-8c476975d93d	lang-richardson	\N
3116	dac2fd55-5686-465f-a1b6-6fbed0b417c5	russo-slugger	\N
3117	db33a54c-3934-478f-bad4-fc313ac2580e	percival-wheeler	\N
3118	db3ff6f0-1045-4223-b3a8-a016ca987af9	murphy-thibault	\N
3119	db53211c-f841-4f33-accf-0c3e167889a0	travis-bendie	\N
3120	dd0b48fe-2d49-4344-83ed-9f0770b370a8	tillman-wan	\N
3121	dd6ba7f1-a97a-4374-a3a7-b3596e286bb3	matheo-tanaka	\N
3122	dd7e710f-da4e-475b-b870-2c29fe9d8c00	itsuki-weeks	\N
3123	dd8a43a4-a024-44e9-a522-785d998b29c3	miguel-peterson	\N
3124	de52d5c0-cba4-4ace-8308-e2ed3f8799d0	jose-mitchell	\N
3125	de67b585-9bf4-4e49-b410-101483ca2fbc	shaquille-sunshine	\N
3126	defbc540-a36d-460b-afd8-07da2375ee63	castillo-turner	\N
3127	df4da81a-917b-434f-b309-f00423ee4967	eugenia-bickle	\N
3128	dfd5ccbb-90ed-4bfe-83e0-dae9cc763f10	owen-picklestein	\N
3129	dfe3bc1b-fca8-47eb-965f-6cf947c35447	linus-haley	\N
3130	e111a46d-5ada-4311-ac4f-175cca3357da	alexandria-rosales	\N
3131	e16c3f28-eecd-4571-be1a-606bbac36b2b	wyatt-glover	\N
3132	e16c3f28-eecd-4571-be1a-606bbac36b2b	comfort-glover	\N
3133	e16c3f28-eecd-4571-be1a-606bbac36b2b	wyatt-mason-11	\N
3134	e1e33aab-df8c-4f53-b30a-ca1cea9f046e	joyner-rugrat	\N
3135	e376a90b-7ffe-47a2-a934-f36d6806f17d	howell-rocha	\N
3136	e3c06405-0564-47ce-bbbd-552bee4dd66f	scrap-weeks	\N
3137	e3c514ae-f813-470e-9c91-d5baf5ffcf16	tot-clark	\N
3138	e3e1d190-2b94-40c0-8e88-baa3fd198d0f	chambers-kennedy	\N
3139	e4034192-4dc6-4901-bb30-07fe3cf77b5e	wyatt-breadwinner	\N
3140	e4034192-4dc6-4901-bb30-07fe3cf77b5e	wyatt-mason-12	\N
3141	e4034192-4dc6-4901-bb30-07fe3cf77b5e	baldwin-breadwinner	\N
3142	e4e4c17d-8128-4704-9e04-f244d4573c4d	wesley-poole	\N
3143	e4f1f358-ee1f-4466-863e-f329766279d0	ronan-combs	\N
3144	e6114fd4-a11d-4f6c-b823-65691bb2d288	bevan-underbuck	\N
3145	e6502bc7-5b76-4939-9fb8-132057390b30	greer-lott	\N
3146	e749dc27-ca3b-456e-889c-d2ec02ac7f5f	aureliano-estes	\N
3147	e919dfae-91c3-475c-b5d5-8b0c14940c41	famous-meng	\N
3148	e972984c-2895-451c-b518-f06a0d8bd375	becker-solis	\N
3149	ea44bd36-65b4-4f3b-ac71-78d87a540b48	wanda-pothos	\N
3150	ea44bd36-65b4-4f3b-ac71-78d87a540b48	wyatt-pothos	\N
3151	ea44bd36-65b4-4f3b-ac71-78d87a540b48	wyatt-mason-13	\N
3152	eaaef47e-82cc-4c90-b77d-75c3fb279e83	herring-winfield	\N
3153	ebf2da50-7711-46ba-9e49-341ce3487e00	baldwin-jones	\N
3154	ecb8d2f5-4ff5-4890-9693-5654e00055f6	yeongho-benitez	\N
3155	ecf19925-dc57-4b89-b114-923d5a714dbe	margarito-bishop	\N
3156	ee55248b-318a-4bfb-8894-1cc70e4e0720	theo-king	\N
3157	ef9f8b95-9e73-49cd-be54-60f84858a285	collins-melon	\N
3158	efa73de4-af17-4f88-99d6-d0d69ed1d200	antonio-mccall	\N
3159	efafe75e-2f00-4418-914c-9b6675d39264	aldon-cashmoney	\N
3160	f0594932-8ef7-4d70-9894-df4be64875d8	fitzgerald-wanderlust	\N
3161	f071889c-f10f-4d2f-a1dd-c5dda34b3e2b	zion-facepunch	\N
3162	f0bcf4bb-74b3-412e-a54c-04c12ad28ecb	hahn-fox	\N
3163	f10ba06e-d509-414b-90cd-4d70d43c75f9	hernando-winter	\N
3164	f1185b20-7b4a-4ccc-a977-dc1afdfd4cb9	frazier-tosser	\N
3165	f2468055-e880-40bf-8ac6-a0763d846eb2	alaynabella-hollywood	\N
3166	f2a27a7e-bf04-4d31-86f5-16bfa3addbe7	winnie-hess	\N
3167	f2c477fb-28ea-4fcb-943a-9fab22df3da0	sandford-garner	\N
3168	f38c5d80-093f-46eb-99d6-942aa45cd921	andrew-solis	\N
3169	f3c07eaf-3d6c-4cc3-9e54-cbecc9c08286	campos-arias	\N
3170	f3ddfd87-73a2-4681-96fe-829476c97886	theodore-duende	\N
3171	f44a8b27-85c1-44de-b129-1b0f60bcb99c	atlas-jonbois	\N
3172	f4a5d734-0ade-4410-abb6-c0cd5a7a1c26	agan-harrison	\N
3173	f4ca437c-c31c-4508-afe7-6dae4330d717	fran-beans	\N
3174	f56657d3-3bdc-4840-a20c-91aca9cc360e	malik-romayne	\N
3175	f6342729-a38a-4204-af8d-64b7accb5620	marco-winner	\N
3176	f6b38e56-0d98-4e00-a96e-345aaac1e653	leticia-snyder	\N
3177	f70dd57b-55c4-4a62-a5ea-7cc4bf9d8ac1	tillman-henderson	\N
3178	f73009c5-2ede-4dc4-b96d-84ba93c8a429	thomas-kirby	\N
3179	f741dc01-2bae-4459-bfc0-f97536193eea	alejandro-leaf	\N
3180	f741dc01-2bae-4459-bfc0-f97536193eea	wyatt-mason-14	\N
3181	f7715b05-ee69-43e5-a0e5-8e3d34270c82	caligula-lotus	\N
3182	f7847de2-df43-4236-8dbe-ae403f5f3ab3	blood-hamburger	\N
3183	f883269f-117e-45ec-bb1e-fa8dbcf40d3e	jayden-wright	\N
3184	f8c20693-f439-4a29-a421-05ed92749f10	combs-duende	\N
3185	f967d064-0eaf-4445-b225-daed700e044b	wesley-dudley	\N
3186	f968532a-bf06-478e-89e0-3856b7f4b124	daniel-benedicte	\N
3187	f9930cb1-7ed2-4b9a-bf4f-7e35f2586d71	finn-james	\N
3188	f9c0d3cb-d8be-4f53-94c9-fc53bcbce520	matteo-prestige	\N
3189	fa477c92-39b6-4a52-b065-40af2f29840a	howell-franklin	\N
3190	fa5b54d2-b488-47cd-a529-592831e4813d	kina-larsen	\N
3191	fbb5291c-2438-400e-ab32-30ce1259c600	cory-novak	\N
3192	fcbe1d14-04c4-4331-97ad-46e170610633	jode-preston	\N
3193	fdfd36c7-e0c1-4fce-98f7-921c3d17eafe	reese-harrington	\N
3194	ff5a37d9-a6dd-49aa-b6fb-b935fd670820	dunn-keyes	\N
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

SELECT pg_catalog.setval('data.game_event_base_runners_id_seq', 3971025, true);


--
-- Name: game_events_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.game_events_id_seq', 4563761, true);


--
-- Name: imported_logs_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.imported_logs_id_seq', 28375, true);


--
-- Name: player_events_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.player_events_id_seq', 3711, true);


--
-- Name: player_modifications_player_modifications_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.player_modifications_player_modifications_id_seq', 1251, true);


--
-- Name: players_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.players_id_seq', 47788, true);


--
-- Name: team_modifications_team_modifications_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.team_modifications_team_modifications_id_seq', 66, true);


--
-- Name: team_positions_team_position_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.team_positions_team_position_id_seq', 10553, true);


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.teams_id_seq', 355, true);


--
-- Name: time_map_time_map_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.time_map_time_map_id_seq', 4563693, true);


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

SELECT pg_catalog.setval('taxa.player_url_slugs_player_url_slug_id_seq', 3194, true);


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
-- Name: event_types event_types_event_type_key; Type: CONSTRAINT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.event_types
    ADD CONSTRAINT event_types_event_type_key UNIQUE (event_type);


--
-- Name: event_types event_types_pkey; Type: CONSTRAINT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.event_types
    ADD CONSTRAINT event_types_pkey PRIMARY KEY (event_type_id);


--
-- Name: game_events_indx_event_type; Type: INDEX; Schema: data; Owner: -
--

CREATE INDEX game_events_indx_event_type ON data.game_events USING btree (event_type);


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

