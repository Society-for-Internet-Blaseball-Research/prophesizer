--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.3

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
ALTER TABLE IF EXISTS ONLY public.time_map DROP CONSTRAINT IF EXISTS time_map_pkey;
ALTER TABLE IF EXISTS ONLY public.teams DROP CONSTRAINT IF EXISTS teams_pkey;
ALTER TABLE IF EXISTS ONLY public.time_map DROP CONSTRAINT IF EXISTS season_day_unique;
ALTER TABLE IF EXISTS ONLY public.players DROP CONSTRAINT IF EXISTS players_pkey;
ALTER TABLE IF EXISTS ONLY public.player_events DROP CONSTRAINT IF EXISTS player_events_pkey;
ALTER TABLE IF EXISTS ONLY public.imported_logs DROP CONSTRAINT IF EXISTS imported_logs_pkey;
ALTER TABLE IF EXISTS ONLY public.games DROP CONSTRAINT IF EXISTS game_pkey;
ALTER TABLE IF EXISTS ONLY public.game_events DROP CONSTRAINT IF EXISTS game_events_pkey;
ALTER TABLE IF EXISTS ONLY public.game_event_base_runners DROP CONSTRAINT IF EXISTS game_event_base_runners_pkey;
ALTER TABLE IF EXISTS xref.team_division ALTER COLUMN team_division_id DROP DEFAULT;
ALTER TABLE IF EXISTS xref.player_attributes ALTER COLUMN player_attributes_id DROP DEFAULT;
ALTER TABLE IF EXISTS raw.game_events ALTER COLUMN game_event_raw_id DROP DEFAULT;
ALTER TABLE IF EXISTS raw.all_teams ALTER COLUMN all_teams_raw_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.time_map ALTER COLUMN time_map_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.teams ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.team_roster ALTER COLUMN team_roster_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.players ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.player_events ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.imported_logs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.game_events ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.game_event_base_runners ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS xref.team_division_team_division_id_seq;
DROP TABLE IF EXISTS xref.team_division;
DROP SEQUENCE IF EXISTS xref.player_attributes_player_attributes_id_seq;
DROP TABLE IF EXISTS xref.player_attributes;
DROP SEQUENCE IF EXISTS raw.game_events_game_event_raw_id_seq;
DROP TABLE IF EXISTS raw.game_events;
DROP TABLE IF EXISTS raw.event_text;
DROP SEQUENCE IF EXISTS raw.all_teams_raw_all_teams_raw_id_seq;
DROP TABLE IF EXISTS raw.all_teams;
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
DROP TABLE IF EXISTS public.teams;
DROP TABLE IF EXISTS public.team_roster;
DROP SEQUENCE IF EXISTS public.players_id_seq;
DROP TABLE IF EXISTS public.players;
DROP SEQUENCE IF EXISTS public.player_events_id_seq;
DROP TABLE IF EXISTS public.player_events;
DROP SEQUENCE IF EXISTS public.imported_logs_id_seq;
DROP TABLE IF EXISTS public.imported_logs;
DROP TABLE IF EXISTS public.games;
DROP SEQUENCE IF EXISTS public.game_events_id_seq;
DROP TABLE IF EXISTS public.game_events;
DROP SEQUENCE IF EXISTS public.game_event_base_runners_id_seq;
DROP TABLE IF EXISTS public.game_event_base_runners;
DROP FUNCTION IF EXISTS xref.team_positions_raw_to_xref();
DROP PROCEDURE IF EXISTS public.wipe_hourly();
DROP PROCEDURE IF EXISTS public.wipe_events();
DROP PROCEDURE IF EXISTS public.wipe_all();
DROP FUNCTION IF EXISTS public.round_half_even(val numeric, prec integer);
DROP FUNCTION IF EXISTS public.rating_to_star(in_rating numeric);
DROP FUNCTION IF EXISTS public.pitching_rating(in_player_id character varying, valid_until timestamp without time zone);
DROP FUNCTION IF EXISTS public.get_player_star_ratings(in_player_id character varying, valid_until timestamp without time zone);
DROP FUNCTION IF EXISTS public.defense_rating(in_player_id character varying, valid_until timestamp without time zone);
DROP FUNCTION IF EXISTS public.current_season();
DROP FUNCTION IF EXISTS public.batting_rating(in_player_id character varying, valid_until timestamp without time zone);
DROP FUNCTION IF EXISTS public.baserunning_rating(in_player_id character varying, valid_until timestamp without time zone);
DROP SCHEMA IF EXISTS xref;
DROP SCHEMA IF EXISTS raw;
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
-- Name: raw; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA raw;


--
-- Name: xref; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA xref;


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


--
-- Name: team_positions_raw_to_xref(); Type: FUNCTION; Schema: xref; Owner: -
--

CREATE FUNCTION xref.team_positions_raw_to_xref() RETURNS boolean
    LANGUAGE sql
    AS $$

UPDATE xref.team_positions SET valid_until = (SELECT MAX(download_time) FROM raw.all_teams) WHERE valid_until IS NULL;

INSERT INTO xref.team_positions (position_id, player_id, team_id) 
(
SELECT 
CASE
	when mod(row_number() OVER (order BY NOW()),9) = 0 THEN 9 
	ELSE mod(row_number() OVER (order BY NOW()),9)
END AS row_number,
lineup, b.team_id
FROM
(
	SELECT json_array_elements_text(json_team_instance->'lineup') as lineup, 
	download_time, json_team_instance->>'id' AS team_id
	FROM
	(
		SELECT json_array_elements(json_data)::json AS json_team_instance, download_time
		FROM raw.all_teams
	) a
	WHERE download_time = (SELECT MAX(download_time) FROM raw.all_teams)
	--AND json_team_instance->>'id' = '7966eb04-efcc-499b-8f03-d13916330531'

) b

UNION
--/*
SELECT 
CASE
	when mod(row_number() OVER (order BY NOW()),5) = 0 THEN 14 
	ELSE 
	mod(row_number() OVER (order BY NOW()),5) + 9
END 
AS row_number,
lineup, b.team_id
FROM
(
	SELECT json_array_elements_text(json_team_instance->'rotation') AS lineup, 
	download_time, json_team_instance->>'id' AS team_id
	FROM
	(
		SELECT json_array_elements(json_data)::json AS json_team_instance, download_time
		FROM raw.all_teams
	) a
	WHERE download_time = (SELECT MAX(download_time) FROM raw.all_teams)
	--AND json_team_instance->>'id' = '7966eb04-efcc-499b-8f03-d13916330531'

) b
ORDER BY team_id, row_number
);

select true;

$$;


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
-- Name: all_teams; Type: TABLE; Schema: raw; Owner: -
--

CREATE TABLE raw.all_teams (
    all_teams_raw_id integer NOT NULL,
    json_data json,
    download_time timestamp without time zone DEFAULT now()
);


--
-- Name: all_teams_raw_all_teams_raw_id_seq; Type: SEQUENCE; Schema: raw; Owner: -
--

CREATE SEQUENCE raw.all_teams_raw_all_teams_raw_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: all_teams_raw_all_teams_raw_id_seq; Type: SEQUENCE OWNED BY; Schema: raw; Owner: -
--

ALTER SEQUENCE raw.all_teams_raw_all_teams_raw_id_seq OWNED BY raw.all_teams.all_teams_raw_id;


--
-- Name: event_text; Type: TABLE; Schema: raw; Owner: -
--

CREATE TABLE raw.event_text (
    event_text_raw_id bigint,
    event_text_raw text,
    game_id character varying(36)
);


--
-- Name: game_events; Type: TABLE; Schema: raw; Owner: -
--

CREATE TABLE raw.game_events (
    game_event_raw_id integer NOT NULL,
    json_data json,
    download_time timestamp without time zone DEFAULT now()
);


--
-- Name: game_events_game_event_raw_id_seq; Type: SEQUENCE; Schema: raw; Owner: -
--

CREATE SEQUENCE raw.game_events_game_event_raw_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: game_events_game_event_raw_id_seq; Type: SEQUENCE OWNED BY; Schema: raw; Owner: -
--

ALTER SEQUENCE raw.game_events_game_event_raw_id_seq OWNED BY raw.game_events.game_event_raw_id;


--
-- Name: player_attributes; Type: TABLE; Schema: xref; Owner: -
--

CREATE TABLE xref.player_attributes (
    player_attributes_id integer NOT NULL,
    player_id character varying,
    attribute_id integer,
    valid_until timestamp without time zone,
    attribute_value integer
);


--
-- Name: player_attributes_player_attributes_id_seq; Type: SEQUENCE; Schema: xref; Owner: -
--

CREATE SEQUENCE xref.player_attributes_player_attributes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: player_attributes_player_attributes_id_seq; Type: SEQUENCE OWNED BY; Schema: xref; Owner: -
--

ALTER SEQUENCE xref.player_attributes_player_attributes_id_seq OWNED BY xref.player_attributes.player_attributes_id;


--
-- Name: team_division; Type: TABLE; Schema: xref; Owner: -
--

CREATE TABLE xref.team_division (
    team_division_id integer NOT NULL,
    team_id character varying,
    division character varying,
    league character varying,
    valid_until timestamp without time zone
);


--
-- Name: team_division_team_division_id_seq; Type: SEQUENCE; Schema: xref; Owner: -
--

CREATE SEQUENCE xref.team_division_team_division_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: team_division_team_division_id_seq; Type: SEQUENCE OWNED BY; Schema: xref; Owner: -
--

ALTER SEQUENCE xref.team_division_team_division_id_seq OWNED BY xref.team_division.team_division_id;


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
-- Name: all_teams all_teams_raw_id; Type: DEFAULT; Schema: raw; Owner: -
--

ALTER TABLE ONLY raw.all_teams ALTER COLUMN all_teams_raw_id SET DEFAULT nextval('raw.all_teams_raw_all_teams_raw_id_seq'::regclass);


--
-- Name: game_events game_event_raw_id; Type: DEFAULT; Schema: raw; Owner: -
--

ALTER TABLE ONLY raw.game_events ALTER COLUMN game_event_raw_id SET DEFAULT nextval('raw.game_events_game_event_raw_id_seq'::regclass);


--
-- Name: player_attributes player_attributes_id; Type: DEFAULT; Schema: xref; Owner: -
--

ALTER TABLE ONLY xref.player_attributes ALTER COLUMN player_attributes_id SET DEFAULT nextval('xref.player_attributes_player_attributes_id_seq'::regclass);


--
-- Name: team_division team_division_id; Type: DEFAULT; Schema: xref; Owner: -
--

ALTER TABLE ONLY xref.team_division ALTER COLUMN team_division_id SET DEFAULT nextval('xref.team_division_team_division_id_seq'::regclass);


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

