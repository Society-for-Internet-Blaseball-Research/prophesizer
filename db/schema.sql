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

ALTER TABLE IF EXISTS ONLY public.player_events DROP CONSTRAINT IF EXISTS player_events_game_event_id_fkey;
ALTER TABLE IF EXISTS ONLY public.game_event_base_runners DROP CONSTRAINT IF EXISTS game_event_base_runners_game_event_id_fkey;
ALTER TABLE IF EXISTS ONLY taxa.event_types DROP CONSTRAINT IF EXISTS event_types_pkey;
ALTER TABLE IF EXISTS ONLY public.time_map DROP CONSTRAINT IF EXISTS time_map_pkey;
ALTER TABLE IF EXISTS ONLY public.teams DROP CONSTRAINT IF EXISTS teams_pkey;
ALTER TABLE IF EXISTS ONLY public.time_map DROP CONSTRAINT IF EXISTS season_day_unique;
ALTER TABLE IF EXISTS ONLY public.players DROP CONSTRAINT IF EXISTS players_pkey;
ALTER TABLE IF EXISTS ONLY public.player_events DROP CONSTRAINT IF EXISTS player_events_pkey;
ALTER TABLE IF EXISTS ONLY public.imported_logs DROP CONSTRAINT IF EXISTS imported_logs_pkey;
ALTER TABLE IF EXISTS ONLY public.games DROP CONSTRAINT IF EXISTS game_pkey;
ALTER TABLE IF EXISTS ONLY public.game_events DROP CONSTRAINT IF EXISTS game_events_pkey;
ALTER TABLE IF EXISTS ONLY public.game_event_base_runners DROP CONSTRAINT IF EXISTS game_event_base_runners_pkey;
ALTER TABLE IF EXISTS taxa.vibe_to_arrows ALTER COLUMN vibe_to_arrow_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.modifications ALTER COLUMN modification_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.leagues ALTER COLUMN league_db_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.event_types ALTER COLUMN event_type_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.divisions ALTER COLUMN division_db_id DROP DEFAULT;
ALTER TABLE IF EXISTS taxa.attributes ALTER COLUMN attribute_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.time_map ALTER COLUMN time_map_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.teams ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.team_roster ALTER COLUMN team_roster_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.players ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.player_events ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.imported_logs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.game_events ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.game_event_base_runners ALTER COLUMN id DROP DEFAULT;
DROP TABLE IF EXISTS taxa.weather;
DROP SEQUENCE IF EXISTS taxa.vibe_to_arrows_vibe_to_arrow_id_seq;
DROP TABLE IF EXISTS taxa.vibe_to_arrows;
DROP TABLE IF EXISTS taxa.player_fk_attributes;
DROP SEQUENCE IF EXISTS taxa.modifications_modification_id_seq;
DROP TABLE IF EXISTS taxa.modifications;
DROP SEQUENCE IF EXISTS taxa.leagues_league_id_seq;
DROP TABLE IF EXISTS taxa.leagues;
DROP SEQUENCE IF EXISTS taxa.event_types_event_type_id_seq;
DROP SEQUENCE IF EXISTS taxa.divisions_division_id_seq;
DROP TABLE IF EXISTS taxa.divisions;
DROP TABLE IF EXISTS taxa.coffee;
DROP TABLE IF EXISTS taxa.blood;
DROP SEQUENCE IF EXISTS taxa.attributes_attribute_id_seq;
DROP TABLE IF EXISTS taxa.attributes;
DROP SEQUENCE IF EXISTS public.time_map_time_map_id_seq;
DROP TABLE IF EXISTS public.time_map;
DROP SEQUENCE IF EXISTS public.teams_id_seq;
DROP SEQUENCE IF EXISTS public.team_positions_team_position_id_seq;
DROP VIEW IF EXISTS public.season_leaders_outs_defended;
DROP VIEW IF EXISTS public.season_leaders_on_base_slugging;
DROP VIEW IF EXISTS public.season_leaders_slugging;
DROP VIEW IF EXISTS public.season_leaders_on_base_perecentage;
DROP VIEW IF EXISTS public.season_leaders_batting_average_risp;
DROP VIEW IF EXISTS public.season_leaders_batting_average;
DROP TABLE IF EXISTS taxa.event_types;
DROP TABLE IF EXISTS public.teams;
DROP TABLE IF EXISTS public.team_roster;
DROP SEQUENCE IF EXISTS public.players_id_seq;
DROP TABLE IF EXISTS public.players;
DROP TABLE IF EXISTS public.player_idols;
DROP SEQUENCE IF EXISTS public.player_events_id_seq;
DROP TABLE IF EXISTS public.player_events;
DROP SEQUENCE IF EXISTS public.imported_logs_id_seq;
DROP TABLE IF EXISTS public.imported_logs;
DROP TABLE IF EXISTS public.games;
DROP SEQUENCE IF EXISTS public.game_events_id_seq;
DROP TABLE IF EXISTS public.game_events;
DROP SEQUENCE IF EXISTS public.game_event_base_runners_id_seq;
DROP TABLE IF EXISTS public.game_event_base_runners;
DROP PROCEDURE IF EXISTS public.wipe_hourly();
DROP PROCEDURE IF EXISTS public.wipe_events();
DROP PROCEDURE IF EXISTS public.wipe_all();
DROP FUNCTION IF EXISTS public.timestamp_to_gameday(in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS public.team_from_timestamp(in_team_id character varying, in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS public.team_from_gameday(in_team_id character varying, in_season integer, in_gameday integer);
DROP FUNCTION IF EXISTS public.season_timespan(in_season integer);
DROP FUNCTION IF EXISTS public.round_half_even(val numeric, prec integer);
DROP FUNCTION IF EXISTS public.rating_to_star(in_rating numeric);
DROP FUNCTION IF EXISTS public.player_from_timestamp(in_player_id character varying, in_timestamp timestamp without time zone);
DROP FUNCTION IF EXISTS public.player_from_gameday(in_player_id character varying, in_season integer, in_gameday integer);
DROP FUNCTION IF EXISTS public.player_day_vibe(in_player_id character varying, in_gameday integer, valid_until timestamp without time zone);
DROP FUNCTION IF EXISTS public.pitching_rating(in_player_id character varying, valid_until timestamp without time zone);
DROP FUNCTION IF EXISTS public.last_position(in_string text, in_search text);
DROP FUNCTION IF EXISTS public.get_player_star_ratings(in_player_id character varying, valid_until timestamp without time zone);
DROP FUNCTION IF EXISTS public.defense_rating(in_player_id character varying, valid_until timestamp without time zone);
DROP FUNCTION IF EXISTS public.current_season();
DROP FUNCTION IF EXISTS public.batting_rating(in_player_id character varying, valid_until timestamp without time zone);
DROP FUNCTION IF EXISTS public.baserunning_rating(in_player_id character varying, valid_until timestamp without time zone);
DROP FUNCTION IF EXISTS public.bankers_round(in_val numeric, in_prec integer);
DROP SCHEMA IF EXISTS taxa;
DROP SCHEMA IF EXISTS public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: taxa; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA taxa;


--
-- Name: bankers_round(numeric, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.bankers_round(in_val numeric, in_prec integer) RETURNS numeric
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
-- Name: baserunning_rating(character varying, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.baserunning_rating(in_player_id character varying, valid_until timestamp without time zone DEFAULT NULL::timestamp without time zone) RETURNS numeric
    LANGUAGE sql
    AS $$

SELECT 

	power(p.laserlikeness,0.5) *

   	power(p.continuation * p.base_thirst * p.indulgence * p.ground_friction, 0.1)

FROM players p

WHERE 

--player_name = 'Jessica Telephone'

player_id = in_player_id

AND coalesce(valid_until::text,'') = '';

$$;


--
-- Name: batting_rating(character varying, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.batting_rating(in_player_id character varying, valid_until timestamp without time zone DEFAULT NULL::timestamp without time zone) RETURNS numeric
    LANGUAGE sql
    AS $$

SELECT 

power((1 - p.tragicness),0.01) * 

	power((1 - p.patheticism),0.05) *

   power((p.thwackability * p.divinity),0.35) *

   power((p.moxie * p.musclitude),0.075) * 

	power(p.martyrdom,0.02)

FROM players p

WHERE 

--player_name = 'Jessica Telephone'

player_id = in_player_id

AND coalesce(valid_until::text,'') = '';

$$;


--
-- Name: current_season(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.current_season() RETURNS integer
    LANGUAGE sql
    AS $$

SELECT max(season) from games;

$$;


--
-- Name: defense_rating(character varying, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.defense_rating(in_player_id character varying, valid_until timestamp without time zone DEFAULT NULL::timestamp without time zone) RETURNS numeric
    LANGUAGE sql
    AS $$

SELECT 

	power((p.omniscience * p.tenaciousness),0.2) *

   	power((p.watchfulness * p.anticapitalism * p.chasiness),0.1)

FROM players p

WHERE 

--player_name = 'Jessica Telephone'

player_id = in_player_id

AND coalesce(valid_until::text,'') = '';

$$;


--
-- Name: get_player_star_ratings(character varying, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_player_star_ratings(in_player_id character varying, valid_until timestamp without time zone DEFAULT NULL::timestamp without time zone) RETURNS TABLE(baserunning_rating numeric, batting_rating numeric, defense_rating numeric, pitching_rating numeric)
    LANGUAGE sql
    AS $$

SELECT 



0.5 * round_half_even(( 

(

	power(p.laserlikeness,0.5) *

   power(p.continuation * p.base_thirst * p.indulgence * p.ground_friction, 0.1)

) * 10),0) AS baserunner_rating,



0.5 * round_half_even((

( 

	power((1 - p.tragicness),0.01) * 

	power((1 - p.patheticism),0.05) *

   power((p.thwackability * p.divinity),0.35) *

   power((p.moxie * p.musclitude),0.075) * 

	power(p.martyrdom,0.02)

) * 10),0) AS batter_rating,



0.5 * round_half_even((

(

	power((p.omniscience * p.tenaciousness),0.2) *

   power((p.watchfulness * p.anticapitalism * p.chasiness),0.1)

) * 10),0) AS defense_rating,



0.5 * round_half_even((

(

	power(p.unthwackability,0.5) * 

	power(p.ruthlessness,0.4) *

   power(p.overpowerment,0.15) * 

	power(p.shakespearianism,0.1) * 

	power(p.coldness,0.025)

) * 10),0) AS pitching_rating



FROM players p

WHERE 

--player_name = 'Jessica Telephone'

player_id = in_player_id

AND coalesce(valid_until::text,'') = '';

$$;


--
-- Name: last_position(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.last_position(in_string text, in_search text) RETURNS integer
    LANGUAGE sql
    AS $$ 

Select length(in_string) - 
position(reverse(in_search) in reverse(in_string)) - length(in_search); 

$$;


--
-- Name: pitching_rating(character varying, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.pitching_rating(in_player_id character varying, valid_until timestamp without time zone DEFAULT NULL::timestamp without time zone) RETURNS numeric
    LANGUAGE sql
    AS $$

SELECT 

	power(p.unthwackability,0.5) * 

	power(p.ruthlessness,0.4) *

   	power(p.overpowerment,0.15) * 

	power(p.shakespearianism,0.1) * 

	power(p.coldness,0.025)

FROM players p

WHERE 

--player_name = 'Jessica Telephone'

player_id = in_player_id

AND coalesce(valid_until::text,'') = '';

$$;


--
-- Name: player_day_vibe(character varying, integer, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.player_day_vibe(in_player_id character varying, in_gameday integer DEFAULT 0, valid_until timestamp without time zone DEFAULT NULL::timestamp without time zone) RETURNS numeric
    LANGUAGE sql
    AS $$
SELECT 
(0.5 * (p.pressurization + p.cinnamon) * sin(PI() * 
	(2 / (6 + round(10 * p.buoyancy)) * in_gameday + .5)) - .5 
    * p.pressurization + .5 * p.cinnamon)::numeric
FROM players p
WHERE 
--player_name = 'Jessica Telephone'
player_id = in_player_id
AND coalesce(valid_until::text,'') = '';
$$;


--
-- Name: player_from_gameday(character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.player_from_gameday(in_player_id character varying, in_season integer, in_gameday integer) RETURNS integer
    LANGUAGE sql
    AS $$
	SELECT min(id)
	FROM players
	WHERE player_id = in_player_id
	AND valid_until >
	(
		SELECT first_time
		FROM time_map
		WHERE season = in_season
		AND DAY = in_gameday
	)

$$;


--
-- Name: player_from_timestamp(character varying, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.player_from_timestamp(in_player_id character varying, in_timestamp timestamp without time zone) RETURNS integer
    LANGUAGE sql
    AS $$
	SELECT min(id)
	FROM players
	WHERE player_id = in_player_id
	AND valid_until > in_timestamp

$$;


--
-- Name: rating_to_star(numeric); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.rating_to_star(in_rating numeric) RETURNS numeric
    LANGUAGE sql
    AS $$

SELECT 0.5 * round_half_even((

(in_rating)* 10),0);

$$;


--
-- Name: round_half_even(numeric, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.round_half_even(val numeric, prec integer) RETURNS numeric
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
-- Name: season_timespan(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.season_timespan(in_season integer) RETURNS TABLE(season_start timestamp without time zone, season_end timestamp without time zone)
    LANGUAGE sql
    AS $$
SELECT
(
	SELECT first_time FROM time_map WHERE DAY = 0 AND season = in_season
) AS season_start,
COALESCE
(
	(
		SELECT first_time - INTERVAL '1 SECOND' FROM time_map WHERE DAY = 0 AND season = 
		(in_season + 1)
	), NOW()::timestamp
) AS season_end
$$;


--
-- Name: team_from_gameday(character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.team_from_gameday(in_team_id character varying, in_season integer, in_gameday integer) RETURNS integer
    LANGUAGE sql
    AS $$
	SELECT min(id)
	FROM teams
	WHERE team_id = team_id
	AND valid_until >
	(
		SELECT first_time
		FROM time_map
		WHERE season = in_season
		AND DAY = in_gameday
	)

$$;


--
-- Name: team_from_timestamp(character varying, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.team_from_timestamp(in_team_id character varying, in_timestamp timestamp without time zone) RETURNS integer
    LANGUAGE sql
    AS $$
	SELECT min(id)
	FROM teams
	WHERE team_id = in_team_id
	AND valid_until > in_timestamp

$$;


--
-- Name: timestamp_to_gameday(timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.timestamp_to_gameday(in_timestamp timestamp without time zone) RETURNS TABLE(season integer, gameday integer)
    LANGUAGE sql
    AS $$
SELECT season, day
FROM time_map
WHERE first_time =
(
	SELECT max(first_time) FROM time_map WHERE first_time < in_timestamp
)
$$;


--
-- Name: wipe_all(); Type: PROCEDURE; Schema: public; Owner: -
--

CREATE PROCEDURE public.wipe_all()
    LANGUAGE plpgsql
    AS $$begin
call wipe_events();
call wipe_hourly();
end;$$;


--
-- Name: wipe_events(); Type: PROCEDURE; Schema: public; Owner: -
--

CREATE PROCEDURE public.wipe_events()
    LANGUAGE plpgsql
    AS $$begin
truncate game_events cascade;
delete from imported_logs where key like 'blaseball-log%';
truncate time_map;
end;$$;


--
-- Name: wipe_hourly(); Type: PROCEDURE; Schema: public; Owner: -
--

CREATE PROCEDURE public.wipe_hourly()
    LANGUAGE plpgsql
    AS $$begin
delete from imported_logs where key like 'compressed-hourly%';
truncate players cascade;
truncate teams cascade;
truncate games cascade;
truncate team_roster cascade;
end;$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: game_event_base_runners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.game_event_base_runners (
    id integer NOT NULL,
    game_event_id integer,
    runner_id character varying(36),
    responsible_pitcher_id character varying(36),
    base_before_play integer,
    base_after_play integer,
    was_base_stolen boolean,
    was_caught_stealing boolean,
    was_picked_off boolean
);


--
-- Name: game_event_base_runners_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.game_event_base_runners_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: game_event_base_runners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.game_event_base_runners_id_seq OWNED BY public.game_event_base_runners.id;


--
-- Name: game_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.game_events (
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
-- Name: game_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.game_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: game_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.game_events_id_seq OWNED BY public.game_events.id;


--
-- Name: games; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.games (
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
-- Name: imported_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.imported_logs (
    id integer NOT NULL,
    key text,
    imported_at timestamp without time zone
);


--
-- Name: imported_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.imported_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: imported_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.imported_logs_id_seq OWNED BY public.imported_logs.id;


--
-- Name: player_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.player_events (
    id integer NOT NULL,
    game_event_id integer,
    player_id character varying(36),
    event_type text
);


--
-- Name: player_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.player_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: player_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.player_events_id_seq OWNED BY public.player_events.id;


--
-- Name: player_idols; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.player_idols (
    player_idol_id bigint,
    instance_id text,
    player_id text,
    idol_count integer,
    valid_from timestamp without time zone,
    valid_until timestamp without time zone
);


--
-- Name: players; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.players (
    id integer NOT NULL,
    player_id character varying(36),
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
    blood smallint
);


--
-- Name: players_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.players_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.players_id_seq OWNED BY public.players.id;


--
-- Name: team_roster; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.team_roster (
    team_roster_id integer NOT NULL,
    team_id character varying,
    position_id integer,
    valid_until timestamp without time zone,
    player_id character varying
);


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams (
    id integer NOT NULL,
    team_id character varying(36),
    location text,
    nickname text,
    full_name text,
    valid_until timestamp without time zone,
    hash uuid
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
    total_bases integer
);


--
-- Name: season_leaders_batting_average; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.season_leaders_batting_average AS
 SELECT p.player_id,
    p.player_name,
    t.nickname,
    rank() OVER (ORDER BY ((((sum(et.hit))::numeric / ((sum(et.at_bat) - sum(
        CASE
            WHEN (ge.is_sacrifice_hit OR ge.is_sacrifice_fly) THEN 1
            ELSE 0
        END)))::numeric))::numeric(10,3)) DESC) AS rank,
    (sum(et.at_bat) - sum(
        CASE
            WHEN (ge.is_sacrifice_hit OR ge.is_sacrifice_fly) THEN 1
            ELSE 0
        END)) AS at_bats,
    sum(et.hit) AS hits,
    (((sum(et.hit))::numeric / ((sum(et.at_bat) - sum(
        CASE
            WHEN (ge.is_sacrifice_hit OR ge.is_sacrifice_fly) THEN 1
            ELSE 0
        END)))::numeric))::numeric(10,3) AS batting_average
   FROM ((((public.game_events ge
     JOIN taxa.event_types et ON ((ge.event_type = et.event_type)))
     JOIN public.players p ON ((((ge.batter_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
     JOIN public.team_roster tp ON ((((p.player_id)::text = (tp.player_id)::text) AND (tp.valid_until IS NULL))))
     JOIN public.teams t ON (((tp.team_id)::text = (t.team_id)::text)))
  WHERE (ge.season = ( SELECT public.current_season() AS current_season))
  GROUP BY p.player_id, p.player_name, t.nickname
  ORDER BY ((((sum(et.hit))::numeric / ((sum(et.at_bat) - sum(
        CASE
            WHEN (ge.is_sacrifice_hit OR ge.is_sacrifice_fly) THEN 1
            ELSE 0
        END)))::numeric))::numeric(10,3)) DESC, p.player_name;


--
-- Name: season_leaders_batting_average_risp; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.season_leaders_batting_average_risp AS
 SELECT p.player_id,
    p.player_name,
    t.nickname,
    rank() OVER (ORDER BY ((((sum(et.hit))::numeric / ((sum(et.at_bat) - sum(
        CASE
            WHEN (ge.is_sacrifice_hit OR ge.is_sacrifice_fly) THEN 1
            ELSE 0
        END)))::numeric))::numeric(10,3)) DESC) AS rank,
    (sum(et.at_bat) - sum(
        CASE
            WHEN (ge.is_sacrifice_hit OR ge.is_sacrifice_fly) THEN 1
            ELSE 0
        END)) AS at_bats,
    sum(et.hit) AS hits,
    (((sum(et.hit))::numeric / ((sum(et.at_bat) - sum(
        CASE
            WHEN (ge.is_sacrifice_hit OR ge.is_sacrifice_fly) THEN 1
            ELSE 0
        END)))::numeric))::numeric(10,3) AS risp
   FROM (((((public.game_events ge
     JOIN ( SELECT array_agg(game_event_base_runners.base_before_play ORDER BY game_event_base_runners.base_before_play) AS baserunners,
            game_event_base_runners.game_event_id
           FROM public.game_event_base_runners
          GROUP BY game_event_base_runners.game_event_id
         HAVING ((2 = ANY (array_agg(game_event_base_runners.base_before_play))) OR (3 = ANY (array_agg(game_event_base_runners.base_before_play))))) br ON ((ge.id = br.game_event_id)))
     JOIN taxa.event_types et ON ((ge.event_type = et.event_type)))
     JOIN public.players p ON ((((ge.batter_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
     JOIN public.team_roster tp ON ((((p.player_id)::text = (tp.player_id)::text) AND (tp.valid_until IS NULL))))
     JOIN public.teams t ON (((tp.team_id)::text = (t.team_id)::text)))
  WHERE (ge.season = ( SELECT public.current_season() AS current_season))
  GROUP BY p.player_id, p.player_name, t.nickname
  ORDER BY ((((sum(et.hit))::numeric / ((sum(et.at_bat) - sum(
        CASE
            WHEN (ge.is_sacrifice_hit OR ge.is_sacrifice_fly) THEN 1
            ELSE 0
        END)))::numeric))::numeric(10,3)) DESC, p.player_name;


--
-- Name: season_leaders_on_base_perecentage; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.season_leaders_on_base_perecentage AS
 SELECT p.player_id,
    p.player_name,
    t.nickname,
    rank() OVER (ORDER BY (((((sum(et.hit) + sum(
        CASE
            WHEN (ge.event_type = 'WALK'::text) THEN 1
            ELSE 0
        END)))::numeric / (((sum(et.at_bat) + sum(
        CASE
            WHEN (ge.event_type = 'WALK'::text) THEN 1
            ELSE 0
        END)) - sum(
        CASE
            WHEN (ge.is_sacrifice_hit OR ge.is_sacrifice_fly) THEN 1
            ELSE 0
        END)))::numeric))::numeric(10,3)) DESC) AS rank,
    sum(
        CASE
            WHEN (ge.event_type = 'WALK'::text) THEN 1
            ELSE 0
        END) AS walks,
    (sum(et.at_bat) - sum(
        CASE
            WHEN (ge.is_sacrifice_hit OR ge.is_sacrifice_fly) THEN 1
            ELSE 0
        END)) AS at_bats,
    sum(et.hit) AS hits,
    ((((sum(et.hit) + sum(
        CASE
            WHEN (ge.event_type = 'WALK'::text) THEN 1
            ELSE 0
        END)))::numeric / (((sum(et.at_bat) + sum(
        CASE
            WHEN (ge.event_type = 'WALK'::text) THEN 1
            ELSE 0
        END)) - sum(
        CASE
            WHEN (ge.is_sacrifice_hit OR ge.is_sacrifice_fly) THEN 1
            ELSE 0
        END)))::numeric))::numeric(10,3) AS on_base_percentage
   FROM ((((public.game_events ge
     JOIN taxa.event_types et ON ((ge.event_type = et.event_type)))
     JOIN public.players p ON ((((ge.batter_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
     JOIN public.team_roster tp ON ((((p.player_id)::text = (tp.player_id)::text) AND (tp.valid_until IS NULL))))
     JOIN public.teams t ON (((tp.team_id)::text = (t.team_id)::text)))
  WHERE (ge.season = ( SELECT public.current_season() AS current_season))
  GROUP BY p.player_id, p.player_name, t.nickname
  ORDER BY (((((sum(et.hit) + sum(
        CASE
            WHEN (ge.event_type = 'WALK'::text) THEN 1
            ELSE 0
        END)))::numeric / (((sum(et.at_bat) + sum(
        CASE
            WHEN (ge.event_type = 'WALK'::text) THEN 1
            ELSE 0
        END)) - sum(
        CASE
            WHEN (ge.is_sacrifice_hit OR ge.is_sacrifice_fly) THEN 1
            ELSE 0
        END)))::numeric))::numeric(10,3)) DESC, p.player_name;


--
-- Name: season_leaders_slugging; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.season_leaders_slugging AS
 SELECT p.player_id,
    p.player_name,
    t.nickname,
    rank() OVER (ORDER BY ((((sum(et.total_bases))::numeric / ((sum(et.at_bat) - sum(
        CASE
            WHEN (ge.is_sacrifice_hit OR ge.is_sacrifice_fly) THEN 1
            ELSE 0
        END)))::numeric))::numeric(10,3)) DESC) AS rank,
    (sum(et.at_bat) - sum(
        CASE
            WHEN (ge.is_sacrifice_hit OR ge.is_sacrifice_fly) THEN 1
            ELSE 0
        END)) AS at_bats,
    sum(et.total_bases) AS total_bases,
    (((sum(et.total_bases))::numeric / ((sum(et.at_bat) - sum(
        CASE
            WHEN (ge.is_sacrifice_hit OR ge.is_sacrifice_fly) THEN 1
            ELSE 0
        END)))::numeric))::numeric(10,3) AS slugging
   FROM ((((public.game_events ge
     JOIN taxa.event_types et ON ((ge.event_type = et.event_type)))
     JOIN public.players p ON ((((ge.batter_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
     JOIN public.team_roster tp ON ((((p.player_id)::text = (tp.player_id)::text) AND (tp.valid_until IS NULL))))
     JOIN public.teams t ON (((tp.team_id)::text = (t.team_id)::text)))
  WHERE (ge.season = ( SELECT public.current_season() AS current_season))
  GROUP BY p.player_id, p.player_name, t.nickname
  ORDER BY ((((sum(et.total_bases))::numeric / ((sum(et.at_bat) - sum(
        CASE
            WHEN (ge.is_sacrifice_hit OR ge.is_sacrifice_fly) THEN 1
            ELSE 0
        END)))::numeric))::numeric(10,3)) DESC, p.player_name;


--
-- Name: season_leaders_on_base_slugging; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.season_leaders_on_base_slugging AS
 SELECT a.player_id,
    a.player_name,
    a.nickname,
    a.on_base_percentage,
    b.slugging,
    ((a.on_base_percentage + b.slugging))::numeric(10,3) AS on_base_slugging
   FROM (public.season_leaders_slugging b
     JOIN public.season_leaders_on_base_perecentage a ON (((a.player_id)::text = (b.player_id)::text)))
  ORDER BY (((a.on_base_percentage + b.slugging))::numeric(10,3)) DESC, a.player_name;


--
-- Name: season_leaders_outs_defended; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.season_leaders_outs_defended AS
 SELECT sum(a.plays) AS plays,
    btrim(a.defender) AS defender,
    p.player_id,
    t.nickname AS team_name,
    rank() OVER (ORDER BY (sum(a.plays)) DESC) AS rank
   FROM (((( SELECT count(1) AS plays,
            "substring"((a_1.event_text)::text, ("position"((a_1.event_text)::text, 'ground out to '::text) + 14), "position"("right"((a_1.event_text)::text, ((length((a_1.event_text)::text) - "position"((a_1.event_text)::text, 'ground out to '::text)) - 14)), '.'::text)) AS defender
           FROM (public.game_events a_1
             JOIN public.games b USING (game_id))
          WHERE (("position"((a_1.event_text)::text, 'ground out to '::text) > 0) AND (b.season = 4))
          GROUP BY ("substring"((a_1.event_text)::text, ("position"((a_1.event_text)::text, 'ground out to '::text) + 14), "position"("right"((a_1.event_text)::text, ((length((a_1.event_text)::text) - "position"((a_1.event_text)::text, 'ground out to '::text)) - 14)), '.'::text)))
        UNION
         SELECT count(1) AS plays,
            "substring"((a_1.event_text)::text, ("position"((a_1.event_text)::text, 'flyout to '::text) + 9), "position"("right"((a_1.event_text)::text, ((length((a_1.event_text)::text) - "position"((a_1.event_text)::text, 'flyout to '::text)) - 9)), '.'::text)) AS defender
           FROM (public.game_events a_1
             JOIN public.games b USING (game_id))
          WHERE (("position"((a_1.event_text)::text, 'flyout to '::text) > 0) AND (a_1.season = ( SELECT public.current_season() AS current_season)))
          GROUP BY ("substring"((a_1.event_text)::text, ("position"((a_1.event_text)::text, 'flyout to '::text) + 9), "position"("right"((a_1.event_text)::text, ((length((a_1.event_text)::text) - "position"((a_1.event_text)::text, 'flyout to '::text)) - 9)), '.'::text)))) a
     JOIN public.players p ON (((btrim(a.defender) = (p.player_name)::text) AND (p.valid_until IS NULL))))
     JOIN public.team_roster tp ON ((((p.player_id)::text = (tp.player_id)::text) AND (p.valid_until IS NULL) AND (tp.valid_until IS NULL))))
     JOIN public.teams t ON ((((tp.team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
  GROUP BY (btrim(a.defender)), p.player_id, t.nickname
  ORDER BY (sum(a.plays)) DESC;


--
-- Name: team_positions_team_position_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.team_positions_team_position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: team_positions_team_position_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.team_positions_team_position_id_seq OWNED BY public.team_roster.team_roster_id;


--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.teams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.teams_id_seq OWNED BY public.teams.id;


--
-- Name: time_map; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.time_map (
    season integer NOT NULL,
    day integer NOT NULL,
    first_time timestamp without time zone,
    time_map_id integer NOT NULL
);


--
-- Name: time_map_time_map_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.time_map_time_map_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: time_map_time_map_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.time_map_time_map_id_seq OWNED BY public.time_map.time_map_id;


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
-- Name: divisions; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.divisions (
    division_db_id integer NOT NULL,
    division_text character varying,
    league_id integer,
    valid_until timestamp without time zone,
    division_seasons integer[],
    division_id character varying
);


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
-- Name: leagues; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.leagues (
    league_db_id integer NOT NULL,
    league_text character varying,
    league_seasons integer[],
    valid_until timestamp without time zone,
    league_id character varying
);


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
    modification_id integer NOT NULL,
    modification_text character varying,
    modification_desc character varying,
    modification_definition character varying
);


--
-- Name: modifications_modification_id_seq; Type: SEQUENCE; Schema: taxa; Owner: -
--

CREATE SEQUENCE taxa.modifications_modification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: modifications_modification_id_seq; Type: SEQUENCE OWNED BY; Schema: taxa; Owner: -
--

ALTER SEQUENCE taxa.modifications_modification_id_seq OWNED BY taxa.modifications.modification_id;


--
-- Name: player_fk_attributes; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.player_fk_attributes (
    attribute_id integer DEFAULT nextval('taxa.attributes_attribute_id_seq'::regclass) NOT NULL,
    attribute_text character varying,
    attribute_desc character varying,
    attribute_short character varying
);


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
-- Name: game_event_base_runners id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_event_base_runners ALTER COLUMN id SET DEFAULT nextval('public.game_event_base_runners_id_seq'::regclass);


--
-- Name: game_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_events ALTER COLUMN id SET DEFAULT nextval('public.game_events_id_seq'::regclass);


--
-- Name: imported_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imported_logs ALTER COLUMN id SET DEFAULT nextval('public.imported_logs_id_seq'::regclass);


--
-- Name: player_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.player_events ALTER COLUMN id SET DEFAULT nextval('public.player_events_id_seq'::regclass);


--
-- Name: players id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players ALTER COLUMN id SET DEFAULT nextval('public.players_id_seq'::regclass);


--
-- Name: team_roster team_roster_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.team_roster ALTER COLUMN team_roster_id SET DEFAULT nextval('public.team_positions_team_position_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams ALTER COLUMN id SET DEFAULT nextval('public.teams_id_seq'::regclass);


--
-- Name: time_map time_map_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.time_map ALTER COLUMN time_map_id SET DEFAULT nextval('public.time_map_time_map_id_seq'::regclass);


--
-- Name: attributes attribute_id; Type: DEFAULT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.attributes ALTER COLUMN attribute_id SET DEFAULT nextval('taxa.attributes_attribute_id_seq'::regclass);


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
-- Name: modifications modification_id; Type: DEFAULT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.modifications ALTER COLUMN modification_id SET DEFAULT nextval('taxa.modifications_modification_id_seq'::regclass);


--
-- Name: vibe_to_arrows vibe_to_arrow_id; Type: DEFAULT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.vibe_to_arrows ALTER COLUMN vibe_to_arrow_id SET DEFAULT nextval('taxa.vibe_to_arrows_vibe_to_arrow_id_seq'::regclass);


--
-- Data for Name: game_event_base_runners; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.game_event_base_runners (id, game_event_id, runner_id, responsible_pitcher_id, base_before_play, base_after_play, was_base_stolen, was_caught_stealing, was_picked_off) FROM stdin;
\.


--
-- Data for Name: game_events; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.game_events (id, perceived_at, game_id, event_type, event_index, inning, top_of_inning, outs_before_play, batter_id, batter_team_id, pitcher_id, pitcher_team_id, home_score, away_score, home_strike_count, away_strike_count, batter_count, pitches, total_strikes, total_balls, total_fouls, is_leadoff, is_pinch_hit, lineup_position, is_last_event_for_plate_appearance, bases_hit, runs_batted_in, is_sacrifice_hit, is_sacrifice_fly, outs_on_play, is_double_play, is_triple_play, is_wild_pitch, batted_ball_type, is_bunt, errors_on_play, batter_base_after_play, is_last_game_event, event_text, additional_context, season, day, parsing_error, parsing_error_list, fixed_error, fixed_error_list) FROM stdin;
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.games (game_id, day, season, last_game_event, home_odds, away_odds, weather, series_index, series_length, is_postseason, home_team, away_team, home_score, away_score, number_of_innings, ended_on_top_of_inning, ended_in_shame, terminology_id, rules_id, statsheet_id) FROM stdin;
\.


--
-- Data for Name: imported_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.imported_logs (id, key, imported_at) FROM stdin;
\.


--
-- Data for Name: player_events; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.player_events (id, game_event_id, player_id, event_type) FROM stdin;
\.


--
-- Data for Name: player_idols; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.player_idols (player_idol_id, instance_id, player_id, idol_count, valid_from, valid_until) FROM stdin;
\.


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.players (id, player_id, valid_until, player_name, deceased, hash, anticapitalism, base_thirst, buoyancy, chasiness, coldness, continuation, divinity, ground_friction, indulgence, laserlikeness, martyrdom, moxie, musclitude, omniscience, overpowerment, patheticism, ruthlessness, shakespearianism, suppression, tenaciousness, thwackability, tragicness, unthwackability, watchfulness, pressurization, cinnamon, total_fingers, soul, fate, peanut_allergy, armor, bat, ritual, coffee, blood) FROM stdin;
\.


--
-- Data for Name: team_roster; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.team_roster (team_roster_id, team_id, position_id, valid_until, player_id) FROM stdin;
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.teams (id, team_id, location, nickname, full_name, valid_until, hash) FROM stdin;
\.


--
-- Data for Name: time_map; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.time_map (season, day, first_time, time_map_id) FROM stdin;
\.


--
-- Data for Name: attributes; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.attributes (attribute_id, attribute_text, attribute_desc, attribute_objects, attributes_short, attribute_short) FROM stdin;
1	anticapitalism	\N	\N	\N	A
2	base_thirst	\N	\N	\N	Bt
3	buoyancy	\N	\N	\N	Bu
4	chasiness	\N	\N	\N	Ch
5	coldness	\N	\N	\N	Co
6	continuation	\N	\N	\N	Cn
7	divinity	\N	\N	\N	Dv
8	ground_friction	\N	\N	\N	G
9	indulgence	\N	\N	\N	I
10	laserlikeness	\N	\N	\N	L
11	martyrdom	\N	\N	\N	Mr
12	moxie	\N	\N	\N	Mo
13	musclitude	\N	\N	\N	Ms
14	omniscience	\N	\N	\N	Om
15	overpowerment	\N	\N	\N	Ov
16	patheticism	\N	\N	\N	Pa
17	ruthlessness	\N	\N	\N	R
18	shakespearianism	\N	\N	\N	S
19	suppression	\N	\N	\N	
20	tenaciousness	\N	\N	\N	Te
21	thwackability	\N	\N	\N	Tw
22	tragicness	\N	\N	\N	Tr
23	unthwackability	\N	\N	\N	Un
24	watchfulness	\N	\N	\N	W
25	pressurization	\N	\N	\N	Pr
26	cinnamon	\N	\N	\N	Ci
27	total_fingers	\N	\N	\N	
28	soul	\N	\N	\N	
29	fate	\N	\N	\N	
30	peanut_allergy	\N	\N	\N	
31	coffee	\N	\N	\N	
32	blood	\N	\N	\N	
1	anticapitalism	\N	\N	\N	A
2	base_thirst	\N	\N	\N	Bt
3	buoyancy	\N	\N	\N	Bu
4	chasiness	\N	\N	\N	Ch
5	coldness	\N	\N	\N	Co
6	continuation	\N	\N	\N	Cn
7	divinity	\N	\N	\N	Dv
8	ground_friction	\N	\N	\N	G
9	indulgence	\N	\N	\N	I
10	laserlikeness	\N	\N	\N	L
11	martyrdom	\N	\N	\N	Mr
12	moxie	\N	\N	\N	Mo
13	musclitude	\N	\N	\N	Ms
14	omniscience	\N	\N	\N	Om
15	overpowerment	\N	\N	\N	Ov
16	patheticism	\N	\N	\N	Pa
17	ruthlessness	\N	\N	\N	R
18	shakespearianism	\N	\N	\N	S
19	suppression	\N	\N	\N	
20	tenaciousness	\N	\N	\N	Te
21	thwackability	\N	\N	\N	Tw
22	tragicness	\N	\N	\N	Tr
23	unthwackability	\N	\N	\N	Un
24	watchfulness	\N	\N	\N	W
25	pressurization	\N	\N	\N	Pr
26	cinnamon	\N	\N	\N	Ci
27	total_fingers	\N	\N	\N	
28	soul	\N	\N	\N	
29	fate	\N	\N	\N	
30	peanut_allergy	\N	\N	\N	
31	coffee	\N	\N	\N	
32	blood	\N	\N	\N	
1	anticapitalism	\N	\N	\N	A
2	base_thirst	\N	\N	\N	Bt
3	buoyancy	\N	\N	\N	Bu
4	chasiness	\N	\N	\N	Ch
5	coldness	\N	\N	\N	Co
6	continuation	\N	\N	\N	Cn
7	divinity	\N	\N	\N	Dv
8	ground_friction	\N	\N	\N	G
9	indulgence	\N	\N	\N	I
10	laserlikeness	\N	\N	\N	L
11	martyrdom	\N	\N	\N	Mr
12	moxie	\N	\N	\N	Mo
13	musclitude	\N	\N	\N	Ms
14	omniscience	\N	\N	\N	Om
15	overpowerment	\N	\N	\N	Ov
16	patheticism	\N	\N	\N	Pa
17	ruthlessness	\N	\N	\N	R
18	shakespearianism	\N	\N	\N	S
19	suppression	\N	\N	\N	
20	tenaciousness	\N	\N	\N	Te
21	thwackability	\N	\N	\N	Tw
22	tragicness	\N	\N	\N	Tr
23	unthwackability	\N	\N	\N	Un
24	watchfulness	\N	\N	\N	W
25	pressurization	\N	\N	\N	Pr
26	cinnamon	\N	\N	\N	Ci
27	total_fingers	\N	\N	\N	
28	soul	\N	\N	\N	
29	fate	\N	\N	\N	
30	peanut_allergy	\N	\N	\N	
31	coffee	\N	\N	\N	
32	blood	\N	\N	\N	
1	anticapitalism	\N	\N	\N	A
2	base_thirst	\N	\N	\N	Bt
3	buoyancy	\N	\N	\N	Bu
4	chasiness	\N	\N	\N	Ch
5	coldness	\N	\N	\N	Co
6	continuation	\N	\N	\N	Cn
7	divinity	\N	\N	\N	Dv
8	ground_friction	\N	\N	\N	G
9	indulgence	\N	\N	\N	I
10	laserlikeness	\N	\N	\N	L
11	martyrdom	\N	\N	\N	Mr
12	moxie	\N	\N	\N	Mo
13	musclitude	\N	\N	\N	Ms
14	omniscience	\N	\N	\N	Om
15	overpowerment	\N	\N	\N	Ov
16	patheticism	\N	\N	\N	Pa
17	ruthlessness	\N	\N	\N	R
18	shakespearianism	\N	\N	\N	S
19	suppression	\N	\N	\N	
20	tenaciousness	\N	\N	\N	Te
21	thwackability	\N	\N	\N	Tw
22	tragicness	\N	\N	\N	Tr
23	unthwackability	\N	\N	\N	Un
24	watchfulness	\N	\N	\N	W
25	pressurization	\N	\N	\N	Pr
26	cinnamon	\N	\N	\N	Ci
27	total_fingers	\N	\N	\N	
28	soul	\N	\N	\N	
29	fate	\N	\N	\N	
30	peanut_allergy	\N	\N	\N	
31	coffee	\N	\N	\N	
32	blood	\N	\N	\N	
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
-- Data for Name: divisions; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.divisions (division_db_id, division_text, league_id, valid_until, division_seasons, division_id) FROM stdin;
1	Lawful Good	1	2020-09-06 15:26:39.925823	{0,1,2,3,4}	f711d960-dc28-4ae2-9249-e1f320fec7d7
2	Chaotic Good	1	2020-09-06 15:26:39.925823	{0,1,2,3,4}	5eb2271a-3e49-48dc-b002-9cb615288836
3	Lawful Evil	2	2020-09-06 15:26:39.925823	{0,1,2,3,4}	765a1e03-4101-4e8e-b611-389e71d13619
4	Chaotic Evil	2	2020-09-06 15:26:39.925823	{0,1,2,3,4}	7fbad33c-59ab-4e80-ba63-347177edaa2e
5	Wild High	3	\N	{5}	d4cc18de-a136-4271-84f1-32516be91a80
6	Wild Low	3	\N	{5}	98c92da4-0ea7-43be-bd75-c6150e184326
7	Mild High	4	\N	{5}	456089f0-f338-4620-a014-9540868789c9
8	Mild Low	4	\N	{5}	fadc9684-45b3-47a6-b647-3be3f0735a84
\.


--
-- Data for Name: event_types; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.event_types (event_type_id, event_type, plate_appearance, at_bat, hit, total_bases) FROM stdin;
13	CAUGHT_STEALING	0	0	0	0
14	DOUBLE	1	1	1	2
15	FIELDERS_CHOICE	1	1	0	1
16	HOME_RUN	1	1	1	4
17	OUT	1	1	0	0
18	SINGLE	1	1	1	1
19	STOLEN_BASE	0	0	0	0
20	STRIKEOUT	1	1	0	0
21	TRIPLE	1	1	1	3
22	WALK	0	0	0	1
23	UNKNOWN	1	0	0	0
24	SACRIFICE	1	0	0	0
1	CAUGHT_STEALING	0	0	0	0
3	DOUBLE	1	1	1	2
4	FIELDERS_CHOICE	1	1	0	1
5	HOME_RUN	1	1	1	4
6	OUT	1	1	0	0
7	SINGLE	1	1	1	1
8	STOLEN_BASE	0	0	0	0
9	STRIKEOUT	1	1	0	0
10	TRIPLE	1	1	1	3
12	UNKNOWN	1	0	0	0
11	WALK	0	0	0	1
\.


--
-- Data for Name: leagues; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.leagues (league_db_id, league_text, league_seasons, valid_until, league_id) FROM stdin;
1	Good	{0,1,2,3,4}	2020-09-06 15:26:34.254566	7d3a3dd6-9ea1-4535-9d91-bde875c85e80
3	Wild	{5}	\N	aabc11a1-81af-4036-9f18-229c759ca8a9
4	Mild	{5}	\N	4fe65afa-804f-4bb2-9b15-1281b2eab110
2	Evil	{0,1,2,3,4}	2020-09-06 15:26:34.254566	93e58443-9617-44d4-8561-e254a1dbd450
\.


--
-- Data for Name: modifications; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.modifications (modification_id, modification_text, modification_desc, modification_definition) FROM stdin;
1	EXTRA_STRIKE	The Fourth Strike	Those with the Fourth Strike will get an extra strike in each at bat.
2	SHAME_PIT	Targeted Shame	Teams with Targeted Shame will star with negative runs the game after being shamed.
3	HOME_FIELD	Home Field Advantage	Teams with Home Field Advantage will start each home game with one run.
4	FIREPROOF	Fireproof	A Fireproof player can not be incinerated.
5	ALTERNATE	Alternate	This player is an Alternate...
6	SOUNDPROOF	Soundproof	A Soundproof player can not be caught in Feedback's reality flickers.
7	SHELLED	Shelled	A Shelled player is Shelled.
8	REVERBERATING	Reverberating	A Reverberating player has a small chance of batting again after each of their At-Bats end.
\.


--
-- Data for Name: player_fk_attributes; Type: TABLE DATA; Schema: taxa; Owner: -
--

COPY taxa.player_fk_attributes (attribute_id, attribute_text, attribute_desc, attribute_short) FROM stdin;
1	anticapitalism	\N	A
2	base_thirst	\N	Bt
3	buoyancy	\N	Bu
4	chasiness	\N	Ch
5	coldness	\N	Co
6	continuation	\N	Cn
7	divinity	\N	Dv
8	ground_friction	\N	G
9	indulgence	\N	I
10	laserlikeness	\N	L
11	martyrdom	\N	Mr
12	moxie	\N	Mo
13	musclitude	\N	Ms
14	omniscience	\N	Om
15	overpowerment	\N	Ov
16	patheticism	\N	Pa
17	ruthlessness	\N	R
18	shakespearianism	\N	S
19	suppression	\N	
20	tenaciousness	\N	Te
21	thwackability	\N	Tw
22	tragicness	\N	Tr
23	unthwackability	\N	Un
24	watchfulness	\N	W
25	pressurization	\N	Pr
26	cinnamon	\N	Ci
27	total_fingers	\N	
28	soul	\N	
29	fate	\N	
30	peanut_allergy	\N	
31	coffee	\N	
32	blood	\N	
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
9	Bloodwind
10	Peanuts
11	Birds
12	Feedback
13	Reverb
\.


--
-- Name: game_event_base_runners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.game_event_base_runners_id_seq', 213052, true);


--
-- Name: game_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.game_events_id_seq', 240027, true);


--
-- Name: imported_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.imported_logs_id_seq', 1500, true);


--
-- Name: player_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.player_events_id_seq', 112, true);


--
-- Name: players_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.players_id_seq', 2576, true);


--
-- Name: team_positions_team_position_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.team_positions_team_position_id_seq', 492, true);


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.teams_id_seq', 21, true);


--
-- Name: time_map_time_map_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.time_map_time_map_id_seq', 240027, true);


--
-- Name: attributes_attribute_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.attributes_attribute_id_seq', 32, true);


--
-- Name: divisions_division_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.divisions_division_id_seq', 8, true);


--
-- Name: event_types_event_type_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.event_types_event_type_id_seq', 12, true);


--
-- Name: leagues_league_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.leagues_league_id_seq', 4, true);


--
-- Name: modifications_modification_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.modifications_modification_id_seq', 8, true);


--
-- Name: vibe_to_arrows_vibe_to_arrow_id_seq; Type: SEQUENCE SET; Schema: taxa; Owner: -
--

SELECT pg_catalog.setval('taxa.vibe_to_arrows_vibe_to_arrow_id_seq', 13, true);


--
-- Name: game_event_base_runners game_event_base_runners_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_event_base_runners
    ADD CONSTRAINT game_event_base_runners_pkey PRIMARY KEY (id);


--
-- Name: game_events game_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_events
    ADD CONSTRAINT game_events_pkey PRIMARY KEY (id);


--
-- Name: games game_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT game_pkey PRIMARY KEY (game_id);


--
-- Name: imported_logs imported_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imported_logs
    ADD CONSTRAINT imported_logs_pkey PRIMARY KEY (id);


--
-- Name: player_events player_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.player_events
    ADD CONSTRAINT player_events_pkey PRIMARY KEY (id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: time_map season_day_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.time_map
    ADD CONSTRAINT season_day_unique UNIQUE (season, day);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: time_map time_map_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.time_map
    ADD CONSTRAINT time_map_pkey PRIMARY KEY (time_map_id);


--
-- Name: event_types event_types_pkey; Type: CONSTRAINT; Schema: taxa; Owner: -
--

ALTER TABLE ONLY taxa.event_types
    ADD CONSTRAINT event_types_pkey PRIMARY KEY (event_type_id);


--
-- Name: game_event_base_runners game_event_base_runners_game_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_event_base_runners
    ADD CONSTRAINT game_event_base_runners_game_event_id_fkey FOREIGN KEY (game_event_id) REFERENCES public.game_events(id) ON DELETE CASCADE;


--
-- Name: player_events player_events_game_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.player_events
    ADD CONSTRAINT player_events_game_event_id_fkey FOREIGN KEY (game_event_id) REFERENCES public.game_events(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

