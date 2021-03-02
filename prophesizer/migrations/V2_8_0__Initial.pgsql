DROP SCHEMA IF EXISTS data CASCADE;
DROP SCHEMA IF EXISTS taxa CASCADE;

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
DROP SEQUENCE IF EXISTS data.time_map_time_map_id_seq;
DROP TABLE IF EXISTS data.time_map;
DROP SEQUENCE IF EXISTS data.teams_id_seq;
DROP SEQUENCE IF EXISTS data.team_positions_team_position_id_seq;
DROP SEQUENCE IF EXISTS data.team_modifications_team_modifications_id_seq;
DROP SEQUENCE IF EXISTS data.players_id_seq;
DROP SEQUENCE IF EXISTS data.player_modifications_player_modifications_id_seq;
DROP SEQUENCE IF EXISTS data.player_events_id_seq;
DROP TABLE IF EXISTS data.outcomes;
DROP SEQUENCE IF EXISTS data.imported_logs_id_seq;
DROP TABLE IF EXISTS data.imported_logs;
DROP SEQUENCE IF EXISTS data.game_events_id_seq;
DROP SEQUENCE IF EXISTS data.game_event_base_runners_id_seq;
DROP TABLE IF EXISTS data.chronicler_meta;
DROP SEQUENCE IF EXISTS data.chronicler_hash_game_event_chronicler_hash_game_event_id_seq;
DROP TABLE IF EXISTS data.chronicler_hash_game_event;
DROP TABLE IF EXISTS data.games;
DROP TABLE IF EXISTS data.game_event_base_runners;
DROP TABLE IF EXISTS data.teams;
DROP TABLE IF EXISTS data.team_roster;
DROP TABLE IF EXISTS data.team_modifications;
DROP TABLE IF EXISTS data.players;
DROP TABLE IF EXISTS data.player_modifications;
DROP TABLE IF EXISTS data.game_events;
DROP SEQUENCE IF EXISTS data.applied_patches_patch_id_seq;
DROP TABLE IF EXISTS data.applied_patches;
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
    runs_batted_in numeric,
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
    home_base_count integer DEFAULT 4,
    tournament integer
);

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
    losing_pitcher_id character varying,
    tournament integer
);

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

-- TODO: remove all these sequence things? Don't need em

--
-- Name: applied_patches_patch_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--
SELECT pg_catalog.setval('data.applied_patches_patch_id_seq', 38, true);
--
-- Name: chronicler_hash_game_event_chronicler_hash_game_event_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--
SELECT pg_catalog.setval('data.chronicler_hash_game_event_chronicler_hash_game_event_id_seq', 37730983, true);
--
-- Name: game_event_base_runners_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--
SELECT pg_catalog.setval('data.game_event_base_runners_id_seq', 16617286, true);
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
SELECT pg_catalog.setval('data.player_events_id_seq', 92152, true);
--
-- Name: player_modifications_player_modifications_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--
SELECT pg_catalog.setval('data.player_modifications_player_modifications_id_seq', 14719, true);
--
-- Name: players_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--
SELECT pg_catalog.setval('data.players_id_seq', 152894, true);
--
-- Name: team_modifications_team_modifications_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--
SELECT pg_catalog.setval('data.team_modifications_team_modifications_id_seq', 3359, true);
--
-- Name: team_positions_team_position_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--
SELECT pg_catalog.setval('data.team_positions_team_position_id_seq', 36274, true);
--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--
SELECT pg_catalog.setval('data.teams_id_seq', 1470, true);
--
-- Name: time_map_time_map_id_seq; Type: SEQUENCE SET; Schema: data; Owner: -
--
SELECT pg_catalog.setval('data.time_map_time_map_id_seq', 14090289, true);

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
-- Name: team_roster_idx; Type: INDEX; Schema: data; Owner: -
--
CREATE INDEX team_roster_idx ON data.team_roster USING btree (valid_until NULLS FIRST, team_id, position_id, position_type_id) INCLUDE (team_id, position_id, valid_until, position_type_id);
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
