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
ALTER TABLE IF EXISTS ONLY data.chronicler_hash_game_event DROP CONSTRAINT IF EXISTS chronicler_hash_game_event_game_event_id_fkey;
DROP TRIGGER IF EXISTS team_insert ON data.teams;
DROP TRIGGER IF EXISTS player_insert ON data.players;
DROP INDEX IF EXISTS data.team_roster_idx;
DROP INDEX IF EXISTS data.running_stats_all_events_indx_player_id;
DROP INDEX IF EXISTS data.game_events_indx_game_id;
DROP INDEX IF EXISTS data.game_events_indx_event_type;
DROP INDEX IF EXISTS data.chronicler_hash_game_event_indx_game_event_id;
DROP INDEX IF EXISTS data.batting_stats_all_events_indx_season;
DROP INDEX IF EXISTS data.batting_stats_all_events_indx_player_id;
ALTER TABLE IF EXISTS ONLY taxa.event_types DROP CONSTRAINT IF EXISTS event_types_pkey;
ALTER TABLE IF EXISTS ONLY taxa.event_types DROP CONSTRAINT IF EXISTS event_types_event_type_key;
ALTER TABLE IF EXISTS ONLY taxa.card DROP CONSTRAINT IF EXISTS card_pkey;
ALTER TABLE IF EXISTS ONLY taxa.attributes DROP CONSTRAINT IF EXISTS attributes_pkey;
ALTER TABLE IF EXISTS ONLY data.time_map DROP CONSTRAINT IF EXISTS time_map_pkey;
ALTER TABLE IF EXISTS ONLY data.teams DROP CONSTRAINT IF EXISTS teams_pkey;
ALTER TABLE IF EXISTS ONLY data.team_roster DROP CONSTRAINT IF EXISTS team_roster_pkey;
ALTER TABLE IF EXISTS ONLY data.team_modifications DROP CONSTRAINT IF EXISTS team_modifications_pkey;
ALTER TABLE IF EXISTS ONLY data.time_map DROP CONSTRAINT IF EXISTS season_day_unique;
ALTER TABLE IF EXISTS ONLY data.players DROP CONSTRAINT IF EXISTS players_pkey;
ALTER TABLE IF EXISTS ONLY data.player_modifications DROP CONSTRAINT IF EXISTS player_modifications_pkey;
ALTER TABLE IF EXISTS ONLY data.outcomes DROP CONSTRAINT IF EXISTS player_events_pkey;
ALTER TABLE IF EXISTS ONLY data.game_events DROP CONSTRAINT IF EXISTS no_dupes;
ALTER TABLE IF EXISTS ONLY data.imported_logs DROP CONSTRAINT IF EXISTS imported_logs_pkey;
ALTER TABLE IF EXISTS ONLY data.games DROP CONSTRAINT IF EXISTS game_pkey;
ALTER TABLE IF EXISTS ONLY data.game_events DROP CONSTRAINT IF EXISTS game_events_pkey;
ALTER TABLE IF EXISTS ONLY data.game_event_base_runners DROP CONSTRAINT IF EXISTS game_event_base_runners_pkey;
ALTER TABLE IF EXISTS ONLY data.chronicler_meta DROP CONSTRAINT IF EXISTS chronicler_meta_pk;
ALTER TABLE IF EXISTS ONLY data.chronicler_hash_game_event DROP CONSTRAINT IF EXISTS chronicler_hash_game_event_pkey;
ALTER TABLE IF EXISTS ONLY data.applied_patches DROP CONSTRAINT IF EXISTS applied_patches_pkey;
ALTER TABLE IF EXISTS taxa.vibe_to_arrows ALTER COLUMN vibe_to_arrow_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.team_divine_favor ALTER COLUMN team_divine_favor_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.team_abbreviations ALTER COLUMN team_abbreviation_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.player_url_slugs ALTER COLUMN player_url_slug_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.modifications ALTER COLUMN modification_db_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.leagues ALTER COLUMN league_db_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.event_types ALTER COLUMN event_type_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.divisions ALTER COLUMN division_db_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.division_teams ALTER COLUMN division_teams_id DROP DEFAULT;
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
ALTER TABLE IF EXISTS data.chronicler_hash_game_event ALTER COLUMN chronicler_hash_game_event_id DROP DEFAULT;
ALTER TABLE IF EXISTS data.applied_patches ALTER COLUMN patch_id DROP DEFAULT;
DROP TABLE IF EXISTS taxa.weather;
DROP SEQUENCE IF EXISTS taxa.vibe_to_arrows_vibe_to_arrow_id_seq;
DROP TABLE IF EXISTS taxa.vibe_to_arrows;
DROP SEQUENCE IF EXISTS taxa.team_divine_favor_team_divine_favor_id_seq;
DROP TABLE IF EXISTS taxa.team_divine_favor;
DROP SEQUENCE IF EXISTS taxa.team_abbreviations_team_abbreviation_id_seq;
DROP SEQUENCE IF EXISTS taxa.player_url_slugs_player_url_slug_id_seq;
DROP TABLE IF EXISTS taxa.pitch_types;
DROP TABLE IF EXISTS taxa.phases;
DROP SEQUENCE IF EXISTS taxa.modifications_modification_db_id_seq;
DROP TABLE IF EXISTS taxa.modifications;
DROP SEQUENCE IF EXISTS taxa.leagues_league_id_seq;
DROP SEQUENCE IF EXISTS taxa.event_types_event_type_id_seq;
DROP SEQUENCE IF EXISTS taxa.divisions_division_id_seq;
DROP SEQUENCE IF EXISTS taxa.division_teams_division_teams_id_seq;
DROP TABLE IF EXISTS taxa.card;
DROP SEQUENCE IF EXISTS taxa.attributes_attribute_id_seq;
DROP TABLE IF EXISTS taxa.attributes;
DROP SEQUENCE IF EXISTS data.time_map_time_map_id_seq;
DROP TABLE IF EXISTS data.time_map;
DROP SEQUENCE IF EXISTS data.teams_id_seq;
DROP SEQUENCE IF EXISTS data.team_positions_team_position_id_seq;
DROP SEQUENCE IF EXISTS data.team_modifications_team_modifications_id_seq;
DROP VIEW IF EXISTS data.stars_team_all_current;
DROP VIEW IF EXISTS data.running_stats_player_season;
DROP VIEW IF EXISTS data.running_stats_player_lifetime;
DROP MATERIALIZED VIEW IF EXISTS data.running_stats_all_events;
DROP VIEW IF EXISTS data.rosters_extended_current;
DROP VIEW IF EXISTS data.rosters_current;
DROP SEQUENCE IF EXISTS data.players_id_seq;
DROP VIEW IF EXISTS data.players_extended_current;
DROP VIEW IF EXISTS data.players_current;
DROP TABLE IF EXISTS taxa.player_url_slugs;
DROP SEQUENCE IF EXISTS data.player_modifications_player_modifications_id_seq;
DROP SEQUENCE IF EXISTS data.player_events_id_seq;
DROP VIEW IF EXISTS data.pitching_stats_player_season;
DROP VIEW IF EXISTS data.pitching_stats_player_lifetime;
DROP VIEW IF EXISTS data.pitching_records_player_single_game;
DROP MATERIALIZED VIEW IF EXISTS data.pitching_stats_all_appearances;
DROP TABLE IF EXISTS data.outcomes;
DROP SEQUENCE IF EXISTS data.imported_logs_id_seq;
DROP TABLE IF EXISTS data.imported_logs;
DROP SEQUENCE IF EXISTS data.game_events_id_seq;
DROP SEQUENCE IF EXISTS data.game_event_base_runners_id_seq;
DROP VIEW IF EXISTS data.fielder_stats_season;
DROP VIEW IF EXISTS data.fielder_stats_playoffs_season;
DROP VIEW IF EXISTS data.fielder_stats_playoffs_lifetime;
DROP VIEW IF EXISTS data.fielder_stats_lifetime;
DROP MATERIALIZED VIEW IF EXISTS data.fielder_stats_all_events;
DROP TABLE IF EXISTS data.chronicler_meta;
DROP SEQUENCE IF EXISTS data.chronicler_hash_game_event_chronicler_hash_game_event_id_seq;
DROP TABLE IF EXISTS data.chronicler_hash_game_event;
DROP VIEW IF EXISTS data.charm_counts;
DROP VIEW IF EXISTS data.batting_stats_player_season;
DROP VIEW IF EXISTS data.batting_stats_player_playoffs_season;
DROP VIEW IF EXISTS data.batting_stats_player_lifetime;
DROP VIEW IF EXISTS data.batting_records_team_single_game;
DROP VIEW IF EXISTS data.batting_records_team_season;
DROP VIEW IF EXISTS data.batting_records_team_playoffs_single_game;
DROP VIEW IF EXISTS data.batting_records_team_playoffs_season;
DROP VIEW IF EXISTS data.teams_current;
DROP VIEW IF EXISTS data.batting_records_player_single_game;
DROP MATERIALIZED VIEW IF EXISTS data.batting_stats_player_single_game;
DROP MATERIALIZED VIEW IF EXISTS data.batting_stats_all_events;
DROP TABLE IF EXISTS data.games;
DROP TABLE IF EXISTS data.game_event_base_runners;
DROP VIEW IF EXISTS data.batting_records_player_season;
DROP VIEW IF EXISTS data.batting_records_player_playoffs_single_game;
DROP VIEW IF EXISTS data.batting_records_player_playoffs_season;
DROP MATERIALIZED VIEW IF EXISTS data.players_info_expanded_all;
DROP TABLE IF EXISTS taxa.position_types;
DROP TABLE IF EXISTS taxa.coffee;
DROP TABLE IF EXISTS taxa.blood;
DROP VIEW IF EXISTS data.player_status_flags;
DROP VIEW IF EXISTS data.teams_info_expanded_all;
DROP TABLE IF EXISTS taxa.team_abbreviations;
DROP TABLE IF EXISTS taxa.leagues;
DROP TABLE IF EXISTS taxa.divisions;
DROP TABLE IF EXISTS taxa.division_teams;
DROP TABLE IF EXISTS data.teams;
DROP TABLE IF EXISTS data.team_roster;
DROP TABLE IF EXISTS data.team_modifications;
DROP TABLE IF EXISTS data.players;
DROP TABLE IF EXISTS data.player_modifications;
DROP VIEW IF EXISTS data.batting_records_league_season;
DROP VIEW IF EXISTS data.batting_records_league_playoffs_season;
DROP VIEW IF EXISTS data.batting_records_combined_teams_single_game;
DROP VIEW IF EXISTS data.batting_records_combined_teams_playoffs_single_game;
DROP TABLE IF EXISTS taxa.event_types;
DROP TABLE IF EXISTS data.game_events;
DROP SEQUENCE IF EXISTS data.applied_patches_patch_id_seq;
DROP TABLE IF EXISTS data.applied_patches;
DROP PROCEDURE IF EXISTS data.wipe_hourly();
DROP PROCEDURE IF EXISTS data.wipe_events();
DROP PROCEDURE IF EXISTS data.wipe_all();
DROP FUNCTION IF EXISTS data.timestamp_from_gameday(in_season integer, in_gameday integer);
DROP FUNCTION IF EXISTS data.teams_from_timestamp(in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.team_slug_creation();
DROP FUNCTION IF EXISTS data.slugging(in_total_bases_from_hits bigint, in_at_bats bigint);
DROP FUNCTION IF EXISTS data.season_timespan(in_season integer);
DROP FUNCTION IF EXISTS data.round_half_even(val numeric, prec integer);
DROP FUNCTION IF EXISTS data.rosters_from_timestamp(in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.refresh_matviews();
DROP PROCEDURE IF EXISTS data.refresh_materialized_views();
DROP FUNCTION IF EXISTS data.ref_leaderboard_season_pitching(in_season integer);
DROP FUNCTION IF EXISTS data.ref_leaderboard_season_batting(in_season integer);
DROP FUNCTION IF EXISTS data.reblase_gameid(in_game_id character varying);
DROP FUNCTION IF EXISTS data.rating_to_star(in_rating numeric);
DROP FUNCTION IF EXISTS data.players_from_timestamp(in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS data.player_slug_creation();
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
-- Name: player_slug_creation(); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.player_slug_creation() RETURNS trigger
    LANGUAGE plpgsql
    AS $$






BEGIN













	new.url_slug = replace(regexp_replace(lower(unaccent(new.player_name)), '[^A-Za-z'' ]', '','g'),' ','-');













	RETURN new;






END;






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
-- Name: reblase_gameid(character varying); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.reblase_gameid(in_game_id character varying) RETURNS character varying
    LANGUAGE sql
    AS $$






select 'https://reblase.sibr.dev/game/' || in_game_id;






$$;


--
-- Name: ref_leaderboard_season_batting(integer); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.ref_leaderboard_season_batting(in_season integer) RETURNS TABLE(player_id character varying, player_name character varying, url_slug character varying, team_id character varying, team text, value numeric, rank bigint, stat text)
    LANGUAGE plpgsql
    AS $$





begin





	return query 





SELECT 





a.player_id, 





p.player_name, 





p.url_slug,





p.team_id,





p.team,





c.*





FROM 





(





	SELECT b.*, 





	ba.on_base_percentage, 





	ba.slugging, 





	ba.batting_average, 





	ba.on_base_slugging,





	ba.obp_rank, 





	ba.slugging_rank, 





	ba.ba_rank, 





	ba.ops_rank,





	r.runs,





	r.stolen_bases,





	r.caught_stealing,





	r.runs_rank,





	r.sb_rank,





	r.cs_rank





	from





	(





		SELECT x.player_id,





		season,





		hits_risps,





		walks,





		doubles,





		triples,





		quadruples,





		home_runs,





		total_bases,





		hits,





		runs_batted_in,





		sacrifices,





		strikeouts,





		hbps,





		gidps,





		rank() OVER (ORDER BY hits_risps DESC) AS hits_risp_rank,





		rank() OVER (ORDER BY walks DESC) AS bb_rank,





		rank() OVER (ORDER BY doubles DESC) AS dbl_rank,





		rank() OVER (ORDER BY triples DESC) AS trp_rank,





		rank() OVER (ORDER BY home_runs DESC) AS hr_rank,





		rank() OVER (ORDER BY total_bases DESC) AS tb_rank,





		rank() OVER (ORDER BY quadruples DESC) AS qd_rank,





		rank() OVER (ORDER BY hits DESC) AS hits_rank,





		rank() OVER (ORDER BY runs_batted_in DESC) AS rbi_rank,





		rank() OVER (ORDER BY sacrifices DESC) AS sac_rank,





		rank() OVER (ORDER BY strikeouts DESC) AS k_rank,





		rank() OVER (ORDER BY hbps DESC) AS hbp_rank,





		rank() OVER (ORDER BY gidps DESC) AS gidp_rank





		FROM DATA.batting_stats_player_season x





		WHERE season = in_season





	) b





	LEFT JOIN





	(





		SELECT y.player_id,





		on_base_percentage,





		slugging,





		batting_average,





		on_base_slugging,





		rank() OVER (ORDER BY on_base_percentage DESC) AS obp_rank,





		rank() OVER (ORDER BY slugging DESC) AS slugging_rank,





		rank() OVER (ORDER BY batting_average DESC) AS ba_rank,           





		rank() OVER (ORDER BY on_base_slugging DESC) AS ops_rank





		FROM DATA.batting_stats_player_season y





		WHERE season = in_season





		AND plate_appearances > (SELECT MAX(DAY)+1 FROM DATA.games WHERE season = in_season





		AND NOT is_postseason)*2





	) ba





	ON (b.player_id = ba.player_id)





	LEFT JOIN





	(





		SELECT z.player_id,





		season,





		runs,





		stolen_bases,





		caught_stealing,





		rank() OVER (ORDER BY runs DESC) AS runs_rank,





		rank() OVER (ORDER BY stolen_bases DESC) AS sb_rank,





		rank() OVER (ORDER BY caught_stealing DESC) AS cs_rank





		FROM DATA.running_stats_player_season z





		WHERE season = in_season





	) r





	ON (b.player_id = r.player_id)





) a





CROSS JOIN LATERAL 





(





	VALUES 





	(a.on_base_percentage, a.obp_rank, 'on_base_percentage'),





	(a.slugging, a.slugging_rank, 'slugging'),





	(a.batting_average,a.ba_rank,'batting_average'), 





	(a.on_base_slugging,a.ops_rank,'on_base_slugging'),





	(a.hits_risps,a.hits_risp_rank,'hits_risp'), 





	(a.walks,a.bb_rank,'walks'), 





	(a.doubles,a.dbl_rank,'doubles'), 





	(a.triples,a.trp_rank,'triples'), 





	(a.quadruples,a.qd_rank,'quadruples'),





	(a.home_runs,a.hr_rank,'home_runs'), 





	(a.total_bases,a.tb_rank,'total_bases'), 





	(a.hits,a.hits_rank,'hits'), 





	(a.runs_batted_in,a.rbi_rank,'runs_batted_in'), 





	(a.sacrifices,a.sac_rank,'sacrifices'), 





	(a.strikeouts,a.k_rank,'strikeouts'),





	(a.hbps,a.hbp_rank,'hit_by_pitches'),





	(a.gidps,a.gidp_rank,'gidp'),





	(a.runs,a.runs_rank,'runs_scored'),





	(a.stolen_bases,a.sb_rank,'stolen_bases'),





	(a.caught_stealing,a.cs_rank,'caught_stealing')





) AS c(value, rank, stat)





JOIN data.players_info_expanded_all p ON (a.player_id = p.player_id 





AND (SELECT max(tm.first_time) FROM data.time_map tm WHERE tm.season = a.season 





	AND tm.day = (SELECT max(DAY) FROM DATA.games WHERE season = in_season AND NOT is_postseason)) >= p.valid_from





AND (SELECT max(tm.first_time) FROM data.time_map tm WHERE tm.season = a.season 





	AND tm.day = (SELECT max(DAY) FROM DATA.games WHERE season = in_season AND NOT is_postseason)) <= p.valid_until)





WHERE c.rank <= 10 





ORDER BY c.stat, c.rank, p.player_name;	











	end;





$$;


--
-- Name: ref_leaderboard_season_pitching(integer); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.ref_leaderboard_season_pitching(in_season integer) RETURNS TABLE(player_id character varying, player_name character varying, url_slug character varying, team_id character varying, team text, value numeric, rank bigint, stat text)
    LANGUAGE plpgsql
    AS $$

begin



	return query 



SELECT 

a.player_id, 

p.player_name, 

p.url_slug,

p.team_id,

p.team,

c.*

FROM 

(

	SELECT p.*,

	pa.era,

	pa.bb_per_9,

	pa.hits_per_9,

	pa.hr_per_9,

	pa.k_per_9,

	pa.era_rank,

	pa.bb9_rank,

	pa.hits9_rank,

	pa.hr9_rank,

	pa.k9_rank

	from

	(

		SELECT x.player_id,

		season,

		walks,

		ROUND(walks/batters_faced,3) AS bb_pct,

		strikeouts,

		round(strikeouts/walks,2) AS k_bb,

		ROUND(strikeouts/batters_faced,3) AS k_pct,

		runs_allowed,

		hits_allowed,

		hrs_allowed,

		innings,

		pitch_count,

		hbps,

		wins,

		losses,

		shutouts,

		quality_starts,

		ROUND((walks+hits_allowed)/innings,3) AS whip,

		round(wins::DECIMAL/(wins::DECIMAL+losses::DECIMAL),3) AS win_pct,

		rank() OVER (ORDER BY walks DESC) AS bb_rank,

		rank() OVER (ORDER BY round(walks/batters_faced,3)) AS bbpct_rank,		

		rank() OVER (ORDER BY strikeouts DESC) AS k_rank,

		rank() OVER (ORDER BY round(strikeouts/walks,2) DESC) AS kbb_rank,

		rank() OVER (ORDER BY round(strikeouts/batters_faced,3) DESC) AS kpct_rank,		

		rank() OVER (ORDER BY runs_allowed DESC) AS runs_rank,

		rank() OVER (ORDER BY hits_allowed DESC) AS hits_rank,

		rank() OVER (ORDER BY hrs_allowed DESC) AS hrs_rank,

		rank() OVER (ORDER BY innings DESC) AS inn_rank,

		rank() OVER (ORDER BY pitch_count DESC) AS ptch_rank,

		rank() OVER (ORDER BY hbps DESC) AS hbp_rank,

		rank() OVER (ORDER BY wins DESC) AS win_rank,

		rank() OVER (ORDER BY losses DESC) AS loss_rank,

		rank() OVER (ORDER BY shutouts DESC) AS shut_rank,

		rank() OVER (ORDER BY quality_starts DESC) AS qual_rank,

		rank() OVER (ORDER BY ROUND((walks+hits_allowed)/innings,3)) AS whip_rank

		FROM DATA.pitching_stats_player_season x

		WHERE season = in_season

	) p

	LEFT JOIN

	(

		SELECT x.player_id,

		era,

		bb_per_9,

		hits_per_9,

		hr_per_9,

		k_per_9,

		rank() OVER (ORDER BY era) AS era_rank,

		rank() OVER (ORDER BY bb_per_9) AS bb9_rank,

		rank() OVER (ORDER BY hits_per_9) AS hits9_rank,

		rank() OVER (ORDER BY hr_per_9) AS hr9_rank,

		rank() OVER (ORDER BY k_per_9 DESC) AS k9_rank

		FROM DATA.pitching_stats_player_season x

		WHERE season = in_season

		

		--at least 1 inning per team's regular season games for averaging stats

		AND outs_recorded > (SELECT MAX(DAY)+1 FROM DATA.games WHERE season = in_season

		AND NOT is_postseason)*3

	) pa

	ON (p.player_id = pa.player_id)

) a

CROSS JOIN LATERAL 

(

	VALUES 

	(a.walks, a.bb_rank, 'walks'),

	(a.bb_pct, a.bbpct_rank, 'walk_percentage'),

	(a.strikeouts, a.k_rank, 'strikeouts'),

	(a.k_bb, a.kbb_rank, 'strikeouts_per_walk'),

	(a.k_pct, a.kpct_rank, 'strikeout_percentage'),

	(a.runs_allowed, a.runs_rank, 'runs_allowed'),

	(a.hits_allowed, a.hits_rank, 'hits_allowed'),

	(a.hrs_allowed, a.hrs_rank, 'home_runs_allowed'),

	(a.innings, a.inn_rank, 'innings'),

	(a.pitch_count, a.ptch_rank, 'pitches_thrown'),

	(a.hbps, a.hbp_rank, 'hit_by_pitches'),

	(a.wins, a.win_rank, 'wins'),

	(a.losses, a.loss_rank, 'losses'),

	(a.shutouts, a.shut_rank, 'shutouts'),

	(a.quality_starts, a.qual_rank, 'quality_starts'),

	(a.era, a.era_rank, 'earned_run_average'),

	(a.bb_per_9, a.bb9_rank, 'walks_per_9'),

	(a.hits_per_9, a.hits9_rank, 'hits_per_9'),

	(a.hr_per_9, a.hr9_rank, 'home_runs_per_9'),

	(a.k_per_9, a.k9_rank, 'strikeouts_per_9')



) AS c(value, rank, stat)

JOIN data.players_info_expanded_all p ON (a.player_id = p.player_id 

AND (SELECT max(tm.first_time) FROM data.time_map tm WHERE tm.season = a.season 

AND tm.day = (SELECT max(DAY) FROM DATA.games WHERE season = in_season AND NOT is_postseason)) >= p.valid_from

AND (SELECT max(tm.first_time) FROM data.time_map tm WHERE tm.season = a.season 

AND tm.day = (SELECT max(DAY) FROM DATA.games WHERE season = in_season AND NOT is_postseason)) <= p.valid_until)

WHERE c.rank <= 10 

ORDER BY c.stat, c.rank, p.player_name;	



	end;

$$;


--
-- Name: refresh_materialized_views(); Type: PROCEDURE; Schema: data; Owner: -
--

CREATE PROCEDURE data.refresh_materialized_views()
    LANGUAGE plpgsql
    AS $$






begin













perform data.refresh_matviews();













end;






$$;


--
-- Name: refresh_matviews(); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.refresh_matviews() RETURNS void
    LANGUAGE sql SECURITY DEFINER
    AS $$
REFRESH MATERIALIZED VIEW data.players_info_expanded_all;
REFRESH MATERIALIZED VIEW data.batting_stats_all_events;
REFRESH MATERIALIZED VIEW data.batting_stats_player_single_game;
REFRESH MATERIALIZED VIEW data.fielder_stats_all_events;
REFRESH MATERIALIZED VIEW data.running_stats_all_events;
REFRESH MATERIALIZED VIEW data.pitching_stats_all_appearances;
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
-- Name: team_slug_creation(); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.team_slug_creation() RETURNS trigger
    LANGUAGE plpgsql
    AS $$






BEGIN






	new.url_slug = replace(regexp_replace(lower(unaccent(new.nickname)), '[^A-Za-z'' ]', '','g'),' ','-');






	RETURN new;






END;






$$;


--
-- Name: teams_from_timestamp(timestamp without time zone); Type: FUNCTION; Schema: data; Owner: -
--

CREATE FUNCTION data.teams_from_timestamp(in_timestamp timestamp without time zone) RETURNS TABLE(id integer, team_id character varying, location text, nickname text, full_name text, valid_from timestamp without time zone, valid_until timestamp without time zone, hash uuid, url_slug character varying, card integer)
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
    AS $$






begin






	call data.wipe_events();






	call data.wipe_hourly();






end;






$$;


--
-- Name: wipe_events(); Type: PROCEDURE; Schema: data; Owner: -
--

CREATE PROCEDURE data.wipe_events()
    LANGUAGE plpgsql
    AS $$






begin













truncate data.game_events cascade;






delete from data.imported_logs where key like 'blaseball-log%';






update data.chronicler_meta set season=0, day=0, game_timestamp=null where id=0;






truncate data.time_map;






truncate data.chronicler_hash_game_event;













end;






$$;


--
-- Name: wipe_hourly(); Type: PROCEDURE; Schema: data; Owner: -
--

CREATE PROCEDURE data.wipe_hourly()
    LANGUAGE plpgsql
    AS $$






begin













update data.chronicler_meta set team_timestamp=null, player_timestamp=null where id=0;













delete from data.imported_logs where key like 'compressed-hourly%';













truncate data.players cascade;






truncate data.teams cascade;






truncate data.games cascade;






truncate data.team_roster cascade;






truncate data.player_modifications cascade;






truncate data.team_modifications cascade;













end;






$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: applied_patches; Type: TABLE; Schema: data; Owner: -
--

CREATE TABLE data.applied_patches (
    patch_id integer NOT NULL,
    patch_hash uuid
);


--
-- Name: applied_patches_patch_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.applied_patches_patch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: applied_patches_patch_id_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: -
--

ALTER SEQUENCE data.applied_patches_patch_id_seq OWNED BY data.applied_patches.patch_id;


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
-- Name: batting_records_combined_teams_playoffs_single_game; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_records_combined_teams_playoffs_single_game AS
 SELECT y.that AS record,
    y.game_id,
    y.event,
    y.season,
    y.day
   FROM ( SELECT x.that,
            x.game_id,
            x.event,
            x.season,
            x.day,
            rank() OVER (PARTITION BY x.event ORDER BY x.that DESC) AS this
           FROM ( SELECT count(1) AS that,
                    game_events.game_id,
                    game_events.event_type AS event,
                    game_events.season,
                    game_events.day
                   FROM data.game_events
                  WHERE ((game_events.event_type <> ALL (ARRAY['UNKNOWN'::text, 'OUT'::text, 'GAME_OVER'::text])) AND (game_events.day >= 99))
                  GROUP BY game_events.game_id, game_events.event_type, game_events.season, game_events.day
                UNION
                 SELECT sum(xe.hit) AS that,
                    ge.game_id,
                    'HIT'::text AS event,
                    ge.season,
                    ge.day
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day >= 99))
                  GROUP BY ge.game_id, 'HIT'::text, ge.season, ge.day
                UNION
                 SELECT sum(xe.total_bases) AS that,
                    ge.game_id,
                    'TOTAL_BASES'::text AS event,
                    ge.season,
                    ge.day
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day >= 99))
                  GROUP BY ge.game_id, 'TOTAL_BASES'::text, ge.season, ge.day
                UNION
                 SELECT sum(ge.runs_batted_in) AS that,
                    ge.game_id,
                    'RBIS'::text AS event,
                    ge.season,
                    ge.day
                   FROM data.game_events ge
                  WHERE ((ge.runs_batted_in > 0) AND (ge.day >= 99))
                  GROUP BY ge.game_id, 'RBIS'::text, ge.season, ge.day) x) y
  WHERE (y.this = 1)
  ORDER BY y.event, y.season, y.day;


--
-- Name: batting_records_combined_teams_single_game; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_records_combined_teams_single_game AS
 SELECT y.that AS record,
    y.game_id,
    y.event,
    y.season,
    y.day
   FROM ( SELECT x.that,
            x.game_id,
            x.event,
            x.season,
            x.day,
            rank() OVER (PARTITION BY x.event ORDER BY x.that DESC) AS this
           FROM ( SELECT count(1) AS that,
                    game_events.game_id,
                    game_events.event_type AS event,
                    game_events.season,
                    game_events.day
                   FROM data.game_events
                  WHERE ((game_events.event_type <> ALL (ARRAY['UNKNOWN'::text, 'OUT'::text, 'GAME_OVER'::text])) AND (game_events.day < 99))
                  GROUP BY game_events.game_id, game_events.event_type, game_events.season, game_events.day
                UNION
                 SELECT sum(xe.hit) AS that,
                    ge.game_id,
                    'HIT'::text AS event,
                    ge.season,
                    ge.day
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day < 99))
                  GROUP BY ge.game_id, 'HIT'::text, ge.season, ge.day
                UNION
                 SELECT sum(xe.total_bases) AS that,
                    ge.game_id,
                    'TOTAL_BASES'::text AS event,
                    ge.season,
                    ge.day
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day < 99))
                  GROUP BY ge.game_id, 'TOTAL_BASES'::text, ge.season, ge.day
                UNION
                 SELECT sum(ge.runs_batted_in) AS that,
                    ge.game_id,
                    'RBIS'::text AS event,
                    ge.season,
                    ge.day
                   FROM data.game_events ge
                  WHERE ((ge.runs_batted_in > 0) AND (ge.day < 99))
                  GROUP BY ge.game_id, 'RBIS'::text, ge.season, ge.day) x) y
  WHERE (y.this = 1)
  ORDER BY y.event, y.season, y.day;


--
-- Name: batting_records_league_playoffs_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_records_league_playoffs_season AS
 SELECT y.that AS record,
    y.event,
    y.season
   FROM ( SELECT x.that,
            x.event,
            x.season,
            rank() OVER (PARTITION BY x.event ORDER BY x.that DESC) AS this
           FROM ( SELECT count(1) AS that,
                    game_events.event_type AS event,
                    game_events.season
                   FROM data.game_events
                  WHERE ((game_events.event_type <> ALL (ARRAY['UNKNOWN'::text, 'OUT'::text, 'GAME_OVER'::text])) AND (game_events.day >= 99))
                  GROUP BY game_events.event_type, game_events.season
                UNION
                 SELECT sum(xe.hit) AS that,
                    'HIT'::text AS event,
                    ge.season
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day >= 99))
                  GROUP BY 'HIT'::text, ge.season
                UNION
                 SELECT sum(xe.total_bases) AS that,
                    'TOTAL_BASES'::text AS event,
                    ge.season
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day >= 99))
                  GROUP BY 'TOTAL_BASES'::text, ge.season
                UNION
                 SELECT sum(ge.runs_batted_in) AS that,
                    'RBIS'::text AS event,
                    ge.season
                   FROM data.game_events ge
                  WHERE ((ge.runs_batted_in > 0) AND (ge.day >= 99))
                  GROUP BY 'RBIS'::text, ge.season) x) y
  WHERE (y.this = 1)
  ORDER BY y.event, y.season;


--
-- Name: batting_records_league_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_records_league_season AS
 SELECT y.that AS record,
    y.event,
    y.season
   FROM ( SELECT x.that,
            x.event,
            x.season,
            rank() OVER (PARTITION BY x.event ORDER BY x.that DESC) AS this
           FROM ( SELECT count(1) AS that,
                    game_events.event_type AS event,
                    game_events.season
                   FROM data.game_events
                  WHERE ((game_events.event_type <> ALL (ARRAY['UNKNOWN'::text, 'OUT'::text, 'GAME_OVER'::text])) AND (game_events.day < 99))
                  GROUP BY game_events.event_type, game_events.season
                UNION
                 SELECT sum(xe.hit) AS that,
                    'HIT'::text AS event,
                    ge.season
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day < 99))
                  GROUP BY 'HIT'::text, ge.season
                UNION
                 SELECT sum(xe.total_bases) AS that,
                    'TOTAL_BASES'::text AS event,
                    ge.season
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day < 99))
                  GROUP BY 'TOTAL_BASES'::text, ge.season
                UNION
                 SELECT sum(ge.runs_batted_in) AS that,
                    'RBIS'::text AS event,
                    ge.season
                   FROM data.game_events ge
                  WHERE ((ge.runs_batted_in > 0) AND (ge.day < 99))
                  GROUP BY 'RBIS'::text, ge.season) x) y
  WHERE (y.this = 1)
  ORDER BY y.event, y.season;


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
    hash uuid,
    url_slug character varying,
    card integer
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
-- Name: team_abbreviations; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.team_abbreviations (
    team_abbreviation_id integer NOT NULL,
    team_abbreviation character varying,
    team_id character varying
);


--
-- Name: teams_info_expanded_all; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.teams_info_expanded_all AS
 SELECT ts.team_id,
    t.location,
    t.nickname,
    t.full_name,
    ta.team_abbreviation,
    t.url_slug,
        CASE
            WHEN (NOT (EXISTS ( SELECT 1
               FROM taxa.division_teams xdt
              WHERE ((xdt.team_id)::text = (ts.team_id)::text)))) THEN 'disbanded'::text
            WHEN (EXISTS ( SELECT 1
               FROM taxa.division_teams xdt
              WHERE (((xdt.team_id)::text = (ts.team_id)::text) AND (xdt.division_id IS NOT NULL) AND (xdt.valid_until IS NULL)))) THEN 'active'::text
            ELSE 'ascended'::text
        END AS current_status,
    ts.timestampd AS valid_from,
    lead(ts.timestampd) OVER (PARTITION BY ts.team_id ORDER BY ts.timestampd) AS valid_until,
    ( SELECT gameday_from_timestamp.gameday
           FROM data.gameday_from_timestamp(ts.timestampd) gameday_from_timestamp(season, gameday)) AS gameday_from,
    ( SELECT gameday_from_timestamp.season
           FROM data.gameday_from_timestamp(ts.timestampd) gameday_from_timestamp(season, gameday)) AS season_from,
    d.division_text AS division,
    d.division_id,
    l.league_text AS league,
    l.league_id,
    ( SELECT array_agg(DISTINCT m.modification ORDER BY m.modification) AS array_agg
           FROM data.team_modifications m
          WHERE (((m.team_id)::text = (ts.team_id)::text) AND (m.valid_from <= ts.timestampd) AND (ts.timestampd < COALESCE((m.valid_until)::timestamp with time zone, (now() + '00:00:00.001'::interval))))
          GROUP BY m.team_id) AS modifications
   FROM (((((( SELECT DISTINCT x.team_id,
            unnest(x.a) AS timestampd
           FROM ( SELECT DISTINCT t_1.team_id,
                    ARRAY[t_1.valid_from, t_1.valid_until] AS a
                   FROM data.teams t_1
                UNION
                 SELECT DISTINCT dt_1.team_id,
                    ARRAY[dt_1.valid_from, dt_1.valid_until] AS a
                   FROM taxa.division_teams dt_1
                UNION
                 SELECT DISTINCT tm.team_id,
                    ARRAY[tm.valid_from, tm.valid_until] AS a
                   FROM data.team_modifications tm
                  WHERE (NOT ((( SELECT gameday_from_timestamp.gameday
                           FROM data.gameday_from_timestamp(COALESCE(tm.valid_from, (now())::timestamp without time zone)) gameday_from_timestamp(season, gameday)) >= 98) AND ((tm.modification)::text = 'PARTY_TIME'::text)))) x) ts
     JOIN data.teams t ON ((((ts.team_id)::text = (t.team_id)::text) AND (t.valid_from <= (ts.timestampd + '00:00:00.001'::interval)) AND (ts.timestampd < COALESCE((t.valid_until)::timestamp with time zone, (now() + '00:00:00.001'::interval))))))
     LEFT JOIN taxa.team_abbreviations ta ON (((ts.team_id)::text = (ta.team_id)::text)))
     LEFT JOIN taxa.division_teams dt ON ((((ts.team_id)::text = (dt.team_id)::text) AND (dt.valid_from <= (ts.timestampd + '00:00:00.001'::interval)) AND (ts.timestampd < COALESCE((dt.valid_until)::timestamp with time zone, (now() + '00:00:00.001'::interval))))))
     LEFT JOIN taxa.divisions d ON (((dt.division_id)::text = (d.division_id)::text)))
     LEFT JOIN taxa.leagues l ON ((d.league_id = l.league_db_id)))
  WHERE (ts.timestampd IS NOT NULL)
  ORDER BY t.full_name, ts.timestampd;


--
-- Name: player_status_flags; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.player_status_flags AS
 SELECT DISTINCT p.player_id,
        CASE
            WHEN ((p.player_id)::text = 'bc4187fa-459a-4c06-bbf2-4e0e013d27ce'::text) THEN 'deprecated'::text
            WHEN (EXISTS ( SELECT 1
               FROM (data.team_roster rc
                 JOIN data.teams_info_expanded_all t ON (((rc.team_id)::text = (t.team_id)::text)))
              WHERE (((rc.player_id)::text = (p.player_id)::text) AND (rc.valid_until IS NULL) AND (t.current_status = 'active'::text)))) THEN 'active'::text
            WHEN (EXISTS ( SELECT 1
               FROM (data.team_roster rc
                 JOIN data.teams_info_expanded_all t ON (((rc.team_id)::text = (t.team_id)::text)))
              WHERE (((rc.player_id)::text = (p.player_id)::text) AND (rc.valid_until IS NULL) AND (t.current_status = 'ascended'::text)))) THEN 'ascended'::text
            WHEN ( SELECT ip.deceased
               FROM data.players ip
              WHERE (((ip.player_id)::text = (p.player_id)::text) AND (ip.valid_until IS NULL))) THEN 'deceased'::text
            WHEN (EXISTS ( SELECT 1
               FROM data.player_modifications pm
              WHERE (((pm.player_id)::text = (p.player_id)::text) AND (pm.valid_until IS NULL) AND ((pm.modification)::text = 'RETIRED'::text)))) THEN 'retired'::text
            ELSE NULL::text
        END AS current_state,
        CASE
            WHEN ((EXISTS ( SELECT 1
               FROM data.team_roster rc
              WHERE (((rc.player_id)::text = (p.player_id)::text) AND (rc.valid_until IS NULL) AND (rc.position_type_id < (2)::numeric)))) AND (NOT (EXISTS ( SELECT 1
               FROM (data.team_roster rc
                 JOIN data.teams_info_expanded_all t ON (((rc.team_id)::text = (t.team_id)::text)))
              WHERE (((rc.player_id)::text = (p.player_id)::text) AND (rc.valid_until IS NULL) AND (t.current_status = 'ascended'::text))))) AND (NOT (EXISTS ( SELECT 1
               FROM data.player_modifications pm
              WHERE (((pm.player_id)::text = (p.player_id)::text) AND (pm.valid_until IS NULL) AND ((pm.modification)::text = 'RETIRED'::text)))))) THEN 'main_roster'::text
            WHEN ((EXISTS ( SELECT 1
               FROM data.team_roster rc
              WHERE (((rc.player_id)::text = (p.player_id)::text) AND (rc.valid_until IS NULL) AND (rc.position_type_id > (1)::numeric)))) AND (NOT (EXISTS ( SELECT 1
               FROM data.team_roster rc
              WHERE (((rc.player_id)::text = (p.player_id)::text) AND (rc.position_type_id < (2)::numeric)))))) THEN 'shadow_fk'::text
            WHEN ((EXISTS ( SELECT 1
               FROM data.team_roster rc
              WHERE (((rc.player_id)::text = (p.player_id)::text) AND (rc.valid_until IS NULL) AND (rc.position_type_id > (1)::numeric)))) AND (EXISTS ( SELECT 1
               FROM data.team_roster rc
              WHERE (((rc.player_id)::text = (p.player_id)::text) AND (rc.position_type_id < (2)::numeric))))) THEN 'shadow_known'::text
            ELSE 'other'::text
        END AS current_location
   FROM data.players p;


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
-- Name: position_types; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.position_types (
    position_type_id integer,
    position_type character varying
);


--
-- Name: players_info_expanded_all; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--

CREATE MATERIALIZED VIEW data.players_info_expanded_all AS
 SELECT p.player_id,
    p.player_name,
    ps.current_state,
    ps.current_location,
    r.team_id,
    t.team_abbreviation,
    t.nickname AS team,
    r.position_id,
    xp.position_type,
    ts.timestampd AS valid_from,
    lead(ts.timestampd) OVER (PARTITION BY ts.player_id ORDER BY ts.timestampd) AS valid_until,
    ( SELECT gameday_from_timestamp.gameday
           FROM data.gameday_from_timestamp(ts.timestampd) gameday_from_timestamp(season, gameday)) AS gameday_from,
    ( SELECT gameday_from_timestamp.season
           FROM data.gameday_from_timestamp(ts.timestampd) gameday_from_timestamp(season, gameday)) AS season_from,
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
    xc.coffee_text AS coffee,
    xb.blood_type AS blood,
    p.url_slug,
    ( SELECT array_agg(DISTINCT m.modification ORDER BY m.modification) AS array_agg
           FROM data.player_modifications m
          WHERE (((m.player_id)::text = (ts.player_id)::text) AND (m.valid_from <= ts.timestampd) AND (ts.timestampd < COALESCE((m.valid_until)::timestamp with time zone, (now() + '00:00:00.001'::interval))))
          GROUP BY m.player_id) AS modifications,
    data.batting_rating_raw(p.tragicness, p.patheticism, p.thwackability, p.divinity, p.moxie, p.musclitude, p.martyrdom) AS batting_rating,
    data.baserunning_rating_raw(p.laserlikeness, p.continuation, p.base_thirst, p.indulgence, p.ground_friction) AS baserunning_rating,
    data.defense_rating_raw(p.omniscience, p.tenaciousness, p.watchfulness, p.anticapitalism, p.chasiness) AS defense_rating,
    data.pitching_rating_raw(p.unthwackability, p.ruthlessness, p.overpowerment, p.shakespearianism, p.coldness) AS pitching_rating,
    data.rating_to_star(data.batting_rating_raw(p.tragicness, p.patheticism, p.thwackability, p.divinity, p.moxie, p.musclitude, p.martyrdom)) AS batting_stars,
    data.rating_to_star(data.baserunning_rating_raw(p.laserlikeness, p.continuation, p.base_thirst, p.indulgence, p.ground_friction)) AS baserunning_stars,
    data.rating_to_star(data.defense_rating_raw(p.omniscience, p.tenaciousness, p.watchfulness, p.anticapitalism, p.chasiness)) AS defense_stars,
    data.rating_to_star(data.pitching_rating_raw(p.unthwackability, p.ruthlessness, p.overpowerment, p.shakespearianism, p.coldness)) AS pitching_stars
   FROM (((((((( SELECT DISTINCT x.player_id,
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
                   FROM data.team_roster) x) ts
     JOIN data.players p ON ((((p.player_id)::text = (ts.player_id)::text) AND (p.valid_from <= (ts.timestampd + '00:00:00.001'::interval)) AND (ts.timestampd < COALESCE((p.valid_until)::timestamp with time zone, (now() + '00:00:00.001'::interval))))))
     JOIN data.player_status_flags ps ON (((ts.player_id)::text = (ps.player_id)::text)))
     LEFT JOIN LATERAL data.rosters_from_timestamp(COALESCE(ts.timestampd, (now())::timestamp without time zone)) r(team_roster_id, team_id, position_id, valid_from, valid_until, player_id, position_type_id) ON (((ts.player_id)::text = (r.player_id)::text)))
     LEFT JOIN data.teams_info_expanded_all t ON ((((r.team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
     LEFT JOIN taxa.blood xb ON ((p.blood = xb.blood_id)))
     LEFT JOIN taxa.coffee xc ON ((p.coffee = xc.coffee_id)))
     LEFT JOIN taxa.position_types xp ON ((r.position_type_id = (xp.position_type_id)::numeric)))
  WITH NO DATA;


--
-- Name: batting_records_player_playoffs_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_records_player_playoffs_season AS
 SELECT y.that AS record,
    p.player_name,
    p.player_id,
    y.event,
    y.season
   FROM (( SELECT x.that,
            x.player_id,
            x.event,
            x.season,
            rank() OVER (PARTITION BY x.event ORDER BY x.that DESC) AS this
           FROM ( SELECT count(1) AS that,
                    game_events.batter_id AS player_id,
                    game_events.event_type AS event,
                    game_events.season
                   FROM data.game_events
                  WHERE ((game_events.event_type <> ALL (ARRAY['UNKNOWN'::text, 'OUT'::text, 'GAME_OVER'::text])) AND (game_events.day >= 99))
                  GROUP BY game_events.event_type, game_events.batter_id, game_events.season
                UNION
                 SELECT sum(xe.hit) AS that,
                    ge.batter_id AS player_id,
                    'HIT'::text AS event,
                    ge.season
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day >= 99))
                  GROUP BY 'HIT'::text, ge.batter_id, ge.season
                UNION
                 SELECT sum(xe.total_bases) AS that,
                    ge.batter_id AS player_id,
                    'TOTAL_BASES'::text AS event,
                    ge.season
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day >= 99))
                  GROUP BY 'TOTAL_BASES'::text, ge.batter_id, ge.season
                UNION
                 SELECT sum(ge.runs_batted_in) AS that,
                    ge.batter_id AS player_id,
                    'RBIS'::text AS event,
                    ge.season
                   FROM data.game_events ge
                  WHERE ((ge.runs_batted_in > 0) AND (ge.day >= 99))
                  GROUP BY 'RBIS'::text, ge.batter_id, ge.season) x) y
     JOIN data.players_info_expanded_all p ON ((((y.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
  WHERE (y.this = 1)
  ORDER BY y.event, y.season, p.player_name;


--
-- Name: batting_records_player_playoffs_single_game; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_records_player_playoffs_single_game AS
 SELECT y.that AS record,
    p.player_name,
    p.player_id,
    y.game_id,
    y.event,
    y.season,
    y.day
   FROM (( SELECT x.that,
            x.player_id,
            x.game_id,
            x.event,
            x.season,
            x.day,
            rank() OVER (PARTITION BY x.event ORDER BY x.that DESC) AS this
           FROM ( SELECT count(1) AS that,
                    game_events.batter_id AS player_id,
                    game_events.game_id,
                    game_events.event_type AS event,
                    game_events.season,
                    game_events.day
                   FROM data.game_events
                  WHERE ((game_events.event_type <> ALL (ARRAY['HIT_BY_PITCH'::text, 'UNKNOWN'::text, 'OUT'::text, 'GAME_OVER'::text])) AND (game_events.day >= 99))
                  GROUP BY game_events.game_id, game_events.event_type, game_events.batter_id, game_events.season, game_events.day
                UNION
                 SELECT sum(xe.hit) AS that,
                    ge.batter_id AS player_id,
                    ge.game_id,
                    'HIT'::text AS event,
                    ge.season,
                    ge.day
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day >= 99))
                  GROUP BY ge.game_id, 'HIT'::text, ge.batter_id, ge.season, ge.day
                UNION
                 SELECT sum(xe.total_bases) AS that,
                    ge.batter_id AS player_id,
                    ge.game_id,
                    'TOTAL_BASES'::text AS event,
                    ge.season,
                    ge.day
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day >= 99))
                  GROUP BY ge.game_id, 'TOTAL_BASES'::text, ge.batter_id, ge.season, ge.day
                UNION
                 SELECT sum(ge.runs_batted_in) AS that,
                    ge.batter_id AS player_id,
                    ge.game_id,
                    'RBIS'::text AS event,
                    ge.season,
                    ge.day
                   FROM data.game_events ge
                  WHERE ((ge.runs_batted_in > 0) AND (ge.day >= 99))
                  GROUP BY ge.game_id, 'RBIS'::text, ge.batter_id, ge.season, ge.day) x) y
     JOIN data.players_info_expanded_all p ON ((((y.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
  WHERE (y.this = 1)
  ORDER BY y.event, y.season, y.day, p.player_name;


--
-- Name: batting_records_player_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_records_player_season AS
 SELECT y.that AS record,
    p.player_name,
    p.player_id,
    y.event,
    y.season
   FROM (( SELECT x.that,
            x.player_id,
            x.event,
            x.season,
            rank() OVER (PARTITION BY x.event ORDER BY x.that DESC) AS this
           FROM ( SELECT count(1) AS that,
                    game_events.batter_id AS player_id,
                    game_events.event_type AS event,
                    game_events.season
                   FROM data.game_events
                  WHERE ((game_events.event_type <> ALL (ARRAY['UNKNOWN'::text, 'OUT'::text, 'GAME_OVER'::text])) AND (game_events.day < 99))
                  GROUP BY game_events.event_type, game_events.batter_id, game_events.season
                UNION
                 SELECT sum(xe.hit) AS that,
                    ge.batter_id AS player_id,
                    'HIT'::text AS event,
                    ge.season
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day < 99))
                  GROUP BY 'HIT'::text, ge.batter_id, ge.season
                UNION
                 SELECT sum(xe.total_bases) AS that,
                    ge.batter_id AS player_id,
                    'TOTAL_BASES'::text AS event,
                    ge.season
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day < 99))
                  GROUP BY 'TOTAL_BASES'::text, ge.batter_id, ge.season
                UNION
                 SELECT sum(ge.runs_batted_in) AS that,
                    ge.batter_id AS player_id,
                    'RBIS'::text AS event,
                    ge.season
                   FROM data.game_events ge
                  WHERE ((ge.runs_batted_in > 0) AND (ge.day < 99))
                  GROUP BY 'RBIS'::text, ge.batter_id, ge.season) x) y
     JOIN data.players_info_expanded_all p ON ((((y.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
  WHERE (y.this = 1)
  ORDER BY y.event, y.season, p.player_name;


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
    runner_scored boolean DEFAULT false,
    runs_scored numeric
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
    home_score numeric,
    away_score numeric,
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
-- Name: batting_stats_all_events; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--

CREATE MATERIALIZED VIEW data.batting_stats_all_events AS
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
            WHEN (ge.event_type = 'QUADRUPLE'::text) THEN 1
            ELSE 0
        END AS quadruple,
        CASE
            WHEN (ge.event_type = ANY (ARRAY['HOME_RUN'::text, 'HOME_RUN_5'::text])) THEN 1
            ELSE 0
        END AS home_run,
        CASE
            WHEN (ge.event_type = ANY (ARRAY['WALK'::text, 'CHARM_WALK'::text])) THEN 1
            ELSE 0
        END AS walk,
        CASE
            WHEN (ge.event_type = ANY (ARRAY['STRIKEOUT'::text, 'CHARM_STRIKEOUT'::text])) THEN 1
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
  WHERE (xe.plate_appearance = 1)
  WITH NO DATA;


--
-- Name: batting_stats_player_single_game; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--

CREATE MATERIALIZED VIEW data.batting_stats_player_single_game AS
 SELECT p.player_name,
    a.player_id,
    t.team_id,
    t.nickname AS team,
    a.game_id,
    ga.season,
    ga.day,
    a.is_postseason,
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
    sum(a.quadruple) AS quadruples,
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
   FROM (((data.batting_stats_all_events a
     JOIN data.players_info_expanded_all p ON ((((a.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
     JOIN data.teams_info_expanded_all t ON ((((a.batter_team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
     JOIN data.games ga ON (((a.game_id)::text = (ga.game_id)::text)))
  GROUP BY a.player_id, a.is_postseason, p.player_name, a.game_id, t.nickname, t.team_id, ga.season, ga.day
  WITH NO DATA;


--
-- Name: batting_records_player_single_game; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_records_player_single_game AS
 SELECT a.player_id,
    a.player_name,
    a.game_id,
    a.season,
    a.day,
    a.team_id,
    a.team,
    c.value,
    c.stat
   FROM (( SELECT x.player_id,
            x.player_name,
            x.season,
            x.day,
            x.team_id,
            x.team,
            x.game_id,
            x.hits_risps,
            x.walks,
            x.singles,
            x.doubles,
            x.triples,
            x.quadruples,
            x.home_runs,
            x.total_bases,
            x.hits,
            x.runs_batted_in,
            x.sacrifices,
            x.strikeouts,
            rank() OVER (ORDER BY x.hits_risps DESC) AS hits_risp_rank,
            rank() OVER (ORDER BY x.walks DESC) AS bb_rank,
            rank() OVER (ORDER BY x.singles DESC) AS sng_rank,
            rank() OVER (ORDER BY x.doubles DESC) AS dbl_rank,
            rank() OVER (ORDER BY x.triples DESC) AS trp_rank,
            rank() OVER (ORDER BY x.home_runs DESC) AS hr_rank,
            rank() OVER (ORDER BY x.total_bases DESC) AS tb_rank,
            rank() OVER (ORDER BY x.quadruples DESC) AS qd_rank,
            rank() OVER (ORDER BY x.hits DESC) AS hits_rank,
            rank() OVER (ORDER BY x.runs_batted_in DESC) AS rbi_rank,
            rank() OVER (ORDER BY x.sacrifices DESC) AS sac_rank,
            rank() OVER (ORDER BY x.strikeouts DESC) AS k_rank
           FROM data.batting_stats_player_single_game x) a
     CROSS JOIN LATERAL ( VALUES (a.hits_risps,a.hits_risp_rank,'hits_risp'::text), (a.walks,a.bb_rank,'walks'::text), (a.singles,a.sng_rank,'singles'::text), (a.doubles,a.dbl_rank,'doubles'::text), (a.triples,a.trp_rank,'triples'::text), (a.quadruples,a.qd_rank,'quadruples'::text), (a.home_runs,a.hr_rank,'home_runs'::text), (a.total_bases,a.tb_rank,'total_bases'::text), (a.hits,a.hits_rank,'hits'::text), (a.runs_batted_in,a.rbi_rank,'runs_batted_in'::text), (a.sacrifices,a.sac_rank,'sacrifices'::text), (a.strikeouts,a.k_rank,'strikeouts'::text)) c(value, rank, stat))
  WHERE (c.rank = 1)
  ORDER BY c.stat, a.player_name;


--
-- Name: teams_current; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.teams_current AS
 SELECT t.team_id,
    t.location,
    t.nickname,
    t.url_slug,
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
-- Name: VIEW teams_current; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON VIEW data.teams_current IS 'TO BE DEPRECATED in favor of data.teams_info_expanded_all';


--
-- Name: batting_records_team_playoffs_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_records_team_playoffs_season AS
 SELECT y.that AS record,
    t.nickname AS team,
    t.team_id,
    y.event,
    y.season
   FROM (( SELECT x.that,
            x.team_id,
            x.event,
            x.season,
            rank() OVER (PARTITION BY x.event ORDER BY x.that DESC) AS this
           FROM ( SELECT count(1) AS that,
                    game_events.batter_team_id AS team_id,
                    game_events.event_type AS event,
                    game_events.season
                   FROM data.game_events
                  WHERE ((game_events.event_type <> ALL (ARRAY['UNKNOWN'::text, 'OUT'::text, 'GAME_OVER'::text])) AND (game_events.day >= 99))
                  GROUP BY game_events.event_type, game_events.batter_team_id, game_events.season
                UNION
                 SELECT sum(xe.hit) AS that,
                    ge.batter_team_id AS team_id,
                    'HIT'::text AS event,
                    ge.season
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day >= 99))
                  GROUP BY 'HIT'::text, ge.batter_team_id, ge.season
                UNION
                 SELECT sum(xe.total_bases) AS that,
                    ge.batter_team_id AS team_id,
                    'TOTAL_BASES'::text AS event,
                    ge.season
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day >= 99))
                  GROUP BY 'TOTAL_BASES'::text, ge.batter_team_id, ge.season
                UNION
                 SELECT sum(ge.runs_batted_in) AS that,
                    ge.batter_team_id AS team_id,
                    'RBIS'::text AS event,
                    ge.season
                   FROM data.game_events ge
                  WHERE ((ge.runs_batted_in > 0) AND (ge.day >= 99))
                  GROUP BY 'RBIS'::text, ge.batter_team_id, ge.season) x) y
     JOIN data.teams_current t ON (((y.team_id)::text = (t.team_id)::text)))
  WHERE (y.this = 1)
  ORDER BY y.event, y.season, t.nickname;


--
-- Name: batting_records_team_playoffs_single_game; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_records_team_playoffs_single_game AS
 SELECT y.that AS record,
    t.nickname AS team,
    t.team_id,
    y.game_id,
    y.event,
    y.season,
    y.day
   FROM (( SELECT x.that,
            x.team_id,
            x.game_id,
            x.event,
            x.season,
            x.day,
            rank() OVER (PARTITION BY x.event ORDER BY x.that DESC) AS this
           FROM ( SELECT count(1) AS that,
                    game_events.batter_team_id AS team_id,
                    game_events.game_id,
                    game_events.event_type AS event,
                    game_events.season,
                    game_events.day
                   FROM data.game_events
                  WHERE ((game_events.event_type <> ALL (ARRAY['UNKNOWN'::text, 'OUT'::text, 'GAME_OVER'::text])) AND (game_events.day >= 99))
                  GROUP BY game_events.game_id, game_events.event_type, game_events.batter_team_id, game_events.season, game_events.day
                UNION
                 SELECT sum(xe.hit) AS that,
                    ge.batter_team_id AS team_id,
                    ge.game_id,
                    'HIT'::text AS event,
                    ge.season,
                    ge.day
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day >= 99))
                  GROUP BY ge.game_id, 'HIT'::text, ge.batter_team_id, ge.season, ge.day
                UNION
                 SELECT sum(xe.total_bases) AS that,
                    ge.batter_team_id AS team_id,
                    ge.game_id,
                    'TOTAL_BASES'::text AS event,
                    ge.season,
                    ge.day
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day >= 99))
                  GROUP BY ge.game_id, 'TOTAL_BASES'::text, ge.batter_team_id, ge.season, ge.day
                UNION
                 SELECT sum(ge.runs_batted_in) AS that,
                    ge.batter_team_id AS team_id,
                    ge.game_id,
                    'RBIS'::text AS event,
                    ge.season,
                    ge.day
                   FROM data.game_events ge
                  WHERE ((ge.runs_batted_in >= 0) AND (ge.day < 99))
                  GROUP BY ge.game_id, 'RBIS'::text, ge.batter_team_id, ge.season, ge.day) x) y
     JOIN data.teams_current t ON (((y.team_id)::text = (t.team_id)::text)))
  WHERE (y.this = 1)
  ORDER BY y.event, y.season, y.day, t.nickname;


--
-- Name: batting_records_team_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_records_team_season AS
 SELECT y.that AS record,
    t.nickname AS team,
    (t.team_id)::character varying(36) AS team_id,
    y.event,
    y.season
   FROM (( SELECT x.that,
            x.team_id,
            x.event,
            x.season,
            rank() OVER (PARTITION BY x.event ORDER BY x.that DESC) AS this
           FROM ( SELECT count(1) AS that,
                    game_events.batter_team_id AS team_id,
                    game_events.event_type AS event,
                    game_events.season
                   FROM data.game_events
                  WHERE ((game_events.event_type <> ALL (ARRAY['UNKNOWN'::text, 'OUT'::text, 'GAME_OVER'::text])) AND (game_events.day < 99))
                  GROUP BY game_events.event_type, game_events.batter_team_id, game_events.season
                UNION
                 SELECT sum(xe.hit) AS that,
                    ge.batter_team_id AS team_id,
                    'HIT'::text AS event,
                    ge.season
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day < 99))
                  GROUP BY 'HIT'::text, ge.batter_team_id, ge.season
                UNION
                 SELECT sum(xe.total_bases) AS that,
                    ge.batter_team_id AS team_id,
                    'TOTAL_BASES'::text AS event,
                    ge.season
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day < 99))
                  GROUP BY 'TOTAL_BASES'::text, ge.batter_team_id, ge.season
                UNION
                 SELECT sum(ge.runs_batted_in) AS that,
                    ge.batter_team_id AS team_id,
                    'RBIS'::text AS event,
                    ge.season
                   FROM data.game_events ge
                  WHERE ((ge.runs_batted_in > 0) AND (ge.day < 99))
                  GROUP BY 'RBIS'::text, ge.batter_team_id, ge.season) x) y
     JOIN data.teams_info_expanded_all t ON ((((y.team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
  WHERE (y.this = 1)
  ORDER BY y.event, y.season, t.nickname;


--
-- Name: batting_records_team_single_game; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_records_team_single_game AS
 SELECT y.that AS record,
    t.nickname AS team,
    t.team_id,
    y.game_id,
    y.event,
    y.season,
    y.day
   FROM (( SELECT x.that,
            x.team_id,
            x.game_id,
            x.event,
            x.season,
            x.day,
            rank() OVER (PARTITION BY x.event ORDER BY x.that DESC) AS this
           FROM ( SELECT count(1) AS that,
                    game_events.batter_team_id AS team_id,
                    game_events.game_id,
                    game_events.event_type AS event,
                    game_events.season,
                    game_events.day
                   FROM data.game_events
                  WHERE ((game_events.event_type <> ALL (ARRAY['UNKNOWN'::text, 'OUT'::text, 'GAME_OVER'::text])) AND (game_events.day < 99))
                  GROUP BY game_events.game_id, game_events.event_type, game_events.batter_team_id, game_events.season, game_events.day
                UNION
                 SELECT sum(xe.hit) AS that,
                    ge.batter_team_id AS team_id,
                    ge.game_id,
                    'HIT'::text AS event,
                    ge.season,
                    ge.day
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day < 99))
                  GROUP BY ge.game_id, 'HIT'::text, ge.batter_team_id, ge.season, ge.day
                UNION
                 SELECT sum(xe.total_bases) AS that,
                    ge.batter_team_id AS team_id,
                    ge.game_id,
                    'TOTAL_BASES'::text AS event,
                    ge.season,
                    ge.day
                   FROM (data.game_events ge
                     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
                  WHERE ((xe.hit = 1) AND (ge.day < 99))
                  GROUP BY ge.game_id, 'TOTAL_BASES'::text, ge.batter_team_id, ge.season, ge.day
                UNION
                 SELECT sum(ge.runs_batted_in) AS that,
                    ge.batter_team_id AS team_id,
                    ge.game_id,
                    'RBIS'::text AS event,
                    ge.season,
                    ge.day
                   FROM data.game_events ge
                  WHERE ((ge.runs_batted_in > 0) AND (ge.day < 99))
                  GROUP BY ge.game_id, 'RBIS'::text, ge.batter_team_id, ge.season, ge.day) x) y
     JOIN data.teams_current t ON (((y.team_id)::text = (t.team_id)::text)))
  WHERE (y.this = 1)
  ORDER BY y.event, y.season, y.day, t.nickname;


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
     JOIN data.players_info_expanded_all p ON ((((a.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
  WHERE (NOT a.is_postseason)
  GROUP BY a.player_id, p.player_name;


--
-- Name: batting_stats_player_playoffs_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_player_playoffs_season AS
 SELECT p.player_name,
    a.player_id,
    (t.team_id)::character varying(36) AS team_id,
    t.nickname AS team,
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
     JOIN data.players_info_expanded_all p ON ((((a.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
     JOIN data.teams_info_expanded_all t ON ((((a.batter_team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
  WHERE a.is_postseason
  GROUP BY a.player_id, p.player_name, a.season, t.nickname, t.team_id;


--
-- Name: batting_stats_player_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_player_season AS
 SELECT p.player_name,
    a.player_id,
    (t.team_id)::character varying(36) AS team_id,
    t.nickname AS team,
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
     JOIN data.players_info_expanded_all p ON ((((a.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
     JOIN data.teams_info_expanded_all t ON ((((a.batter_team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
  WHERE (NOT a.is_postseason)
  GROUP BY a.player_id, p.player_name, a.season, t.nickname, t.team_id;


--
-- Name: charm_counts; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.charm_counts AS
 SELECT count(1) AS count,
    p.player_name,
    b.event_type,
    b.season
   FROM (( SELECT DISTINCT ge.game_id,
            ge.event_index,
            ge.event_type,
            ge.event_text,
            ge.day,
            ge.season,
                CASE
                    WHEN (ge.event_type = ANY (ARRAY['OUT'::text, 'STRIKEOUT'::text, 'CHARM_STRIKEOUT'::text])) THEN ge.pitcher_id
                    ELSE ge.batter_id
                END AS charmer
           FROM data.game_events ge
          WHERE ("position"(lower((ge.event_text)::text), 'charm'::text) > 0)) b
     JOIN data.players_info_expanded_all p ON ((((b.charmer)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
  GROUP BY p.player_name, b.event_type, b.season
  ORDER BY (count(1)) DESC, p.player_name, b.season;


--
-- Name: chronicler_hash_game_event; Type: TABLE; Schema: data; Owner: -
--

CREATE TABLE data.chronicler_hash_game_event (
    chronicler_hash_game_event_id integer NOT NULL,
    update_hash uuid,
    game_event_id integer
);


--
-- Name: chronicler_hash_game_event_chronicler_hash_game_event_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.chronicler_hash_game_event_chronicler_hash_game_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: chronicler_hash_game_event_chronicler_hash_game_event_id_seq; Type: SEQUENCE OWNED BY; Schema: data; Owner: -
--

ALTER SEQUENCE data.chronicler_hash_game_event_chronicler_hash_game_event_id_seq OWNED BY data.chronicler_hash_game_event.chronicler_hash_game_event_id;


--
-- Name: chronicler_meta; Type: TABLE; Schema: data; Owner: -
--

CREATE TABLE data.chronicler_meta (
    id smallint NOT NULL,
    season numeric NOT NULL,
    day numeric NOT NULL,
    game_timestamp timestamp without time zone,
    team_timestamp timestamp without time zone,
    player_timestamp timestamp with time zone
);


--
-- Name: fielder_stats_all_events; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--

CREATE MATERIALIZED VIEW data.fielder_stats_all_events AS
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
             JOIN data.players_info_expanded_all p ON ((((p.player_id)::text = (ge.batter_id)::text) AND (p.valid_until IS NULL))))
             JOIN data.games ga ON (((ge.game_id)::text = (ga.game_id)::text)))
          WHERE ((ge.batted_ball_type = ANY (ARRAY['FLY'::text, 'GROUNDER'::text])) AND (ge.event_type = 'OUT'::text))) d
     JOIN data.players_info_expanded_all pd ON (((d.fielder = (pd.player_name)::text) AND (pd.valid_until IS NULL))))
  WITH NO DATA;


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
-- Name: pitching_stats_all_appearances; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--

CREATE MATERIALIZED VIEW data.pitching_stats_all_appearances AS
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
            WHEN (ge.event_type = ANY (ARRAY['STRIKEOUT'::text, 'CHARM_STRIKEOUT'::text])) THEN 1
            ELSE 0
        END) AS strikeouts,
    sum(
        CASE
            WHEN (ge.event_type = ANY (ARRAY['WALK'::text, 'CHARM_WALK'::text])) THEN 1
            ELSE 0
        END) AS walks,
    sum(
        CASE
            WHEN (ge.event_type = ANY (ARRAY['HOME_RUN'::text, 'HOME_RUN_5'::text])) THEN 1
            ELSE 0
        END) AS hrs_allowed,
    sum(
        CASE
            WHEN (ge.event_type = 'HIT_BY_PITCH'::text) THEN 1
            ELSE 0
        END) AS hit_by_pitches,
    sum(xe.hit) AS hits_allowed,
    sum(xe.plate_appearance) AS batters_faced,
    ga.weather AS weather_id,
    ga.is_postseason
   FROM ((data.game_events ge
     JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
     JOIN data.games ga ON (((ge.game_id)::text = (ga.game_id)::text)))
  GROUP BY ge.season, ge.day, ge.game_id, ge.pitcher_id, ga.winning_pitcher_id, ga.losing_pitcher_id, ge.pitcher_team_id, ge.top_of_inning, ga.weather, ga.is_postseason
  WITH NO DATA;


--
-- Name: pitching_records_player_single_game; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.pitching_records_player_single_game AS
 SELECT a.record,
    p.player_name,
    a.player_id,
    a.game_id,
    a.event,
    a.season,
    a.day
   FROM (( SELECT rank() OVER (ORDER BY pitching_stats_all_appearances.strikeouts DESC) AS rank,
            'strikeouts'::text AS event,
            pitching_stats_all_appearances.strikeouts AS record,
            pitching_stats_all_appearances.player_id,
            pitching_stats_all_appearances.game_id,
            pitching_stats_all_appearances.season,
            pitching_stats_all_appearances.day
           FROM data.pitching_stats_all_appearances
        UNION
         SELECT rank() OVER (ORDER BY (round(((pitching_stats_all_appearances.strikeouts)::numeric / ((pitching_stats_all_appearances.outs_recorded)::numeric / (27)::numeric)), 2)) DESC) AS rank,
            'strikeouts per 9 '::text AS event,
            round(((pitching_stats_all_appearances.strikeouts)::numeric / ((pitching_stats_all_appearances.outs_recorded)::numeric / (27)::numeric)), 2) AS record,
            pitching_stats_all_appearances.player_id,
            pitching_stats_all_appearances.game_id,
            pitching_stats_all_appearances.season,
            pitching_stats_all_appearances.day
           FROM data.pitching_stats_all_appearances
          WHERE (pitching_stats_all_appearances.outs_recorded > 23)
        UNION
         SELECT rank() OVER (ORDER BY pitching_stats_all_appearances.outs_recorded DESC) AS rank,
            'outs_recorded'::text AS event,
            pitching_stats_all_appearances.outs_recorded AS record,
            pitching_stats_all_appearances.player_id,
            pitching_stats_all_appearances.game_id,
            pitching_stats_all_appearances.season,
            pitching_stats_all_appearances.day
           FROM data.pitching_stats_all_appearances
        UNION
         SELECT rank() OVER (ORDER BY pitching_stats_all_appearances.pitch_count DESC) AS rank,
            'pitch_count'::text AS event,
            pitching_stats_all_appearances.pitch_count AS record,
            pitching_stats_all_appearances.player_id,
            pitching_stats_all_appearances.game_id,
            pitching_stats_all_appearances.season,
            pitching_stats_all_appearances.day
           FROM data.pitching_stats_all_appearances
          WHERE (COALESCE(pitching_stats_all_appearances.pitch_count, (0)::bigint) > 0)
        UNION
         SELECT rank() OVER (ORDER BY pitching_stats_all_appearances.runs_allowed DESC) AS rank,
            'runs_allowed'::text AS event,
            pitching_stats_all_appearances.runs_allowed AS record,
            pitching_stats_all_appearances.player_id,
            pitching_stats_all_appearances.game_id,
            pitching_stats_all_appearances.season,
            pitching_stats_all_appearances.day
           FROM data.pitching_stats_all_appearances
          WHERE (COALESCE(pitching_stats_all_appearances.runs_allowed, (0)::bigint) > 0)
        UNION
         SELECT rank() OVER (ORDER BY pitching_stats_all_appearances.walks DESC) AS rank,
            'walks'::text AS event,
            pitching_stats_all_appearances.walks AS record,
            pitching_stats_all_appearances.player_id,
            pitching_stats_all_appearances.game_id,
            pitching_stats_all_appearances.season,
            pitching_stats_all_appearances.day
           FROM data.pitching_stats_all_appearances
          WHERE (COALESCE(pitching_stats_all_appearances.walks, (0)::bigint) > 0)
        UNION
         SELECT rank() OVER (ORDER BY pitching_stats_all_appearances.hrs_allowed DESC) AS rank,
            'hrs_allowed'::text AS event,
            pitching_stats_all_appearances.hrs_allowed AS record,
            pitching_stats_all_appearances.player_id,
            pitching_stats_all_appearances.game_id,
            pitching_stats_all_appearances.season,
            pitching_stats_all_appearances.day
           FROM data.pitching_stats_all_appearances
          WHERE (COALESCE(pitching_stats_all_appearances.hrs_allowed, (0)::bigint) > 0)
        UNION
         SELECT rank() OVER (ORDER BY pitching_stats_all_appearances.runs_allowed DESC) AS rank,
            'runs_allowed'::text AS event,
            pitching_stats_all_appearances.runs_allowed AS record,
            pitching_stats_all_appearances.player_id,
            pitching_stats_all_appearances.game_id,
            pitching_stats_all_appearances.season,
            pitching_stats_all_appearances.day
           FROM data.pitching_stats_all_appearances
          WHERE (COALESCE(pitching_stats_all_appearances.runs_allowed, (0)::bigint) > 0)
        UNION
         SELECT rank() OVER (ORDER BY pitching_stats_all_appearances.hits_allowed DESC) AS rank,
            'hits_allowed'::text AS event,
            pitching_stats_all_appearances.hits_allowed AS record,
            pitching_stats_all_appearances.player_id,
            pitching_stats_all_appearances.game_id,
            pitching_stats_all_appearances.season,
            pitching_stats_all_appearances.day
           FROM data.pitching_stats_all_appearances
          WHERE (COALESCE(pitching_stats_all_appearances.hits_allowed, (0)::bigint) > 0)) a
     JOIN data.players_info_expanded_all p ON ((((a.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
  WHERE (a.rank = 1)
  ORDER BY a.event, a.season, a.day, a.game_id;


--
-- Name: pitching_stats_player_lifetime; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.pitching_stats_player_lifetime AS
 SELECT a.player_name,
    p.player_id,
    array_agg(p.team_id) AS team_ids,
    count(1) AS games,
    sum(p.win) AS wins,
    sum(p.loss) AS losses,
    sum(p.pitch_count) AS pitch_count,
    sum(p.outs_recorded) AS outs_recorded,
    round((floor((sum(p.outs_recorded) / (3)::numeric)) + (mod(sum(p.outs_recorded), (3)::numeric) / (10)::numeric)), 1) AS innings,
    sum(p.runs_allowed) AS runs_allowed,
    sum(
        CASE
            WHEN (p.runs_allowed = 0) THEN 1
            ELSE 0
        END) AS shutouts,
    sum(
        CASE
            WHEN ((p.runs_allowed < 4) AND (p.outs_recorded > 18)) THEN 1
            ELSE 0
        END) AS quality_starts,
    sum(p.strikeouts) AS strikeouts,
    sum(p.walks) AS walks,
    sum(p.hrs_allowed) AS hrs_allowed,
    sum(p.hits_allowed) AS hits_allowed,
    sum(p.hit_by_pitches) AS hpbs,
    round((((9)::numeric * sum(p.runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS era,
    round((((9)::numeric * sum(p.walks)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS bb_per_9,
    round((((9)::numeric * sum(p.hits_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS hits_per_9,
    round((((9)::numeric * sum(p.strikeouts)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS k_per_9,
    round((((9)::numeric * sum(p.hrs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS hr_per_9
   FROM (data.pitching_stats_all_appearances p
     JOIN data.players_info_expanded_all a ON ((((a.player_id)::text = (p.player_id)::text) AND (a.valid_until IS NULL))))
  WHERE (NOT p.is_postseason)
  GROUP BY a.player_name, p.player_id;


--
-- Name: pitching_stats_player_season; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.pitching_stats_player_season AS
 SELECT a.player_name,
    p.player_id,
    p.season,
    array_agg(p.team_id) AS team_ids,
    count(1) AS games,
    sum(p.win) AS wins,
    sum(p.loss) AS losses,
    sum(p.pitch_count) AS pitch_count,
    sum(p.batters_faced) AS batters_faced,
    sum(p.outs_recorded) AS outs_recorded,
    round((floor((sum(p.outs_recorded) / (3)::numeric)) + (mod(sum(p.outs_recorded), (3)::numeric) / (10)::numeric)), 1) AS innings,
    sum(p.runs_allowed) AS runs_allowed,
    sum(
        CASE
            WHEN (p.runs_allowed = 0) THEN 1
            ELSE 0
        END) AS shutouts,
    sum(
        CASE
            WHEN ((p.runs_allowed < 4) AND (p.outs_recorded > 18)) THEN 1
            ELSE 0
        END) AS quality_starts,
    sum(p.strikeouts) AS strikeouts,
    sum(p.walks) AS walks,
    sum(p.hrs_allowed) AS hrs_allowed,
    sum(p.hits_allowed) AS hits_allowed,
    sum(p.hit_by_pitches) AS hbps,
    round((((9)::numeric * sum(p.runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS era,
    round((((9)::numeric * sum(p.walks)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS bb_per_9,
    round((((9)::numeric * sum(p.hits_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS hits_per_9,
    round((((9)::numeric * sum(p.strikeouts)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS k_per_9,
    round((((9)::numeric * sum(p.hrs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS hr_per_9
   FROM (data.pitching_stats_all_appearances p
     JOIN data.players_info_expanded_all a ON ((((a.player_id)::text = (p.player_id)::text) AND (a.valid_until IS NULL))))
  WHERE (NOT p.is_postseason)
  GROUP BY a.player_name, p.player_id, p.season;


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
-- Name: player_url_slugs; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.player_url_slugs (
    player_url_slug_id integer NOT NULL,
    player_id character varying,
    url_slug character varying,
    player_name character varying
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
    ( SELECT array_agg(DISTINCT xs.url_slug) AS array_agg
           FROM taxa.player_url_slugs xs
          WHERE (((xs.player_id)::text = (p.player_id)::text) AND ((xs.url_slug)::text <> (p.url_slug)::text))) AS previous_url_slugs,
    p.deceased
   FROM (((((data.players p
     LEFT JOIN taxa.blood xb ON ((p.blood = xb.blood_id)))
     LEFT JOIN taxa.coffee xc ON ((p.coffee = xc.coffee_id)))
     LEFT JOIN data.team_roster tr ON ((((p.player_id)::text = (tr.player_id)::text) AND (tr.valid_until IS NULL))))
     LEFT JOIN data.teams_current t ON (((tr.team_id)::text = (t.team_id)::text)))
     LEFT JOIN taxa.position_types xp ON ((tr.position_type_id = (xp.position_type_id)::numeric)))
  WHERE ((p.valid_until IS NULL) AND (tr.position_type_id < (2)::numeric) AND ((p.player_id)::text <> 'bc4187fa-459a-4c06-bbf2-4e0e013d27ce'::text));


--
-- Name: VIEW players_current; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON VIEW data.players_current IS 'TO BE DEPRECATED in favor of data.players_info_expanded_all';


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
    ( SELECT array_agg(DISTINCT xs.url_slug) AS array_agg
           FROM taxa.player_url_slugs xs
          WHERE (((xs.player_id)::text = (p.player_id)::text) AND ((xs.url_slug)::text <> (p.url_slug)::text))) AS previous_url_slugs,
    p.deceased
   FROM (((((data.players p
     LEFT JOIN taxa.blood xb ON ((p.blood = xb.blood_id)))
     LEFT JOIN taxa.coffee xc ON ((p.coffee = xc.coffee_id)))
     LEFT JOIN data.team_roster tr ON ((((p.player_id)::text = (tr.player_id)::text) AND (tr.valid_until IS NULL))))
     LEFT JOIN data.teams_current t ON (((tr.team_id)::text = (t.team_id)::text)))
     LEFT JOIN taxa.position_types xp ON ((tr.position_type_id = (xp.position_type_id)::numeric)))
  WHERE (((p.valid_until IS NULL) OR (p.deceased = true)) AND ((p.player_id)::text <> 'bc4187fa-459a-4c06-bbf2-4e0e013d27ce'::text));


--
-- Name: VIEW players_extended_current; Type: COMMENT; Schema: data; Owner: -
--

COMMENT ON VIEW data.players_extended_current IS 'TO BE DEPRECATED in favor of data.players_info_expanded_all';


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
-- Name: running_stats_all_events; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--

CREATE MATERIALIZED VIEW data.running_stats_all_events AS
 SELECT geb.runner_id AS player_id,
    ge.batter_team_id AS team_id,
    geb.responsible_pitcher_id,
    ge.pitcher_team_id AS responsible_team_id,
    ge.season,
    ge.day,
    ge.game_id,
    (geb.was_base_stolen)::integer AS was_base_stolen,
    (geb.was_caught_stealing)::integer AS was_caught_stealing,
    geb.runs_scored AS runner_scored,
    geb.base_before_play,
    geb.base_after_play,
    ga.weather AS weather_id
   FROM ((data.game_event_base_runners geb
     JOIN data.game_events ge ON ((geb.game_event_id = ge.id)))
     JOIN data.games ga ON (((ge.game_id)::text = (ga.game_id)::text)))
  WITH NO DATA;


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
     JOIN data.players_info_expanded_all p ON ((((rs.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
  WHERE (rs.day < 99)
  GROUP BY rs.player_id, p.player_name;


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
     JOIN data.players_info_expanded_all p ON ((((rs.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
  WHERE (rs.day < 99)
  GROUP BY rs.player_id, rs.season, p.player_name;


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
    time_map_id integer NOT NULL,
    phase_id integer
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
-- Name: card; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.card (
    card_id integer NOT NULL,
    card character varying,
    card_desc character varying
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
-- Name: modifications; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.modifications (
    modification_db_id integer NOT NULL,
    modification character varying,
    color character varying,
    text_color character varying,
    background character varying,
    title character varying,
    description character varying,
    modification_entity character varying
);


--
-- Name: modifications_modification_db_id_seq; Type: SEQUENCE; Schema: taxa; Owner: -
--

CREATE SEQUENCE taxa.modifications_modification_db_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: modifications_modification_db_id_seq; Type: SEQUENCE OWNED BY; Schema: taxa; Owner: -
--

ALTER SEQUENCE taxa.modifications_modification_db_id_seq OWNED BY taxa.modifications.modification_db_id;


--
-- Name: phases; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.phases (
    phase_id integer,
    phase_type character varying,
    phase_type_id integer
);


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
-- Name: team_abbreviations_team_abbreviation_id_seq; Type: SEQUENCE; Schema: taxa; Owner: -
--

CREATE SEQUENCE taxa.team_abbreviations_team_abbreviation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: team_abbreviations_team_abbreviation_id_seq; Type: SEQUENCE OWNED BY; Schema: taxa; Owner: -
--

ALTER SEQUENCE taxa.team_abbreviations_team_abbreviation_id_seq OWNED BY taxa.team_abbreviations.team_abbreviation_id;


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
-- Name: applied_patches patch_id; Type: DEFAULT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.applied_patches ALTER COLUMN patch_id SET DEFAULT nextval('data.applied_patches_patch_id_seq'::regclass);


--
-- Name: chronicler_hash_game_event chronicler_hash_game_event_id; Type: DEFAULT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.chronicler_hash_game_event ALTER COLUMN chronicler_hash_game_event_id SET DEFAULT nextval('data.chronicler_hash_game_event_chronicler_hash_game_event_id_seq'::regclass);


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
-- Name: modifications modification_db_id; Type: DEFAULT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.modifications ALTER COLUMN modification_db_id SET DEFAULT nextval('taxa.modifications_modification_db_id_seq'::regclass);


--
-- Name: player_url_slugs player_url_slug_id; Type: DEFAULT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.player_url_slugs ALTER COLUMN player_url_slug_id SET DEFAULT nextval('taxa.player_url_slugs_player_url_slug_id_seq'::regclass);


--
-- Name: team_abbreviations team_abbreviation_id; Type: DEFAULT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.team_abbreviations ALTER COLUMN team_abbreviation_id SET DEFAULT nextval('taxa.team_abbreviations_team_abbreviation_id_seq'::regclass);


--
-- Name: team_divine_favor team_divine_favor_id; Type: DEFAULT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.team_divine_favor ALTER COLUMN team_divine_favor_id SET DEFAULT nextval('taxa.team_divine_favor_team_divine_favor_id_seq'::regclass);


--
-- Name: vibe_to_arrows vibe_to_arrow_id; Type: DEFAULT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.vibe_to_arrows ALTER COLUMN vibe_to_arrow_id SET DEFAULT nextval('taxa.vibe_to_arrows_vibe_to_arrow_id_seq'::regclass);


--
-- Data for Name: applied_patches; Type: TABLE DATA; Schema: data; Owner: -
--

COPY data.applied_patches (patch_id, patch_hash) FROM stdin;
1	1d044f78-667b-a9a6-7461-751ed5bad476
2	411a7bff-8cf9-0ee9-ab20-1ab3628c5c0d
\.


--
-- Data for Name: chronicler_hash_game_event; Type: TABLE DATA; Schema: data; Owner: -
--

COPY data.chronicler_hash_game_event (chronicler_hash_game_event_id, update_hash, game_event_id) FROM stdin;
\.


--
-- Data for Name: chronicler_meta; Type: TABLE DATA; Schema: data; Owner: -
--

COPY data.chronicler_meta (id, season, day, game_timestamp, team_timestamp, player_timestamp) FROM stdin;
0	0	0	\N	\N	\N
\.


--
-- Data for Name: game_event_base_runners; Type: TABLE DATA; Schema: data; Owner: -
--

COPY data.game_event_base_runners (id, game_event_id, runner_id, responsible_pitcher_id, base_before_play, base_after_play, was_base_stolen, was_caught_stealing, was_picked_off, runner_scored, runs_scored) FROM stdin;
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

COPY data.teams (id, team_id, location, nickname, full_name, valid_from, valid_until, hash, url_slug, card) FROM stdin;
\.


--
-- Data for Name: time_map; Type: TABLE DATA; Schema: data; Owner: -
--

COPY data.time_map (season, day, first_time, time_map_id, phase_id) FROM stdin;
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
-- Data for Name: card; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.card (card_id, card, card_desc) FROM stdin;
11	XII The Hanged Man	\N
4	V The Pope	\N
14	XV The Devil	\N
6	VII The Chariot	\N
17	XVIII The Moon	\N
9	X The Wheel of Fortune	\N
13	XIIII Temperance	\N
7	VIII Justice	\N
3	IIII The Emperor	\N
1	II The High Priestess	\N
16	XVII The Star	\N
19	XX Judgment	\N
2	III The Empress	\N
15	XVI The Tower	\N
12	XIII	\N
0	I The Magician	\N
5	VI The Lover 	\N
8	VIIII The Hermit	\N
18	XVIIII The Sun	\N
10	XI Strength	\N
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
8	Heavy Foam
9	Latte
10	Decaf
11	Milk Substitute
12	Plenty of Sugar
13	Anything
7	Espresso
\.


--
-- Data for Name: division_teams; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.division_teams (division_teams_id, division_id, team_id, valid_from, valid_until) FROM stdin;
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
41	d4cc18de-a136-4271-84f1-32516be91a80	c73b705c-40ad-4633-a6ed-d357ee2e2bcf	2020-10-18 19:00:09.443928	\N
43	d4cc18de-a136-4271-84f1-32516be91a80	747b8e4a-7e50-4638-a973-ea7950a3e739	2020-10-19 15:00:01.023128	\N
44	456089f0-f338-4620-a014-9540868789c9	23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7	2020-10-19 15:00:01.023128	\N
45	d4cc18de-a136-4271-84f1-32516be91a80	57ec08cc-0411-4643-b304-0e80dbc15ac7	2020-10-19 15:00:01.023128	\N
46	456089f0-f338-4620-a014-9540868789c9	b72f3061-f573-40d7-832a-5ad475bd7909	2020-10-19 15:00:01.023128	\N
47	456089f0-f338-4620-a014-9540868789c9	36569151-a2fb-43c1-9df7-2df512424c82	2020-10-19 15:00:01.023128	\N
42	fadc9684-45b3-47a6-b647-3be3f0735a84	eb67ae5e-c4bf-46ca-bbbc-425cd34182ff	2020-10-19 15:00:01.023128	\N
48	fadc9684-45b3-47a6-b647-3be3f0735a84	adc5b394-8f76-416d-9ce9-813706877b84	2020-10-19 15:00:01.023128	\N
49	\N	8d87c468-699a-47a8-b40d-cfb73a5660ad	2020-10-18 19:00:09.443928	\N
2	fadc9684-45b3-47a6-b647-3be3f0735a84	979aee4a-6d80-4863-bf1c-ee1a78e06024	2020-09-06 15:26:39.925823	\N
4	fadc9684-45b3-47a6-b647-3be3f0735a84	bfd38797-8404-4b38-8b82-341da28b1f83	2020-09-06 15:26:39.925823	\N
5	fadc9684-45b3-47a6-b647-3be3f0735a84	7966eb04-efcc-499b-8f03-d13916330531	2020-09-06 15:26:39.925823	\N
29	d4cc18de-a136-4271-84f1-32516be91a80	ca3f1c8c-c025-4d8e-8eef-5be6accbeb16	2020-09-06 15:26:39.925823	\N
30	d4cc18de-a136-4271-84f1-32516be91a80	a37f9158-7f82-46bc-908c-c9e2dda7c33b	2020-09-06 15:26:39.925823	\N
31	98c92da4-0ea7-43be-bd75-c6150e184326	9debc64f-74b7-4ae1-a4d6-fce0144b6ea5	2020-09-06 15:26:39.925823	\N
32	98c92da4-0ea7-43be-bd75-c6150e184326	3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e	2020-09-06 15:26:39.925823	\N
33	98c92da4-0ea7-43be-bd75-c6150e184326	b63be8c2-576a-4d6e-8daf-814f8bcea96f	2020-09-06 15:26:39.925823	\N
34	98c92da4-0ea7-43be-bd75-c6150e184326	f02aeae2-5e6a-4098-9842-02d2273f25c7	2020-09-06 15:26:39.925823	\N
35	98c92da4-0ea7-43be-bd75-c6150e184326	878c1bf6-0d21-4659-bfee-916c8314d69c	2020-09-06 15:26:39.925823	\N
38	456089f0-f338-4620-a014-9540868789c9	105bc3ff-1320-4e37-8ef0-8d595cb95dd0	2020-09-06 15:26:39.925823	\N
39	456089f0-f338-4620-a014-9540868789c9	b024e975-1c4a-4575-8936-a3754a08806a	2020-09-06 15:26:39.925823	\N
27	d4cc18de-a136-4271-84f1-32516be91a80	8d87c468-699a-47a8-b40d-cfb73a5660ad	2020-09-06 15:26:39.925823	2020-10-18 19:00:09.443928
1	fadc9684-45b3-47a6-b647-3be3f0735a84	57ec08cc-0411-4643-b304-0e80dbc15ac7	2020-09-06 15:26:39.925823	2020-10-19 15:00:01.023128
3	fadc9684-45b3-47a6-b647-3be3f0735a84	23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7	2020-09-06 15:26:39.925823	2020-10-19 15:00:01.023128
26	d4cc18de-a136-4271-84f1-32516be91a80	b72f3061-f573-40d7-832a-5ad475bd7909	2020-09-06 15:26:39.925823	2020-10-19 15:00:01.023128
28	d4cc18de-a136-4271-84f1-32516be91a80	36569151-a2fb-43c1-9df7-2df512424c82	2020-09-06 15:26:39.925823	2020-10-19 15:00:01.023128
36	456089f0-f338-4620-a014-9540868789c9	747b8e4a-7e50-4638-a973-ea7950a3e739	2020-09-06 15:26:39.925823	2020-10-19 15:00:01.023128
37	456089f0-f338-4620-a014-9540868789c9	eb67ae5e-c4bf-46ca-bbbc-425cd34182ff	2020-09-06 15:26:39.925823	2020-10-19 15:00:01.023128
40	456089f0-f338-4620-a014-9540868789c9	adc5b394-8f76-416d-9ce9-813706877b84	2020-09-06 15:26:39.925823	2020-10-19 15:00:01.023128
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
26	SACRIFICE	1	0	0	0	1
27	QUADRUPLE	1	1	1	4	0
4	FIELDERS_CHOICE	1	1	0	0	1
126	GAME_OVER	0	0	0	0	0
12	UNKNOWN_OUT	0	0	0	0	1
178	UNKNOWN	0	0	0	0	0
143	DOUBLE WALK	1	0	0	2	0
13	HIT_BY_PITCH	1	0	0	1	0
197	TRIPLE_WALK	1	0	0	3	0
11	WALK	1	0	0	1	0
217	WILD_PITCH	0	0	0	0	0
28	HOME_RUN_5	1	1	1	5	0
238	CHARM_STRIKEOUT	1	1	0	0	1
260	CHARM_WALK	1	0	0	1	0
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
-- Data for Name: modifications; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.modifications (modification_db_id, modification, color, text_color, background, title, description, modification_entity) FROM stdin;
2	SHAME_PIT	#b96dbd	#b96dbd	#3d1539	Targeted Shame	Teams with Targeted Shame will start with negative runs the game after being shamed.	team
3	HOME_FIELD	#f9ff54	#f9ff54	#4f9c30	Home Field Advantage	Teams with Home Field Advantage will start each home game with one run.	team
10	BLOOD_THIEF	#ff1f3c	#ff1f3c	#52050f	Blood Thief	In the Blood Bath, this team will steal Stars from a division opponent that finished ahead of them in the standings.	team
11	BLOOD_PITY	#ff1f3c	#ff1f3c	#52050f	Blood Pity	In the Blood Bath, this team must give Stars to the team that finished last in their division.	team
12	BLOOD_WINNER	#ff1f3c	#ff1f3c	#52050f	Blood Winner	In the Blood Bath, this team must give Stars to the team that finished first in their division.	team
14	BLOOD_LAW	#ff1f3c	#ff1f3c	#52050f	Blood Law	In the Blood Bath, this team will gain or lose Stars depending on how low or high they finish in their division.	team
15	BLOOD_CHAOS	#ff1f3c	#ff1f3c	#52050f	Blood Chaos	In the Blood Bath, each player on this team will gain or lose a random amount of Stars.	team
19	PARTY_TIME	#ff66f9	#ff66f9	#fff947	Party Time	This team is mathematically eliminated from the Postseason, and will occasionally receive permanent stats boost in their games.	team
20	LIFE_OF_PARTY	#fff45e	#fff45e	#9141ba	Life of the Party	This team gets 10% more from their Party Time stat boosts.	team
31	EXTRA_BASE	#d9d9d9	#d9d9d9	#4a001a	Fifth Base	This team must run five bases instead of four in order to score.	team
32	BLESS_OFF	#e0cafa	#e0cafa	#7d58a8	Bless Off	This team cannot win any Blessings in the upcoming Election.	team
35	ELECTRIC	#fff199	#fff199	#04144a	Electric	Electric teams have a chance of zapping away Strikes.	team
40	GROWTH	#52a17b	#52a17b	#13422b	Growth	Growth teams will play better as the season goes on, up to a 5% global boost by season's end.	team
41	BASE_INSTINCTS	#dedede	#dedede	#329c98	Base Instincts	Batters with Base Instincts will have a chance of heading past first base when getting walked.	team
4	FIREPROOF	#a5c5f0	#a5c5f0	#4c77b0	Fireproof	A Fireproof player can not be incinerated.	player
5	ALTERNATE	#fffd85	#fffd85	#404040	Alternate	This player is an Alternate...	player
6	SOUNDPROOF	#c92080	#c92080	#000000	Soundproof	A Soundproof player can not be caught in Feedback's reality flickers.	player
7	SHELLED	#fffd85	#fffd85	#404040	Shelled	A Shelled player is trapped in a big Peanut is unable to bat or pitch.	player
8	REVERBERATING	#61b3ff	#61b3ff	#756773	Reverberating	A Reverberating player has a small chance of batting again after each of their At-Bats end.	player
13	BLOOD_FAITH	#ff1f3c	#ff1f3c	#52050f	Blood Faith	In the Blood Bath, this player will receive a small boost to a random stat.	player
17	INWARD	#d3d8de	#d3d8de	#38080d	Inward	This player has turned Inward.	player
18	MARKED	#eaabff	#eaabff	#1b1c80	Unstable	Unstable players have a much higher chance of being incinerated in a Solar Eclipse.	player
21	DEBT_ZERO	#ff1f3c	#ff1f3c	#1b1c80	Debt	This player must fulfill a debt.	player
22	DEBT	#ff1f3c	#ff1f3c	#363738	Refinanced Debt	This player must fulfill a debt.	player
23	DEBT_TWO	#ff1f3c	#ff1f3c	#612273	Consolidated Debt	This player must fulfill a debt.	player
24	SPICY	#9e0022	#9e0022	#d15700	Spicy	Spicy batters will be Red Hot when they get three consecutive hits.	player
25	HEATING_UP	#9e0022	#9e0022	#d15700	Heating Up...	This batter needs one more consecutive hit to enter Fire mode. This mod will disappear if the batter gets out.	player
26	ON_FIRE	#fff982	#fff982	#e32600	Red Hot!	Red Hot! This player's batting is greatly boosted. This mod will disappear if the batter gets out.	player
27	HONEY_ROASTED	#ffda75	#ffda75	#b5831f	Honey Roasted	This player has been Honey-Roasted.	player
28	FIRST_BORN	#fffea8	#fffea8	#517063	First Born	This player was the first born from the New Field of Eggs.	player
29	SUPERALLERGIC	#bd224e	#bd224e	#45003d	Superallergic	This player is Superallergic	player
30	SUPERYUMMY	#ffdb59	#ffdb59	#c96faa	Superyummy	This player seriously loves peanuts	player
33	NON_IDOLIZED	#fffaba	#fffaba	#540e43	Idol Immune	Idol Immune players cannot be Idolized by Fans.	player
34	GRAVITY	#759bc9	#759bc9	#4c5052	Gravity	This player cannot be affected by Reverb.	player
36	DOUBLE_PAYOUTS	#fffaba	#fffaba	#786600	Super Idol	This player will earn Fans double the rewards from all Idol Pendants.	player
37	FIRE_PROTECTOR	#c4ff85	#c4ff85	#1f474f	Fire Protector	This player will protect their team from incinerations.	player
38	RECEIVER	#ff007b	#ff007b	#383838	Receiver	This player is a Receiver.	player
39	FLICKERING	#ff007b	#ff007b	#383838	Flickering	Flickering players have a much higher chance of being Feedbacked to their opponent.	player
42	STABLE	#91b5a3	#91b5a3	#335980	Stable	Stable players cannot be made Unstable.	player
45	SQUIDDISH	#5988ff	#5988ff	#163073	Squiddish	When a Squiddish player is incinerated, they'll be replaced by a random Hall of Flame player.	player
46	CRUNCHY	#f5eb5d	#f5eb5d	#de8123	Crunchy	The Honey-Roasted players on a Crunchy team will hit 100% better and with +200% Power.	player
49	REPEATING	#61b3ff	#61b3ff	#3d5982	Repeating	In Reverb Weather, this player will Repeat.	player
52	FIRE_EATER	#f50a31	#f50a31	#e3d514	Fire Eater	Fire Eaters swallow fire instead of being incinerated.	player
51	LIBERATED	#90eb07	#90eb07	#07a1a3	Liberated	Liberated players will be guaranteed extra bases when they get a hit.	player
53	MAGMATIC	#e63200	#e63200	#6b0004	Magmatic	Magmatic players are guaranteed to hit a home run in their next At Bat.	player
54	LOYALTY	#ff61a5	#ff61a5	#2c1240	Loyalty	Players leaving a team with Loyalty will gain the Saboteur modification.	player
44	CURSE_OF_CROWS	#915387	#915387	#3d2830	Curse of Crows	This team or player will be occasionally attacked by Birds.	both
47	PITY	#ffffff	#ffffff	#000000	Pity	This team is holding back, out of Pity.	team
48	GOD	#ff4d90	#ff4d90	#fffc57	God	This team will start with 1,000x the amount of Team Spirit	team
50	SUBJECTION	#d16f6f	#d16f6f	#2e2f33	Subjection	Players leaving a team with Subjection will gain the Liberated modification.	team
1	EXTRA_STRIKE	#f77c9f	#f77c9f	#8c1839	The Fourth Strike	Those with the Fourth Strike will get an extra strike in each at bat.	team
9	BLOOD_DONOR	#ff1f3c	#ff1f3c	#52050f	Blood Donor	In the Blood Bath, this team will donate Stars to a division opponent that finished behind them in the standings.	team
16	RETURNED	#fbff8a	#fbff8a	#1b1c80	Returned	This player has Returned from the void. At the end of each season, this player has a chance of being called back to the Void.	player
43	AFFINITY_FOR_CROWS	#cb80d9	#cb80d9	#240c36	Affinity for Crows	Players with Affinity for Crows will hit and pitch 50% better during Birds weather.	player
55	SABOTEUR	#6b6a6a	#6b6a6a	#240c36	Saboteur	A Saboteur has a chance of intentionally failing.	player
56	CREDIT_TO_THE_TEAM	#fffaba	#fffaba	#786600	Credit to the Team	This player will earn Fans 5x the rewards from all Idol Pendants.	player
59	FLINCH	#219ccc	#219ccc	#5e5e5e	Flinch	Hitters with Flinch cannot swing until a strike has been thrown in the At Bat.	player
60	WILD	#219ccc	#219ccc	#361a57	Mild	Pitchers with Mild have a chance of throwing a Mild Pitch.	player
62	SIPHON	#e30000	#e30000	#2b0000	Siphon	Siphons will steal blood more often in Blooddrain and use it in more ways.	player
63	FLIICKERRRIIING	#80fffb	#80fffb	#383838	Fliickerrriiing	Fliickerrriiing players are Flickering a lot.	player
64	FRIEND_OF_CROWS	#ff7ae7	#ff7ae7	#570026	Friend of Crows	In Birds weather, pitchers with Friend of Crows will encourage the Birds to attack hitters.	player
65	BLASERUNNING	#fffaa3	#fffaa3	#570026	Blaserunning	Blaserunners will score .2 Runs for their Team whenever they steal a base.	player
68	HAUNTED	#b59c9c	#b59c9c	#1c1c1c	Haunted	Haunted players will occasionally be Inhabited.	player
69	TRAVELING	#cfebff	#cfebff	#1c1c1c	Traveling	Traveling teams will play 5% better in Away games.	team
78	RETIRED	#d3ede5	#d3ede5	#000e33	Released		player
79	RESTING	#5988ff	#5988ff	#163073	Resting		player
80	INHABITING	#b59c9c	#b59c9c	#1c1c1c	Inhabiting	This player is temporarily Inhabiting a Haunted player.	player
57	LOVE	#ff2b6b	#ff2b6b	#732652	Charm	Players with Charm have a chance of convincing their opponents to fail.	team
58	PEANUT_RAIN	#fff199	#fff199	#04144a	Peanut Rain	This Team weaponizes Peanut weather against their enemies.	team
61	DESTRUCTION	#ff8a24	#ff8a24	#802d00	Destruction	Teams with Destruction will add a bunch of Curses to their Opponent when defeating them in battle.	team
66	WALK_IN_THE_PARK	#faff9c	#faff9c	#275c2a	Walk in the Park	Those with Walk in the Park will walk to first base on one less Ball.	team
67	BIRD_SEED	#1e0036	#dca8f7	#dca8f7	Bird Seed	Birds like to eat Bird Seed. They'll peck those with Bird Seed out of peanut shells more often. Because they like to eat Bird Seed.	team
70	SEALANT	#eded91	#eded91	#571f26	Sealant	Players with Sealant cannot have blood drained in Blooddrain.	team
71	O_NO	#cffff0	#cffff0	#485099	0 No	Players with 0 No cannot be struck out when there are 0 Balls in the Count.	team
72	FAIRNESS	#12b300	#12b300	#ffdb0f	Total Fairness	This Season, each team will win only one Blessing, and will be Happy with what they get.	team
73	ESCAPE	#ffe521	#ffe521	#0d0d0d	Pending	The players on this Team are Pending...	team
74	UNFLAMED	#eaabff	#eaabff	#1b1c80	Chaotic	The Unstable players on a Chaotic team will hit 100% better.	team
75	TRIBUTE	#dbce6e	#dbce6e	#362803	Tribute	When Hall of Flame players join this team, they'll add their Tribute as Team Spirit.	team
76	SQUIDDEST	#e6eaeb	#e6eaeb	#163073	Squiddest	This Team is the Squiddest. When a player joins the Team, they'll become Squiddish.	team
77	CONTAINMENT	#91ab91	#91ab91	#023802	Containment	When an Unstable player on this team is incinerated, the Instability cannot chain to their opponent.	team
\.


--
-- Data for Name: phases; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.phases (phase_id, phase_type, phase_type_id) FROM stdin;
1	PRESEASON	0
2	GAMEDAY	1
3	END_REGULAR_SEASON	2
7	END_REGULAR_SEASON	2
4	POSTSEASON	3
10	POSTSEASON	3
11	POSTSEASON	3
9	BOSS_FIGHT	4
0	ELECTION_RESULTS	5
5	END_POSTSEASON	5
6	END_POSTSEASON	5
8	UNKNOWN_THE_OCHO	99
99	SIESTA	99
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

COPY taxa.player_url_slugs (player_url_slug_id, player_id, url_slug, player_name) FROM stdin;
3195	3d4545ed-6217-4d7a-9c4a-209265eb6404	tiana-cash	Tiana Cash
3196	e3c514ae-f813-470e-9c91-d5baf5ffcf16	tot-clark	Tot Clark
3197	0d5300f6-0966-430f-903f-a4c2338abf00	wyatt-dovenpart	Wyatt Dovenpart
3198	5c60f834-a133-4dc6-9c07-392fb37b3e6a	ramirez-winters	Ramirez Winters
3199	82733eb4-103d-4be1-843e-6eb6df35ecd7	adkins-tosser	Adkins Tosser
3200	04f955fe-9cc9-4482-a4d2-07fe033b59ee	zane-vapor	Zane Vapor
3201	f6342729-a38a-4204-af8d-64b7accb5620	marco-winner	Marco Winner
3202	6524e9e0-828a-46c4-935d-0ee2edeb7e9a	carter-turnip	Carter Turnip
3203	94baa9ac-ff96-4f56-a987-10358e917d91	gabriel-griffith	Gabriel Griffith
3204	cc11963b-a05b-477b-b154-911dc31960df	pudge-nakatamo	Pudge Nakatamo
3205	ae4acebd-edb5-4d20-bf69-f2d5151312ff	theodore-cervantes	Theodore Cervantes
3206	4b3e8e9b-6de1-4840-8751-b1fb45dc5605	thomas-dracaena	Thomas Dracaena
3207	864b3be8-e836-426e-ae56-20345b41d03d	goodwin-morin	Goodwin Morin
3208	a38ada0a-aeac-4a3d-b9a5-968687ccd2f9	sixpack-santiago	Sixpack Santiago
3209	90768354-957e-4b4c-bb6d-eab6bbda0ba3	eugenia-garbage	Eugenia Garbage
3210	1ba715f2-caa3-44c0-9118-b045ea702a34	juan-rangel	Juan Rangel
3211	d6e9a211-7b33-45d9-8f09-6d1a1a7a3c78	william-boone	William Boone
3212	0e27df51-ad0c-4546-acf5-96b3cb4d7501	chorby-spoon	Chorby Spoon
3213	8adb084b-19fe-4295-bcd2-f92afdb62bd7	logan-rodriguez	Logan Rodriguez
3214	5fc4713c-45e1-4593-a968-7defeb00a0d4	percival-bendie	Percival Bendie
3215	1db2f602-64b1-4a5c-8697-1932cc2c6df1	mummy-melcon	Mummy Melcon
3216	b88d313f-e546-407e-8bc6-94040499daa5	oliver-loofah	Oliver Loofah
3217	d8742d68-8fce-4d52-9a49-f4e33bd2a6fc	ortiz-morse	Ortiz Morse
3218	9820f2c5-f9da-4a07-b610-c2dd7bee2ef6	dan-bong	Dan Bong
3219	12577256-bc4e-4955-81d6-b422d895fb12	jasmine-washington	Jasmine Washington
3220	c6e2e389-ed04-4626-a5ba-fe398fe89568	henry-marshallow	Henry Marshallow
3221	64f4cd75-0c1e-42cf-9ff0-e41c4756f22a	grey-alvarado	Grey Alvarado
3222	4f69e8c2-b2a1-4e98-996a-ccf35ac844c5	igneus-delacruz	Igneus Delacruz
3223	c4951cae-0b47-468b-a3ac-390cc8e9fd05	timmy-vine	Timmy Vine
3224	667cb445-c288-4e62-b603-27291c1e475d	dan-holloway	Dan Holloway
3225	5149c919-48fe-45c6-b7ee-bb8e5828a095	adkins-davis	Adkins Davis
3226	e4034192-4dc6-4901-bb30-07fe3cf77b5e	wyatt-breadwinner	Wyatt Breadwinner
3227	bbf9543f-f100-445a-a467-81d7aab12236	farrell-seagull	Farrell Seagull
3228	b86237bb-ade6-4b1d-9199-a3cc354118d9	hurley-pacheco	Hurley Pacheco
3229	68f98a04-204f-4675-92a7-8823f2277075	isaac-johnson	Isaac Johnson
3230	b7cdb93b-6f9d-468a-ae00-54cbc324ee84	ruslan-duran	Ruslan Duran
3231	459f7700-521e-40da-9483-4d111119d659	comfort-monreal	Comfort Monreal
3232	3a96d76a-c508-45a0-94a0-8f64cd6beeb4	thomas-england	Thomas England
3233	2b5f5dd7-e31f-4829-bec5-546652103bc0	dudley-mueller	Dudley Mueller
3234	89ec77d8-c186-4027-bd45-f407b4800c2c	james-mora	James Mora
3235	e6502bc7-5b76-4939-9fb8-132057390b30	greer-lott	Greer Lott
3236	3531c282-cb48-43df-b549-c5276296aaa7	oliver-hess	Oliver Hess
3237	d46abb00-c546-4952-9218-4f16084e3238	atlas-guerra	Atlas Guerra
3238	d51f1fe8-4ab8-411e-b836-5bba92984d32	hiroto-cerna	Hiroto Cerna
3239	7a75d626-d4fd-474f-a862-473138d8c376	beck-whitney	Beck Whitney
3240	03b80a57-77ea-4913-9be4-7a85c3594745	halexandrey-walton	Halexandrey Walton
3241	c0998a08-de15-4187-b903-2e096ffa08e5	cannonball-sports	Cannonball Sports
3242	d5192d95-a547-498a-b4ea-6770dde4b9f5	summers-slugger	Summers Slugger
3243	94f30f21-f889-4a2e-9b94-818475bb1ca0	kirkland-sobremesa	Kirkland Sobremesa
3244	ceb5606d-ea3f-4471-9ca7-3d2e71a50dde	london-simmons	London Simmons
3245	87e6ae4b-67de-4973-aa56-0fc9835a1e1e	wyatts-mason	Wyatts Mason
3246	bd9d1d6e-7822-4ad9-bac4-89b8afd8a630	derrick-krueger	Derrick Krueger
3247	5ca7e854-dc00-4955-9235-d7fcd732ddcf	wyatt-mason-6	Wyatt Mason
3248	43bf6a6d-cc03-4bcf-938d-620e185433e1	miguel-javier	Miguel Javier
3249	f38c5d80-093f-46eb-99d6-942aa45cd921	andrew-solis	Andrew Solis
3250	d2a1e734-60d9-4989-b7d9-6eacda70486b	tiana-takahashi	Tiana Takahashi
3251	a5adc84c-80b8-49e4-9962-8b4ade99a922	richardson-turquoise	Richardson Turquoise
3252	9313e41c-3bf7-436d-8bdc-013d3a1ecdeb	sandie-nelson	Sandie Nelson
3253	52cfebfb-8008-4b9f-a566-72a30e0b64bf	spears-rogers	Spears Rogers
3254	88ca603e-b2e5-4916-bef5-d6bba03235f5	clare-mccall	Clare Mccall
3255	b6aa8ce8-2587-4627-83c1-2a48d44afaee	inky-rutledge	Inky Rutledge
3256	d002946f-e7ed-4ce4-a405-63bdaf5eabb5	jorge-owens	Jorge Owens
3257	16a59f5f-ef0f-4ada-8682-891ad571a0b6	boyfriend-berger	Boyfriend Berger
3258	c771abab-f468-46e9-bac5-43db4c5b410f	wade-howe	Wade Howe
3259	24cb35c1-c24c-45ca-ac0b-f99a2e650d89	tyreek-peterson	Tyreek Peterson
3260	ae81e172-801a-4236-929a-b990fc7190ce	august-sky	August Sky
3261	21cbbfaa-100e-48c5-9cea-7118b0d08a34	juice-collins	Juice Collins
3262	03f920cc-411f-44ef-ae66-98a44e883291	cornelius-games	Cornelius Games
3263	333067fd-c2b4-4045-a9a4-e87a8d0332d0	miguel-james	Miguel James
3264	a8e757c6-e299-4a2e-a370-4f7c3da98bd1	hendricks-lenny	Hendricks Lenny
3265	3a96d76a-c508-45a0-94a0-8f64cd6beeb4	sixpack-dogwalker	Sixpack Dogwalker
3266	0ecf6190-f869-421a-b339-29195d30d37c	mcbaseball-clembons	McBaseball Clembons
3267	94d772c7-0254-4f08-814c-f6fc58fcfb9b	fletcher-peck	Fletcher Peck
3268	1ded0384-d290-4ea1-a72b-4f9d220cbe37	juan-murphy	Juan Murphy
3269	a3947fbc-50ec-45a4-bca4-49ffebb77dbe	chorby-short	Chorby Short
3270	ab9b2592-a64a-4913-bf6c-3ae5bd5d26a5	beau-huerta	Beau Huerta
3271	57448b62-f952-40e2-820c-48d8afe0f64d	jessi-wise	Jessi Wise
3272	2ca0c790-e1d5-4a14-ab3c-e9241c87fc23	murray-pony	Murray Pony
3273	64aaa3cb-7daf-47e3-89a8-e565a3715b5d	travis-nakamura	Travis Nakamura
3274	97981e86-4a42-4f85-8783-9f29833c192b	daiya-vine	Daiya Vine
3275	21d52455-6c2c-4ee4-8673-ab46b4b926b4	wyatt-mason-4	Wyatt Mason
3276	86d4e22b-f107-4bcf-9625-32d387fcb521	york-silk	York Silk
3277	9be56060-3b01-47aa-a090-d072ef109fbf	jesus-koch	Jesús Koch
3278	d6c69d2d-9344-4b19-85a4-6cfcbaead5d2	joshua-watson	Joshua Watson
3279	7b55d484-6ea9-4670-8145-986cb9e32412	stevenson-heat	Stevenson Heat
3280	4aa843a4-baa1-4f35-8748-63aa82bd0e03	aureliano-dollie	Aureliano Dollie
3281	2c4b2a6d-9961-4e40-882c-a338f4e72117	evelton-mcblase-ii	Evelton McBlase II
3282	63a31035-2e6d-4922-a3f9-fa6e659b54ad	moody-rodriguez	Moody Rodriguez
3283	6598e40a-d76d-413f-ad06-ac4872875bde	daniel-mendoza	Daniel Mendoza
3284	03d06163-6f06-4817-abe5-0d14c3154236	garcia-tabby	Garcia Tabby
3285	99e7de75-d2b8-4330-b897-a7334708aff9	winnie-loser	Winnie Loser
3286	cd417f8a-ce01-4ab2-921d-42e2e445bbe2	eizabeth-guerra	Eizabeth Guerra
3287	c755efce-d04d-4e00-b5c1-d801070d3808	basilio-fig	Basilio Fig
3288	9fd1f392-d492-4c48-8d46-27fb4283b2db	lucas-petty	Lucas Petty
3289	f7847de2-df43-4236-8dbe-ae403f5f3ab3	blood-hamburger	Blood Hamburger
3290	de67b585-9bf4-4e49-b410-101483ca2fbc	shaquille-sunshine	Shaquille Sunshine
3291	18f45a1b-76eb-4b59-a275-c64cf62afce0	steph-weeks	Steph Weeks
3292	937c1a37-4b05-4dc5-a86d-d75226f8490a	pippin-carpenter	Pippin Carpenter
3293	0d5300f6-0966-430f-903f-a4c2338abf00	wyatt-mason-3	Wyatt Mason
3294	68dd9d47-b9a8-4fd3-a89c-5c112eb1982e	durham-spaceman	Durham Spaceman
3295	0f61d948-4f0c-4550-8410-ae1c7f9f5613	tamara-crankit	Tamara Crankit
3296	3a8c52d7-4124-4a65-a20d-d51abcbe6540	theodore-holloway	Theodore Holloway
3297	15d3a844-df6b-4193-a8f5-9ab129312d8d	sebastian-woodman	Sebastian Woodman
3298	bd4c6837-eeaa-4675-ae48-061efa0fd11a	workman-gloom	Workman Gloom
3299	51c5473a-7545-4a9a-920d-d9b718d0e8d1	jacob-haynes	Jacob Haynes
3300	405dfadf-d435-4307-82f6-8eba2287e87a	jaxon-buckley	Jaxon Buckley
3301	190a0f31-d686-4ac4-a7f3-cfc87b72c145	nerd-pacheco	Nerd Pacheco
3302	1c73f91e-0562-480d-9543-2aab1d5e5acd	sparks-beans	Sparks Beans
3303	4b73367f-b2bb-4df6-b2eb-2a0dd373eead	tristin-crankit	Tristin Crankit
3304	ad8d15f4-e041-4a12-a10e-901e6285fdc5	baby-urlacher	Baby Urlacher
3305	7c5ae357-e079-4427-a90f-97d164c7262e	milo-brown	Milo Brown
3306	4b6f0a4e-de18-44ad-b497-03b1f470c43c	rodriguez-internet	Rodriguez Internet
3307	17392be2-7344-48a0-b4db-8a040a7fb532	washer-barajas	Washer Barajas
3308	0295c6c2-b33c-47dd-affa-349da7fa1760	combs-estes	Combs Estes
3309	60026a9d-fc9a-4f5a-94fd-2225398fa3da	bright-zimmerman	Bright Zimmerman
3310	58c9e294-bd49-457c-883f-fb3162fc668e	kichiro-guerra	Kichiro Guerra
3311	e16c3f28-eecd-4571-be1a-606bbac36b2b	wyatt-mason-11	Wyatt Mason
3312	c83a13f6-ee66-4b1c-9747-faa67395a6f1	zi-delacruz	Zi Delacruz
3313	82d1b7b4-ce00-4536-8631-a025f05150ce	sam-scandal	Sam Scandal
3314	e749dc27-ca3b-456e-889c-d2ec02ac7f5f	aureliano-estes	Aureliano Estes
3315	8903a74f-f322-41d2-bd75-dbf7563c4abb	francisca-sasquatch	Francisca Sasquatch
3316	b9293beb-d199-4b46-add9-c02f9362d802	bauer-zimmerman	Bauer Zimmerman
3317	2f3d7bc7-6ffb-40c3-a94f-5e626be413c9	elijah-valenzuela	Elijah Valenzuela
3318	09f2787a-3352-41a6-8810-d80e97b253b5	curry-aliciakeyes	Curry Aliciakeyes
3319	29bf512a-cd8c-4ceb-b25a-d96300c184bb	garcia-soto	Garcia Soto
3320	c86b5add-6c9a-40e0-aa43-e4fd7dd4f2c7	sosa-elftower	Sosa Elftower
3321	a1628d97-16ca-4a75-b8df-569bae02bef9	chorby-soul	Chorby Soul
3322	35d5b43f-8322-4666-aab1-d466b4a5a388	jordan-boone	Jordan Boone
3323	b056a825-b629-4856-856b-53a15ad34acb	bennett-takahashi	Bennett Takahashi
3324	020ed630-8bae-4441-95cc-0e4ecc27253b	simon-haley	Simon Haley
3325	6bd4cf6e-fefe-499a-aa7a-890bcc7b53fa	igneus-mcdaniel	Igneus Mcdaniel
3326	3ebb5361-3895-4a50-801e-e7a0ee61750c	augusto-reddick	Augusto Reddick
3327	f0594932-8ef7-4d70-9894-df4be64875d8	fitzgerald-wanderlust	Fitzgerald Wanderlust
3328	b7267aba-6114-4d53-a519-bf6c99f4e3a9	sosa-hayes	Sosa Hayes
3329	58fca5fa-e559-4f5e-ac87-dc99dd19e410	sullivan-septemberish	Sullivan Septemberish
3330	37efef78-2df4-4c76-800c-43d4faf07737	lenix-ren	Lenix Ren
3331	c4418663-7aa4-4c9f-ae73-0e81e442e8a2	chris-thibault	Chris Thibault
3332	ce0a156b-ba7b-4313-8fea-75807b4bc77f	conrad-twelve	Conrad Twelve
3333	bd8d58b6-f37f-48e6-9919-8e14ec91f92a	jose-haley	José Haley
3334	945974c5-17d9-43e7-92f6-ba49064bbc59	bates-silk	Bates Silk
3335	094ad9a1-e2c7-49a0-af18-da0e3eb656ba	erickson-sato	Erickson Sato
3336	97f5a9cd-72f0-413e-9e68-a6ee6a663489	kline-greenlemon	Kline Greenlemon
3337	1ffb1153-909d-44c7-9df1-6ed3a9a45bbd	montgomery-bullock	Montgomery Bullock
3338	1a93a2d2-b5b6-479b-a595-703e4a2f3885	pedro-davids	Pedro Davids
3339	04931546-1b4a-469f-b391-7ed67afe824c	glabe-moon	Glabe Moon
3340	21d52455-6c2c-4ee4-8673-ab46b4b926b4	emmett-owens	Emmett Owens
3341	f8c20693-f439-4a29-a421-05ed92749f10	combs-duende	Combs Duende
3342	a938f586-f5c1-4a35-9e7f-8eaab6de67a6	jasper-destiny	Jasper Destiny
3343	1aec2c01-b766-4018-a271-419e5371bc8f	rush-ito	Rush Ito
3344	542af915-79c5-431c-a271-f7185e37c6ae	oliver-notarobot	Oliver Notarobot
3345	23e78d92-ee2d-498a-a99c-f40bc4c5fe99	annie-williams	Annie Williams
3346	ce3fb736-d20e-4e2a-88cb-e136783d3a47	javier-howe	Javier Howe
3347	75f9d874-5e69-438d-900d-a3fcb1d429b3	moses-mason	Moses Mason
3348	527c1f6e-a7e4-4447-a824-703b662bae4e	melton-campbell	Melton Campbell
3349	3064c7d6-91cc-4c2a-a433-1ce1aabc1ad4	jorge-ito	Jorge Ito
3350	0bd5a3ec-e14c-45bf-8283-7bc191ae53e4	stephanie-donaldson	Stephanie Donaldson
3351	b390b28c-df96-443e-b81f-f0104bd37860	karato-rangel	Karato Rangel
3352	f741dc01-2bae-4459-bfc0-f97536193eea	alejandro-leaf	Alejandro Leaf
3353	d796d287-77ef-49f0-89ef-87bcdeb280ee	izuki-clark	Izuki Clark
3354	f1185b20-7b4a-4ccc-a977-dc1afdfd4cb9	frazier-tosser	Frazier Tosser
3355	80dff591-2393-448a-8d88-122bd424fa4c	elvis-figueroa	Elvis Figueroa
3356	9ba361a1-16d5-4f30-b590-fc4fc2fb53d2	mooney-doctor	Mooney Doctor
3357	2cadc28c-88a5-4e25-a6eb-cdab60dd446d	elijah-bookbaby	Elijah Bookbaby
3358	1f145436-b25d-49b9-a1e3-2d3c91626211	joe-voorhees	Joe Voorhees
3359	c31d874c-1b4d-40f2-a1b3-42542e934047	cedric-spliff	Cedric Spliff
3360	0672a4be-7e00-402c-b8d6-0b813f58ba96	castillo-logan	Castillo Logan
3361	5915b7bb-e532-4036-9009-79f1e80c0e28	rosa-holloway	Rosa Holloway
3362	3db02423-92af-485f-b30f-78256721dcc6	son-jensen	Son Jensen
3363	425f3f84-bab0-4cf2-91c1-96e78cf5cd02	luis-acevedo	Luis Acevedo
3364	20e13b56-599b-4a22-b752-8059effc81dc	lou-roseheart	Lou Roseheart
3365	c17a4397-4dcc-440e-8c53-d897e971cae9	august-mina	August Mina
3366	90c8be89-896d-404c-945e-c135d063a74e	james-boy	James Boy
3367	7e4f012e-828c-43bb-8b8a-6c33bdfd7e3f	patel-olive	Patel Olive
3368	1732e623-ffc2-40f0-87ba-fdcf97131f1f	betsy-trombone	Betsy Trombone
3369	113f47b2-3111-4abb-b25e-18f7889e2d44	adkins-swagger	Adkins Swagger
3370	efafe75e-2f00-4418-914c-9b6675d39264	aldon-cashmoney	Aldon Cashmoney
3371	4542f0b0-3409-4a4a-a9e1-e8e8e5d73fcf	brock-watson	Brock Watson
3372	65273615-22d5-4df1-9a73-707b23e828d5	burke-gonzales	Burke Gonzales
3373	262c49c6-8301-487d-8356-747023fa46a9	alexandria-dracaena	Alexandria Dracaena
3374	c3b1b4e5-4b88-4245-b2b1-ae3ade57349e	wall-osborn	Wall Osborn
3375	5bcfb3ff-5786-4c6c-964c-5c325fcc48d7	paula-turnip	Paula Turnip
3376	34e1b683-ecd5-477f-b9e3-dd4bca76db45	alexandria-hess	Alexandria Hess
3377	6c346d8b-d186-4228-9adb-ae919d7131dd	greer-gwiffin	Greer Gwiffin
3378	4ecee7be-93e4-4f04-b114-6b333e0e6408	sutton-dreamy	Sutton Dreamy
3379	d2f827a5-0133-4d96-b403-85a5e50d49e0	robbins-schmitt	Robbins Schmitt
3380	51cba429-13e8-487e-9568-847b7b8b9ac5	collins-mina	Collins Mina
3381	3f08f8cd-6418-447a-84d3-22a981c68f16	pollard-beard	Pollard Beard
3382	7aeb8e0b-f6fb-4a9e-bba2-335dada5f0a3	dunlap-figueroa	Dunlap Figueroa
3383	be35caba-b16a-4e0d-b927-4da857f4cdb5	frasier-shmurmgle	Frasier Shmurmgle
3384	7932c7c7-babb-4245-b9f5-cdadb97c99fb	randy-castillo	Randy Castillo
3385	7e160e9f-2c79-4e08-8b76-b816de388a98	thomas-marsh	Thomas Marsh
3386	af6b3edc-ed52-4edc-b0c9-14e0a5ae0ee3	wyatt-masons	Wyatt Masons
3387	c8de53a4-d90f-4192-955b-cec1732d920e	tyreek-cain	Tyreek Cain
3388	d74a2473-1f29-40fa-a41e-66fa2281dfca	landry-violence	Landry Violence
3389	a199a681-decf-4433-b6ab-5454450bbe5e	leach-ingram	Leach Ingram
3390	b082ca6e-eb11-4eab-8d6a-30f8be522ec4	nicholas-mora	Nicholas Mora
3391	7fed72df-87de-407d-8253-2295a2b60d3b	stout-schmitt	Stout Schmitt
3392	8c8cc584-199b-4b76-b2cd-eaa9a74965e5	ziwa-mueller	Ziwa Mueller
3393	8d337b47-2a7d-418d-a44e-ef81e401c2ef	case-sports	Case Sports
3394	fa5b54d2-b488-47cd-a529-592831e4813d	kina-larsen	Kina Larsen
3395	46721a07-7cd2-4839-982e-7046df6e8b66	stew-briggs	Stew Briggs
3396	316abea7-9890-4fb8-aaea-86b35e24d9be	kennedy-rodgers	Kennedy Rodgers
3397	b4505c48-fc75-4f9e-8419-42b28dcc5273	sebastian-townsend	Sebastian Townsend
3398	50154d56-c58a-461f-976d-b06a4ae467f9	carter-oconnor	Carter Oconnor
3399	ab9eb213-0917-4374-a259-458295045021	matheo-carpenter	Matheo Carpenter
3400	6b8d128f-ed51-496d-a965-6614476f8256	orville-manco	Orville Manco
3401	9ac2e7c5-5a34-4738-98d8-9f917bc6d119	christian-combs	Christian Combs
3402	2e86de11-a2dd-4b28-b5fe-f4d0c38cd20b	zion-aliciakeyes	Zion Aliciakeyes
3403	dddb6485-0527-4523-9bec-324a5b66bf37	beans-mcblase	Beans McBlase
3404	6f9de777-e812-4c84-915c-ef283c9f0cde	arturo-huerta	Arturo Huerta
3405	f9c0d3cb-d8be-4f53-94c9-fc53bcbce520	matteo-prestige	Matteo Prestige
3406	ccc99f2f-2feb-4f32-a9b9-c289f619d84c	itsuki-winner	Itsuki Winner
3407	817dee99-9ccf-4f41-84e3-dc9773237bc8	holden-stanton	Holden Stanton
3408	24f6829e-7bb4-4e1e-8b59-a07514657e72	king-weatherman	King Weatherman
3409	defbc540-a36d-460b-afd8-07da2375ee63	castillo-turner	Castillo Turner
3410	b39b5aae-8571-4c90-887a-6a00f2a2f6fd	dickerson-morse	Dickerson Morse
3411	d47dd08e-833c-4302-a965-a391d345455c	stu-trololol	Stu Trololol
3412	90cc0211-cd04-4cac-bdac-646c792773fc	case-lancaster	Case Lancaster
3413	ebf2da50-7711-46ba-9e49-341ce3487e00	baldwin-jones	Baldwin Jones
3414	eaaef47e-82cc-4c90-b77d-75c3fb279e83	herring-winfield	Herring Winfield
3415	64b055d1-b691-4e0c-8583-fc08ba663846	theodore-passon	Theodore Passon
3416	f2a27a7e-bf04-4d31-86f5-16bfa3addbe7	winnie-hess	Winnie Hess
3417	088884af-f38d-4914-9d67-b319287481b4	liam-petty	Liam Petty
3418	b3d518b9-dc68-4902-b68c-0022ceb25aa0	hendricks-rangel	Hendricks Rangel
3419	5dbf11c0-994a-4482-bd1e-99379148ee45	conrad-vaughan	Conrad Vaughan
3420	14d88771-7a96-48aa-ba59-07bae1733e96	sebastian-telephone	Sebastian Telephone
3421	e1e33aab-df8c-4f53-b30a-ca1cea9f046e	joyner-rugrat	Joyner Rugrat
3422	b85161da-7f4c-42a8-b7f6-19789cf6861d	javier-lotus	Javier Lotus
3423	3c331c87-1634-46c4-87ce-e4b9c59e2969	yosh-carpenter	Yosh Carpenter
3424	c22e3af5-9001-465f-b450-864d7db2b4a0	logan-horseman	Logan Horseman
3425	c6bd21a8-7880-4c00-8abe-33560fe84ac5	wendy-cerna	Wendy Cerna
3426	cd6b102e-1881-4079-9a37-455038bbf10e	caleb-morin	Caleb Morin
3427	9c3273a0-2711-4958-b716-bfcf60857013	kathy-mathews	Kathy Mathews
3428	4941976e-31fc-49b5-801a-18abe072178b	sebastian-sunshine	Sebastian Sunshine
3429	4562ac1f-026c-472c-b4e9-ee6ff800d701	chris-koch	Chris Koch
3430	32551e28-3a40-47ae-aed1-ff5bc66be879	math-velazquez	Math Velazquez
3431	019ce117-2399-4382-8036-8c14db7e1d30	lori-boston	Lori Boston
3432	b7c4f986-e62a-4a8f-b5f0-8f30ecc35c5d	oscar-hollywood	Oscar Hollywood
3433	81a0889a-4606-4f49-b419-866b57331383	summers-pony	Summers Pony
3434	b5c95dba-2624-41b0-aacd-ac3e1e1fe828	cote-rodgers	Cote Rodgers
3435	d2d76815-cbdc-4c4b-9c9e-32ebf2297cc7	denzel-scott	Denzel Scott
3436	493a83de-6bcf-41a1-97dd-cc5e150548a3	boyfriend-monreal	Boyfriend Monreal
3437	9786b2c9-1205-4718-b0f7-fc000ce91106	kevin-dudley	Kevin Dudley
3438	db3ff6f0-1045-4223-b3a8-a016ca987af9	murphy-thibault	Murphy Thibault
3439	afc90398-b891-4cdf-9dea-af8a3a79d793	yazmin-mason	Yazmin Mason
3440	f0bcf4bb-74b3-412e-a54c-04c12ad28ecb	hahn-fox	Hahn Fox
3441	c9e4a49e-e35a-4034-a4c7-293896b40c58	alexander-horne	Alexander Horne
3442	b7adbbcc-0679-43f3-a939-07f009a393db	jode-crutch	Jode Crutch
3443	6192daab-3318-44b5-953f-14d68cdb2722	justin-alstott	Justin Alstott
3444	bf6a24d1-4e89-4790-a4ba-eeb2870cbf6f	rat-mason	Rat Mason
3445	77a41c29-8abd-4456-b6e0-a034252700d2	elip-dean	Elip Dean
3446	f2c477fb-28ea-4fcb-943a-9fab22df3da0	sandford-garner	Sandford Garner
3447	198fd9c8-cb75-482d-873e-e6b91d42a446	ren-hunter	Ren Hunter
3448	167751d5-210c-4a6e-9568-e92d61bab185	jacob-winner	Jacob Winner
3449	ce0e57a7-89f5-41ea-80f9-6e649dd54089	yong-wright	Yong Wright
3450	3dd85c20-a251-4903-8a3b-1b96941c07b7	tot-best	Tot Best
3451	ea44bd36-65b4-4f3b-ac71-78d87a540b48	wyatt-pothos	Wyatt Pothos
3452	14bfad43-2638-41ec-8964-8351f22e9c4f	baby-sliders	Baby Sliders
3453	2d22f026-2873-410b-a45f-3b1dac665ffd	donia-johnson	Donia Johnson
3454	d8ee256f-e3d0-46cb-8c77-b1f88d8c9df9	comfort-septemberish	Comfort Septemberish
3455	63512571-2eca-4bc4-8ad9-a5308a22ae22	oscar-dollie	Oscar Dollie
3456	a73427b3-e96a-4156-a9ab-844edc696fed	wesley-vodka	Wesley Vodka
3457	cd68d3a6-7fbc-445d-90f1-970c955e32f4	miguel-wheeler	Miguel Wheeler
3458	ce58415f-4e62-47e2-a2c9-4d6a85961e1e	schneider-blanco	Schneider Blanco
3459	7cf83bdc-f95f-49d3-b716-06f2cf60a78d	matteo-urlacher	Matteo Urlacher
3460	ecf19925-dc57-4b89-b114-923d5a714dbe	margarito-bishop	Margarito Bishop
3461	5f3b5dc2-351a-4dee-a9d6-fa5f44f2a365	alston-england	Alston England
3462	f56657d3-3bdc-4840-a20c-91aca9cc360e	malik-romayne	Malik Romayne
3463	75f9d874-5e69-438d-900d-a3fcb1d429b3	moses-simmons	Moses Simmons
3464	849e13dc-6eb1-40a8-b55c-d4b4cd160aab	justice-valenzuela	Justice Valenzuela
3465	d9a072f5-1cbb-45ce-87fb-b138e4d8f769	francisco-object	Francisco Object
3466	7b0f91aa-4d66-4362-993d-6ff60f7ce0ef	blankenship-fischer	Blankenship Fischer
3467	2175cda0-a427-40fd-b497-347edcc1cd61	hotbox-sato	Hotbox Sato
3468	042962c8-4d8b-44a6-b854-6ccef3d82716	ronan-jaylee	Ronan Jaylee
3469	36786f44-9066-4028-98d9-4fa84465ab9e	beasley-gloom	Beasley Gloom
3470	285ce77d-e5cd-4daa-9784-801347140d48	son-scotch	Son Scotch
3471	fdfd36c7-e0c1-4fce-98f7-921c3d17eafe	reese-harrington	Reese Harrington
3472	cbd19e6f-3d08-4734-b23f-585330028665	knight-urlacher	Knight Urlacher
3473	b348c037-eefc-4b81-8edd-dfa96188a97e	lowe-forbes	Lowe Forbes
3474	e7ecf646-e5e4-49ef-a0e3-10a78e87f5f4	gallup-crueller	Gallup Crueller
3475	d8bc482e-9309-4230-abcb-2c5a6412446d	august-obrien	August Obrien
3476	d35ccee1-9559-49a1-aaa4-7809f7b5c46e	forrest-best	Forrest Best
3477	6e744b21-c4fa-4fa8-b4ea-e0e97f68ded5	daniel-koch	Daniel Koch
3478	62111c49-1521-4ca7-8678-cd45dacf0858	bambi-perez	Bambi Perez
3479	7951836f-581a-49d5-ae2f-049c6bcc575e	adkins-gwiffin	Adkins Gwiffin
3480	aae38811-122c-43dd-b59c-d0e203154dbe	sandie-carver	Sandie Carver
3481	70ccff1e-6b53-40e2-8844-0a28621cb33e	moody-cookbook	Moody Cookbook
3482	88cd6efa-dbf2-4309-aabe-ec1d6f21f98a	hewitt-best	Hewitt Best
3483	ac69dba3-6225-4afd-ab4b-23fc78f730fb	bevan-wise	Bevan Wise
3484	fcbe1d14-04c4-4331-97ad-46e170610633	jode-preston	Jode Preston
3485	3af96a6b-866c-4b03-bc14-090acf6ecee5	axel-trololol	Axel Trololol
3486	98a98014-9636-4ece-a46a-4625b47c65d5	kiki-familia	Kiki Familia
3487	15ae64cd-f698-4b00-9d61-c9fffd037ae2	mickey-woods	Mickey Woods
3488	dac2fd55-5686-465f-a1b6-6fbed0b417c5	russo-slugger	Russo Slugger
3489	27c68d7f-5e40-4afa-8b6f-9df47b79e7dd	basilio-mason	Basilio Mason
3490	2e6d4fa9-f930-47bd-971a-dd54a3cf7db1	raul-leal	Raúl Leal
3491	733d80f1-2485-40f7-828b-fd7cd8243a01	rai-spliff	Rai Spliff
3492	80e474a3-7d2b-431d-8192-2f1e27162607	summers-preston	Summers Preston
3493	23110c0f-2cf9-4d9c-ab2d-634f2f18867e	kennedy-meh	Kennedy Meh
3494	a1ed3396-114a-40bc-9ff0-54d7e1ad1718	patel-beyonce	Patel Beyonce
3495	9e724d9a-92a0-436e-bde1-da0b2af85d8f	hatfield-suzuki	Hatfield Suzuki
3496	97ec5a2f-ac1a-4cde-86b7-897c030a1fa8	alston-woods	Alston Woods
3497	4ca52626-58cd-449d-88bb-f6d631588640	velasquez-alstott	Velasquez Alstott
3498	d23a1f7e-0071-444e-8361-6ae01f13036f	edric-tosser	Edric Tosser
3499	450e6483-d116-41d8-933b-1b541d5f0026	england-voorhees	England Voorhees
3500	28964497-0efe-420c-9c1d-8574f224a4e9	inez-owens	Inez Owens
3501	b69aa26f-71f7-4e17-bc36-49c875872cc1	francisca-burton	Francisca Burton
3502	7dca7137-b872-46f5-8e59-8c9c996e9d22	emmett-tabby	Emmett Tabby
3503	d744f534-2352-472b-9e42-cd91fa540f1b	tyler-violet	Tyler Violet
3504	2b1cb8a2-9eba-4fce-85cf-5d997ec45714	isaac-rubberman	Isaac Rubberman
3505	0eddd056-9d72-4804-bd60-53144b785d5c	caleb-novak	Caleb Novak
3506	b1b141fc-e867-40d1-842a-cea30a97ca4f	richardson-games	Richardson Games
3507	4ed61b18-c1f6-4d71-aea3-caac01470b5c	lenny-marijuana	Lenny Marijuana
3508	c73d59dd-32a0-49ce-8ab4-b2dbb7dc94ec	eduardo-ingram	Eduardo Ingram
3509	0eea4a48-c84b-4538-97e7-3303671934d2	helga-moreno	Helga Moreno
3510	dd0b48fe-2d49-4344-83ed-9f0770b370a8	tillman-wan	Tillman Wan
3511	57b4827b-26b0-4384-a431-9f63f715bc5b	aureliano-cerna	Aureliano Cerna
3512	7e9a514a-7850-4ed0-93ab-f3a6e2f41c03	nolanestophia-patterson	Nolanestophia Patterson
3513	9f6d06d6-c616-4599-996b-ec4eefcff8b8	silvia-winner	Silvia Winner
3514	7f379b72-f4f0-4d8f-b88b-63211cf50ba6	jesus-rodriguez	Jesús Rodriguez
3515	dfe3bc1b-fca8-47eb-965f-6cf947c35447	linus-haley	Linus Haley
3516	814bae61-071a-449b-981e-e7afc839d6d6	ruslan-greatness	Ruslan Greatness
3517	3c051b92-4a86-4157-988a-e334bf6dc691	tyler-leatherman	Tyler Leatherman
3518	f883269f-117e-45ec-bb1e-fa8dbcf40d3e	jayden-wright	Jayden Wright
3519	d81ce662-07b6-4a73-baa4-acbbb41f9dc5	yummy-elliott	Yummy Elliott
3520	dd6ba7f1-a97a-4374-a3a7-b3596e286bb3	matheo-tanaka	Matheo Tanaka
3521	1f159bab-923a-4811-b6fa-02bfde50925a	wyatt-mason	Wyatt Mason
3522	773712f6-d76d-4caa-8a9b-56fe1d1a5a68	natha-kath	Natha Kath
3523	ac57cf28-556f-47af-9154-6bcea2ace9fc	rey-wooten	Rey Wooten
3524	57290370-6723-4d33-929e-b4fc190e6a9a	mooney-doctor-ii	Mooney Doctor II
3525	b7c1ddda-945c-4b2e-8831-ad9f2ec4a608	nolan-violet	Nolan Violet
3526	90c6e6ca-77fc-42b7-94d8-d8afd6d299e5	miki-santana	Miki Santana
3527	80de2b05-e0d4-4d33-9297-9951b2b5c950	alyssa-harrell	Alyssa Harrell
3528	0fe896e1-108c-4ce9-97be-3470dde73c21	bryanayah-chang	Bryanayah Chang
3529	446a3366-3fe3-41bb-bfdd-d8717f2152a9	marco-escobar	Marco Escobar
3530	1068f44b-34a0-42d8-a92e-2be748681a6f	allison-abbott	Allison Abbott
3531	40db1b0b-6d04-4851-adab-dd6320ad2ed9	scrap-murphy	Scrap Murphy
3532	30218684-7fa1-41a5-a3b3-5d9cd97dd36b	jordan-hildebert	Jordan Hildebert
3533	dfd5ccbb-90ed-4bfe-83e0-dae9cc763f10	owen-picklestein	Owen Picklestein
3534	24ad200d-a45f-4286-bfa5-48909f98a1f7	nicholas-summer	Nicholas Summer
3535	fa477c92-39b6-4a52-b065-40af2f29840a	howell-franklin	Howell Franklin
3536	c09e64b6-8248-407e-b3af-1931b880dbee	lenny-spruce	Lenny Spruce
3537	3954bdfa-931f-4787-b9ac-f44b72fe09d7	nicholas-nolan	Nicholas Nolan
3538	bd8778e5-02e8-4d1f-9c31-7b63942cc570	cell-barajas	Cell Barajas
3539	2720559e-9173-4042-aaa0-d3852b72ab2e	hiroto-wilcox	Hiroto Wilcox
3540	f3ddfd87-73a2-4681-96fe-829476c97886	theodore-duende	Theodore Duende
3541	2b9f9c25-43ec-4f0b-9937-a5aa23be0d9e	lawrence-horne	Lawrence Horne
3542	d4a10c2a-0c28-466a-9213-38ba3339b65e	richmond-harrison	Richmond Harrison
3543	e3c06405-0564-47ce-bbbd-552bee4dd66f	scrap-weeks	Scrap Weeks
3544	63df8701-1871-4987-87d7-b55d4f1df2e9	mcdowell-sasquatch	Mcdowell Sasquatch
3545	89f74891-2e25-4b5a-bd99-c95ba3f36aa0	nagomi-nava	Nagomi Nava
3546	a1ed3396-114a-40bc-9ff0-54d7e1ad1718	wyatt-mason-9	Wyatt Mason
3547	c4dec95e-78a1-4840-b209-b3b597181534	charlatan-seabright	Charlatan Seabright
3548	e972984c-2895-451c-b518-f06a0d8bd375	becker-solis	Becker Solis
3549	8604e861-d784-43f0-b0f8-0d43ea6f7814	randall-marijuana	Randall Marijuana
3550	1e7b02b7-6981-427a-b249-8e9bd35f3882	nora-reddick	Nora Reddick
3551	b3e512df-c411-4100-9544-0ceadddb28cf	famous-owens	Famous Owens
3552	d1a7c13f-8e78-4d2e-9cae-ebf3a5fcdb5d	elijah-bates	Elijah Bates
3553	4bda6584-6c21-4185-8895-47d07e8ad0c0	aldon-anthony	Aldon Anthony
3554	520e6066-b14b-45cf-985c-0a6ee2dc3f7a	zi-sliders	Zi Sliders
3555	06ced607-7f96-41e7-a8cd-b501d11d1a7e	morrow-wilson	Morrow Wilson
3556	ea44bd36-65b4-4f3b-ac71-78d87a540b48	wyatt-mason-13	Wyatt Mason
3557	dd8a43a4-a024-44e9-a522-785d998b29c3	miguel-peterson	Miguel Peterson
3558	73265ee3-bb35-40d1-b696-1f241a6f5966	parker-meng	Parker Meng
3559	bf6a24d1-4e89-4790-a4ba-eeb2870cbf6f	rat-polk	Rat Polk
3560	8b53ce82-4b1a-48f0-999d-1774b3719202	oliver-mueller	Oliver Mueller
3561	e16c3f28-eecd-4571-be1a-606bbac36b2b	comfort-glover	Comfort Glover
3562	8b0d717f-ae42-4492-b2ed-106912e2b530	avila-baker	Avila Baker
3563	126fb128-7c53-45b5-ac2b-5dbf9943d71b	sigmund-castillo	Sigmund Castillo
3564	c6a277c3-d2b5-4363-839b-950896a5ec5e	mike-townsend	Mike Townsend
3565	4f328502-d347-4d2c-8fad-6ae59431d781	stephens-lightner	Stephens Lightner
3566	695daf02-113d-4e76-b802-0862df16afbd	pacheco-weeks	Pacheco Weeks
3567	138fccc3-e66f-4b07-8327-d4b6f372f654	oscar-vaughan	Oscar Vaughan
3568	32810dca-825c-4dbc-8b65-0702794c424e	eduardo-woodman	Eduardo Woodman
3569	68462bfa-9006-4637-8830-2e7840d9089a	parker-horseman	Parker Horseman
3570	8cd06abf-be10-4a35-a3ab-1a408a329147	gloria-bugsnax	Gloria Bugsnax
3571	ceb8f8cd-80b2-47f0-b43e-4d885fa48aa4	donia-bailey	Donia Bailey
3572	338694b7-6256-4724-86b6-3884299a5d9e	polkadot-patterson	PolkaDot Patterson
3573	4bf352d2-6a57-420a-9d45-b23b2b947375	rivers-rosa	Rivers Rosa
3574	03097200-0d48-4236-a3d2-8bdb153aa8f7	bennett-browning	Bennett Browning
3575	51985516-5033-4ab8-a185-7bda07829bdb	stephanie-schmitt	Stephanie Schmitt
3576	aa6c2662-75f8-4506-aa06-9a0993313216	eizabeth-elliott	Eizabeth Elliott
3577	0bb35615-63f2-4492-80ec-b6b322dc5450	sexton-wheeler	Sexton Wheeler
3578	25f3a67c-4ed5-45b6-94b1-ce468d3ead21	hobbs-cain	Hobbs Cain
3579	1f159bab-923a-4811-b6fa-02bfde50925a	nan	NaN
3580	de52d5c0-cba4-4ace-8308-e2ed3f8799d0	jose-mitchell	José Mitchell
3581	70a458ed-25ca-4ff8-97fc-21cbf58f2c2a	trevino-merritt	Trevino Merritt
3582	1e229fe5-a191-48ef-a7dd-6f6e13d6d73f	erickson-fischer	Erickson Fischer
3583	f2468055-e880-40bf-8ac6-a0763d846eb2	alaynabella-hollywood	Alaynabella Hollywood
3584	76c4853b-7fbc-4688-8cda-c5b8de1724e4	lars-mendoza	Lars Mendoza
3585	6644d767-ab15-4528-a4ce-ae1f8aadb65f	paula-reddick	Paula Reddick
3586	248ccf3d-d5f6-4b69-83d9-40230ca909cd	antonio-wallace	Antonio Wallace
3587	0f62c20c-72d0-4c12-a9d7-312ea3d3bcd1	abner-wood	Abner Wood
3588	af6b3edc-ed52-4edc-b0c9-14e0a5ae0ee3	rivers-clembons	Rivers Clembons
3589	ecb8d2f5-4ff5-4890-9693-5654e00055f6	yeongho-benitez	Yeong-Ho Benitez
3590	6a869b40-be99-4520-89e5-d382b07e4a3c	jake-swinger	Jake Swinger
3591	c18961e9-ef3f-4954-bd6b-9fe01c615186	carmelo-plums	Carmelo Plums
3592	a2483925-697f-468f-931c-bcd0071394e5	timmy-manco	Timmy Manco
3593	13a05157-6172-4431-947b-a058217b4aa5	spears-taylor	Spears Taylor
3594	5ff66eae-7111-4e3b-a9b8-a9579165b0a5	peanutiel-duffy	Peanutiel Duffy
3595	11de4da3-8208-43ff-a1ff-0b3480a0fbf1	don-mitchell	Don Mitchell
3596	04e14d7b-5021-4250-a3cd-932ba8e0a889	jaylen-hotdogfingers	Jaylen Hotdogfingers
3597	80a2f015-9d40-426b-a4f6-b9911ba3add8	paul-barnes	Paul Barnes
3598	ca709205-226d-4d92-8be6-5f7871f48e26	rivers-javier	Rivers Javier
3599	20395b48-279d-44ff-b5bf-7cf2624a2d30	adrian-melon	Adrian Melon
3600	a691f2ba-9b69-41f8-892c-1acd42c336e4	jenkins-good	Jenkins Good
3601	f4a5d734-0ade-4410-abb6-c0cd5a7a1c26	agan-harrison	Agan Harrison
3602	f968532a-bf06-478e-89e0-3856b7f4b124	daniel-benedicte	Daniel Benedicte
3603	df4da81a-917b-434f-b309-f00423ee4967	eugenia-bickle	Eugenia Bickle
3604	25376b55-bb6f-48a7-9381-7b8210842fad	emmett-internet	Emmett Internet
3605	f6b38e56-0d98-4e00-a96e-345aaac1e653	leticia-snyder	Leticia Snyder
3606	1e8b09bd-fbdd-444e-bd7e-10326bd57156	fletcher-yamamoto	Fletcher Yamamoto
3607	2727215d-3714-438d-b1ba-2ed15ec481c0	dominic-woman	Dominic Woman
3608	e919dfae-91c3-475c-b5d5-8b0c14940c41	famous-meng	Famous Meng
3609	66cebbbf-9933-4329-924a-72bd3718f321	kennedy-cena	Kennedy Cena
3610	20be1c34-071d-40c6-8824-dde2af184b4d	qais-dogwalker	Qais Dogwalker
3611	6bac62ad-7117-4e41-80f9-5a155a434856	grit-freeman	Grit Freeman
3612	3e008f60-6842-42e7-b125-b88c7e5c1a95	zeboriah-wilson	Zeboriah Wilson
3613	889c9ef9-d521-4436-b41c-9021b81b4dfb	liam-snail	Liam Snail
3614	33fbfe23-37bd-4e37-a481-a87eadb8192d	whit-steakknife	Whit Steakknife
3615	083d09d4-7ed3-4100-b021-8fbe30dd43e8	jessica-telephone	Jessica Telephone
3616	7158d158-e7bf-4e9b-9259-62e5b25e3de8	karato-bean	Karato Bean
3617	4ffd2e50-bb5b-45d0-b7c4-e24d41b2ff5d	schneider-bendie	Schneider Bendie
3618	53e701c7-e3c8-4e18-ba05-9b41b4b64cda	marquez-clark	Marquez Clark
3619	cd5494b4-05d0-4b2e-8578-357f0923ff4c	mcfarland-vargas	Mcfarland Vargas
3620	f3c07eaf-3d6c-4cc3-9e54-cbecc9c08286	campos-arias	Campos Arias
3621	ee55248b-318a-4bfb-8894-1cc70e4e0720	theo-king	Theo King
3622	c0732e36-3731-4f1a-abdc-daa9563b6506	nagomi-mcdaniel	Nagomi Mcdaniel
3623	ceac785e-55fd-4a4e-9bc8-17a662a58a38	best-cerna	Best Cerna
3624	5ff66eae-7111-4e3b-a9b8-a9579165b0a5	daniel-duffy	Daniel Duffy
3625	18798b8f-6391-4cb2-8a5f-6fb540d646d5	morrow-doyle	Morrow Doyle
3626	089af518-e27c-4256-adc8-62e3f4b30f43	silvia-rugrat	Silvia Rugrat
3627	34267632-8c32-4a8b-b5e6-ce1568bb0639	gunther-o'brian	Gunther O'Brian
3628	ef9f8b95-9e73-49cd-be54-60f84858a285	collins-melon	Collins Melon
3629	bf122660-df52-4fc4-9e70-ee185423ff93	walton-sports	Walton Sports
3630	87e6ae4b-67de-4973-aa56-0fc9835a1e1e	marco-stink	Marco Stink
3631	378c07b0-5645-44b5-869f-497d144c7b35	fynn-doyle	Fynn Doyle
3632	5b5bcc6c-d011-490f-b084-6fdc2c52f958	simba-davis	Simba Davis
3633	f73009c5-2ede-4dc4-b96d-84ba93c8a429	thomas-kirby	Thomas Kirby
3634	27faa5a7-d3a8-4d2d-8e62-47cfeba74ff0	spears-nolan	Spears Nolan
3635	b7ca8f3f-2fdc-477b-84f4-157f2802e9b5	leach-herman	Leach Herman
3636	0daf04fc-8d0d-4513-8e98-4f610616453b	lee-mist	Lee Mist
3637	ad1e670a-f346-4bf7-a02f-a91649c41ccb	stephanie-winters	Stephanie Winters
3638	2da49de2-34e5-49d0-b752-af2a2ee061be	cory-twelve	Cory Twelve
3639	d97835fd-2e92-4698-8900-1f5abea0a3b6	king-roland	King Roland
3640	26f01324-9d1c-470b-8eaa-1b9bfbcd8b65	nerd-james	Nerd James
3641	9f85676a-7411-444a-8ae2-c7f8f73c285c	lachlan-shelton	Lachlan Shelton
3642	5ca7e854-dc00-4955-9235-d7fcd732ddcf	taiga-quitter	Taiga Quitter
3643	62823073-84b8-46c2-8451-28fd10dff250	mckinney-vaughan	Mckinney Vaughan
3644	740d5fef-d59f-4dac-9a75-739ec07f91cf	conner-haley	Conner Haley
3645	f4ca437c-c31c-4508-afe7-6dae4330d717	fran-beans	Fran Beans
3646	503a235f-9fa6-41b5-8514-9475c944273f	reese-clark	Reese Clark
3647	75f9d874-5e69-438d-900d-a3fcb1d429b3	wyatt-mason-8	Wyatt Mason
3648	6fc3689f-bb7d-4382-98a2-cf6ddc76909d	cedric-gonzalez	Cedric Gonzalez
3649	84a2b5f6-4955-4007-9299-3d35ae7135d3	kennedy-loser	Kennedy Loser
3650	5fbf04bb-f5ec-4589-ab19-1d89cda056bd	donia-dollie	Donia Dollie
3651	de21c97e-f575-43b7-8be7-ecc5d8c4eaff	pitching-machine	Pitching Machine
3652	e4f1f358-ee1f-4466-863e-f329766279d0	ronan-combs	Ronan Combs
3653	5b3f0a43-45e7-44e7-9496-512c24c040f0	rhys-rivera	Rhys Rivera
3654	611d18e0-b972-4cdd-afc2-793c56bfe5a9	alston-cerveza	Alston Cerveza
3655	13cfbadf-b048-4c4f-903d-f9b52616b15c	bennett-bowen	Bennett Bowen
3656	81b25b16-3370-4eb0-9d1b-6d630194c680	zeboriah-whiskey	Zeboriah Whiskey
3657	a311c089-0df4-46bd-9f5d-8c45c7eb5ae2	mclaughlin-scorpler	Mclaughlin Scorpler
3658	f071889c-f10f-4d2f-a1dd-c5dda34b3e2b	zion-facepunch	Zion Facepunch
3659	c6146c45-3d9b-4749-9f03-d4faae61e2c3	atlas-diaz	Atlas Diaz
3660	6e373fca-b8ab-4848-9dcc-50e92cd732b7	conrad-bates	Conrad Bates
3661	dd7e710f-da4e-475b-b870-2c29fe9d8c00	itsuki-weeks	Itsuki Weeks
3662	4f7d7490-7281-4f8f-b62e-37e99a7c46a0	annie-roland	Annie Roland
3663	f10ba06e-d509-414b-90cd-4d70d43c75f9	hernando-winter	Hernando Winter
3664	90c2cec7-0ed5-426a-9de8-754f34d59b39	tot-fox	Tot Fox
3665	7afedcd8-870d-4655-9659-3bdfb2e17730	pierre-haley	Pierre Haley
3666	3de17e21-17db-4a6b-b7ab-0b2f3c154f42	brewer-vapor	Brewer Vapor
3667	e3e1d190-2b94-40c0-8e88-baa3fd198d0f	chambers-kennedy	Chambers Kennedy
3668	27c68d7f-5e40-4afa-8b6f-9df47b79e7dd	wyatt-mason-5	Wyatt Mason
3669	5eac7fd9-0d19-4bf4-a013-994acc0c40c0	sutton-bishop	Sutton Bishop
3670	27c68d7f-5e40-4afa-8b6f-9df47b79e7dd	basilio-preston	Basilio Preston
3671	8e1fd784-99d5-41c1-a6c5-6b947cec6714	velasquez-meadows	Velasquez Meadows
3672	5ca7e854-dc00-4955-9235-d7fcd732ddcf	wyatt-quitter	Wyatt Quitter
3673	ea44bd36-65b4-4f3b-ac71-78d87a540b48	wanda-pothos	Wanda Pothos
3674	18af933a-4afa-4cba-bda5-45160f3af99b	felix-garbage	Felix Garbage
3675	093af82c-84aa-4bd6-ad1a-401fae1fce44	elijah-glover	Elijah Glover
3676	0c83e3b6-360e-4b7d-85e3-d906633c9ca0	penelope-mathews	Penelope Mathews
3677	e16c3f28-eecd-4571-be1a-606bbac36b2b	wyatt-glover	Wyatt Glover
3678	d5b6b11d-3924-4634-bd50-76553f1f162b	ogden-mendoza	Ogden Mendoza
3679	05bd08d5-7d9f-450b-abfa-1788b8ee8b91	stevenson-monstera	Stevenson Monstera
3680	e6114fd4-a11d-4f6c-b823-65691bb2d288	bevan-underbuck	Bevan Underbuck
3681	721fb947-7548-49ea-8cbe-7721b0ed49e0	tamara-lopez	Tamara Lopez
3682	f7715b05-ee69-43e5-a0e5-8e3d34270c82	caligula-lotus	Caligula Lotus
3683	7310c32f-8f32-40f2-b086-54555a2c0e86	dominic-marijuana	Dominic Marijuana
3684	e4e4c17d-8128-4704-9e04-f244d4573c4d	wesley-poole	Wesley Poole
3685	44c92d97-bb39-469d-a13b-f2dd9ae644d1	francisco-preston	Francisco Preston
3686	f967d064-0eaf-4445-b225-daed700e044b	wesley-dudley	Wesley Dudley
3687	10ea5d50-ec88-40a0-ab53-c6e11cc1e479	nicholas-vincent	Nicholas Vincent
3688	766dfd1e-11c3-42b6-a167-9b2d568b5dc0	sandie-turner	Sandie Turner
3689	9abe02fb-2b5a-432f-b0af-176be6bd62cf	nagomi-meng	Nagomi Meng
3690	e4034192-4dc6-4901-bb30-07fe3cf77b5e	wyatt-mason-12	Wyatt Mason
3691	07ac91e9-0269-4e2c-a62d-a87ef61e3bbe	eduardo-perez	Eduardo Perez
3692	41949d4d-b151-4f46-8bf7-73119a48fac8	ron-monstera	Ron Monstera
3693	1af239ae-7e12-42be-9120-feff90453c85	melton-telephone	Melton Telephone
3694	b8ab86c6-9054-4832-9b96-508dbd4eb624	esme-ramsey	Esme Ramsey
3695	a7edbf19-caf6-45dd-83d5-46496c99aa88	rush-valenzuela	Rush Valenzuela
3696	20fd71e7-4fa0-4132-9f47-06a314ed539a	lars-taylor	Lars Taylor
3697	64f59d5f-8740-4ebf-91bd-d7697b542a9f	zeke-wallace	Zeke Wallace
3698	69196296-f652-42ff-b2ca-0d9b50bd9b7b	joshua-butt	Joshua Butt
3699	7007cbd3-7c7b-44fd-9d6b-393e82b1c06e	rafael-davids	Rafael Davids
3700	bfd9ff52-9bf6-4aaf-a859-d308d8f29616	declan-suzanne	Declan Suzanne
3701	c675fcdf-6117-49a6-ac32-99a89a3a88aa	valentine-games	Valentine Games
3702	0d5300f6-0966-430f-903f-a4c2338abf00	lee-davenport	Lee Davenport
3703	81d7d022-19d6-427d-aafc-031fcb79b29e	patty-fox	Patty Fox
3704	061b209a-9cda-44e8-88ce-6a4a37251970	mcdowell-karim	Mcdowell Karim
3705	a8a5cf36-d1a9-47d1-8d22-4a665933a7cc	helga-washington	Helga Washington
3706	4204c2d1-ca48-4af7-b827-e99907f12d61	axel-cardenas	Axel Cardenas
3707	2b157c5c-9a6a-45a6-858f-bf4cf4cbc0bd	ortiz-lopez	Ortiz Lopez
3708	732899a3-2082-4d9f-b1c2-74c8b75e15fb	minato-ito	Minato Ito
3709	678170e4-0688-436d-a02d-c0467f9af8c0	baby-doyle	Baby Doyle
3710	206bd649-4f5f-4707-ad85-92784be4eb95	newton-underbuck	Newton Underbuck
3711	c182f33c-aea5-48a2-97ed-dc74fa29b3c0	swamuel-mora	Swamuel Mora
3712	d0d7b8fe-bad8-481f-978e-cb659304ed49	adalberto-tosser	Adalberto Tosser
3713	8d81b190-d3b8-4cd9-bcec-0e59fdd7f2bc	albert-stink	Albert Stink
3714	54e5f222-fb16-47e0-adf9-21813218dafa	grit-watson	Grit Watson
3715	a647388d-fc59-4c1b-90d3-8c1826e07775	chambers-simmons	Chambers Simmons
3716	4e6ad1a1-7c71-49de-8bd5-c286712faf9e	sutton-picklestein	Sutton Picklestein
3717	8a6fc67d-a7fe-443b-a084-744294cec647	terrell-bradley	Terrell Bradley
3718	8f11ad58-e0b9-465c-9442-f46991274557	amos-melon	Amos Melon
3719	9965eed5-086c-4977-9470-fe410f92d353	bates-bentley	Bates Bentley
3720	cf8e152e-2d27-4dcc-ba2b-68127de4e6a4	hendricks-richardson	Hendricks Richardson
3721	e111a46d-5ada-4311-ac4f-175cca3357da	alexandria-rosales	Alexandria Rosales
3722	17397256-c28c-4cad-85f2-a21768c66e67	cory-ross	Cory Ross
3723	2ae8cbfc-2155-4647-9996-3f2591091baf	forrest-bookbaby	Forrest Bookbaby
3724	718dea1a-d9a8-4c2b-933a-f0667b5250e6	margarito-nava	Margarito Nava
3725	1513aab6-142c-48c6-b43e-fbda65fd64e8	caleb-alvarado	Caleb Alvarado
3726	4e63cb5d-4fce-441b-b9e4-dc6a467cf2fd	axel-campbell	Axel Campbell
3727	db33a54c-3934-478f-bad4-fc313ac2580e	percival-wheeler	Percival Wheeler
3728	32c9bce6-6e52-40fa-9f64-3629b3d026a8	ren-morin	Ren Morin
3729	b019fb2b-9f4b-4deb-bf78-6bee2f16d98d	gloria-bentley	Gloria Bentley
3730	1750de38-8f5f-426a-9e23-2899a15a2031	kline-nightmare	Kline Nightmare
3731	a5f8ce83-02b2-498c-9e48-533a1d81aebf	evelton-mcblase	Evelton McBlase
3732	f70dd57b-55c4-4a62-a5ea-7cc4bf9d8ac1	tillman-henderson	Tillman Henderson
3733	63df8701-1871-4987-87d7-b55d4f1df2e9	wyatt-mason-7	Wyatt Mason
3734	e376a90b-7ffe-47a2-a934-f36d6806f17d	howell-rocha	Howell Rocha
3735	7dcf6902-632f-48c5-936a-7cf88802b93a	parker-parra	Parker Parra
3736	c57222fd-df55-464c-a44e-b15443e61b70	natha-spruce	Natha Spruce
3737	9397ed91-608e-4b13-98ea-e94c795f651e	yeongho-garcia	Yeong-Ho Garcia
3738	960f041a-f795-4001-bd88-5ddcf58ee520	mayra-buckley	Mayra Buckley
3739	9820f2c5-f9da-4a07-b610-c2dd7bee2ef6	peanut-bong	Peanut Bong
3740	97dfc1f6-ac94-4cdc-b0d5-1cb9f8984aa5	brock-forbes	Brock Forbes
3741	bf6a24d1-4e89-4790-a4ba-eeb2870cbf6f	wyatt-mason-10	Wyatt Mason
3742	5e4dfa16-f1b9-400f-b8ef-a1613c2b026a	snyder-briggs	Snyder Briggs
3743	3d3be7b8-1cbf-450d-8503-fce0daf46cbf	zack-sanders	Zack Sanders
3744	a98917bc-e9df-4b0e-bbde-caa6168aa3d7	jenkins-ingram	Jenkins Ingram
3745	667cb445-c288-4e62-b603-27291c1e475d	peanut-holloway	Peanut Holloway
3746	98f26a25-905f-4850-8960-b741b0c583a4	stu-mcdaniel	Stu Mcdaniel
3747	3afb30c1-1b12-466a-968a-5a9a21458c7f	dickerson-greatness	Dickerson Greatness
3748	bc4187fa-459a-4c06-bbf2-4e0e013d27ce	sixpack-dogwalker	Sixpack Dogwalker
3749	906a5728-5454-44a0-adfe-fd8be15b8d9b	jefferson-delacruz	Jefferson Delacruz
3750	413b3ddb-d933-4567-a60e-6d157480239d	winnie-mccall	Winnie Mccall
3751	5703141c-25d9-46d0-b680-0cf9cfbf4777	sandoval-crossing	Sandoval Crossing
3752	d89da2d2-674c-4b85-8959-a4bd406f760a	fish-summer	Fish Summer
3753	db53211c-f841-4f33-accf-0c3e167889a0	travis-bendie	Travis Bendie
3754	a8530be5-8923-4f74-9675-bf8a1a8f7878	mohammed-picklestein	Mohammed Picklestein
3755	b77dffaa-e0f5-408f-b9f2-1894ed26e744	tucker-lenny	Tucker Lenny
3756	495a6bdc-174d-4ad6-8d51-9ee88b1c2e4a	shaquille-torres	Shaquille Torres
3757	80e474a3-7d2b-431d-8192-2f1e27162607	wyatt-mason-15	Wyatt Mason
3758	bd549bfe-b395-4dc0-8546-5c04c08e24a5	sam-solis	Sam Solis
3759	43d5da5f-c6a1-42f1-ab7f-50ea956b6cd5	justice-spoon	Justice Spoon
3760	8ecea7e0-b1fb-4b74-8c8c-3271cb54f659	fitzgerald-blackburn	Fitzgerald Blackburn
3761	ec68845f-3b26-412f-8446-4fef34e09c77	nandy-fantastic	Nandy Fantastic
3762	2e13249e-38ff-46a2-a55e-d15fa692468a	vito-kravitz	Vito Kravitz
3763	93502db3-85fa-4393-acae-2a5ff3980dde	rodriguez-sunshine	Rodriguez Sunshine
3764	9a031b9a-16f8-4165-a468-5d0e28a81151	tiana-wheeler	Tiana Wheeler
3765	c83f0fe0-44d1-4342-81e8-944bb38f8e23	langley-wheeler	Langley Wheeler
3766	16aff709-e855-47c8-8818-b9ba66e90fe8	mullen-peterson	Mullen Peterson
3767	19af0d67-c73b-4ef2-bc84-e923c1336db5	grit-ramos	Grit Ramos
3768	0cc5bd39-e90d-42f9-9dd8-7e703f316436	don-elliott	Don Elliott
3769	ab36c776-b520-429b-a85f-bf633d7b081a	goobie-ballson	Goobie Ballson
3770	bca38809-81de-42ff-94e3-1c0ebfb1e797	famous-oconnor	Famous Oconnor
3771	0bb35615-63f2-4492-80ec-b6b322dc5450	sexton-wheerer	Sexton Wheerer
3772	5a26fc61-d75d-4c01-9ce2-1880ffb5550f	randy-dennis	Randy Dennis
3773	f741dc01-2bae-4459-bfc0-f97536193eea	wyatt-mason-14	Wyatt Mason
3774	7663c3ca-40a1-4f13-a430-14637dce797a	polkadot-zavala	PolkaDot Zavala
3775	f44a8b27-85c1-44de-b129-1b0f60bcb99c	atlas-jonbois	Atlas Jonbois
3776	d8758c1b-afbb-43a5-b00b-6004d419e2c5	ortiz-nelson	Ortiz Nelson
3777	21d52455-6c2c-4ee4-8673-ab46b4b926b4	wyatt-owens	Wyatt Owens
3778	a7b0bef3-ee3c-42d4-9e6d-683cd9f5ed84	haruta-byrd	Haruta Byrd
3779	4fe28bc1-f690-4ad6-ad09-1b2e984bf30b	cell-longarms	Cell Longarms
3780	bd24e18b-800d-4f15-878d-e334fb4803c4	helga-burton	Helga Burton
3781	86adac6f-c694-44ac-9560-758de7eac937	quack-enjoyable	Quack Enjoyable
3782	da0bbbe6-d13c-40cc-9594-8c476975d93d	lang-richardson	Lang Richardson
3783	e4034192-4dc6-4901-bb30-07fe3cf77b5e	baldwin-breadwinner	Baldwin Breadwinner
3784	5b9727f7-6a20-47d2-93d9-779f0a85c4ee	kennedy-alstott	Kennedy Alstott
3785	c0177f76-67fc-4316-b650-894159dede45	paula-mason	Paula Mason
3786	855775c1-266f-40f6-b07b-3a67ccdf8551	nic-winkler	Nic Winkler
3787	1301ee81-406e-43d9-b2bb-55ca6e0f7765	malik-destiny	Malik Destiny
3788	0bb35615-63f2-4492-80ec-b6b322dc5450	wyatt-mason-2	Wyatt Mason
3789	a7d8196a-ca6b-4dab-a9d7-c27f3e86cc21	commissioner-vapor	Commissioner Vapor
3790	efa73de4-af17-4f88-99d6-d0d69ed1d200	antonio-mccall	Antonio Mccall
3791	472f50c0-ef98-4d05-91d0-d6359eec3946	rhys-trombone	Rhys Trombone
3792	fbb5291c-2438-400e-ab32-30ce1259c600	cory-novak	Cory Novak
3793	26cfccf2-850e-43eb-b085-ff73ad0749b8	beasley-day	Beasley Day
3794	aa7ac9cb-e9db-4313-9941-9f3431728dce	matteo-cash	Matteo Cash
3795	f245f6c6-4613-40f5-bc3b-85aa9ee3cf7e	usurper-violet	Usurper Violet
3796	f9930cb1-7ed2-4b9a-bf4f-7e35f2586d71	finn-james	Finn James
3797	ff5a37d9-a6dd-49aa-b6fb-b935fd670820	dunn-keyes	Dunn Keyes
3798	63df8701-1871-4987-87d7-b55d4f1df2e9	mcdowell-mason	Mcdowell Mason
3799	3be2c730-b351-43f7-a832-a5294fe8468f	amaya-jackson	Amaya Jackson
3800	7853aa8c-e86d-4483-927d-c1d14ea3a34d	tucker-flores	Tucker Flores
3801	8cf78b49-d0ca-4703-88e8-4bcad26c44b1	avila-guzman	Avila Guzman
3802	805ba480-df4d-4f56-a4cf-0b99959111b5	leticia-lozano	Leticia Lozano
3803	31f83a89-44e3-47b7-8c9e-0dfdcd8bd30f	tyreek-olive	Tyreek Olive
3804	8ba7e1ff-4c6d-4963-8e0f-7096d14f4b12	jenna-maldonado	Jenna Maldonado
3805	a071a713-a6a1-4b4c-bb3f-45d9fba7a08c	nora-perez	Nora Perez
3806	bc4187fa-459a-4c06-bbf2-4e0e013d27ce	sixpack-dogwalker-deprecated	Sixpack Dogwalker
3807	c6a19154-7438-4c4f-b786-2dfaf5951f0f	silvaire-roadhouse	Silvaire Roadhouse
3808	ef32eb48-4866-49d0-ae58-9c4982e01142	fitzgerald-massey	Fitzgerald Massey
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
-- Data for Name: team_abbreviations; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.team_abbreviations (team_abbreviation_id, team_abbreviation, team_id) FROM stdin;
1	CRAB	8d87c468-699a-47a8-b40d-cfb73a5660ad
2	BOS	3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e
3	JAZZ	a37f9158-7f82-46bc-908c-c9e2dda7c33b
4	CAN	eb67ae5e-c4bf-46ca-bbbc-425cd34182ff
5	CHST	bfd38797-8404-4b38-8b82-341da28b1f83
6	CHI	ca3f1c8c-c025-4d8e-8eef-5be6accbeb16
7	STK	b024e975-1c4a-4575-8936-a3754a08806a
8	TGRS	747b8e4a-7e50-4638-a973-ea7950a3e739
9	FRI	979aee4a-6d80-4863-bf1c-ee1a78e06024
10	HELL	f02aeae2-5e6a-4098-9842-02d2273f25c7
11	SPY	9debc64f-74b7-4ae1-a4d6-fce0144b6ea5
12	KCBM	adc5b394-8f76-416d-9ce9-813706877b84
13	CDMX	57ec08cc-0411-4643-b304-0e80dbc15ac7
14	DALE	b63be8c2-576a-4d6e-8daf-814f8bcea96f
15	NYM	36569151-a2fb-43c1-9df7-2df512424c82
16	PIES	23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7
17	LVRS	b72f3061-f573-40d7-832a-5ad475bd7909
18	SEA	105bc3ff-1320-4e37-8ef0-8d595cb95dd0
19	LIFT	c73b705c-40ad-4633-a6ed-d357ee2e2bcf
20	TACO	878c1bf6-0d21-4659-bfee-916c8314d69c
21	YELL	7966eb04-efcc-499b-8f03-d13916330531
22	PODS	40b9ec2a-cb43-4dbb-b836-5accb62e7c20
23	STAR	c6c01051-cdd4-47d6-8a98-bb5b754f937f
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
60	ca3f1c8c-c025-4d8e-8eef-5be6accbeb16	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	1
61	a37f9158-7f82-46bc-908c-c9e2dda7c33b	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	2
62	b63be8c2-576a-4d6e-8daf-814f8bcea96f	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	3
63	979aee4a-6d80-4863-bf1c-ee1a78e06024	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	4
64	bfd38797-8404-4b38-8b82-341da28b1f83	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	5
65	b72f3061-f573-40d7-832a-5ad475bd7909	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	6
66	23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	7
67	747b8e4a-7e50-4638-a973-ea7950a3e739	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	8
68	105bc3ff-1320-4e37-8ef0-8d595cb95dd0	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	9
69	f02aeae2-5e6a-4098-9842-02d2273f25c7	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	10
70	36569151-a2fb-43c1-9df7-2df512424c82	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	11
71	9debc64f-74b7-4ae1-a4d6-fce0144b6ea5	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	12
72	adc5b394-8f76-416d-9ce9-813706877b84	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	13
73	7966eb04-efcc-499b-8f03-d13916330531	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	14
74	b024e975-1c4a-4575-8936-a3754a08806a	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	15
75	8d87c468-699a-47a8-b40d-cfb73a5660ad	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	16
76	57ec08cc-0411-4643-b304-0e80dbc15ac7	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	17
77	3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	18
78	eb67ae5e-c4bf-46ca-bbbc-425cd34182ff	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	19
79	878c1bf6-0d21-4659-bfee-916c8314d69c	2020-09-14 07:59:00	2020-09-26 10:29:31.561294	20
80	878c1bf6-0d21-4659-bfee-916c8314d69c	2020-09-26 10:30:06.338053	\N	1
81	b72f3061-f573-40d7-832a-5ad475bd7909	2020-09-26 10:30:06.344018	\N	2
82	979aee4a-6d80-4863-bf1c-ee1a78e06024	2020-09-26 10:30:06.354634	\N	3
83	bfd38797-8404-4b38-8b82-341da28b1f83	2020-09-26 10:30:06.360136	\N	4
84	adc5b394-8f76-416d-9ce9-813706877b84	2020-09-26 10:30:06.3678	\N	5
85	747b8e4a-7e50-4638-a973-ea7950a3e739	2020-09-26 10:30:06.372765	\N	6
86	7966eb04-efcc-499b-8f03-d13916330531	2020-09-26 10:30:06.37793	\N	7
87	a37f9158-7f82-46bc-908c-c9e2dda7c33b	2020-09-26 10:30:06.386655	\N	8
88	23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7	2020-09-26 10:30:06.393127	\N	9
89	f02aeae2-5e6a-4098-9842-02d2273f25c7	2020-09-26 10:30:06.401098	\N	10
90	b63be8c2-576a-4d6e-8daf-814f8bcea96f	2020-09-26 10:30:06.406416	\N	11
91	36569151-a2fb-43c1-9df7-2df512424c82	2020-09-26 10:30:06.412655	\N	12
92	eb67ae5e-c4bf-46ca-bbbc-425cd34182ff	2020-09-26 10:30:06.419253	\N	13
93	3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e	2020-09-26 10:30:06.424344	\N	14
94	b024e975-1c4a-4575-8936-a3754a08806a	2020-09-26 10:30:06.43123	\N	15
95	105bc3ff-1320-4e37-8ef0-8d595cb95dd0	2020-09-26 10:30:06.438918	\N	16
96	ca3f1c8c-c025-4d8e-8eef-5be6accbeb16	2020-09-26 10:30:06.444359	\N	17
97	8d87c468-699a-47a8-b40d-cfb73a5660ad	2020-09-26 10:30:06.451267	\N	18
98	57ec08cc-0411-4643-b304-0e80dbc15ac7	2020-09-26 10:30:06.456357	\N	19
99	9debc64f-74b7-4ae1-a4d6-fce0144b6ea5	2020-09-26 10:30:06.46395	\N	20
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
14	Black Hole
1	Sun 2
\.


--
-- Name: applied_patches_patch_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.applied_patches_patch_id_seq', 2, true);


--
-- Name: chronicler_hash_game_event_chronicler_hash_game_event_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.chronicler_hash_game_event_chronicler_hash_game_event_id_seq', 11092890, true);


--
-- Name: game_event_base_runners_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.game_event_base_runners_id_seq', 10887492, true);


--
-- Name: game_events_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.game_events_id_seq', 5581589, true);


--
-- Name: imported_logs_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.imported_logs_id_seq', 34207, true);


--
-- Name: player_events_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.player_events_id_seq', 69670, true);


--
-- Name: player_modifications_player_modifications_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.player_modifications_player_modifications_id_seq', 6394, true);


--
-- Name: players_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.players_id_seq', 109109, true);


--
-- Name: team_modifications_team_modifications_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.team_modifications_team_modifications_id_seq', 1313, true);


--
-- Name: team_positions_team_position_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.team_positions_team_position_id_seq', 24513, true);


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.teams_id_seq', 880, true);


--
-- Name: time_map_time_map_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--

SELECT pg_catalog.setval('data.time_map_time_map_id_seq', 12664637, true);


--
-- Name: attributes_attribute_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.attributes_attribute_id_seq', 64, true);


--
-- Name: division_teams_division_teams_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.division_teams_division_teams_id_seq', 49, true);


--
-- Name: divisions_division_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.divisions_division_id_seq', 8, true);


--
-- Name: event_types_event_type_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.event_types_event_type_id_seq', 282, true);


--
-- Name: leagues_league_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.leagues_league_id_seq', 4, true);


--
-- Name: modifications_modification_db_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.modifications_modification_db_id_seq', 80, true);


--
-- Name: player_url_slugs_player_url_slug_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.player_url_slugs_player_url_slug_id_seq', 3808, true);


--
-- Name: team_abbreviations_team_abbreviation_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.team_abbreviations_team_abbreviation_id_seq', 23, true);


--
-- Name: team_divine_favor_team_divine_favor_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.team_divine_favor_team_divine_favor_id_seq', 99, true);


--
-- Name: vibe_to_arrows_vibe_to_arrow_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.vibe_to_arrows_vibe_to_arrow_id_seq', 13, true);


--
-- Name: applied_patches applied_patches_pkey; Type: CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.applied_patches
    ADD CONSTRAINT applied_patches_pkey PRIMARY KEY (patch_id);


--
-- Name: chronicler_hash_game_event chronicler_hash_game_event_pkey; Type: CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.chronicler_hash_game_event
    ADD CONSTRAINT chronicler_hash_game_event_pkey PRIMARY KEY (chronicler_hash_game_event_id);


--
-- Name: chronicler_meta chronicler_meta_pk; Type: CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.chronicler_meta
    ADD CONSTRAINT chronicler_meta_pk PRIMARY KEY (id);


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
-- Name: game_events no_dupes; Type: CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.game_events
    ADD CONSTRAINT no_dupes UNIQUE (game_id, event_index);


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
    ADD CONSTRAINT season_day_unique UNIQUE (season, day, phase_id);


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
-- Name: card card_pkey; Type: CONSTRAINT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.card
    ADD CONSTRAINT card_pkey PRIMARY KEY (card_id);


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
-- Name: batting_stats_all_events_indx_player_id; Type: INDEX; Schema: data; Owner: -
--

CREATE INDEX batting_stats_all_events_indx_player_id ON data.batting_stats_all_events USING btree (player_id);


--
-- Name: batting_stats_all_events_indx_season; Type: INDEX; Schema: data; Owner: -
--

CREATE INDEX batting_stats_all_events_indx_season ON data.batting_stats_all_events USING btree (season);


--
-- Name: chronicler_hash_game_event_indx_game_event_id; Type: INDEX; Schema: data; Owner: -
--

CREATE INDEX chronicler_hash_game_event_indx_game_event_id ON data.chronicler_hash_game_event USING btree (game_event_id);


--
-- Name: game_events_indx_event_type; Type: INDEX; Schema: data; Owner: -
--

CREATE INDEX game_events_indx_event_type ON data.game_events USING btree (event_type);


--
-- Name: game_events_indx_game_id; Type: INDEX; Schema: data; Owner: -
--

CREATE INDEX game_events_indx_game_id ON data.game_events USING btree (game_id);


--
-- Name: running_stats_all_events_indx_player_id; Type: INDEX; Schema: data; Owner: -
--

CREATE INDEX running_stats_all_events_indx_player_id ON data.running_stats_all_events USING btree (player_id);


--
-- Name: team_roster_idx; Type: INDEX; Schema: data; Owner: -
--

CREATE INDEX team_roster_idx ON data.team_roster USING btree (valid_until NULLS FIRST, team_id, position_id, position_type_id) INCLUDE (team_id, position_id, valid_until, position_type_id);


--
-- Name: players player_insert; Type: TRIGGER; Schema: data; Owner: -
--

CREATE TRIGGER player_insert BEFORE INSERT ON data.players FOR EACH ROW EXECUTE FUNCTION data.player_slug_creation();


--
-- Name: teams team_insert; Type: TRIGGER; Schema: data; Owner: -
--

CREATE TRIGGER team_insert BEFORE INSERT ON data.teams FOR EACH ROW EXECUTE FUNCTION data.team_slug_creation();


--
-- Name: chronicler_hash_game_event chronicler_hash_game_event_game_event_id_fkey; Type: FK CONSTRAINT; Schema: data; Owner: -
--

ALTER TABLE ONLY data.chronicler_hash_game_event
    ADD CONSTRAINT chronicler_hash_game_event_game_event_id_fkey FOREIGN KEY (game_event_id) REFERENCES data.game_events(id) ON DELETE CASCADE;


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
-- Name: batting_stats_all_events; Type: MATERIALIZED VIEW DATA; Schema: data; Owner: -
--

REFRESH MATERIALIZED VIEW data.batting_stats_all_events;


--
-- Name: players_info_expanded_all; Type: MATERIALIZED VIEW DATA; Schema: data; Owner: -
--

REFRESH MATERIALIZED VIEW data.players_info_expanded_all;


--
-- Name: batting_stats_player_single_game; Type: MATERIALIZED VIEW DATA; Schema: data; Owner: -
--

REFRESH MATERIALIZED VIEW data.batting_stats_player_single_game;


--
-- Name: fielder_stats_all_events; Type: MATERIALIZED VIEW DATA; Schema: data; Owner: -
--

REFRESH MATERIALIZED VIEW data.fielder_stats_all_events;


--
-- Name: pitching_stats_all_appearances; Type: MATERIALIZED VIEW DATA; Schema: data; Owner: -
--

REFRESH MATERIALIZED VIEW data.pitching_stats_all_appearances;


--
-- Name: running_stats_all_events; Type: MATERIALIZED VIEW DATA; Schema: data; Owner: -
--

REFRESH MATERIALIZED VIEW data.running_stats_all_events;


--
-- PostgreSQL database dump complete
--

