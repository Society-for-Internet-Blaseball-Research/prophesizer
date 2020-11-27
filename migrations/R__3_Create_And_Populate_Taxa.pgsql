/*
ALTER TABLE taxa.event_types DROP CONSTRAINT IF EXISTS event_types_pkey;
ALTER TABLE taxa.event_types DROP CONSTRAINT IF EXISTS event_types_event_type_key;
ALTER TABLE taxa.card DROP CONSTRAINT IF EXISTS card_pkey;
ALTER TABLE taxa.attributes DROP CONSTRAINT IF EXISTS attributes_pkey;
ALTER TABLE taxa.vibe_to_arrows ALTER COLUMN vibe_to_arrow_id DROP DEFAULT;
ALTER TABLE taxa.team_divine_favor ALTER COLUMN team_divine_favor_id DROP DEFAULT;
ALTER TABLE taxa.team_abbreviations ALTER COLUMN team_abbreviation_id DROP DEFAULT;
ALTER TABLE taxa.player_url_slugs ALTER COLUMN player_url_slug_id DROP DEFAULT;
ALTER TABLE taxa.modifications ALTER COLUMN modification_db_id DROP DEFAULT;
ALTER TABLE taxa.leagues ALTER COLUMN league_db_id DROP DEFAULT;
ALTER TABLE taxa.event_types ALTER COLUMN event_type_id DROP DEFAULT;
ALTER TABLE taxa.divisions ALTER COLUMN division_db_id DROP DEFAULT;
ALTER TABLE taxa.division_teams ALTER COLUMN division_teams_id DROP DEFAULT;
ALTER TABLE taxa.attributes ALTER COLUMN attribute_id DROP DEFAULT;
*/

DROP TABLE IF EXISTS taxa.weather CASCADE;
DROP SEQUENCE IF EXISTS taxa.vibe_to_arrows_vibe_to_arrow_id_seq CASCADE;
DROP TABLE IF EXISTS taxa.vibe_to_arrows CASCADE;
DROP SEQUENCE IF EXISTS taxa.team_divine_favor_team_divine_favor_id_seq CASCADE;
DROP TABLE IF EXISTS taxa.team_divine_favor CASCADE;
DROP SEQUENCE IF EXISTS taxa.team_abbreviations_team_abbreviation_id_seq CASCADE;
DROP SEQUENCE IF EXISTS taxa.player_url_slugs_player_url_slug_id_seq CASCADE;
DROP TABLE IF EXISTS taxa.pitch_types CASCADE;
DROP TABLE IF EXISTS taxa.phases CASCADE;
DROP SEQUENCE IF EXISTS taxa.modifications_modification_db_id_seq CASCADE;
DROP TABLE IF EXISTS taxa.modifications CASCADE;
DROP SEQUENCE IF EXISTS taxa.leagues_league_id_seq CASCADE;
DROP SEQUENCE IF EXISTS taxa.event_types_event_type_id_seq CASCADE;
DROP SEQUENCE IF EXISTS taxa.divisions_division_id_seq CASCADE;
DROP SEQUENCE IF EXISTS taxa.division_teams_division_teams_id_seq CASCADE;
DROP TABLE IF EXISTS taxa.card CASCADE;
DROP SEQUENCE IF EXISTS taxa.attributes_attribute_id_seq CASCADE;
DROP TABLE IF EXISTS taxa.attributes CASCADE;
DROP TABLE IF EXISTS taxa.player_url_slugs CASCADE;
DROP TABLE IF EXISTS taxa.position_types CASCADE;
DROP TABLE IF EXISTS taxa.coffee CASCADE;
DROP TABLE IF EXISTS taxa.blood CASCADE;
DROP TABLE IF EXISTS taxa.team_abbreviations CASCADE;
DROP TABLE IF EXISTS taxa.leagues CASCADE;
DROP TABLE IF EXISTS taxa.divisions CASCADE;
DROP TABLE IF EXISTS taxa.division_teams CASCADE;
DROP TABLE IF EXISTS taxa.event_types CASCADE;
DROP TABLE IF EXISTS taxa.tournaments CASCADE;
DROP TABLE IF EXISTS taxa.tournament_teams CASCADE;
DROP SEQUENCE IF EXISTS taxa.tournaments_tournament_db_id_seq CASCADE;
DROP SEQUENCE IF EXISTS taxa.tournament_teams_tournament_team_id_seq CASCADE;

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
-- Name: player_url_slugs; Type: TABLE; Schema: taxa; Owner: -
--
CREATE TABLE taxa.player_url_slugs (
    player_url_slug_id integer NOT NULL,
    player_id character varying,
    url_slug character varying,
    player_name character varying
);

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
-- Name: tournament_teams; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.tournament_teams (
    tournament_team_id integer NOT NULL,
    tournament_db_id integer,
    team_id character varying,
    valid_from timestamp without time zone,
    valid_until timestamp without time zone
);

--
-- Name: tournaments; Type: TABLE; Schema: taxa; Owner: -
--

CREATE TABLE taxa.tournaments (
    tournament_db_id integer NOT NULL,
    tournament_id integer,
    tournament_name character varying,
    valid_from timestamp without time zone,
    valid_until timestamp without time zone
);


--
-- Name: tournament_teams_tournament_team_id_seq; Type: SEQUENCE; Schema: taxa; Owner: -
--

CREATE SEQUENCE taxa.tournament_teams_tournament_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: tournament_teams_tournament_team_id_seq; Type: SEQUENCE OWNED BY; Schema: taxa; Owner: -
--

ALTER SEQUENCE taxa.tournament_teams_tournament_team_id_seq OWNED BY taxa.tournament_teams.tournament_team_id;

--
-- Name: tournaments_tournament_db_id_seq; Type: SEQUENCE; Schema: taxa; Owner: -
--

CREATE SEQUENCE taxa.tournaments_tournament_db_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: tournaments_tournament_db_id_seq; Type: SEQUENCE OWNED BY; Schema: taxa; Owner: -
--

ALTER SEQUENCE taxa.tournaments_tournament_db_id_seq OWNED BY taxa.tournaments.tournament_db_id;




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


-- DATA SECTION

--
-- Data for Name: attributes; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.attributes VALUES (33, 'suppression', NULL, NULL, NULL, '');
INSERT INTO taxa.attributes VALUES (34, 'pressurization', NULL, NULL, NULL, 'Pr');
INSERT INTO taxa.attributes VALUES (35, 'chasiness', NULL, NULL, NULL, 'Ch');
INSERT INTO taxa.attributes VALUES (36, 'peanut_allergy', NULL, NULL, NULL, '');
INSERT INTO taxa.attributes VALUES (37, 'unthwackability', NULL, NULL, NULL, 'Un');
INSERT INTO taxa.attributes VALUES (38, 'moxie', NULL, NULL, NULL, 'Mo');
INSERT INTO taxa.attributes VALUES (39, 'base_thirst', NULL, NULL, NULL, 'Bt');
INSERT INTO taxa.attributes VALUES (40, 'soul', NULL, NULL, NULL, '');
INSERT INTO taxa.attributes VALUES (41, 'indulgence', NULL, NULL, NULL, 'I');
INSERT INTO taxa.attributes VALUES (42, 'tragicness', NULL, NULL, NULL, 'Tr');
INSERT INTO taxa.attributes VALUES (43, 'musclitude', NULL, NULL, NULL, 'Ms');
INSERT INTO taxa.attributes VALUES (44, 'anticapitalism', NULL, NULL, NULL, 'A');
INSERT INTO taxa.attributes VALUES (45, 'total_fingers', NULL, NULL, NULL, '');
INSERT INTO taxa.attributes VALUES (46, 'ground_friction', NULL, NULL, NULL, 'G');
INSERT INTO taxa.attributes VALUES (47, 'divinity', NULL, NULL, NULL, 'Dv');
INSERT INTO taxa.attributes VALUES (48, 'overpowerment', NULL, NULL, NULL, 'Ov');
INSERT INTO taxa.attributes VALUES (49, 'coffee', NULL, NULL, NULL, '');
INSERT INTO taxa.attributes VALUES (50, 'thwackability', NULL, NULL, NULL, 'Tw');
INSERT INTO taxa.attributes VALUES (51, 'shakespearianism', NULL, NULL, NULL, 'S');
INSERT INTO taxa.attributes VALUES (52, 'laserlikeness', NULL, NULL, NULL, 'L');
INSERT INTO taxa.attributes VALUES (53, 'tenaciousness', NULL, NULL, NULL, 'Te');
INSERT INTO taxa.attributes VALUES (54, 'continuation', NULL, NULL, NULL, 'Cn');
INSERT INTO taxa.attributes VALUES (55, 'cinnamon', NULL, NULL, NULL, 'Ci');
INSERT INTO taxa.attributes VALUES (56, 'watchfulness', NULL, NULL, NULL, 'W');
INSERT INTO taxa.attributes VALUES (57, 'martyrdom', NULL, NULL, NULL, 'Mr');
INSERT INTO taxa.attributes VALUES (58, 'omniscience', NULL, NULL, NULL, 'Om');
INSERT INTO taxa.attributes VALUES (59, 'blood', NULL, NULL, NULL, '');
INSERT INTO taxa.attributes VALUES (60, 'fate', NULL, NULL, NULL, '');
INSERT INTO taxa.attributes VALUES (61, 'coldness', NULL, NULL, NULL, 'Co');
INSERT INTO taxa.attributes VALUES (62, 'buoyancy', NULL, NULL, NULL, 'Bu');
INSERT INTO taxa.attributes VALUES (63, 'ruthlessness', NULL, NULL, NULL, 'R');
INSERT INTO taxa.attributes VALUES (64, 'patheticism', NULL, NULL, NULL, 'Pa');


--
-- Data for Name: blood; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.blood VALUES (0, 'A');
INSERT INTO taxa.blood VALUES (1, 'AAA');
INSERT INTO taxa.blood VALUES (2, 'AA');
INSERT INTO taxa.blood VALUES (3, 'Acidic');
INSERT INTO taxa.blood VALUES (4, 'Basic');
INSERT INTO taxa.blood VALUES (5, 'O');
INSERT INTO taxa.blood VALUES (6, 'O No');
INSERT INTO taxa.blood VALUES (7, 'H₂O');
INSERT INTO taxa.blood VALUES (8, 'Electric');
INSERT INTO taxa.blood VALUES (9, 'Love');
INSERT INTO taxa.blood VALUES (10, 'Fire');
INSERT INTO taxa.blood VALUES (11, 'Psychic');
INSERT INTO taxa.blood VALUES (12, 'Grass');


--
-- Data for Name: card; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.card VALUES (11, 'XII The Hanged Man', NULL);
INSERT INTO taxa.card VALUES (4, 'V The Pope', NULL);
INSERT INTO taxa.card VALUES (14, 'XV The Devil', NULL);
INSERT INTO taxa.card VALUES (6, 'VII The Chariot', NULL);
INSERT INTO taxa.card VALUES (17, 'XVIII The Moon', NULL);
INSERT INTO taxa.card VALUES (9, 'X The Wheel of Fortune', NULL);
INSERT INTO taxa.card VALUES (13, 'XIIII Temperance', NULL);
INSERT INTO taxa.card VALUES (7, 'VIII Justice', NULL);
INSERT INTO taxa.card VALUES (3, 'IIII The Emperor', NULL);
INSERT INTO taxa.card VALUES (1, 'II The High Priestess', NULL);
INSERT INTO taxa.card VALUES (16, 'XVII The Star', NULL);
INSERT INTO taxa.card VALUES (19, 'XX Judgment', NULL);
INSERT INTO taxa.card VALUES (2, 'III The Empress', NULL);
INSERT INTO taxa.card VALUES (15, 'XVI The Tower', NULL);
INSERT INTO taxa.card VALUES (12, 'XIII', NULL);
INSERT INTO taxa.card VALUES (0, 'I The Magician', NULL);
INSERT INTO taxa.card VALUES (5, 'VI The Lover ', NULL);
INSERT INTO taxa.card VALUES (8, 'VIIII The Hermit', NULL);
INSERT INTO taxa.card VALUES (18, 'XVIIII The Sun', NULL);
INSERT INTO taxa.card VALUES (10, 'XI Strength', NULL);


--
-- Data for Name: coffee; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.coffee VALUES (0, 'Black');
INSERT INTO taxa.coffee VALUES (1, 'Light & Sweet');
INSERT INTO taxa.coffee VALUES (2, 'Macchiato');
INSERT INTO taxa.coffee VALUES (3, 'Cream & Sugar');
INSERT INTO taxa.coffee VALUES (4, 'Cold Brew');
INSERT INTO taxa.coffee VALUES (5, 'Flat White');
INSERT INTO taxa.coffee VALUES (6, 'Americano');
INSERT INTO taxa.coffee VALUES (8, 'Heavy Foam');
INSERT INTO taxa.coffee VALUES (9, 'Latte');
INSERT INTO taxa.coffee VALUES (10, 'Decaf');
INSERT INTO taxa.coffee VALUES (11, 'Milk Substitute');
INSERT INTO taxa.coffee VALUES (12, 'Plenty of Sugar');
INSERT INTO taxa.coffee VALUES (13, 'Anything');
INSERT INTO taxa.coffee VALUES (7, 'Espresso');


--
-- Data for Name: division_teams; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.division_teams VALUES (6, 'f711d960-dc28-4ae2-9249-e1f320fec7d7', 'b72f3061-f573-40d7-832a-5ad475bd7909', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (7, 'f711d960-dc28-4ae2-9249-e1f320fec7d7', '878c1bf6-0d21-4659-bfee-916c8314d69c', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (8, 'f711d960-dc28-4ae2-9249-e1f320fec7d7', 'b024e975-1c4a-4575-8936-a3754a08806a', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (9, 'f711d960-dc28-4ae2-9249-e1f320fec7d7', 'adc5b394-8f76-416d-9ce9-813706877b84', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (10, 'f711d960-dc28-4ae2-9249-e1f320fec7d7', 'ca3f1c8c-c025-4d8e-8eef-5be6accbeb16', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (11, '5eb2271a-3e49-48dc-b002-9cb615288836', 'bfd38797-8404-4b38-8b82-341da28b1f83', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (12, '5eb2271a-3e49-48dc-b002-9cb615288836', '3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (13, '5eb2271a-3e49-48dc-b002-9cb615288836', '979aee4a-6d80-4863-bf1c-ee1a78e06024', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (14, '5eb2271a-3e49-48dc-b002-9cb615288836', '7966eb04-efcc-499b-8f03-d13916330531', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (15, '5eb2271a-3e49-48dc-b002-9cb615288836', '36569151-a2fb-43c1-9df7-2df512424c82', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (16, '765a1e03-4101-4e8e-b611-389e71d13619', '8d87c468-699a-47a8-b40d-cfb73a5660ad', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (17, '765a1e03-4101-4e8e-b611-389e71d13619', '23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (18, '765a1e03-4101-4e8e-b611-389e71d13619', 'f02aeae2-5e6a-4098-9842-02d2273f25c7', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (19, '765a1e03-4101-4e8e-b611-389e71d13619', '57ec08cc-0411-4643-b304-0e80dbc15ac7', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (20, '765a1e03-4101-4e8e-b611-389e71d13619', '747b8e4a-7e50-4638-a973-ea7950a3e739', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (21, '7fbad33c-59ab-4e80-ba63-347177edaa2e', 'eb67ae5e-c4bf-46ca-bbbc-425cd34182ff', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (22, '7fbad33c-59ab-4e80-ba63-347177edaa2e', '9debc64f-74b7-4ae1-a4d6-fce0144b6ea5', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (23, '7fbad33c-59ab-4e80-ba63-347177edaa2e', 'b63be8c2-576a-4d6e-8daf-814f8bcea96f', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (24, '7fbad33c-59ab-4e80-ba63-347177edaa2e', '105bc3ff-1320-4e37-8ef0-8d595cb95dd0', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (25, '7fbad33c-59ab-4e80-ba63-347177edaa2e', 'a37f9158-7f82-46bc-908c-c9e2dda7c33b', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823');
INSERT INTO taxa.division_teams VALUES (41, 'd4cc18de-a136-4271-84f1-32516be91a80', 'c73b705c-40ad-4633-a6ed-d357ee2e2bcf', '2020-10-18 19:00:09.443928', NULL);
INSERT INTO taxa.division_teams VALUES (43, 'd4cc18de-a136-4271-84f1-32516be91a80', '747b8e4a-7e50-4638-a973-ea7950a3e739', '2020-10-19 15:00:01.023128', NULL);
INSERT INTO taxa.division_teams VALUES (44, '456089f0-f338-4620-a014-9540868789c9', '23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7', '2020-10-19 15:00:01.023128', NULL);
INSERT INTO taxa.division_teams VALUES (45, 'd4cc18de-a136-4271-84f1-32516be91a80', '57ec08cc-0411-4643-b304-0e80dbc15ac7', '2020-10-19 15:00:01.023128', NULL);
INSERT INTO taxa.division_teams VALUES (46, '456089f0-f338-4620-a014-9540868789c9', 'b72f3061-f573-40d7-832a-5ad475bd7909', '2020-10-19 15:00:01.023128', NULL);
INSERT INTO taxa.division_teams VALUES (47, '456089f0-f338-4620-a014-9540868789c9', '36569151-a2fb-43c1-9df7-2df512424c82', '2020-10-19 15:00:01.023128', NULL);
INSERT INTO taxa.division_teams VALUES (42, 'fadc9684-45b3-47a6-b647-3be3f0735a84', 'eb67ae5e-c4bf-46ca-bbbc-425cd34182ff', '2020-10-19 15:00:01.023128', NULL);
INSERT INTO taxa.division_teams VALUES (48, 'fadc9684-45b3-47a6-b647-3be3f0735a84', 'adc5b394-8f76-416d-9ce9-813706877b84', '2020-10-19 15:00:01.023128', NULL);
INSERT INTO taxa.division_teams VALUES (49, NULL, '8d87c468-699a-47a8-b40d-cfb73a5660ad', '2020-10-18 19:00:09.443928', NULL);
INSERT INTO taxa.division_teams VALUES (2, 'fadc9684-45b3-47a6-b647-3be3f0735a84', '979aee4a-6d80-4863-bf1c-ee1a78e06024', '2020-09-06 15:26:39.925823', NULL);
INSERT INTO taxa.division_teams VALUES (4, 'fadc9684-45b3-47a6-b647-3be3f0735a84', 'bfd38797-8404-4b38-8b82-341da28b1f83', '2020-09-06 15:26:39.925823', NULL);
INSERT INTO taxa.division_teams VALUES (5, 'fadc9684-45b3-47a6-b647-3be3f0735a84', '7966eb04-efcc-499b-8f03-d13916330531', '2020-09-06 15:26:39.925823', NULL);
INSERT INTO taxa.division_teams VALUES (29, 'd4cc18de-a136-4271-84f1-32516be91a80', 'ca3f1c8c-c025-4d8e-8eef-5be6accbeb16', '2020-09-06 15:26:39.925823', NULL);
INSERT INTO taxa.division_teams VALUES (30, 'd4cc18de-a136-4271-84f1-32516be91a80', 'a37f9158-7f82-46bc-908c-c9e2dda7c33b', '2020-09-06 15:26:39.925823', NULL);
INSERT INTO taxa.division_teams VALUES (31, '98c92da4-0ea7-43be-bd75-c6150e184326', '9debc64f-74b7-4ae1-a4d6-fce0144b6ea5', '2020-09-06 15:26:39.925823', NULL);
INSERT INTO taxa.division_teams VALUES (32, '98c92da4-0ea7-43be-bd75-c6150e184326', '3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e', '2020-09-06 15:26:39.925823', NULL);
INSERT INTO taxa.division_teams VALUES (33, '98c92da4-0ea7-43be-bd75-c6150e184326', 'b63be8c2-576a-4d6e-8daf-814f8bcea96f', '2020-09-06 15:26:39.925823', NULL);
INSERT INTO taxa.division_teams VALUES (34, '98c92da4-0ea7-43be-bd75-c6150e184326', 'f02aeae2-5e6a-4098-9842-02d2273f25c7', '2020-09-06 15:26:39.925823', NULL);
INSERT INTO taxa.division_teams VALUES (35, '98c92da4-0ea7-43be-bd75-c6150e184326', '878c1bf6-0d21-4659-bfee-916c8314d69c', '2020-09-06 15:26:39.925823', NULL);
INSERT INTO taxa.division_teams VALUES (38, '456089f0-f338-4620-a014-9540868789c9', '105bc3ff-1320-4e37-8ef0-8d595cb95dd0', '2020-09-06 15:26:39.925823', NULL);
INSERT INTO taxa.division_teams VALUES (39, '456089f0-f338-4620-a014-9540868789c9', 'b024e975-1c4a-4575-8936-a3754a08806a', '2020-09-06 15:26:39.925823', NULL);
INSERT INTO taxa.division_teams VALUES (27, 'd4cc18de-a136-4271-84f1-32516be91a80', '8d87c468-699a-47a8-b40d-cfb73a5660ad', '2020-09-06 15:26:39.925823', '2020-10-18 19:00:09.443928');
INSERT INTO taxa.division_teams VALUES (1, 'fadc9684-45b3-47a6-b647-3be3f0735a84', '57ec08cc-0411-4643-b304-0e80dbc15ac7', '2020-09-06 15:26:39.925823', '2020-10-19 15:00:01.023128');
INSERT INTO taxa.division_teams VALUES (3, 'fadc9684-45b3-47a6-b647-3be3f0735a84', '23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7', '2020-09-06 15:26:39.925823', '2020-10-19 15:00:01.023128');
INSERT INTO taxa.division_teams VALUES (26, 'd4cc18de-a136-4271-84f1-32516be91a80', 'b72f3061-f573-40d7-832a-5ad475bd7909', '2020-09-06 15:26:39.925823', '2020-10-19 15:00:01.023128');
INSERT INTO taxa.division_teams VALUES (28, 'd4cc18de-a136-4271-84f1-32516be91a80', '36569151-a2fb-43c1-9df7-2df512424c82', '2020-09-06 15:26:39.925823', '2020-10-19 15:00:01.023128');
INSERT INTO taxa.division_teams VALUES (36, '456089f0-f338-4620-a014-9540868789c9', '747b8e4a-7e50-4638-a973-ea7950a3e739', '2020-09-06 15:26:39.925823', '2020-10-19 15:00:01.023128');
INSERT INTO taxa.division_teams VALUES (37, '456089f0-f338-4620-a014-9540868789c9', 'eb67ae5e-c4bf-46ca-bbbc-425cd34182ff', '2020-09-06 15:26:39.925823', '2020-10-19 15:00:01.023128');
INSERT INTO taxa.division_teams VALUES (40, '456089f0-f338-4620-a014-9540868789c9', 'adc5b394-8f76-416d-9ce9-813706877b84', '2020-09-06 15:26:39.925823', '2020-10-19 15:00:01.023128');


--
-- Data for Name: divisions; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.divisions VALUES (1, 'Lawful Good', 1, '2020-09-06 15:26:39.925823', '{0,1,2,3,4}', 'f711d960-dc28-4ae2-9249-e1f320fec7d7', '2020-07-29 08:12:22.438');
INSERT INTO taxa.divisions VALUES (2, 'Chaotic Good', 1, '2020-09-06 15:26:39.925823', '{0,1,2,3,4}', '5eb2271a-3e49-48dc-b002-9cb615288836', '2020-07-29 08:12:22.438');
INSERT INTO taxa.divisions VALUES (3, 'Lawful Evil', 2, '2020-09-06 15:26:39.925823', '{0,1,2,3,4}', '765a1e03-4101-4e8e-b611-389e71d13619', '2020-07-29 08:12:22.438');
INSERT INTO taxa.divisions VALUES (4, 'Chaotic Evil', 2, '2020-09-06 15:26:39.925823', '{0,1,2,3,4}', '7fbad33c-59ab-4e80-ba63-347177edaa2e', '2020-07-29 08:12:22.438');
INSERT INTO taxa.divisions VALUES (5, 'Wild High', 3, NULL, '{5}', 'd4cc18de-a136-4271-84f1-32516be91a80', '2020-09-06 15:26:34.254566');
INSERT INTO taxa.divisions VALUES (6, 'Wild Low', 3, NULL, '{5}', '98c92da4-0ea7-43be-bd75-c6150e184326', '2020-09-06 15:26:34.254566');
INSERT INTO taxa.divisions VALUES (7, 'Mild High', 4, NULL, '{5}', '456089f0-f338-4620-a014-9540868789c9', '2020-09-06 15:26:34.254566');
INSERT INTO taxa.divisions VALUES (8, 'Mild Low', 4, NULL, '{5}', 'fadc9684-45b3-47a6-b647-3be3f0735a84', '2020-09-06 15:26:34.254566');


--
-- Data for Name: event_types; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.event_types VALUES (1, 'CAUGHT_STEALING', 0, 0, 0, 0, 1);
INSERT INTO taxa.event_types VALUES (6, 'OUT', 1, 1, 0, 0, 1);
INSERT INTO taxa.event_types VALUES (9, 'STRIKEOUT', 1, 1, 0, 0, 1);
INSERT INTO taxa.event_types VALUES (3, 'DOUBLE', 1, 1, 1, 2, 0);
INSERT INTO taxa.event_types VALUES (5, 'HOME_RUN', 1, 1, 1, 4, 0);
INSERT INTO taxa.event_types VALUES (7, 'SINGLE', 1, 1, 1, 1, 0);
INSERT INTO taxa.event_types VALUES (8, 'STOLEN_BASE', 0, 0, 0, 0, 0);
INSERT INTO taxa.event_types VALUES (10, 'TRIPLE', 1, 1, 1, 3, 0);
INSERT INTO taxa.event_types VALUES (26, 'SACRIFICE', 1, 0, 0, 0, 1);
INSERT INTO taxa.event_types VALUES (27, 'QUADRUPLE', 1, 1, 1, 4, 0);
INSERT INTO taxa.event_types VALUES (4, 'FIELDERS_CHOICE', 1, 1, 0, 0, 1);
INSERT INTO taxa.event_types VALUES (126, 'GAME_OVER', 0, 0, 0, 0, 0);
INSERT INTO taxa.event_types VALUES (12, 'UNKNOWN_OUT', 0, 0, 0, 0, 1);
INSERT INTO taxa.event_types VALUES (178, 'UNKNOWN', 0, 0, 0, 0, 0);
INSERT INTO taxa.event_types VALUES (143, 'DOUBLE WALK', 1, 0, 0, 2, 0);
INSERT INTO taxa.event_types VALUES (13, 'HIT_BY_PITCH', 1, 0, 0, 1, 0);
INSERT INTO taxa.event_types VALUES (197, 'TRIPLE_WALK', 1, 0, 0, 3, 0);
INSERT INTO taxa.event_types VALUES (11, 'WALK', 1, 0, 0, 1, 0);
INSERT INTO taxa.event_types VALUES (217, 'WILD_PITCH', 0, 0, 0, 0, 0);
INSERT INTO taxa.event_types VALUES (28, 'HOME_RUN_5', 1, 1, 1, 5, 0);
INSERT INTO taxa.event_types VALUES (238, 'CHARM_STRIKEOUT', 1, 1, 0, 0, 1);
INSERT INTO taxa.event_types VALUES (260, 'CHARM_WALK', 1, 0, 0, 1, 0);


--
-- Data for Name: leagues; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.leagues VALUES (1, 'Good', '{0,1,2,3,4}', '2020-09-06 15:26:34.254566', '7d3a3dd6-9ea1-4535-9d91-bde875c85e80', '2020-07-29 08:12:22.438');
INSERT INTO taxa.leagues VALUES (2, 'Evil', '{0,1,2,3,4}', '2020-09-06 15:26:34.254566', '93e58443-9617-44d4-8561-e254a1dbd450', '2020-07-29 08:12:22.438');
INSERT INTO taxa.leagues VALUES (3, 'Wild', '{5}', NULL, 'aabc11a1-81af-4036-9f18-229c759ca8a9', '2020-09-06 15:26:34.254566');
INSERT INTO taxa.leagues VALUES (4, 'Mild', '{5}', NULL, '4fe65afa-804f-4bb2-9b15-1281b2eab110', '2020-09-06 15:26:34.254566');


--
-- Data for Name: modifications; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.modifications VALUES (2, 'SHAME_PIT', '#b96dbd', '#b96dbd', '#3d1539', 'Targeted Shame', 'Teams with Targeted Shame will start with negative runs the game after being shamed.', 'team');
INSERT INTO taxa.modifications VALUES (3, 'HOME_FIELD', '#f9ff54', '#f9ff54', '#4f9c30', 'Home Field Advantage', 'Teams with Home Field Advantage will start each home game with one run.', 'team');
INSERT INTO taxa.modifications VALUES (10, 'BLOOD_THIEF', '#ff1f3c', '#ff1f3c', '#52050f', 'Blood Thief', 'In the Blood Bath, this team will steal Stars from a division opponent that finished ahead of them in the standings.', 'team');
INSERT INTO taxa.modifications VALUES (11, 'BLOOD_PITY', '#ff1f3c', '#ff1f3c', '#52050f', 'Blood Pity', 'In the Blood Bath, this team must give Stars to the team that finished last in their division.', 'team');
INSERT INTO taxa.modifications VALUES (12, 'BLOOD_WINNER', '#ff1f3c', '#ff1f3c', '#52050f', 'Blood Winner', 'In the Blood Bath, this team must give Stars to the team that finished first in their division.', 'team');
INSERT INTO taxa.modifications VALUES (14, 'BLOOD_LAW', '#ff1f3c', '#ff1f3c', '#52050f', 'Blood Law', 'In the Blood Bath, this team will gain or lose Stars depending on how low or high they finish in their division.', 'team');
INSERT INTO taxa.modifications VALUES (15, 'BLOOD_CHAOS', '#ff1f3c', '#ff1f3c', '#52050f', 'Blood Chaos', 'In the Blood Bath, each player on this team will gain or lose a random amount of Stars.', 'team');
INSERT INTO taxa.modifications VALUES (19, 'PARTY_TIME', '#ff66f9', '#ff66f9', '#fff947', 'Party Time', 'This team is mathematically eliminated from the Postseason, and will occasionally receive permanent stats boost in their games.', 'team');
INSERT INTO taxa.modifications VALUES (20, 'LIFE_OF_PARTY', '#fff45e', '#fff45e', '#9141ba', 'Life of the Party', 'This team gets 10% more from their Party Time stat boosts.', 'team');
INSERT INTO taxa.modifications VALUES (31, 'EXTRA_BASE', '#d9d9d9', '#d9d9d9', '#4a001a', 'Fifth Base', 'This team must run five bases instead of four in order to score.', 'team');
INSERT INTO taxa.modifications VALUES (32, 'BLESS_OFF', '#e0cafa', '#e0cafa', '#7d58a8', 'Bless Off', 'This team cannot win any Blessings in the upcoming Election.', 'team');
INSERT INTO taxa.modifications VALUES (35, 'ELECTRIC', '#fff199', '#fff199', '#04144a', 'Electric', 'Electric teams have a chance of zapping away Strikes.', 'team');
INSERT INTO taxa.modifications VALUES (40, 'GROWTH', '#52a17b', '#52a17b', '#13422b', 'Growth', 'Growth teams will play better as the season goes on, up to a 5% global boost by season''s end.', 'team');
INSERT INTO taxa.modifications VALUES (41, 'BASE_INSTINCTS', '#dedede', '#dedede', '#329c98', 'Base Instincts', 'Batters with Base Instincts will have a chance of heading past first base when getting walked.', 'team');
INSERT INTO taxa.modifications VALUES (4, 'FIREPROOF', '#a5c5f0', '#a5c5f0', '#4c77b0', 'Fireproof', 'A Fireproof player can not be incinerated.', 'player');
INSERT INTO taxa.modifications VALUES (5, 'ALTERNATE', '#fffd85', '#fffd85', '#404040', 'Alternate', 'This player is an Alternate...', 'player');
INSERT INTO taxa.modifications VALUES (6, 'SOUNDPROOF', '#c92080', '#c92080', '#000000', 'Soundproof', 'A Soundproof player can not be caught in Feedback''s reality flickers.', 'player');
INSERT INTO taxa.modifications VALUES (7, 'SHELLED', '#fffd85', '#fffd85', '#404040', 'Shelled', 'A Shelled player is trapped in a big Peanut is unable to bat or pitch.', 'player');
INSERT INTO taxa.modifications VALUES (8, 'REVERBERATING', '#61b3ff', '#61b3ff', '#756773', 'Reverberating', 'A Reverberating player has a small chance of batting again after each of their At-Bats end.', 'player');
INSERT INTO taxa.modifications VALUES (13, 'BLOOD_FAITH', '#ff1f3c', '#ff1f3c', '#52050f', 'Blood Faith', 'In the Blood Bath, this player will receive a small boost to a random stat.', 'player');
INSERT INTO taxa.modifications VALUES (17, 'INWARD', '#d3d8de', '#d3d8de', '#38080d', 'Inward', 'This player has turned Inward.', 'player');
INSERT INTO taxa.modifications VALUES (18, 'MARKED', '#eaabff', '#eaabff', '#1b1c80', 'Unstable', 'Unstable players have a much higher chance of being incinerated in a Solar Eclipse.', 'player');
INSERT INTO taxa.modifications VALUES (21, 'DEBT_ZERO', '#ff1f3c', '#ff1f3c', '#1b1c80', 'Debt', 'This player must fulfill a debt.', 'player');
INSERT INTO taxa.modifications VALUES (22, 'DEBT', '#ff1f3c', '#ff1f3c', '#363738', 'Refinanced Debt', 'This player must fulfill a debt.', 'player');
INSERT INTO taxa.modifications VALUES (23, 'DEBT_TWO', '#ff1f3c', '#ff1f3c', '#612273', 'Consolidated Debt', 'This player must fulfill a debt.', 'player');
INSERT INTO taxa.modifications VALUES (24, 'SPICY', '#9e0022', '#9e0022', '#d15700', 'Spicy', 'Spicy batters will be Red Hot when they get three consecutive hits.', 'player');
INSERT INTO taxa.modifications VALUES (25, 'HEATING_UP', '#9e0022', '#9e0022', '#d15700', 'Heating Up...', 'This batter needs one more consecutive hit to enter Fire mode. This mod will disappear if the batter gets out.', 'player');
INSERT INTO taxa.modifications VALUES (26, 'ON_FIRE', '#fff982', '#fff982', '#e32600', 'Red Hot!', 'Red Hot! This player''s batting is greatly boosted. This mod will disappear if the batter gets out.', 'player');
INSERT INTO taxa.modifications VALUES (27, 'HONEY_ROASTED', '#ffda75', '#ffda75', '#b5831f', 'Honey Roasted', 'This player has been Honey-Roasted.', 'player');
INSERT INTO taxa.modifications VALUES (28, 'FIRST_BORN', '#fffea8', '#fffea8', '#517063', 'First Born', 'This player was the first born from the New Field of Eggs.', 'player');
INSERT INTO taxa.modifications VALUES (29, 'SUPERALLERGIC', '#bd224e', '#bd224e', '#45003d', 'Superallergic', 'This player is Superallergic', 'player');
INSERT INTO taxa.modifications VALUES (30, 'SUPERYUMMY', '#ffdb59', '#ffdb59', '#c96faa', 'Superyummy', 'This player seriously loves peanuts', 'player');
INSERT INTO taxa.modifications VALUES (33, 'NON_IDOLIZED', '#fffaba', '#fffaba', '#540e43', 'Idol Immune', 'Idol Immune players cannot be Idolized by Fans.', 'player');
INSERT INTO taxa.modifications VALUES (34, 'GRAVITY', '#759bc9', '#759bc9', '#4c5052', 'Gravity', 'This player cannot be affected by Reverb.', 'player');
INSERT INTO taxa.modifications VALUES (36, 'DOUBLE_PAYOUTS', '#fffaba', '#fffaba', '#786600', 'Super Idol', 'This player will earn Fans double the rewards from all Idol Pendants.', 'player');
INSERT INTO taxa.modifications VALUES (37, 'FIRE_PROTECTOR', '#c4ff85', '#c4ff85', '#1f474f', 'Fire Protector', 'This player will protect their team from incinerations.', 'player');
INSERT INTO taxa.modifications VALUES (38, 'RECEIVER', '#ff007b', '#ff007b', '#383838', 'Receiver', 'This player is a Receiver.', 'player');
INSERT INTO taxa.modifications VALUES (39, 'FLICKERING', '#ff007b', '#ff007b', '#383838', 'Flickering', 'Flickering players have a much higher chance of being Feedbacked to their opponent.', 'player');
INSERT INTO taxa.modifications VALUES (42, 'STABLE', '#91b5a3', '#91b5a3', '#335980', 'Stable', 'Stable players cannot be made Unstable.', 'player');
INSERT INTO taxa.modifications VALUES (45, 'SQUIDDISH', '#5988ff', '#5988ff', '#163073', 'Squiddish', 'When a Squiddish player is incinerated, they''ll be replaced by a random Hall of Flame player.', 'player');
INSERT INTO taxa.modifications VALUES (46, 'CRUNCHY', '#f5eb5d', '#f5eb5d', '#de8123', 'Crunchy', 'The Honey-Roasted players on a Crunchy team will hit 100% better and with +200% Power.', 'player');
INSERT INTO taxa.modifications VALUES (49, 'REPEATING', '#61b3ff', '#61b3ff', '#3d5982', 'Repeating', 'In Reverb Weather, this player will Repeat.', 'player');
INSERT INTO taxa.modifications VALUES (52, 'FIRE_EATER', '#f50a31', '#f50a31', '#e3d514', 'Fire Eater', 'Fire Eaters swallow fire instead of being incinerated.', 'player');
INSERT INTO taxa.modifications VALUES (51, 'LIBERATED', '#90eb07', '#90eb07', '#07a1a3', 'Liberated', 'Liberated players will be guaranteed extra bases when they get a hit.', 'player');
INSERT INTO taxa.modifications VALUES (53, 'MAGMATIC', '#e63200', '#e63200', '#6b0004', 'Magmatic', 'Magmatic players are guaranteed to hit a home run in their next At Bat.', 'player');
INSERT INTO taxa.modifications VALUES (54, 'LOYALTY', '#ff61a5', '#ff61a5', '#2c1240', 'Loyalty', 'Players leaving a team with Loyalty will gain the Saboteur modification.', 'player');
INSERT INTO taxa.modifications VALUES (44, 'CURSE_OF_CROWS', '#915387', '#915387', '#3d2830', 'Curse of Crows', 'This team or player will be occasionally attacked by Birds.', 'both');
INSERT INTO taxa.modifications VALUES (47, 'PITY', '#ffffff', '#ffffff', '#000000', 'Pity', 'This team is holding back, out of Pity.', 'team');
INSERT INTO taxa.modifications VALUES (48, 'GOD', '#ff4d90', '#ff4d90', '#fffc57', 'God', 'This team will start with 1,000x the amount of Team Spirit', 'team');
INSERT INTO taxa.modifications VALUES (50, 'SUBJECTION', '#d16f6f', '#d16f6f', '#2e2f33', 'Subjection', 'Players leaving a team with Subjection will gain the Liberated modification.', 'team');
INSERT INTO taxa.modifications VALUES (1, 'EXTRA_STRIKE', '#f77c9f', '#f77c9f', '#8c1839', 'The Fourth Strike', 'Those with the Fourth Strike will get an extra strike in each at bat.', 'team');
INSERT INTO taxa.modifications VALUES (9, 'BLOOD_DONOR', '#ff1f3c', '#ff1f3c', '#52050f', 'Blood Donor', 'In the Blood Bath, this team will donate Stars to a division opponent that finished behind them in the standings.', 'team');
INSERT INTO taxa.modifications VALUES (16, 'RETURNED', '#fbff8a', '#fbff8a', '#1b1c80', 'Returned', 'This player has Returned from the void. At the end of each season, this player has a chance of being called back to the Void.', 'player');
INSERT INTO taxa.modifications VALUES (43, 'AFFINITY_FOR_CROWS', '#cb80d9', '#cb80d9', '#240c36', 'Affinity for Crows', 'Players with Affinity for Crows will hit and pitch 50% better during Birds weather.', 'player');
INSERT INTO taxa.modifications VALUES (55, 'SABOTEUR', '#6b6a6a', '#6b6a6a', '#240c36', 'Saboteur', 'A Saboteur has a chance of intentionally failing.', 'player');
INSERT INTO taxa.modifications VALUES (56, 'CREDIT_TO_THE_TEAM', '#fffaba', '#fffaba', '#786600', 'Credit to the Team', 'This player will earn Fans 5x the rewards from all Idol Pendants.', 'player');
INSERT INTO taxa.modifications VALUES (59, 'FLINCH', '#219ccc', '#219ccc', '#5e5e5e', 'Flinch', 'Hitters with Flinch cannot swing until a strike has been thrown in the At Bat.', 'player');
INSERT INTO taxa.modifications VALUES (60, 'WILD', '#219ccc', '#219ccc', '#361a57', 'Mild', 'Pitchers with Mild have a chance of throwing a Mild Pitch.', 'player');
INSERT INTO taxa.modifications VALUES (62, 'SIPHON', '#e30000', '#e30000', '#2b0000', 'Siphon', 'Siphons will steal blood more often in Blooddrain and use it in more ways.', 'player');
INSERT INTO taxa.modifications VALUES (63, 'FLIICKERRRIIING', '#80fffb', '#80fffb', '#383838', 'Fliickerrriiing', 'Fliickerrriiing players are Flickering a lot.', 'player');
INSERT INTO taxa.modifications VALUES (64, 'FRIEND_OF_CROWS', '#ff7ae7', '#ff7ae7', '#570026', 'Friend of Crows', 'In Birds weather, pitchers with Friend of Crows will encourage the Birds to attack hitters.', 'player');
INSERT INTO taxa.modifications VALUES (65, 'BLASERUNNING', '#fffaa3', '#fffaa3', '#570026', 'Blaserunning', 'Blaserunners will score .2 Runs for their Team whenever they steal a base.', 'player');
INSERT INTO taxa.modifications VALUES (68, 'HAUNTED', '#b59c9c', '#b59c9c', '#1c1c1c', 'Haunted', 'Haunted players will occasionally be Inhabited.', 'player');
INSERT INTO taxa.modifications VALUES (69, 'TRAVELING', '#cfebff', '#cfebff', '#1c1c1c', 'Traveling', 'Traveling teams will play 5% better in Away games.', 'team');
INSERT INTO taxa.modifications VALUES (78, 'RETIRED', '#d3ede5', '#d3ede5', '#000e33', 'Released', '', 'player');
INSERT INTO taxa.modifications VALUES (79, 'RESTING', '#5988ff', '#5988ff', '#163073', 'Resting', '', 'player');
INSERT INTO taxa.modifications VALUES (80, 'INHABITING', '#b59c9c', '#b59c9c', '#1c1c1c', 'Inhabiting', 'This player is temporarily Inhabiting a Haunted player.', 'player');
INSERT INTO taxa.modifications VALUES (57, 'LOVE', '#ff2b6b', '#ff2b6b', '#732652', 'Charm', 'Players with Charm have a chance of convincing their opponents to fail.', 'team');
INSERT INTO taxa.modifications VALUES (58, 'PEANUT_RAIN', '#fff199', '#fff199', '#04144a', 'Peanut Rain', 'This Team weaponizes Peanut weather against their enemies.', 'team');
INSERT INTO taxa.modifications VALUES (61, 'DESTRUCTION', '#ff8a24', '#ff8a24', '#802d00', 'Destruction', 'Teams with Destruction will add a bunch of Curses to their Opponent when defeating them in battle.', 'team');
INSERT INTO taxa.modifications VALUES (66, 'WALK_IN_THE_PARK', '#faff9c', '#faff9c', '#275c2a', 'Walk in the Park', 'Those with Walk in the Park will walk to first base on one less Ball.', 'team');
INSERT INTO taxa.modifications VALUES (67, 'BIRD_SEED', '#1e0036', '#dca8f7', '#dca8f7', 'Bird Seed', 'Birds like to eat Bird Seed. They''ll peck those with Bird Seed out of peanut shells more often. Because they like to eat Bird Seed.', 'team');
INSERT INTO taxa.modifications VALUES (70, 'SEALANT', '#eded91', '#eded91', '#571f26', 'Sealant', 'Players with Sealant cannot have blood drained in Blooddrain.', 'team');
INSERT INTO taxa.modifications VALUES (71, 'O_NO', '#cffff0', '#cffff0', '#485099', '0 No', 'Players with 0 No cannot be struck out when there are 0 Balls in the Count.', 'team');
INSERT INTO taxa.modifications VALUES (72, 'FAIRNESS', '#12b300', '#12b300', '#ffdb0f', 'Total Fairness', 'This Season, each team will win only one Blessing, and will be Happy with what they get.', 'team');
INSERT INTO taxa.modifications VALUES (73, 'ESCAPE', '#ffe521', '#ffe521', '#0d0d0d', 'Pending', 'The players on this Team are Pending...', 'team');
INSERT INTO taxa.modifications VALUES (74, 'UNFLAMED', '#eaabff', '#eaabff', '#1b1c80', 'Chaotic', 'The Unstable players on a Chaotic team will hit 100% better.', 'team');
INSERT INTO taxa.modifications VALUES (75, 'TRIBUTE', '#dbce6e', '#dbce6e', '#362803', 'Tribute', 'When Hall of Flame players join this team, they''ll add their Tribute as Team Spirit.', 'team');
INSERT INTO taxa.modifications VALUES (76, 'SQUIDDEST', '#e6eaeb', '#e6eaeb', '#163073', 'Squiddest', 'This Team is the Squiddest. When a player joins the Team, they''ll become Squiddish.', 'team');
INSERT INTO taxa.modifications VALUES (77, 'CONTAINMENT', '#91ab91', '#91ab91', '#023802', 'Containment', 'When an Unstable player on this team is incinerated, the Instability cannot chain to their opponent.', 'team');


--
-- Data for Name: phases; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.phases VALUES (1, 'PRESEASON', 0);
INSERT INTO taxa.phases VALUES (2, 'GAMEDAY', 1);
INSERT INTO taxa.phases VALUES (3, 'END_REGULAR_SEASON', 2);
INSERT INTO taxa.phases VALUES (7, 'END_REGULAR_SEASON', 2);
INSERT INTO taxa.phases VALUES (4, 'POSTSEASON', 3);
INSERT INTO taxa.phases VALUES (10, 'POSTSEASON', 3);
INSERT INTO taxa.phases VALUES (11, 'POSTSEASON', 3);
INSERT INTO taxa.phases VALUES (9, 'BOSS_FIGHT', 4);
INSERT INTO taxa.phases VALUES (0, 'ELECTION_RESULTS', 5);
INSERT INTO taxa.phases VALUES (5, 'END_POSTSEASON', 5);
INSERT INTO taxa.phases VALUES (6, 'END_POSTSEASON', 5);
INSERT INTO taxa.phases VALUES (8, 'UNKNOWN_THE_OCHO', 99);
INSERT INTO taxa.phases VALUES (99, 'SIESTA', 99);
INSERT INTO taxa.phases VALUES (12, 'TOURNAMENT_PRESEASON', 6);
INSERT INTO taxa.phases VALUES (13, 'TOURNAMENT_GAMEDAY', 7);
INSERT INTO taxa.phases VALUES (14, 'TOURNAMENT_GAMEDAY', 7);
INSERT INTO taxa.phases VALUES (15, 'TOURNAMENT_POSTSEASON', 8);
INSERT INTO taxa.phases VALUES (16, 'END_TOURNAMENT', 9);


--
-- Data for Name: pitch_types; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.pitch_types VALUES ('F', 'Foul Ball', 0, 0);
INSERT INTO taxa.pitch_types VALUES ('X', 'Ball in play', 0, 0);
INSERT INTO taxa.pitch_types VALUES ('A', 'Ball - Assumed', 1, 0);
INSERT INTO taxa.pitch_types VALUES ('B', 'Ball', 1, 0);
INSERT INTO taxa.pitch_types VALUES ('C', 'Called Strike', 0, 1);
INSERT INTO taxa.pitch_types VALUES ('K', 'Strike - Assumed', 0, 1);
INSERT INTO taxa.pitch_types VALUES ('S', 'Swinging Strike', 0, 1);


--
-- Data for Name: position_types; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.position_types VALUES (0, 'BATTER');
INSERT INTO taxa.position_types VALUES (1, 'PITCHER');
INSERT INTO taxa.position_types VALUES (2, 'BULLPEN');
INSERT INTO taxa.position_types VALUES (3, 'BENCH');


--
-- Data for Name: team_abbreviations; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.team_abbreviations VALUES (1, 'CRAB', '8d87c468-699a-47a8-b40d-cfb73a5660ad');
INSERT INTO taxa.team_abbreviations VALUES (2, 'BOS', '3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e');
INSERT INTO taxa.team_abbreviations VALUES (3, 'JAZZ', 'a37f9158-7f82-46bc-908c-c9e2dda7c33b');
INSERT INTO taxa.team_abbreviations VALUES (4, 'CAN', 'eb67ae5e-c4bf-46ca-bbbc-425cd34182ff');
INSERT INTO taxa.team_abbreviations VALUES (5, 'CHST', 'bfd38797-8404-4b38-8b82-341da28b1f83');
INSERT INTO taxa.team_abbreviations VALUES (6, 'CHI', 'ca3f1c8c-c025-4d8e-8eef-5be6accbeb16');
INSERT INTO taxa.team_abbreviations VALUES (7, 'STK', 'b024e975-1c4a-4575-8936-a3754a08806a');
INSERT INTO taxa.team_abbreviations VALUES (8, 'TGRS', '747b8e4a-7e50-4638-a973-ea7950a3e739');
INSERT INTO taxa.team_abbreviations VALUES (9, 'FRI', '979aee4a-6d80-4863-bf1c-ee1a78e06024');
INSERT INTO taxa.team_abbreviations VALUES (10, 'HELL', 'f02aeae2-5e6a-4098-9842-02d2273f25c7');
INSERT INTO taxa.team_abbreviations VALUES (11, 'SPY', '9debc64f-74b7-4ae1-a4d6-fce0144b6ea5');
INSERT INTO taxa.team_abbreviations VALUES (12, 'KCBM', 'adc5b394-8f76-416d-9ce9-813706877b84');
INSERT INTO taxa.team_abbreviations VALUES (13, 'CDMX', '57ec08cc-0411-4643-b304-0e80dbc15ac7');
INSERT INTO taxa.team_abbreviations VALUES (14, 'DALE', 'b63be8c2-576a-4d6e-8daf-814f8bcea96f');
INSERT INTO taxa.team_abbreviations VALUES (15, 'NYM', '36569151-a2fb-43c1-9df7-2df512424c82');
INSERT INTO taxa.team_abbreviations VALUES (16, 'PIES', '23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7');
INSERT INTO taxa.team_abbreviations VALUES (17, 'LVRS', 'b72f3061-f573-40d7-832a-5ad475bd7909');
INSERT INTO taxa.team_abbreviations VALUES (18, 'SEA', '105bc3ff-1320-4e37-8ef0-8d595cb95dd0');
INSERT INTO taxa.team_abbreviations VALUES (19, 'LIFT', 'c73b705c-40ad-4633-a6ed-d357ee2e2bcf');
INSERT INTO taxa.team_abbreviations VALUES (20, 'TACO', '878c1bf6-0d21-4659-bfee-916c8314d69c');
INSERT INTO taxa.team_abbreviations VALUES (21, 'YELL', '7966eb04-efcc-499b-8f03-d13916330531');
INSERT INTO taxa.team_abbreviations VALUES (22, 'PODS', '40b9ec2a-cb43-4dbb-b836-5accb62e7c20');
INSERT INTO taxa.team_abbreviations VALUES (23, 'STAR', 'c6c01051-cdd4-47d6-8a98-bb5b754f937f');


--
-- Data for Name: team_divine_favor; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.team_divine_favor VALUES (1, 'b72f3061-f573-40d7-832a-5ad475bd7909', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 1);
INSERT INTO taxa.team_divine_favor VALUES (2, '878c1bf6-0d21-4659-bfee-916c8314d69c', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 2);
INSERT INTO taxa.team_divine_favor VALUES (3, 'b024e975-1c4a-4575-8936-a3754a08806a', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 3);
INSERT INTO taxa.team_divine_favor VALUES (5, 'ca3f1c8c-c025-4d8e-8eef-5be6accbeb16', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 5);
INSERT INTO taxa.team_divine_favor VALUES (6, 'bfd38797-8404-4b38-8b82-341da28b1f83', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 6);
INSERT INTO taxa.team_divine_favor VALUES (7, '3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 7);
INSERT INTO taxa.team_divine_favor VALUES (8, '979aee4a-6d80-4863-bf1c-ee1a78e06024', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 8);
INSERT INTO taxa.team_divine_favor VALUES (9, '7966eb04-efcc-499b-8f03-d13916330531', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 9);
INSERT INTO taxa.team_divine_favor VALUES (11, '8d87c468-699a-47a8-b40d-cfb73a5660ad', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 11);
INSERT INTO taxa.team_divine_favor VALUES (12, '23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 12);
INSERT INTO taxa.team_divine_favor VALUES (13, 'f02aeae2-5e6a-4098-9842-02d2273f25c7', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 13);
INSERT INTO taxa.team_divine_favor VALUES (14, '57ec08cc-0411-4643-b304-0e80dbc15ac7', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 14);
INSERT INTO taxa.team_divine_favor VALUES (15, '747b8e4a-7e50-4638-a973-ea7950a3e739', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 15);
INSERT INTO taxa.team_divine_favor VALUES (16, 'eb67ae5e-c4bf-46ca-bbbc-425cd34182ff', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 16);
INSERT INTO taxa.team_divine_favor VALUES (17, '9debc64f-74b7-4ae1-a4d6-fce0144b6ea5', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 17);
INSERT INTO taxa.team_divine_favor VALUES (18, 'b63be8c2-576a-4d6e-8daf-814f8bcea96f', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 18);
INSERT INTO taxa.team_divine_favor VALUES (19, '105bc3ff-1320-4e37-8ef0-8d595cb95dd0', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 19);
INSERT INTO taxa.team_divine_favor VALUES (4, 'adc5b394-8f76-416d-9ce9-813706877b84', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 4);
INSERT INTO taxa.team_divine_favor VALUES (10, '36569151-a2fb-43c1-9df7-2df512424c82', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 10);
INSERT INTO taxa.team_divine_favor VALUES (20, 'a37f9158-7f82-46bc-908c-c9e2dda7c33b', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 20);
INSERT INTO taxa.team_divine_favor VALUES (21, '23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 1);
INSERT INTO taxa.team_divine_favor VALUES (41, 'b72f3061-f573-40d7-832a-5ad475bd7909', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 2);
INSERT INTO taxa.team_divine_favor VALUES (42, '878c1bf6-0d21-4659-bfee-916c8314d69c', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 3);
INSERT INTO taxa.team_divine_favor VALUES (43, 'b024e975-1c4a-4575-8936-a3754a08806a', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 4);
INSERT INTO taxa.team_divine_favor VALUES (44, 'ca3f1c8c-c025-4d8e-8eef-5be6accbeb16', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 6);
INSERT INTO taxa.team_divine_favor VALUES (45, 'bfd38797-8404-4b38-8b82-341da28b1f83', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 7);
INSERT INTO taxa.team_divine_favor VALUES (46, '3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 8);
INSERT INTO taxa.team_divine_favor VALUES (47, '979aee4a-6d80-4863-bf1c-ee1a78e06024', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 9);
INSERT INTO taxa.team_divine_favor VALUES (48, '7966eb04-efcc-499b-8f03-d13916330531', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 10);
INSERT INTO taxa.team_divine_favor VALUES (49, '8d87c468-699a-47a8-b40d-cfb73a5660ad', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 12);
INSERT INTO taxa.team_divine_favor VALUES (50, 'f02aeae2-5e6a-4098-9842-02d2273f25c7', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 13);
INSERT INTO taxa.team_divine_favor VALUES (51, '57ec08cc-0411-4643-b304-0e80dbc15ac7', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 14);
INSERT INTO taxa.team_divine_favor VALUES (52, '747b8e4a-7e50-4638-a973-ea7950a3e739', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 15);
INSERT INTO taxa.team_divine_favor VALUES (53, 'eb67ae5e-c4bf-46ca-bbbc-425cd34182ff', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 16);
INSERT INTO taxa.team_divine_favor VALUES (54, '9debc64f-74b7-4ae1-a4d6-fce0144b6ea5', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 17);
INSERT INTO taxa.team_divine_favor VALUES (55, 'b63be8c2-576a-4d6e-8daf-814f8bcea96f', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 18);
INSERT INTO taxa.team_divine_favor VALUES (56, '105bc3ff-1320-4e37-8ef0-8d595cb95dd0', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 19);
INSERT INTO taxa.team_divine_favor VALUES (57, 'adc5b394-8f76-416d-9ce9-813706877b84', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 5);
INSERT INTO taxa.team_divine_favor VALUES (58, '36569151-a2fb-43c1-9df7-2df512424c82', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 11);
INSERT INTO taxa.team_divine_favor VALUES (59, 'a37f9158-7f82-46bc-908c-c9e2dda7c33b', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 20);
INSERT INTO taxa.team_divine_favor VALUES (60, 'ca3f1c8c-c025-4d8e-8eef-5be6accbeb16', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 1);
INSERT INTO taxa.team_divine_favor VALUES (61, 'a37f9158-7f82-46bc-908c-c9e2dda7c33b', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 2);
INSERT INTO taxa.team_divine_favor VALUES (62, 'b63be8c2-576a-4d6e-8daf-814f8bcea96f', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 3);
INSERT INTO taxa.team_divine_favor VALUES (63, '979aee4a-6d80-4863-bf1c-ee1a78e06024', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 4);
INSERT INTO taxa.team_divine_favor VALUES (64, 'bfd38797-8404-4b38-8b82-341da28b1f83', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 5);
INSERT INTO taxa.team_divine_favor VALUES (65, 'b72f3061-f573-40d7-832a-5ad475bd7909', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 6);
INSERT INTO taxa.team_divine_favor VALUES (66, '23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 7);
INSERT INTO taxa.team_divine_favor VALUES (67, '747b8e4a-7e50-4638-a973-ea7950a3e739', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 8);
INSERT INTO taxa.team_divine_favor VALUES (68, '105bc3ff-1320-4e37-8ef0-8d595cb95dd0', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 9);
INSERT INTO taxa.team_divine_favor VALUES (69, 'f02aeae2-5e6a-4098-9842-02d2273f25c7', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 10);
INSERT INTO taxa.team_divine_favor VALUES (70, '36569151-a2fb-43c1-9df7-2df512424c82', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 11);
INSERT INTO taxa.team_divine_favor VALUES (71, '9debc64f-74b7-4ae1-a4d6-fce0144b6ea5', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 12);
INSERT INTO taxa.team_divine_favor VALUES (72, 'adc5b394-8f76-416d-9ce9-813706877b84', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 13);
INSERT INTO taxa.team_divine_favor VALUES (73, '7966eb04-efcc-499b-8f03-d13916330531', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 14);
INSERT INTO taxa.team_divine_favor VALUES (74, 'b024e975-1c4a-4575-8936-a3754a08806a', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 15);
INSERT INTO taxa.team_divine_favor VALUES (75, '8d87c468-699a-47a8-b40d-cfb73a5660ad', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 16);
INSERT INTO taxa.team_divine_favor VALUES (76, '57ec08cc-0411-4643-b304-0e80dbc15ac7', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 17);
INSERT INTO taxa.team_divine_favor VALUES (77, '3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 18);
INSERT INTO taxa.team_divine_favor VALUES (78, 'eb67ae5e-c4bf-46ca-bbbc-425cd34182ff', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 19);
INSERT INTO taxa.team_divine_favor VALUES (79, '878c1bf6-0d21-4659-bfee-916c8314d69c', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 20);
INSERT INTO taxa.team_divine_favor VALUES (80, '878c1bf6-0d21-4659-bfee-916c8314d69c', '2020-09-26 10:30:06.338053', NULL, 1);
INSERT INTO taxa.team_divine_favor VALUES (81, 'b72f3061-f573-40d7-832a-5ad475bd7909', '2020-09-26 10:30:06.344018', NULL, 2);
INSERT INTO taxa.team_divine_favor VALUES (82, '979aee4a-6d80-4863-bf1c-ee1a78e06024', '2020-09-26 10:30:06.354634', NULL, 3);
INSERT INTO taxa.team_divine_favor VALUES (83, 'bfd38797-8404-4b38-8b82-341da28b1f83', '2020-09-26 10:30:06.360136', NULL, 4);
INSERT INTO taxa.team_divine_favor VALUES (84, 'adc5b394-8f76-416d-9ce9-813706877b84', '2020-09-26 10:30:06.3678', NULL, 5);
INSERT INTO taxa.team_divine_favor VALUES (85, '747b8e4a-7e50-4638-a973-ea7950a3e739', '2020-09-26 10:30:06.372765', NULL, 6);
INSERT INTO taxa.team_divine_favor VALUES (86, '7966eb04-efcc-499b-8f03-d13916330531', '2020-09-26 10:30:06.37793', NULL, 7);
INSERT INTO taxa.team_divine_favor VALUES (87, 'a37f9158-7f82-46bc-908c-c9e2dda7c33b', '2020-09-26 10:30:06.386655', NULL, 8);
INSERT INTO taxa.team_divine_favor VALUES (88, '23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7', '2020-09-26 10:30:06.393127', NULL, 9);
INSERT INTO taxa.team_divine_favor VALUES (89, 'f02aeae2-5e6a-4098-9842-02d2273f25c7', '2020-09-26 10:30:06.401098', NULL, 10);
INSERT INTO taxa.team_divine_favor VALUES (90, 'b63be8c2-576a-4d6e-8daf-814f8bcea96f', '2020-09-26 10:30:06.406416', NULL, 11);
INSERT INTO taxa.team_divine_favor VALUES (91, '36569151-a2fb-43c1-9df7-2df512424c82', '2020-09-26 10:30:06.412655', NULL, 12);
INSERT INTO taxa.team_divine_favor VALUES (92, 'eb67ae5e-c4bf-46ca-bbbc-425cd34182ff', '2020-09-26 10:30:06.419253', NULL, 13);
INSERT INTO taxa.team_divine_favor VALUES (93, '3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e', '2020-09-26 10:30:06.424344', NULL, 14);
INSERT INTO taxa.team_divine_favor VALUES (94, 'b024e975-1c4a-4575-8936-a3754a08806a', '2020-09-26 10:30:06.43123', NULL, 15);
INSERT INTO taxa.team_divine_favor VALUES (95, '105bc3ff-1320-4e37-8ef0-8d595cb95dd0', '2020-09-26 10:30:06.438918', NULL, 16);
INSERT INTO taxa.team_divine_favor VALUES (96, 'ca3f1c8c-c025-4d8e-8eef-5be6accbeb16', '2020-09-26 10:30:06.444359', NULL, 17);
INSERT INTO taxa.team_divine_favor VALUES (97, '8d87c468-699a-47a8-b40d-cfb73a5660ad', '2020-09-26 10:30:06.451267', NULL, 18);
INSERT INTO taxa.team_divine_favor VALUES (98, '57ec08cc-0411-4643-b304-0e80dbc15ac7', '2020-09-26 10:30:06.456357', NULL, 19);
INSERT INTO taxa.team_divine_favor VALUES (99, '9debc64f-74b7-4ae1-a4d6-fce0144b6ea5', '2020-09-26 10:30:06.46395', NULL, 20);


--
-- Data for Name: tournament_teams; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.tournament_teams VALUES (1, 1, '4e5d0063-73b4-440a-b2d1-214a7345cf16', NULL, NULL);
INSERT INTO taxa.tournament_teams VALUES (2, 1, '49181b72-7f1c-4f1c-929f-928d763ad7fb', NULL, NULL);
INSERT INTO taxa.tournament_teams VALUES (3, 1, 'f29d6e60-8fce-4ac6-8bc2-b5e3cabc5696', NULL, NULL);
INSERT INTO taxa.tournament_teams VALUES (4, 1, 'a3ea6358-ce03-4f23-85f9-deb38cb81b20', NULL, NULL);
INSERT INTO taxa.tournament_teams VALUES (5, 1, '4d921519-410b-41e2-882e-9726a4e54a6a', NULL, NULL);
INSERT INTO taxa.tournament_teams VALUES (6, 1, 'b3b9636a-f88a-47dc-a91d-86ecc79f9934', NULL, NULL);
INSERT INTO taxa.tournament_teams VALUES (7, 1, 'e3f90fa1-0bbe-40df-88ce-578d0723a23b', NULL, NULL);
INSERT INTO taxa.tournament_teams VALUES (8, 1, 'e8f7ffee-ec53-4fe0-8e87-ea8ff1d0b4a9', NULL, NULL);
INSERT INTO taxa.tournament_teams VALUES (9, 1, 'd8f82163-2e74-496b-8e4b-2ab35b2d3ff1', NULL, NULL);
INSERT INTO taxa.tournament_teams VALUES (10, 1, '70eab4ab-6cb1-41e7-ac8b-1050ee12eecc', NULL, NULL);
INSERT INTO taxa.tournament_teams VALUES (11, 1, '9e42c12a-7561-42a2-b2d0-7cf81a817a5e', NULL, NULL);
INSERT INTO taxa.tournament_teams VALUES (12, 1, 'a7592bd7-1d3c-4ffb-8b3a-0b1e4bc321fd', NULL, NULL);
INSERT INTO taxa.tournament_teams VALUES (13, 1, '3b0a289b-aebd-493c-bc11-96793e7216d5', NULL, NULL);
INSERT INTO taxa.tournament_teams VALUES (14, 1, '7fcb63bc-11f2-40b9-b465-f1d458692a63', NULL, NULL);
INSERT INTO taxa.tournament_teams VALUES (15, 1, '9a5ab308-41f2-4889-a3c3-733b9aab806e', NULL, NULL);
INSERT INTO taxa.tournament_teams VALUES (16, 1, 'd2634113-b650-47b9-ad95-673f8e28e687', NULL, NULL);


--
-- Data for Name: tournaments; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.tournaments VALUES (1, 0, 'The Coffee Cup', NULL, NULL);


--
-- Data for Name: vibe_to_arrows; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.vibe_to_arrows VALUES (1, 3, 0.8, 999);
INSERT INTO taxa.vibe_to_arrows VALUES (2, 2, 0.4, 0.8);
INSERT INTO taxa.vibe_to_arrows VALUES (3, 1, 0.1, 0.4);
INSERT INTO taxa.vibe_to_arrows VALUES (6, 0, -0.1, 0.1);
INSERT INTO taxa.vibe_to_arrows VALUES (7, -1, -0.4, -0.1);
INSERT INTO taxa.vibe_to_arrows VALUES (8, -2, -0.8, -0.4);
INSERT INTO taxa.vibe_to_arrows VALUES (9, 0, -999, -0.8);


--
-- Data for Name: weather; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.weather VALUES (0, 'Void');
INSERT INTO taxa.weather VALUES (2, 'Overcast');
INSERT INTO taxa.weather VALUES (3, 'Rainy');
INSERT INTO taxa.weather VALUES (4, 'Sandstorm');
INSERT INTO taxa.weather VALUES (5, 'Snowy');
INSERT INTO taxa.weather VALUES (6, 'Acidic');
INSERT INTO taxa.weather VALUES (7, 'Solar Eclipse');
INSERT INTO taxa.weather VALUES (8, 'Glitter');
INSERT INTO taxa.weather VALUES (9, 'Blooddrain');
INSERT INTO taxa.weather VALUES (10, 'Peanuts');
INSERT INTO taxa.weather VALUES (11, 'Birds');
INSERT INTO taxa.weather VALUES (12, 'Feedback');
INSERT INTO taxa.weather VALUES (13, 'Reverb');
INSERT INTO taxa.weather VALUES (14, 'Black Hole');
INSERT INTO taxa.weather VALUES (1, 'Sun 2');
INSERT INTO taxa.weather VALUES (15, 'Coffee');

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
-- Data for Name: player_url_slugs; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.player_url_slugs VALUES (3195, '3d4545ed-6217-4d7a-9c4a-209265eb6404', 'tiana-cash', 'Tiana Cash');
INSERT INTO taxa.player_url_slugs VALUES (3196, 'e3c514ae-f813-470e-9c91-d5baf5ffcf16', 'tot-clark', 'Tot Clark');
INSERT INTO taxa.player_url_slugs VALUES (3197, '0d5300f6-0966-430f-903f-a4c2338abf00', 'wyatt-dovenpart', 'Wyatt Dovenpart');
INSERT INTO taxa.player_url_slugs VALUES (3198, '5c60f834-a133-4dc6-9c07-392fb37b3e6a', 'ramirez-winters', 'Ramirez Winters');
INSERT INTO taxa.player_url_slugs VALUES (3199, '82733eb4-103d-4be1-843e-6eb6df35ecd7', 'adkins-tosser', 'Adkins Tosser');
INSERT INTO taxa.player_url_slugs VALUES (3200, '04f955fe-9cc9-4482-a4d2-07fe033b59ee', 'zane-vapor', 'Zane Vapor');
INSERT INTO taxa.player_url_slugs VALUES (3201, 'f6342729-a38a-4204-af8d-64b7accb5620', 'marco-winner', 'Marco Winner');
INSERT INTO taxa.player_url_slugs VALUES (3202, '6524e9e0-828a-46c4-935d-0ee2edeb7e9a', 'carter-turnip', 'Carter Turnip');
INSERT INTO taxa.player_url_slugs VALUES (3203, '94baa9ac-ff96-4f56-a987-10358e917d91', 'gabriel-griffith', 'Gabriel Griffith');
INSERT INTO taxa.player_url_slugs VALUES (3204, 'cc11963b-a05b-477b-b154-911dc31960df', 'pudge-nakatamo', 'Pudge Nakatamo');
INSERT INTO taxa.player_url_slugs VALUES (3205, 'ae4acebd-edb5-4d20-bf69-f2d5151312ff', 'theodore-cervantes', 'Theodore Cervantes');
INSERT INTO taxa.player_url_slugs VALUES (3206, '4b3e8e9b-6de1-4840-8751-b1fb45dc5605', 'thomas-dracaena', 'Thomas Dracaena');
INSERT INTO taxa.player_url_slugs VALUES (3207, '864b3be8-e836-426e-ae56-20345b41d03d', 'goodwin-morin', 'Goodwin Morin');
INSERT INTO taxa.player_url_slugs VALUES (3208, 'a38ada0a-aeac-4a3d-b9a5-968687ccd2f9', 'sixpack-santiago', 'Sixpack Santiago');
INSERT INTO taxa.player_url_slugs VALUES (3209, '90768354-957e-4b4c-bb6d-eab6bbda0ba3', 'eugenia-garbage', 'Eugenia Garbage');
INSERT INTO taxa.player_url_slugs VALUES (3210, '1ba715f2-caa3-44c0-9118-b045ea702a34', 'juan-rangel', 'Juan Rangel');
INSERT INTO taxa.player_url_slugs VALUES (3211, 'd6e9a211-7b33-45d9-8f09-6d1a1a7a3c78', 'william-boone', 'William Boone');
INSERT INTO taxa.player_url_slugs VALUES (3212, '0e27df51-ad0c-4546-acf5-96b3cb4d7501', 'chorby-spoon', 'Chorby Spoon');
INSERT INTO taxa.player_url_slugs VALUES (3213, '8adb084b-19fe-4295-bcd2-f92afdb62bd7', 'logan-rodriguez', 'Logan Rodriguez');
INSERT INTO taxa.player_url_slugs VALUES (3214, '5fc4713c-45e1-4593-a968-7defeb00a0d4', 'percival-bendie', 'Percival Bendie');
INSERT INTO taxa.player_url_slugs VALUES (3215, '1db2f602-64b1-4a5c-8697-1932cc2c6df1', 'mummy-melcon', 'Mummy Melcon');
INSERT INTO taxa.player_url_slugs VALUES (3216, 'b88d313f-e546-407e-8bc6-94040499daa5', 'oliver-loofah', 'Oliver Loofah');
INSERT INTO taxa.player_url_slugs VALUES (3217, 'd8742d68-8fce-4d52-9a49-f4e33bd2a6fc', 'ortiz-morse', 'Ortiz Morse');
INSERT INTO taxa.player_url_slugs VALUES (3218, '9820f2c5-f9da-4a07-b610-c2dd7bee2ef6', 'dan-bong', 'Dan Bong');
INSERT INTO taxa.player_url_slugs VALUES (3219, '12577256-bc4e-4955-81d6-b422d895fb12', 'jasmine-washington', 'Jasmine Washington');
INSERT INTO taxa.player_url_slugs VALUES (3220, 'c6e2e389-ed04-4626-a5ba-fe398fe89568', 'henry-marshallow', 'Henry Marshallow');
INSERT INTO taxa.player_url_slugs VALUES (3221, '64f4cd75-0c1e-42cf-9ff0-e41c4756f22a', 'grey-alvarado', 'Grey Alvarado');
INSERT INTO taxa.player_url_slugs VALUES (3222, '4f69e8c2-b2a1-4e98-996a-ccf35ac844c5', 'igneus-delacruz', 'Igneus Delacruz');
INSERT INTO taxa.player_url_slugs VALUES (3223, 'c4951cae-0b47-468b-a3ac-390cc8e9fd05', 'timmy-vine', 'Timmy Vine');
INSERT INTO taxa.player_url_slugs VALUES (3224, '667cb445-c288-4e62-b603-27291c1e475d', 'dan-holloway', 'Dan Holloway');
INSERT INTO taxa.player_url_slugs VALUES (3225, '5149c919-48fe-45c6-b7ee-bb8e5828a095', 'adkins-davis', 'Adkins Davis');
INSERT INTO taxa.player_url_slugs VALUES (3226, 'e4034192-4dc6-4901-bb30-07fe3cf77b5e', 'wyatt-breadwinner', 'Wyatt Breadwinner');
INSERT INTO taxa.player_url_slugs VALUES (3227, 'bbf9543f-f100-445a-a467-81d7aab12236', 'farrell-seagull', 'Farrell Seagull');
INSERT INTO taxa.player_url_slugs VALUES (3228, 'b86237bb-ade6-4b1d-9199-a3cc354118d9', 'hurley-pacheco', 'Hurley Pacheco');
INSERT INTO taxa.player_url_slugs VALUES (3229, '68f98a04-204f-4675-92a7-8823f2277075', 'isaac-johnson', 'Isaac Johnson');
INSERT INTO taxa.player_url_slugs VALUES (3230, 'b7cdb93b-6f9d-468a-ae00-54cbc324ee84', 'ruslan-duran', 'Ruslan Duran');
INSERT INTO taxa.player_url_slugs VALUES (3231, '459f7700-521e-40da-9483-4d111119d659', 'comfort-monreal', 'Comfort Monreal');
INSERT INTO taxa.player_url_slugs VALUES (3232, '3a96d76a-c508-45a0-94a0-8f64cd6beeb4', 'thomas-england', 'Thomas England');
INSERT INTO taxa.player_url_slugs VALUES (3233, '2b5f5dd7-e31f-4829-bec5-546652103bc0', 'dudley-mueller', 'Dudley Mueller');
INSERT INTO taxa.player_url_slugs VALUES (3234, '89ec77d8-c186-4027-bd45-f407b4800c2c', 'james-mora', 'James Mora');
INSERT INTO taxa.player_url_slugs VALUES (3235, 'e6502bc7-5b76-4939-9fb8-132057390b30', 'greer-lott', 'Greer Lott');
INSERT INTO taxa.player_url_slugs VALUES (3236, '3531c282-cb48-43df-b549-c5276296aaa7', 'oliver-hess', 'Oliver Hess');
INSERT INTO taxa.player_url_slugs VALUES (3237, 'd46abb00-c546-4952-9218-4f16084e3238', 'atlas-guerra', 'Atlas Guerra');
INSERT INTO taxa.player_url_slugs VALUES (3238, 'd51f1fe8-4ab8-411e-b836-5bba92984d32', 'hiroto-cerna', 'Hiroto Cerna');
INSERT INTO taxa.player_url_slugs VALUES (3239, '7a75d626-d4fd-474f-a862-473138d8c376', 'beck-whitney', 'Beck Whitney');
INSERT INTO taxa.player_url_slugs VALUES (3240, '03b80a57-77ea-4913-9be4-7a85c3594745', 'halexandrey-walton', 'Halexandrey Walton');
INSERT INTO taxa.player_url_slugs VALUES (3241, 'c0998a08-de15-4187-b903-2e096ffa08e5', 'cannonball-sports', 'Cannonball Sports');
INSERT INTO taxa.player_url_slugs VALUES (3242, 'd5192d95-a547-498a-b4ea-6770dde4b9f5', 'summers-slugger', 'Summers Slugger');
INSERT INTO taxa.player_url_slugs VALUES (3243, '94f30f21-f889-4a2e-9b94-818475bb1ca0', 'kirkland-sobremesa', 'Kirkland Sobremesa');
INSERT INTO taxa.player_url_slugs VALUES (3244, 'ceb5606d-ea3f-4471-9ca7-3d2e71a50dde', 'london-simmons', 'London Simmons');
INSERT INTO taxa.player_url_slugs VALUES (3245, '87e6ae4b-67de-4973-aa56-0fc9835a1e1e', 'wyatts-mason', 'Wyatts Mason');
INSERT INTO taxa.player_url_slugs VALUES (3246, 'bd9d1d6e-7822-4ad9-bac4-89b8afd8a630', 'derrick-krueger', 'Derrick Krueger');
INSERT INTO taxa.player_url_slugs VALUES (3247, '5ca7e854-dc00-4955-9235-d7fcd732ddcf', 'wyatt-mason-6', 'Wyatt Mason');
INSERT INTO taxa.player_url_slugs VALUES (3248, '43bf6a6d-cc03-4bcf-938d-620e185433e1', 'miguel-javier', 'Miguel Javier');
INSERT INTO taxa.player_url_slugs VALUES (3249, 'f38c5d80-093f-46eb-99d6-942aa45cd921', 'andrew-solis', 'Andrew Solis');
INSERT INTO taxa.player_url_slugs VALUES (3250, 'd2a1e734-60d9-4989-b7d9-6eacda70486b', 'tiana-takahashi', 'Tiana Takahashi');
INSERT INTO taxa.player_url_slugs VALUES (3251, 'a5adc84c-80b8-49e4-9962-8b4ade99a922', 'richardson-turquoise', 'Richardson Turquoise');
INSERT INTO taxa.player_url_slugs VALUES (3252, '9313e41c-3bf7-436d-8bdc-013d3a1ecdeb', 'sandie-nelson', 'Sandie Nelson');
INSERT INTO taxa.player_url_slugs VALUES (3253, '52cfebfb-8008-4b9f-a566-72a30e0b64bf', 'spears-rogers', 'Spears Rogers');
INSERT INTO taxa.player_url_slugs VALUES (3254, '88ca603e-b2e5-4916-bef5-d6bba03235f5', 'clare-mccall', 'Clare Mccall');
INSERT INTO taxa.player_url_slugs VALUES (3255, 'b6aa8ce8-2587-4627-83c1-2a48d44afaee', 'inky-rutledge', 'Inky Rutledge');
INSERT INTO taxa.player_url_slugs VALUES (3256, 'd002946f-e7ed-4ce4-a405-63bdaf5eabb5', 'jorge-owens', 'Jorge Owens');
INSERT INTO taxa.player_url_slugs VALUES (3257, '16a59f5f-ef0f-4ada-8682-891ad571a0b6', 'boyfriend-berger', 'Boyfriend Berger');
INSERT INTO taxa.player_url_slugs VALUES (3258, 'c771abab-f468-46e9-bac5-43db4c5b410f', 'wade-howe', 'Wade Howe');
INSERT INTO taxa.player_url_slugs VALUES (3259, '24cb35c1-c24c-45ca-ac0b-f99a2e650d89', 'tyreek-peterson', 'Tyreek Peterson');
INSERT INTO taxa.player_url_slugs VALUES (3260, 'ae81e172-801a-4236-929a-b990fc7190ce', 'august-sky', 'August Sky');
INSERT INTO taxa.player_url_slugs VALUES (3261, '21cbbfaa-100e-48c5-9cea-7118b0d08a34', 'juice-collins', 'Juice Collins');
INSERT INTO taxa.player_url_slugs VALUES (3262, '03f920cc-411f-44ef-ae66-98a44e883291', 'cornelius-games', 'Cornelius Games');
INSERT INTO taxa.player_url_slugs VALUES (3263, '333067fd-c2b4-4045-a9a4-e87a8d0332d0', 'miguel-james', 'Miguel James');
INSERT INTO taxa.player_url_slugs VALUES (3264, 'a8e757c6-e299-4a2e-a370-4f7c3da98bd1', 'hendricks-lenny', 'Hendricks Lenny');
INSERT INTO taxa.player_url_slugs VALUES (3265, '3a96d76a-c508-45a0-94a0-8f64cd6beeb4', 'sixpack-dogwalker', 'Sixpack Dogwalker');
INSERT INTO taxa.player_url_slugs VALUES (3266, '0ecf6190-f869-421a-b339-29195d30d37c', 'mcbaseball-clembons', 'McBaseball Clembons');
INSERT INTO taxa.player_url_slugs VALUES (3267, '94d772c7-0254-4f08-814c-f6fc58fcfb9b', 'fletcher-peck', 'Fletcher Peck');
INSERT INTO taxa.player_url_slugs VALUES (3268, '1ded0384-d290-4ea1-a72b-4f9d220cbe37', 'juan-murphy', 'Juan Murphy');
INSERT INTO taxa.player_url_slugs VALUES (3269, 'a3947fbc-50ec-45a4-bca4-49ffebb77dbe', 'chorby-short', 'Chorby Short');
INSERT INTO taxa.player_url_slugs VALUES (3270, 'ab9b2592-a64a-4913-bf6c-3ae5bd5d26a5', 'beau-huerta', 'Beau Huerta');
INSERT INTO taxa.player_url_slugs VALUES (3271, '57448b62-f952-40e2-820c-48d8afe0f64d', 'jessi-wise', 'Jessi Wise');
INSERT INTO taxa.player_url_slugs VALUES (3272, '2ca0c790-e1d5-4a14-ab3c-e9241c87fc23', 'murray-pony', 'Murray Pony');
INSERT INTO taxa.player_url_slugs VALUES (3273, '64aaa3cb-7daf-47e3-89a8-e565a3715b5d', 'travis-nakamura', 'Travis Nakamura');
INSERT INTO taxa.player_url_slugs VALUES (3274, '97981e86-4a42-4f85-8783-9f29833c192b', 'daiya-vine', 'Daiya Vine');
INSERT INTO taxa.player_url_slugs VALUES (3275, '21d52455-6c2c-4ee4-8673-ab46b4b926b4', 'wyatt-mason-4', 'Wyatt Mason');
INSERT INTO taxa.player_url_slugs VALUES (3276, '86d4e22b-f107-4bcf-9625-32d387fcb521', 'york-silk', 'York Silk');
INSERT INTO taxa.player_url_slugs VALUES (3277, '9be56060-3b01-47aa-a090-d072ef109fbf', 'jesus-koch', 'Jesús Koch');
INSERT INTO taxa.player_url_slugs VALUES (3278, 'd6c69d2d-9344-4b19-85a4-6cfcbaead5d2', 'joshua-watson', 'Joshua Watson');
INSERT INTO taxa.player_url_slugs VALUES (3279, '7b55d484-6ea9-4670-8145-986cb9e32412', 'stevenson-heat', 'Stevenson Heat');
INSERT INTO taxa.player_url_slugs VALUES (3280, '4aa843a4-baa1-4f35-8748-63aa82bd0e03', 'aureliano-dollie', 'Aureliano Dollie');
INSERT INTO taxa.player_url_slugs VALUES (3281, '2c4b2a6d-9961-4e40-882c-a338f4e72117', 'evelton-mcblase-ii', 'Evelton McBlase II');
INSERT INTO taxa.player_url_slugs VALUES (3282, '63a31035-2e6d-4922-a3f9-fa6e659b54ad', 'moody-rodriguez', 'Moody Rodriguez');
INSERT INTO taxa.player_url_slugs VALUES (3283, '6598e40a-d76d-413f-ad06-ac4872875bde', 'daniel-mendoza', 'Daniel Mendoza');
INSERT INTO taxa.player_url_slugs VALUES (3284, '03d06163-6f06-4817-abe5-0d14c3154236', 'garcia-tabby', 'Garcia Tabby');
INSERT INTO taxa.player_url_slugs VALUES (3285, '99e7de75-d2b8-4330-b897-a7334708aff9', 'winnie-loser', 'Winnie Loser');
INSERT INTO taxa.player_url_slugs VALUES (3286, 'cd417f8a-ce01-4ab2-921d-42e2e445bbe2', 'eizabeth-guerra', 'Eizabeth Guerra');
INSERT INTO taxa.player_url_slugs VALUES (3287, 'c755efce-d04d-4e00-b5c1-d801070d3808', 'basilio-fig', 'Basilio Fig');
INSERT INTO taxa.player_url_slugs VALUES (3288, '9fd1f392-d492-4c48-8d46-27fb4283b2db', 'lucas-petty', 'Lucas Petty');
INSERT INTO taxa.player_url_slugs VALUES (3289, 'f7847de2-df43-4236-8dbe-ae403f5f3ab3', 'blood-hamburger', 'Blood Hamburger');
INSERT INTO taxa.player_url_slugs VALUES (3290, 'de67b585-9bf4-4e49-b410-101483ca2fbc', 'shaquille-sunshine', 'Shaquille Sunshine');
INSERT INTO taxa.player_url_slugs VALUES (3291, '18f45a1b-76eb-4b59-a275-c64cf62afce0', 'steph-weeks', 'Steph Weeks');
INSERT INTO taxa.player_url_slugs VALUES (3292, '937c1a37-4b05-4dc5-a86d-d75226f8490a', 'pippin-carpenter', 'Pippin Carpenter');
INSERT INTO taxa.player_url_slugs VALUES (3293, '0d5300f6-0966-430f-903f-a4c2338abf00', 'wyatt-mason-3', 'Wyatt Mason');
INSERT INTO taxa.player_url_slugs VALUES (3294, '68dd9d47-b9a8-4fd3-a89c-5c112eb1982e', 'durham-spaceman', 'Durham Spaceman');
INSERT INTO taxa.player_url_slugs VALUES (3295, '0f61d948-4f0c-4550-8410-ae1c7f9f5613', 'tamara-crankit', 'Tamara Crankit');
INSERT INTO taxa.player_url_slugs VALUES (3296, '3a8c52d7-4124-4a65-a20d-d51abcbe6540', 'theodore-holloway', 'Theodore Holloway');
INSERT INTO taxa.player_url_slugs VALUES (3297, '15d3a844-df6b-4193-a8f5-9ab129312d8d', 'sebastian-woodman', 'Sebastian Woodman');
INSERT INTO taxa.player_url_slugs VALUES (3298, 'bd4c6837-eeaa-4675-ae48-061efa0fd11a', 'workman-gloom', 'Workman Gloom');
INSERT INTO taxa.player_url_slugs VALUES (3299, '51c5473a-7545-4a9a-920d-d9b718d0e8d1', 'jacob-haynes', 'Jacob Haynes');
INSERT INTO taxa.player_url_slugs VALUES (3300, '405dfadf-d435-4307-82f6-8eba2287e87a', 'jaxon-buckley', 'Jaxon Buckley');
INSERT INTO taxa.player_url_slugs VALUES (3301, '190a0f31-d686-4ac4-a7f3-cfc87b72c145', 'nerd-pacheco', 'Nerd Pacheco');
INSERT INTO taxa.player_url_slugs VALUES (3302, '1c73f91e-0562-480d-9543-2aab1d5e5acd', 'sparks-beans', 'Sparks Beans');
INSERT INTO taxa.player_url_slugs VALUES (3303, '4b73367f-b2bb-4df6-b2eb-2a0dd373eead', 'tristin-crankit', 'Tristin Crankit');
INSERT INTO taxa.player_url_slugs VALUES (3304, 'ad8d15f4-e041-4a12-a10e-901e6285fdc5', 'baby-urlacher', 'Baby Urlacher');
INSERT INTO taxa.player_url_slugs VALUES (3305, '7c5ae357-e079-4427-a90f-97d164c7262e', 'milo-brown', 'Milo Brown');
INSERT INTO taxa.player_url_slugs VALUES (3306, '4b6f0a4e-de18-44ad-b497-03b1f470c43c', 'rodriguez-internet', 'Rodriguez Internet');
INSERT INTO taxa.player_url_slugs VALUES (3307, '17392be2-7344-48a0-b4db-8a040a7fb532', 'washer-barajas', 'Washer Barajas');
INSERT INTO taxa.player_url_slugs VALUES (3308, '0295c6c2-b33c-47dd-affa-349da7fa1760', 'combs-estes', 'Combs Estes');
INSERT INTO taxa.player_url_slugs VALUES (3309, '60026a9d-fc9a-4f5a-94fd-2225398fa3da', 'bright-zimmerman', 'Bright Zimmerman');
INSERT INTO taxa.player_url_slugs VALUES (3310, '58c9e294-bd49-457c-883f-fb3162fc668e', 'kichiro-guerra', 'Kichiro Guerra');
INSERT INTO taxa.player_url_slugs VALUES (3311, 'e16c3f28-eecd-4571-be1a-606bbac36b2b', 'wyatt-mason-11', 'Wyatt Mason');
INSERT INTO taxa.player_url_slugs VALUES (3312, 'c83a13f6-ee66-4b1c-9747-faa67395a6f1', 'zi-delacruz', 'Zi Delacruz');
INSERT INTO taxa.player_url_slugs VALUES (3313, '82d1b7b4-ce00-4536-8631-a025f05150ce', 'sam-scandal', 'Sam Scandal');
INSERT INTO taxa.player_url_slugs VALUES (3314, 'e749dc27-ca3b-456e-889c-d2ec02ac7f5f', 'aureliano-estes', 'Aureliano Estes');
INSERT INTO taxa.player_url_slugs VALUES (3315, '8903a74f-f322-41d2-bd75-dbf7563c4abb', 'francisca-sasquatch', 'Francisca Sasquatch');
INSERT INTO taxa.player_url_slugs VALUES (3316, 'b9293beb-d199-4b46-add9-c02f9362d802', 'bauer-zimmerman', 'Bauer Zimmerman');
INSERT INTO taxa.player_url_slugs VALUES (3317, '2f3d7bc7-6ffb-40c3-a94f-5e626be413c9', 'elijah-valenzuela', 'Elijah Valenzuela');
INSERT INTO taxa.player_url_slugs VALUES (3318, '09f2787a-3352-41a6-8810-d80e97b253b5', 'curry-aliciakeyes', 'Curry Aliciakeyes');
INSERT INTO taxa.player_url_slugs VALUES (3319, '29bf512a-cd8c-4ceb-b25a-d96300c184bb', 'garcia-soto', 'Garcia Soto');
INSERT INTO taxa.player_url_slugs VALUES (3320, 'c86b5add-6c9a-40e0-aa43-e4fd7dd4f2c7', 'sosa-elftower', 'Sosa Elftower');
INSERT INTO taxa.player_url_slugs VALUES (3321, 'a1628d97-16ca-4a75-b8df-569bae02bef9', 'chorby-soul', 'Chorby Soul');
INSERT INTO taxa.player_url_slugs VALUES (3322, '35d5b43f-8322-4666-aab1-d466b4a5a388', 'jordan-boone', 'Jordan Boone');
INSERT INTO taxa.player_url_slugs VALUES (3323, 'b056a825-b629-4856-856b-53a15ad34acb', 'bennett-takahashi', 'Bennett Takahashi');
INSERT INTO taxa.player_url_slugs VALUES (3324, '020ed630-8bae-4441-95cc-0e4ecc27253b', 'simon-haley', 'Simon Haley');
INSERT INTO taxa.player_url_slugs VALUES (3325, '6bd4cf6e-fefe-499a-aa7a-890bcc7b53fa', 'igneus-mcdaniel', 'Igneus Mcdaniel');
INSERT INTO taxa.player_url_slugs VALUES (3326, '3ebb5361-3895-4a50-801e-e7a0ee61750c', 'augusto-reddick', 'Augusto Reddick');
INSERT INTO taxa.player_url_slugs VALUES (3327, 'f0594932-8ef7-4d70-9894-df4be64875d8', 'fitzgerald-wanderlust', 'Fitzgerald Wanderlust');
INSERT INTO taxa.player_url_slugs VALUES (3328, 'b7267aba-6114-4d53-a519-bf6c99f4e3a9', 'sosa-hayes', 'Sosa Hayes');
INSERT INTO taxa.player_url_slugs VALUES (3329, '58fca5fa-e559-4f5e-ac87-dc99dd19e410', 'sullivan-septemberish', 'Sullivan Septemberish');
INSERT INTO taxa.player_url_slugs VALUES (3330, '37efef78-2df4-4c76-800c-43d4faf07737', 'lenix-ren', 'Lenix Ren');
INSERT INTO taxa.player_url_slugs VALUES (3331, 'c4418663-7aa4-4c9f-ae73-0e81e442e8a2', 'chris-thibault', 'Chris Thibault');
INSERT INTO taxa.player_url_slugs VALUES (3332, 'ce0a156b-ba7b-4313-8fea-75807b4bc77f', 'conrad-twelve', 'Conrad Twelve');
INSERT INTO taxa.player_url_slugs VALUES (3333, 'bd8d58b6-f37f-48e6-9919-8e14ec91f92a', 'jose-haley', 'José Haley');
INSERT INTO taxa.player_url_slugs VALUES (3334, '945974c5-17d9-43e7-92f6-ba49064bbc59', 'bates-silk', 'Bates Silk');
INSERT INTO taxa.player_url_slugs VALUES (3335, '094ad9a1-e2c7-49a0-af18-da0e3eb656ba', 'erickson-sato', 'Erickson Sato');
INSERT INTO taxa.player_url_slugs VALUES (3336, '97f5a9cd-72f0-413e-9e68-a6ee6a663489', 'kline-greenlemon', 'Kline Greenlemon');
INSERT INTO taxa.player_url_slugs VALUES (3337, '1ffb1153-909d-44c7-9df1-6ed3a9a45bbd', 'montgomery-bullock', 'Montgomery Bullock');
INSERT INTO taxa.player_url_slugs VALUES (3338, '1a93a2d2-b5b6-479b-a595-703e4a2f3885', 'pedro-davids', 'Pedro Davids');
INSERT INTO taxa.player_url_slugs VALUES (3339, '04931546-1b4a-469f-b391-7ed67afe824c', 'glabe-moon', 'Glabe Moon');
INSERT INTO taxa.player_url_slugs VALUES (3340, '21d52455-6c2c-4ee4-8673-ab46b4b926b4', 'emmett-owens', 'Emmett Owens');
INSERT INTO taxa.player_url_slugs VALUES (3341, 'f8c20693-f439-4a29-a421-05ed92749f10', 'combs-duende', 'Combs Duende');
INSERT INTO taxa.player_url_slugs VALUES (3342, 'a938f586-f5c1-4a35-9e7f-8eaab6de67a6', 'jasper-destiny', 'Jasper Destiny');
INSERT INTO taxa.player_url_slugs VALUES (3343, '1aec2c01-b766-4018-a271-419e5371bc8f', 'rush-ito', 'Rush Ito');
INSERT INTO taxa.player_url_slugs VALUES (3344, '542af915-79c5-431c-a271-f7185e37c6ae', 'oliver-notarobot', 'Oliver Notarobot');
INSERT INTO taxa.player_url_slugs VALUES (3345, '23e78d92-ee2d-498a-a99c-f40bc4c5fe99', 'annie-williams', 'Annie Williams');
INSERT INTO taxa.player_url_slugs VALUES (3346, 'ce3fb736-d20e-4e2a-88cb-e136783d3a47', 'javier-howe', 'Javier Howe');
INSERT INTO taxa.player_url_slugs VALUES (3347, '75f9d874-5e69-438d-900d-a3fcb1d429b3', 'moses-mason', 'Moses Mason');
INSERT INTO taxa.player_url_slugs VALUES (3348, '527c1f6e-a7e4-4447-a824-703b662bae4e', 'melton-campbell', 'Melton Campbell');
INSERT INTO taxa.player_url_slugs VALUES (3349, '3064c7d6-91cc-4c2a-a433-1ce1aabc1ad4', 'jorge-ito', 'Jorge Ito');
INSERT INTO taxa.player_url_slugs VALUES (3350, '0bd5a3ec-e14c-45bf-8283-7bc191ae53e4', 'stephanie-donaldson', 'Stephanie Donaldson');
INSERT INTO taxa.player_url_slugs VALUES (3351, 'b390b28c-df96-443e-b81f-f0104bd37860', 'karato-rangel', 'Karato Rangel');
INSERT INTO taxa.player_url_slugs VALUES (3352, 'f741dc01-2bae-4459-bfc0-f97536193eea', 'alejandro-leaf', 'Alejandro Leaf');
INSERT INTO taxa.player_url_slugs VALUES (3353, 'd796d287-77ef-49f0-89ef-87bcdeb280ee', 'izuki-clark', 'Izuki Clark');
INSERT INTO taxa.player_url_slugs VALUES (3354, 'f1185b20-7b4a-4ccc-a977-dc1afdfd4cb9', 'frazier-tosser', 'Frazier Tosser');
INSERT INTO taxa.player_url_slugs VALUES (3355, '80dff591-2393-448a-8d88-122bd424fa4c', 'elvis-figueroa', 'Elvis Figueroa');
INSERT INTO taxa.player_url_slugs VALUES (3356, '9ba361a1-16d5-4f30-b590-fc4fc2fb53d2', 'mooney-doctor', 'Mooney Doctor');
INSERT INTO taxa.player_url_slugs VALUES (3357, '2cadc28c-88a5-4e25-a6eb-cdab60dd446d', 'elijah-bookbaby', 'Elijah Bookbaby');
INSERT INTO taxa.player_url_slugs VALUES (3358, '1f145436-b25d-49b9-a1e3-2d3c91626211', 'joe-voorhees', 'Joe Voorhees');
INSERT INTO taxa.player_url_slugs VALUES (3359, 'c31d874c-1b4d-40f2-a1b3-42542e934047', 'cedric-spliff', 'Cedric Spliff');
INSERT INTO taxa.player_url_slugs VALUES (3360, '0672a4be-7e00-402c-b8d6-0b813f58ba96', 'castillo-logan', 'Castillo Logan');
INSERT INTO taxa.player_url_slugs VALUES (3361, '5915b7bb-e532-4036-9009-79f1e80c0e28', 'rosa-holloway', 'Rosa Holloway');
INSERT INTO taxa.player_url_slugs VALUES (3362, '3db02423-92af-485f-b30f-78256721dcc6', 'son-jensen', 'Son Jensen');
INSERT INTO taxa.player_url_slugs VALUES (3363, '425f3f84-bab0-4cf2-91c1-96e78cf5cd02', 'luis-acevedo', 'Luis Acevedo');
INSERT INTO taxa.player_url_slugs VALUES (3364, '20e13b56-599b-4a22-b752-8059effc81dc', 'lou-roseheart', 'Lou Roseheart');
INSERT INTO taxa.player_url_slugs VALUES (3365, 'c17a4397-4dcc-440e-8c53-d897e971cae9', 'august-mina', 'August Mina');
INSERT INTO taxa.player_url_slugs VALUES (3366, '90c8be89-896d-404c-945e-c135d063a74e', 'james-boy', 'James Boy');
INSERT INTO taxa.player_url_slugs VALUES (3367, '7e4f012e-828c-43bb-8b8a-6c33bdfd7e3f', 'patel-olive', 'Patel Olive');
INSERT INTO taxa.player_url_slugs VALUES (3368, '1732e623-ffc2-40f0-87ba-fdcf97131f1f', 'betsy-trombone', 'Betsy Trombone');
INSERT INTO taxa.player_url_slugs VALUES (3369, '113f47b2-3111-4abb-b25e-18f7889e2d44', 'adkins-swagger', 'Adkins Swagger');
INSERT INTO taxa.player_url_slugs VALUES (3370, 'efafe75e-2f00-4418-914c-9b6675d39264', 'aldon-cashmoney', 'Aldon Cashmoney');
INSERT INTO taxa.player_url_slugs VALUES (3371, '4542f0b0-3409-4a4a-a9e1-e8e8e5d73fcf', 'brock-watson', 'Brock Watson');
INSERT INTO taxa.player_url_slugs VALUES (3372, '65273615-22d5-4df1-9a73-707b23e828d5', 'burke-gonzales', 'Burke Gonzales');
INSERT INTO taxa.player_url_slugs VALUES (3373, '262c49c6-8301-487d-8356-747023fa46a9', 'alexandria-dracaena', 'Alexandria Dracaena');
INSERT INTO taxa.player_url_slugs VALUES (3374, 'c3b1b4e5-4b88-4245-b2b1-ae3ade57349e', 'wall-osborn', 'Wall Osborn');
INSERT INTO taxa.player_url_slugs VALUES (3375, '5bcfb3ff-5786-4c6c-964c-5c325fcc48d7', 'paula-turnip', 'Paula Turnip');
INSERT INTO taxa.player_url_slugs VALUES (3376, '34e1b683-ecd5-477f-b9e3-dd4bca76db45', 'alexandria-hess', 'Alexandria Hess');
INSERT INTO taxa.player_url_slugs VALUES (3377, '6c346d8b-d186-4228-9adb-ae919d7131dd', 'greer-gwiffin', 'Greer Gwiffin');
INSERT INTO taxa.player_url_slugs VALUES (3378, '4ecee7be-93e4-4f04-b114-6b333e0e6408', 'sutton-dreamy', 'Sutton Dreamy');
INSERT INTO taxa.player_url_slugs VALUES (3379, 'd2f827a5-0133-4d96-b403-85a5e50d49e0', 'robbins-schmitt', 'Robbins Schmitt');
INSERT INTO taxa.player_url_slugs VALUES (3380, '51cba429-13e8-487e-9568-847b7b8b9ac5', 'collins-mina', 'Collins Mina');
INSERT INTO taxa.player_url_slugs VALUES (3381, '3f08f8cd-6418-447a-84d3-22a981c68f16', 'pollard-beard', 'Pollard Beard');
INSERT INTO taxa.player_url_slugs VALUES (3382, '7aeb8e0b-f6fb-4a9e-bba2-335dada5f0a3', 'dunlap-figueroa', 'Dunlap Figueroa');
INSERT INTO taxa.player_url_slugs VALUES (3383, 'be35caba-b16a-4e0d-b927-4da857f4cdb5', 'frasier-shmurmgle', 'Frasier Shmurmgle');
INSERT INTO taxa.player_url_slugs VALUES (3384, '7932c7c7-babb-4245-b9f5-cdadb97c99fb', 'randy-castillo', 'Randy Castillo');
INSERT INTO taxa.player_url_slugs VALUES (3385, '7e160e9f-2c79-4e08-8b76-b816de388a98', 'thomas-marsh', 'Thomas Marsh');
INSERT INTO taxa.player_url_slugs VALUES (3386, 'af6b3edc-ed52-4edc-b0c9-14e0a5ae0ee3', 'wyatt-masons', 'Wyatt Masons');
INSERT INTO taxa.player_url_slugs VALUES (3387, 'c8de53a4-d90f-4192-955b-cec1732d920e', 'tyreek-cain', 'Tyreek Cain');
INSERT INTO taxa.player_url_slugs VALUES (3388, 'd74a2473-1f29-40fa-a41e-66fa2281dfca', 'landry-violence', 'Landry Violence');
INSERT INTO taxa.player_url_slugs VALUES (3389, 'a199a681-decf-4433-b6ab-5454450bbe5e', 'leach-ingram', 'Leach Ingram');
INSERT INTO taxa.player_url_slugs VALUES (3390, 'b082ca6e-eb11-4eab-8d6a-30f8be522ec4', 'nicholas-mora', 'Nicholas Mora');
INSERT INTO taxa.player_url_slugs VALUES (3391, '7fed72df-87de-407d-8253-2295a2b60d3b', 'stout-schmitt', 'Stout Schmitt');
INSERT INTO taxa.player_url_slugs VALUES (3392, '8c8cc584-199b-4b76-b2cd-eaa9a74965e5', 'ziwa-mueller', 'Ziwa Mueller');
INSERT INTO taxa.player_url_slugs VALUES (3393, '8d337b47-2a7d-418d-a44e-ef81e401c2ef', 'case-sports', 'Case Sports');
INSERT INTO taxa.player_url_slugs VALUES (3394, 'fa5b54d2-b488-47cd-a529-592831e4813d', 'kina-larsen', 'Kina Larsen');
INSERT INTO taxa.player_url_slugs VALUES (3395, '46721a07-7cd2-4839-982e-7046df6e8b66', 'stew-briggs', 'Stew Briggs');
INSERT INTO taxa.player_url_slugs VALUES (3396, '316abea7-9890-4fb8-aaea-86b35e24d9be', 'kennedy-rodgers', 'Kennedy Rodgers');
INSERT INTO taxa.player_url_slugs VALUES (3397, 'b4505c48-fc75-4f9e-8419-42b28dcc5273', 'sebastian-townsend', 'Sebastian Townsend');
INSERT INTO taxa.player_url_slugs VALUES (3398, '50154d56-c58a-461f-976d-b06a4ae467f9', 'carter-oconnor', 'Carter Oconnor');
INSERT INTO taxa.player_url_slugs VALUES (3399, 'ab9eb213-0917-4374-a259-458295045021', 'matheo-carpenter', 'Matheo Carpenter');
INSERT INTO taxa.player_url_slugs VALUES (3400, '6b8d128f-ed51-496d-a965-6614476f8256', 'orville-manco', 'Orville Manco');
INSERT INTO taxa.player_url_slugs VALUES (3401, '9ac2e7c5-5a34-4738-98d8-9f917bc6d119', 'christian-combs', 'Christian Combs');
INSERT INTO taxa.player_url_slugs VALUES (3402, '2e86de11-a2dd-4b28-b5fe-f4d0c38cd20b', 'zion-aliciakeyes', 'Zion Aliciakeyes');
INSERT INTO taxa.player_url_slugs VALUES (3403, 'dddb6485-0527-4523-9bec-324a5b66bf37', 'beans-mcblase', 'Beans McBlase');
INSERT INTO taxa.player_url_slugs VALUES (3404, '6f9de777-e812-4c84-915c-ef283c9f0cde', 'arturo-huerta', 'Arturo Huerta');
INSERT INTO taxa.player_url_slugs VALUES (3405, 'f9c0d3cb-d8be-4f53-94c9-fc53bcbce520', 'matteo-prestige', 'Matteo Prestige');
INSERT INTO taxa.player_url_slugs VALUES (3406, 'ccc99f2f-2feb-4f32-a9b9-c289f619d84c', 'itsuki-winner', 'Itsuki Winner');
INSERT INTO taxa.player_url_slugs VALUES (3407, '817dee99-9ccf-4f41-84e3-dc9773237bc8', 'holden-stanton', 'Holden Stanton');
INSERT INTO taxa.player_url_slugs VALUES (3408, '24f6829e-7bb4-4e1e-8b59-a07514657e72', 'king-weatherman', 'King Weatherman');
INSERT INTO taxa.player_url_slugs VALUES (3409, 'defbc540-a36d-460b-afd8-07da2375ee63', 'castillo-turner', 'Castillo Turner');
INSERT INTO taxa.player_url_slugs VALUES (3410, 'b39b5aae-8571-4c90-887a-6a00f2a2f6fd', 'dickerson-morse', 'Dickerson Morse');
INSERT INTO taxa.player_url_slugs VALUES (3411, 'd47dd08e-833c-4302-a965-a391d345455c', 'stu-trololol', 'Stu Trololol');
INSERT INTO taxa.player_url_slugs VALUES (3412, '90cc0211-cd04-4cac-bdac-646c792773fc', 'case-lancaster', 'Case Lancaster');
INSERT INTO taxa.player_url_slugs VALUES (3413, 'ebf2da50-7711-46ba-9e49-341ce3487e00', 'baldwin-jones', 'Baldwin Jones');
INSERT INTO taxa.player_url_slugs VALUES (3414, 'eaaef47e-82cc-4c90-b77d-75c3fb279e83', 'herring-winfield', 'Herring Winfield');
INSERT INTO taxa.player_url_slugs VALUES (3415, '64b055d1-b691-4e0c-8583-fc08ba663846', 'theodore-passon', 'Theodore Passon');
INSERT INTO taxa.player_url_slugs VALUES (3416, 'f2a27a7e-bf04-4d31-86f5-16bfa3addbe7', 'winnie-hess', 'Winnie Hess');
INSERT INTO taxa.player_url_slugs VALUES (3417, '088884af-f38d-4914-9d67-b319287481b4', 'liam-petty', 'Liam Petty');
INSERT INTO taxa.player_url_slugs VALUES (3418, 'b3d518b9-dc68-4902-b68c-0022ceb25aa0', 'hendricks-rangel', 'Hendricks Rangel');
INSERT INTO taxa.player_url_slugs VALUES (3419, '5dbf11c0-994a-4482-bd1e-99379148ee45', 'conrad-vaughan', 'Conrad Vaughan');
INSERT INTO taxa.player_url_slugs VALUES (3420, '14d88771-7a96-48aa-ba59-07bae1733e96', 'sebastian-telephone', 'Sebastian Telephone');
INSERT INTO taxa.player_url_slugs VALUES (3421, 'e1e33aab-df8c-4f53-b30a-ca1cea9f046e', 'joyner-rugrat', 'Joyner Rugrat');
INSERT INTO taxa.player_url_slugs VALUES (3422, 'b85161da-7f4c-42a8-b7f6-19789cf6861d', 'javier-lotus', 'Javier Lotus');
INSERT INTO taxa.player_url_slugs VALUES (3423, '3c331c87-1634-46c4-87ce-e4b9c59e2969', 'yosh-carpenter', 'Yosh Carpenter');
INSERT INTO taxa.player_url_slugs VALUES (3424, 'c22e3af5-9001-465f-b450-864d7db2b4a0', 'logan-horseman', 'Logan Horseman');
INSERT INTO taxa.player_url_slugs VALUES (3425, 'c6bd21a8-7880-4c00-8abe-33560fe84ac5', 'wendy-cerna', 'Wendy Cerna');
INSERT INTO taxa.player_url_slugs VALUES (3426, 'cd6b102e-1881-4079-9a37-455038bbf10e', 'caleb-morin', 'Caleb Morin');
INSERT INTO taxa.player_url_slugs VALUES (3427, '9c3273a0-2711-4958-b716-bfcf60857013', 'kathy-mathews', 'Kathy Mathews');
INSERT INTO taxa.player_url_slugs VALUES (3428, '4941976e-31fc-49b5-801a-18abe072178b', 'sebastian-sunshine', 'Sebastian Sunshine');
INSERT INTO taxa.player_url_slugs VALUES (3429, '4562ac1f-026c-472c-b4e9-ee6ff800d701', 'chris-koch', 'Chris Koch');
INSERT INTO taxa.player_url_slugs VALUES (3430, '32551e28-3a40-47ae-aed1-ff5bc66be879', 'math-velazquez', 'Math Velazquez');
INSERT INTO taxa.player_url_slugs VALUES (3431, '019ce117-2399-4382-8036-8c14db7e1d30', 'lori-boston', 'Lori Boston');
INSERT INTO taxa.player_url_slugs VALUES (3432, 'b7c4f986-e62a-4a8f-b5f0-8f30ecc35c5d', 'oscar-hollywood', 'Oscar Hollywood');
INSERT INTO taxa.player_url_slugs VALUES (3433, '81a0889a-4606-4f49-b419-866b57331383', 'summers-pony', 'Summers Pony');
INSERT INTO taxa.player_url_slugs VALUES (3434, 'b5c95dba-2624-41b0-aacd-ac3e1e1fe828', 'cote-rodgers', 'Cote Rodgers');
INSERT INTO taxa.player_url_slugs VALUES (3435, 'd2d76815-cbdc-4c4b-9c9e-32ebf2297cc7', 'denzel-scott', 'Denzel Scott');
INSERT INTO taxa.player_url_slugs VALUES (3436, '493a83de-6bcf-41a1-97dd-cc5e150548a3', 'boyfriend-monreal', 'Boyfriend Monreal');
INSERT INTO taxa.player_url_slugs VALUES (3437, '9786b2c9-1205-4718-b0f7-fc000ce91106', 'kevin-dudley', 'Kevin Dudley');
INSERT INTO taxa.player_url_slugs VALUES (3438, 'db3ff6f0-1045-4223-b3a8-a016ca987af9', 'murphy-thibault', 'Murphy Thibault');
INSERT INTO taxa.player_url_slugs VALUES (3439, 'afc90398-b891-4cdf-9dea-af8a3a79d793', 'yazmin-mason', 'Yazmin Mason');
INSERT INTO taxa.player_url_slugs VALUES (3440, 'f0bcf4bb-74b3-412e-a54c-04c12ad28ecb', 'hahn-fox', 'Hahn Fox');
INSERT INTO taxa.player_url_slugs VALUES (3441, 'c9e4a49e-e35a-4034-a4c7-293896b40c58', 'alexander-horne', 'Alexander Horne');
INSERT INTO taxa.player_url_slugs VALUES (3442, 'b7adbbcc-0679-43f3-a939-07f009a393db', 'jode-crutch', 'Jode Crutch');
INSERT INTO taxa.player_url_slugs VALUES (3443, '6192daab-3318-44b5-953f-14d68cdb2722', 'justin-alstott', 'Justin Alstott');
INSERT INTO taxa.player_url_slugs VALUES (3444, 'bf6a24d1-4e89-4790-a4ba-eeb2870cbf6f', 'rat-mason', 'Rat Mason');
INSERT INTO taxa.player_url_slugs VALUES (3445, '77a41c29-8abd-4456-b6e0-a034252700d2', 'elip-dean', 'Elip Dean');
INSERT INTO taxa.player_url_slugs VALUES (3446, 'f2c477fb-28ea-4fcb-943a-9fab22df3da0', 'sandford-garner', 'Sandford Garner');
INSERT INTO taxa.player_url_slugs VALUES (3447, '198fd9c8-cb75-482d-873e-e6b91d42a446', 'ren-hunter', 'Ren Hunter');
INSERT INTO taxa.player_url_slugs VALUES (3448, '167751d5-210c-4a6e-9568-e92d61bab185', 'jacob-winner', 'Jacob Winner');
INSERT INTO taxa.player_url_slugs VALUES (3449, 'ce0e57a7-89f5-41ea-80f9-6e649dd54089', 'yong-wright', 'Yong Wright');
INSERT INTO taxa.player_url_slugs VALUES (3450, '3dd85c20-a251-4903-8a3b-1b96941c07b7', 'tot-best', 'Tot Best');
INSERT INTO taxa.player_url_slugs VALUES (3451, 'ea44bd36-65b4-4f3b-ac71-78d87a540b48', 'wyatt-pothos', 'Wyatt Pothos');
INSERT INTO taxa.player_url_slugs VALUES (3452, '14bfad43-2638-41ec-8964-8351f22e9c4f', 'baby-sliders', 'Baby Sliders');
INSERT INTO taxa.player_url_slugs VALUES (3453, '2d22f026-2873-410b-a45f-3b1dac665ffd', 'donia-johnson', 'Donia Johnson');
INSERT INTO taxa.player_url_slugs VALUES (3454, 'd8ee256f-e3d0-46cb-8c77-b1f88d8c9df9', 'comfort-septemberish', 'Comfort Septemberish');
INSERT INTO taxa.player_url_slugs VALUES (3455, '63512571-2eca-4bc4-8ad9-a5308a22ae22', 'oscar-dollie', 'Oscar Dollie');
INSERT INTO taxa.player_url_slugs VALUES (3456, 'a73427b3-e96a-4156-a9ab-844edc696fed', 'wesley-vodka', 'Wesley Vodka');
INSERT INTO taxa.player_url_slugs VALUES (3457, 'cd68d3a6-7fbc-445d-90f1-970c955e32f4', 'miguel-wheeler', 'Miguel Wheeler');
INSERT INTO taxa.player_url_slugs VALUES (3458, 'ce58415f-4e62-47e2-a2c9-4d6a85961e1e', 'schneider-blanco', 'Schneider Blanco');
INSERT INTO taxa.player_url_slugs VALUES (3459, '7cf83bdc-f95f-49d3-b716-06f2cf60a78d', 'matteo-urlacher', 'Matteo Urlacher');
INSERT INTO taxa.player_url_slugs VALUES (3460, 'ecf19925-dc57-4b89-b114-923d5a714dbe', 'margarito-bishop', 'Margarito Bishop');
INSERT INTO taxa.player_url_slugs VALUES (3461, '5f3b5dc2-351a-4dee-a9d6-fa5f44f2a365', 'alston-england', 'Alston England');
INSERT INTO taxa.player_url_slugs VALUES (3462, 'f56657d3-3bdc-4840-a20c-91aca9cc360e', 'malik-romayne', 'Malik Romayne');
INSERT INTO taxa.player_url_slugs VALUES (3463, '75f9d874-5e69-438d-900d-a3fcb1d429b3', 'moses-simmons', 'Moses Simmons');
INSERT INTO taxa.player_url_slugs VALUES (3464, '849e13dc-6eb1-40a8-b55c-d4b4cd160aab', 'justice-valenzuela', 'Justice Valenzuela');
INSERT INTO taxa.player_url_slugs VALUES (3465, 'd9a072f5-1cbb-45ce-87fb-b138e4d8f769', 'francisco-object', 'Francisco Object');
INSERT INTO taxa.player_url_slugs VALUES (3466, '7b0f91aa-4d66-4362-993d-6ff60f7ce0ef', 'blankenship-fischer', 'Blankenship Fischer');
INSERT INTO taxa.player_url_slugs VALUES (3467, '2175cda0-a427-40fd-b497-347edcc1cd61', 'hotbox-sato', 'Hotbox Sato');
INSERT INTO taxa.player_url_slugs VALUES (3468, '042962c8-4d8b-44a6-b854-6ccef3d82716', 'ronan-jaylee', 'Ronan Jaylee');
INSERT INTO taxa.player_url_slugs VALUES (3469, '36786f44-9066-4028-98d9-4fa84465ab9e', 'beasley-gloom', 'Beasley Gloom');
INSERT INTO taxa.player_url_slugs VALUES (3470, '285ce77d-e5cd-4daa-9784-801347140d48', 'son-scotch', 'Son Scotch');
INSERT INTO taxa.player_url_slugs VALUES (3471, 'fdfd36c7-e0c1-4fce-98f7-921c3d17eafe', 'reese-harrington', 'Reese Harrington');
INSERT INTO taxa.player_url_slugs VALUES (3472, 'cbd19e6f-3d08-4734-b23f-585330028665', 'knight-urlacher', 'Knight Urlacher');
INSERT INTO taxa.player_url_slugs VALUES (3473, 'b348c037-eefc-4b81-8edd-dfa96188a97e', 'lowe-forbes', 'Lowe Forbes');
INSERT INTO taxa.player_url_slugs VALUES (3474, 'e7ecf646-e5e4-49ef-a0e3-10a78e87f5f4', 'gallup-crueller', 'Gallup Crueller');
INSERT INTO taxa.player_url_slugs VALUES (3475, 'd8bc482e-9309-4230-abcb-2c5a6412446d', 'august-obrien', 'August Obrien');
INSERT INTO taxa.player_url_slugs VALUES (3476, 'd35ccee1-9559-49a1-aaa4-7809f7b5c46e', 'forrest-best', 'Forrest Best');
INSERT INTO taxa.player_url_slugs VALUES (3477, '6e744b21-c4fa-4fa8-b4ea-e0e97f68ded5', 'daniel-koch', 'Daniel Koch');
INSERT INTO taxa.player_url_slugs VALUES (3478, '62111c49-1521-4ca7-8678-cd45dacf0858', 'bambi-perez', 'Bambi Perez');
INSERT INTO taxa.player_url_slugs VALUES (3479, '7951836f-581a-49d5-ae2f-049c6bcc575e', 'adkins-gwiffin', 'Adkins Gwiffin');
INSERT INTO taxa.player_url_slugs VALUES (3480, 'aae38811-122c-43dd-b59c-d0e203154dbe', 'sandie-carver', 'Sandie Carver');
INSERT INTO taxa.player_url_slugs VALUES (3481, '70ccff1e-6b53-40e2-8844-0a28621cb33e', 'moody-cookbook', 'Moody Cookbook');
INSERT INTO taxa.player_url_slugs VALUES (3482, '88cd6efa-dbf2-4309-aabe-ec1d6f21f98a', 'hewitt-best', 'Hewitt Best');
INSERT INTO taxa.player_url_slugs VALUES (3483, 'ac69dba3-6225-4afd-ab4b-23fc78f730fb', 'bevan-wise', 'Bevan Wise');
INSERT INTO taxa.player_url_slugs VALUES (3484, 'fcbe1d14-04c4-4331-97ad-46e170610633', 'jode-preston', 'Jode Preston');
INSERT INTO taxa.player_url_slugs VALUES (3485, '3af96a6b-866c-4b03-bc14-090acf6ecee5', 'axel-trololol', 'Axel Trololol');
INSERT INTO taxa.player_url_slugs VALUES (3486, '98a98014-9636-4ece-a46a-4625b47c65d5', 'kiki-familia', 'Kiki Familia');
INSERT INTO taxa.player_url_slugs VALUES (3487, '15ae64cd-f698-4b00-9d61-c9fffd037ae2', 'mickey-woods', 'Mickey Woods');
INSERT INTO taxa.player_url_slugs VALUES (3488, 'dac2fd55-5686-465f-a1b6-6fbed0b417c5', 'russo-slugger', 'Russo Slugger');
INSERT INTO taxa.player_url_slugs VALUES (3489, '27c68d7f-5e40-4afa-8b6f-9df47b79e7dd', 'basilio-mason', 'Basilio Mason');
INSERT INTO taxa.player_url_slugs VALUES (3490, '2e6d4fa9-f930-47bd-971a-dd54a3cf7db1', 'raul-leal', 'Raúl Leal');
INSERT INTO taxa.player_url_slugs VALUES (3491, '733d80f1-2485-40f7-828b-fd7cd8243a01', 'rai-spliff', 'Rai Spliff');
INSERT INTO taxa.player_url_slugs VALUES (3492, '80e474a3-7d2b-431d-8192-2f1e27162607', 'summers-preston', 'Summers Preston');
INSERT INTO taxa.player_url_slugs VALUES (3493, '23110c0f-2cf9-4d9c-ab2d-634f2f18867e', 'kennedy-meh', 'Kennedy Meh');
INSERT INTO taxa.player_url_slugs VALUES (3494, 'a1ed3396-114a-40bc-9ff0-54d7e1ad1718', 'patel-beyonce', 'Patel Beyonce');
INSERT INTO taxa.player_url_slugs VALUES (3495, '9e724d9a-92a0-436e-bde1-da0b2af85d8f', 'hatfield-suzuki', 'Hatfield Suzuki');
INSERT INTO taxa.player_url_slugs VALUES (3496, '97ec5a2f-ac1a-4cde-86b7-897c030a1fa8', 'alston-woods', 'Alston Woods');
INSERT INTO taxa.player_url_slugs VALUES (3497, '4ca52626-58cd-449d-88bb-f6d631588640', 'velasquez-alstott', 'Velasquez Alstott');
INSERT INTO taxa.player_url_slugs VALUES (3498, 'd23a1f7e-0071-444e-8361-6ae01f13036f', 'edric-tosser', 'Edric Tosser');
INSERT INTO taxa.player_url_slugs VALUES (3499, '450e6483-d116-41d8-933b-1b541d5f0026', 'england-voorhees', 'England Voorhees');
INSERT INTO taxa.player_url_slugs VALUES (3500, '28964497-0efe-420c-9c1d-8574f224a4e9', 'inez-owens', 'Inez Owens');
INSERT INTO taxa.player_url_slugs VALUES (3501, 'b69aa26f-71f7-4e17-bc36-49c875872cc1', 'francisca-burton', 'Francisca Burton');
INSERT INTO taxa.player_url_slugs VALUES (3502, '7dca7137-b872-46f5-8e59-8c9c996e9d22', 'emmett-tabby', 'Emmett Tabby');
INSERT INTO taxa.player_url_slugs VALUES (3503, 'd744f534-2352-472b-9e42-cd91fa540f1b', 'tyler-violet', 'Tyler Violet');
INSERT INTO taxa.player_url_slugs VALUES (3504, '2b1cb8a2-9eba-4fce-85cf-5d997ec45714', 'isaac-rubberman', 'Isaac Rubberman');
INSERT INTO taxa.player_url_slugs VALUES (3505, '0eddd056-9d72-4804-bd60-53144b785d5c', 'caleb-novak', 'Caleb Novak');
INSERT INTO taxa.player_url_slugs VALUES (3506, 'b1b141fc-e867-40d1-842a-cea30a97ca4f', 'richardson-games', 'Richardson Games');
INSERT INTO taxa.player_url_slugs VALUES (3507, '4ed61b18-c1f6-4d71-aea3-caac01470b5c', 'lenny-marijuana', 'Lenny Marijuana');
INSERT INTO taxa.player_url_slugs VALUES (3508, 'c73d59dd-32a0-49ce-8ab4-b2dbb7dc94ec', 'eduardo-ingram', 'Eduardo Ingram');
INSERT INTO taxa.player_url_slugs VALUES (3509, '0eea4a48-c84b-4538-97e7-3303671934d2', 'helga-moreno', 'Helga Moreno');
INSERT INTO taxa.player_url_slugs VALUES (3510, 'dd0b48fe-2d49-4344-83ed-9f0770b370a8', 'tillman-wan', 'Tillman Wan');
INSERT INTO taxa.player_url_slugs VALUES (3511, '57b4827b-26b0-4384-a431-9f63f715bc5b', 'aureliano-cerna', 'Aureliano Cerna');
INSERT INTO taxa.player_url_slugs VALUES (3512, '7e9a514a-7850-4ed0-93ab-f3a6e2f41c03', 'nolanestophia-patterson', 'Nolanestophia Patterson');
INSERT INTO taxa.player_url_slugs VALUES (3513, '9f6d06d6-c616-4599-996b-ec4eefcff8b8', 'silvia-winner', 'Silvia Winner');
INSERT INTO taxa.player_url_slugs VALUES (3514, '7f379b72-f4f0-4d8f-b88b-63211cf50ba6', 'jesus-rodriguez', 'Jesús Rodriguez');
INSERT INTO taxa.player_url_slugs VALUES (3515, 'dfe3bc1b-fca8-47eb-965f-6cf947c35447', 'linus-haley', 'Linus Haley');
INSERT INTO taxa.player_url_slugs VALUES (3516, '814bae61-071a-449b-981e-e7afc839d6d6', 'ruslan-greatness', 'Ruslan Greatness');
INSERT INTO taxa.player_url_slugs VALUES (3517, '3c051b92-4a86-4157-988a-e334bf6dc691', 'tyler-leatherman', 'Tyler Leatherman');
INSERT INTO taxa.player_url_slugs VALUES (3518, 'f883269f-117e-45ec-bb1e-fa8dbcf40d3e', 'jayden-wright', 'Jayden Wright');
INSERT INTO taxa.player_url_slugs VALUES (3519, 'd81ce662-07b6-4a73-baa4-acbbb41f9dc5', 'yummy-elliott', 'Yummy Elliott');
INSERT INTO taxa.player_url_slugs VALUES (3520, 'dd6ba7f1-a97a-4374-a3a7-b3596e286bb3', 'matheo-tanaka', 'Matheo Tanaka');
INSERT INTO taxa.player_url_slugs VALUES (3521, '1f159bab-923a-4811-b6fa-02bfde50925a', 'wyatt-mason', 'Wyatt Mason');
INSERT INTO taxa.player_url_slugs VALUES (3522, '773712f6-d76d-4caa-8a9b-56fe1d1a5a68', 'natha-kath', 'Natha Kath');
INSERT INTO taxa.player_url_slugs VALUES (3523, 'ac57cf28-556f-47af-9154-6bcea2ace9fc', 'rey-wooten', 'Rey Wooten');
INSERT INTO taxa.player_url_slugs VALUES (3524, '57290370-6723-4d33-929e-b4fc190e6a9a', 'mooney-doctor-ii', 'Mooney Doctor II');
INSERT INTO taxa.player_url_slugs VALUES (3525, 'b7c1ddda-945c-4b2e-8831-ad9f2ec4a608', 'nolan-violet', 'Nolan Violet');
INSERT INTO taxa.player_url_slugs VALUES (3526, '90c6e6ca-77fc-42b7-94d8-d8afd6d299e5', 'miki-santana', 'Miki Santana');
INSERT INTO taxa.player_url_slugs VALUES (3527, '80de2b05-e0d4-4d33-9297-9951b2b5c950', 'alyssa-harrell', 'Alyssa Harrell');
INSERT INTO taxa.player_url_slugs VALUES (3528, '0fe896e1-108c-4ce9-97be-3470dde73c21', 'bryanayah-chang', 'Bryanayah Chang');
INSERT INTO taxa.player_url_slugs VALUES (3529, '446a3366-3fe3-41bb-bfdd-d8717f2152a9', 'marco-escobar', 'Marco Escobar');
INSERT INTO taxa.player_url_slugs VALUES (3530, '1068f44b-34a0-42d8-a92e-2be748681a6f', 'allison-abbott', 'Allison Abbott');
INSERT INTO taxa.player_url_slugs VALUES (3531, '40db1b0b-6d04-4851-adab-dd6320ad2ed9', 'scrap-murphy', 'Scrap Murphy');
INSERT INTO taxa.player_url_slugs VALUES (3532, '30218684-7fa1-41a5-a3b3-5d9cd97dd36b', 'jordan-hildebert', 'Jordan Hildebert');
INSERT INTO taxa.player_url_slugs VALUES (3533, 'dfd5ccbb-90ed-4bfe-83e0-dae9cc763f10', 'owen-picklestein', 'Owen Picklestein');
INSERT INTO taxa.player_url_slugs VALUES (3534, '24ad200d-a45f-4286-bfa5-48909f98a1f7', 'nicholas-summer', 'Nicholas Summer');
INSERT INTO taxa.player_url_slugs VALUES (3535, 'fa477c92-39b6-4a52-b065-40af2f29840a', 'howell-franklin', 'Howell Franklin');
INSERT INTO taxa.player_url_slugs VALUES (3536, 'c09e64b6-8248-407e-b3af-1931b880dbee', 'lenny-spruce', 'Lenny Spruce');
INSERT INTO taxa.player_url_slugs VALUES (3537, '3954bdfa-931f-4787-b9ac-f44b72fe09d7', 'nicholas-nolan', 'Nicholas Nolan');
INSERT INTO taxa.player_url_slugs VALUES (3538, 'bd8778e5-02e8-4d1f-9c31-7b63942cc570', 'cell-barajas', 'Cell Barajas');
INSERT INTO taxa.player_url_slugs VALUES (3539, '2720559e-9173-4042-aaa0-d3852b72ab2e', 'hiroto-wilcox', 'Hiroto Wilcox');
INSERT INTO taxa.player_url_slugs VALUES (3540, 'f3ddfd87-73a2-4681-96fe-829476c97886', 'theodore-duende', 'Theodore Duende');
INSERT INTO taxa.player_url_slugs VALUES (3541, '2b9f9c25-43ec-4f0b-9937-a5aa23be0d9e', 'lawrence-horne', 'Lawrence Horne');
INSERT INTO taxa.player_url_slugs VALUES (3542, 'd4a10c2a-0c28-466a-9213-38ba3339b65e', 'richmond-harrison', 'Richmond Harrison');
INSERT INTO taxa.player_url_slugs VALUES (3543, 'e3c06405-0564-47ce-bbbd-552bee4dd66f', 'scrap-weeks', 'Scrap Weeks');
INSERT INTO taxa.player_url_slugs VALUES (3544, '63df8701-1871-4987-87d7-b55d4f1df2e9', 'mcdowell-sasquatch', 'Mcdowell Sasquatch');
INSERT INTO taxa.player_url_slugs VALUES (3545, '89f74891-2e25-4b5a-bd99-c95ba3f36aa0', 'nagomi-nava', 'Nagomi Nava');
INSERT INTO taxa.player_url_slugs VALUES (3546, 'a1ed3396-114a-40bc-9ff0-54d7e1ad1718', 'wyatt-mason-9', 'Wyatt Mason');
INSERT INTO taxa.player_url_slugs VALUES (3547, 'c4dec95e-78a1-4840-b209-b3b597181534', 'charlatan-seabright', 'Charlatan Seabright');
INSERT INTO taxa.player_url_slugs VALUES (3548, 'e972984c-2895-451c-b518-f06a0d8bd375', 'becker-solis', 'Becker Solis');
INSERT INTO taxa.player_url_slugs VALUES (3549, '8604e861-d784-43f0-b0f8-0d43ea6f7814', 'randall-marijuana', 'Randall Marijuana');
INSERT INTO taxa.player_url_slugs VALUES (3550, '1e7b02b7-6981-427a-b249-8e9bd35f3882', 'nora-reddick', 'Nora Reddick');
INSERT INTO taxa.player_url_slugs VALUES (3551, 'b3e512df-c411-4100-9544-0ceadddb28cf', 'famous-owens', 'Famous Owens');
INSERT INTO taxa.player_url_slugs VALUES (3552, 'd1a7c13f-8e78-4d2e-9cae-ebf3a5fcdb5d', 'elijah-bates', 'Elijah Bates');
INSERT INTO taxa.player_url_slugs VALUES (3553, '4bda6584-6c21-4185-8895-47d07e8ad0c0', 'aldon-anthony', 'Aldon Anthony');
INSERT INTO taxa.player_url_slugs VALUES (3554, '520e6066-b14b-45cf-985c-0a6ee2dc3f7a', 'zi-sliders', 'Zi Sliders');
INSERT INTO taxa.player_url_slugs VALUES (3555, '06ced607-7f96-41e7-a8cd-b501d11d1a7e', 'morrow-wilson', 'Morrow Wilson');
INSERT INTO taxa.player_url_slugs VALUES (3556, 'ea44bd36-65b4-4f3b-ac71-78d87a540b48', 'wyatt-mason-13', 'Wyatt Mason');
INSERT INTO taxa.player_url_slugs VALUES (3557, 'dd8a43a4-a024-44e9-a522-785d998b29c3', 'miguel-peterson', 'Miguel Peterson');
INSERT INTO taxa.player_url_slugs VALUES (3558, '73265ee3-bb35-40d1-b696-1f241a6f5966', 'parker-meng', 'Parker Meng');
INSERT INTO taxa.player_url_slugs VALUES (3559, 'bf6a24d1-4e89-4790-a4ba-eeb2870cbf6f', 'rat-polk', 'Rat Polk');
INSERT INTO taxa.player_url_slugs VALUES (3560, '8b53ce82-4b1a-48f0-999d-1774b3719202', 'oliver-mueller', 'Oliver Mueller');
INSERT INTO taxa.player_url_slugs VALUES (3561, 'e16c3f28-eecd-4571-be1a-606bbac36b2b', 'comfort-glover', 'Comfort Glover');
INSERT INTO taxa.player_url_slugs VALUES (3562, '8b0d717f-ae42-4492-b2ed-106912e2b530', 'avila-baker', 'Avila Baker');
INSERT INTO taxa.player_url_slugs VALUES (3563, '126fb128-7c53-45b5-ac2b-5dbf9943d71b', 'sigmund-castillo', 'Sigmund Castillo');
INSERT INTO taxa.player_url_slugs VALUES (3564, 'c6a277c3-d2b5-4363-839b-950896a5ec5e', 'mike-townsend', 'Mike Townsend');
INSERT INTO taxa.player_url_slugs VALUES (3565, '4f328502-d347-4d2c-8fad-6ae59431d781', 'stephens-lightner', 'Stephens Lightner');
INSERT INTO taxa.player_url_slugs VALUES (3566, '695daf02-113d-4e76-b802-0862df16afbd', 'pacheco-weeks', 'Pacheco Weeks');
INSERT INTO taxa.player_url_slugs VALUES (3567, '138fccc3-e66f-4b07-8327-d4b6f372f654', 'oscar-vaughan', 'Oscar Vaughan');
INSERT INTO taxa.player_url_slugs VALUES (3568, '32810dca-825c-4dbc-8b65-0702794c424e', 'eduardo-woodman', 'Eduardo Woodman');
INSERT INTO taxa.player_url_slugs VALUES (3569, '68462bfa-9006-4637-8830-2e7840d9089a', 'parker-horseman', 'Parker Horseman');
INSERT INTO taxa.player_url_slugs VALUES (3570, '8cd06abf-be10-4a35-a3ab-1a408a329147', 'gloria-bugsnax', 'Gloria Bugsnax');
INSERT INTO taxa.player_url_slugs VALUES (3571, 'ceb8f8cd-80b2-47f0-b43e-4d885fa48aa4', 'donia-bailey', 'Donia Bailey');
INSERT INTO taxa.player_url_slugs VALUES (3572, '338694b7-6256-4724-86b6-3884299a5d9e', 'polkadot-patterson', 'PolkaDot Patterson');
INSERT INTO taxa.player_url_slugs VALUES (3573, '4bf352d2-6a57-420a-9d45-b23b2b947375', 'rivers-rosa', 'Rivers Rosa');
INSERT INTO taxa.player_url_slugs VALUES (3574, '03097200-0d48-4236-a3d2-8bdb153aa8f7', 'bennett-browning', 'Bennett Browning');
INSERT INTO taxa.player_url_slugs VALUES (3575, '51985516-5033-4ab8-a185-7bda07829bdb', 'stephanie-schmitt', 'Stephanie Schmitt');
INSERT INTO taxa.player_url_slugs VALUES (3576, 'aa6c2662-75f8-4506-aa06-9a0993313216', 'eizabeth-elliott', 'Eizabeth Elliott');
INSERT INTO taxa.player_url_slugs VALUES (3577, '0bb35615-63f2-4492-80ec-b6b322dc5450', 'sexton-wheeler', 'Sexton Wheeler');
INSERT INTO taxa.player_url_slugs VALUES (3578, '25f3a67c-4ed5-45b6-94b1-ce468d3ead21', 'hobbs-cain', 'Hobbs Cain');
INSERT INTO taxa.player_url_slugs VALUES (3579, '1f159bab-923a-4811-b6fa-02bfde50925a', 'nan', 'NaN');
INSERT INTO taxa.player_url_slugs VALUES (3580, 'de52d5c0-cba4-4ace-8308-e2ed3f8799d0', 'jose-mitchell', 'José Mitchell');
INSERT INTO taxa.player_url_slugs VALUES (3581, '70a458ed-25ca-4ff8-97fc-21cbf58f2c2a', 'trevino-merritt', 'Trevino Merritt');
INSERT INTO taxa.player_url_slugs VALUES (3582, '1e229fe5-a191-48ef-a7dd-6f6e13d6d73f', 'erickson-fischer', 'Erickson Fischer');
INSERT INTO taxa.player_url_slugs VALUES (3583, 'f2468055-e880-40bf-8ac6-a0763d846eb2', 'alaynabella-hollywood', 'Alaynabella Hollywood');
INSERT INTO taxa.player_url_slugs VALUES (3584, '76c4853b-7fbc-4688-8cda-c5b8de1724e4', 'lars-mendoza', 'Lars Mendoza');
INSERT INTO taxa.player_url_slugs VALUES (3585, '6644d767-ab15-4528-a4ce-ae1f8aadb65f', 'paula-reddick', 'Paula Reddick');
INSERT INTO taxa.player_url_slugs VALUES (3586, '248ccf3d-d5f6-4b69-83d9-40230ca909cd', 'antonio-wallace', 'Antonio Wallace');
INSERT INTO taxa.player_url_slugs VALUES (3587, '0f62c20c-72d0-4c12-a9d7-312ea3d3bcd1', 'abner-wood', 'Abner Wood');
INSERT INTO taxa.player_url_slugs VALUES (3588, 'af6b3edc-ed52-4edc-b0c9-14e0a5ae0ee3', 'rivers-clembons', 'Rivers Clembons');
INSERT INTO taxa.player_url_slugs VALUES (3589, 'ecb8d2f5-4ff5-4890-9693-5654e00055f6', 'yeongho-benitez', 'Yeong-Ho Benitez');
INSERT INTO taxa.player_url_slugs VALUES (3590, '6a869b40-be99-4520-89e5-d382b07e4a3c', 'jake-swinger', 'Jake Swinger');
INSERT INTO taxa.player_url_slugs VALUES (3591, 'c18961e9-ef3f-4954-bd6b-9fe01c615186', 'carmelo-plums', 'Carmelo Plums');
INSERT INTO taxa.player_url_slugs VALUES (3592, 'a2483925-697f-468f-931c-bcd0071394e5', 'timmy-manco', 'Timmy Manco');
INSERT INTO taxa.player_url_slugs VALUES (3593, '13a05157-6172-4431-947b-a058217b4aa5', 'spears-taylor', 'Spears Taylor');
INSERT INTO taxa.player_url_slugs VALUES (3594, '5ff66eae-7111-4e3b-a9b8-a9579165b0a5', 'peanutiel-duffy', 'Peanutiel Duffy');
INSERT INTO taxa.player_url_slugs VALUES (3595, '11de4da3-8208-43ff-a1ff-0b3480a0fbf1', 'don-mitchell', 'Don Mitchell');
INSERT INTO taxa.player_url_slugs VALUES (3596, '04e14d7b-5021-4250-a3cd-932ba8e0a889', 'jaylen-hotdogfingers', 'Jaylen Hotdogfingers');
INSERT INTO taxa.player_url_slugs VALUES (3597, '80a2f015-9d40-426b-a4f6-b9911ba3add8', 'paul-barnes', 'Paul Barnes');
INSERT INTO taxa.player_url_slugs VALUES (3598, 'ca709205-226d-4d92-8be6-5f7871f48e26', 'rivers-javier', 'Rivers Javier');
INSERT INTO taxa.player_url_slugs VALUES (3599, '20395b48-279d-44ff-b5bf-7cf2624a2d30', 'adrian-melon', 'Adrian Melon');
INSERT INTO taxa.player_url_slugs VALUES (3600, 'a691f2ba-9b69-41f8-892c-1acd42c336e4', 'jenkins-good', 'Jenkins Good');
INSERT INTO taxa.player_url_slugs VALUES (3601, 'f4a5d734-0ade-4410-abb6-c0cd5a7a1c26', 'agan-harrison', 'Agan Harrison');
INSERT INTO taxa.player_url_slugs VALUES (3602, 'f968532a-bf06-478e-89e0-3856b7f4b124', 'daniel-benedicte', 'Daniel Benedicte');
INSERT INTO taxa.player_url_slugs VALUES (3603, 'df4da81a-917b-434f-b309-f00423ee4967', 'eugenia-bickle', 'Eugenia Bickle');
INSERT INTO taxa.player_url_slugs VALUES (3604, '25376b55-bb6f-48a7-9381-7b8210842fad', 'emmett-internet', 'Emmett Internet');
INSERT INTO taxa.player_url_slugs VALUES (3605, 'f6b38e56-0d98-4e00-a96e-345aaac1e653', 'leticia-snyder', 'Leticia Snyder');
INSERT INTO taxa.player_url_slugs VALUES (3606, '1e8b09bd-fbdd-444e-bd7e-10326bd57156', 'fletcher-yamamoto', 'Fletcher Yamamoto');
INSERT INTO taxa.player_url_slugs VALUES (3607, '2727215d-3714-438d-b1ba-2ed15ec481c0', 'dominic-woman', 'Dominic Woman');
INSERT INTO taxa.player_url_slugs VALUES (3608, 'e919dfae-91c3-475c-b5d5-8b0c14940c41', 'famous-meng', 'Famous Meng');
INSERT INTO taxa.player_url_slugs VALUES (3609, '66cebbbf-9933-4329-924a-72bd3718f321', 'kennedy-cena', 'Kennedy Cena');
INSERT INTO taxa.player_url_slugs VALUES (3610, '20be1c34-071d-40c6-8824-dde2af184b4d', 'qais-dogwalker', 'Qais Dogwalker');
INSERT INTO taxa.player_url_slugs VALUES (3611, '6bac62ad-7117-4e41-80f9-5a155a434856', 'grit-freeman', 'Grit Freeman');
INSERT INTO taxa.player_url_slugs VALUES (3612, '3e008f60-6842-42e7-b125-b88c7e5c1a95', 'zeboriah-wilson', 'Zeboriah Wilson');
INSERT INTO taxa.player_url_slugs VALUES (3613, '889c9ef9-d521-4436-b41c-9021b81b4dfb', 'liam-snail', 'Liam Snail');
INSERT INTO taxa.player_url_slugs VALUES (3614, '33fbfe23-37bd-4e37-a481-a87eadb8192d', 'whit-steakknife', 'Whit Steakknife');
INSERT INTO taxa.player_url_slugs VALUES (3615, '083d09d4-7ed3-4100-b021-8fbe30dd43e8', 'jessica-telephone', 'Jessica Telephone');
INSERT INTO taxa.player_url_slugs VALUES (3616, '7158d158-e7bf-4e9b-9259-62e5b25e3de8', 'karato-bean', 'Karato Bean');
INSERT INTO taxa.player_url_slugs VALUES (3617, '4ffd2e50-bb5b-45d0-b7c4-e24d41b2ff5d', 'schneider-bendie', 'Schneider Bendie');
INSERT INTO taxa.player_url_slugs VALUES (3618, '53e701c7-e3c8-4e18-ba05-9b41b4b64cda', 'marquez-clark', 'Marquez Clark');
INSERT INTO taxa.player_url_slugs VALUES (3619, 'cd5494b4-05d0-4b2e-8578-357f0923ff4c', 'mcfarland-vargas', 'Mcfarland Vargas');
INSERT INTO taxa.player_url_slugs VALUES (3620, 'f3c07eaf-3d6c-4cc3-9e54-cbecc9c08286', 'campos-arias', 'Campos Arias');
INSERT INTO taxa.player_url_slugs VALUES (3621, 'ee55248b-318a-4bfb-8894-1cc70e4e0720', 'theo-king', 'Theo King');
INSERT INTO taxa.player_url_slugs VALUES (3622, 'c0732e36-3731-4f1a-abdc-daa9563b6506', 'nagomi-mcdaniel', 'Nagomi Mcdaniel');
INSERT INTO taxa.player_url_slugs VALUES (3623, 'ceac785e-55fd-4a4e-9bc8-17a662a58a38', 'best-cerna', 'Best Cerna');
INSERT INTO taxa.player_url_slugs VALUES (3624, '5ff66eae-7111-4e3b-a9b8-a9579165b0a5', 'daniel-duffy', 'Daniel Duffy');
INSERT INTO taxa.player_url_slugs VALUES (3625, '18798b8f-6391-4cb2-8a5f-6fb540d646d5', 'morrow-doyle', 'Morrow Doyle');
INSERT INTO taxa.player_url_slugs VALUES (3626, '089af518-e27c-4256-adc8-62e3f4b30f43', 'silvia-rugrat', 'Silvia Rugrat');
INSERT INTO taxa.player_url_slugs VALUES (3627, '34267632-8c32-4a8b-b5e6-ce1568bb0639', 'gunther-o''brian', 'Gunther O''Brian');
INSERT INTO taxa.player_url_slugs VALUES (3628, 'ef9f8b95-9e73-49cd-be54-60f84858a285', 'collins-melon', 'Collins Melon');
INSERT INTO taxa.player_url_slugs VALUES (3629, 'bf122660-df52-4fc4-9e70-ee185423ff93', 'walton-sports', 'Walton Sports');
INSERT INTO taxa.player_url_slugs VALUES (3630, '87e6ae4b-67de-4973-aa56-0fc9835a1e1e', 'marco-stink', 'Marco Stink');
INSERT INTO taxa.player_url_slugs VALUES (3631, '378c07b0-5645-44b5-869f-497d144c7b35', 'fynn-doyle', 'Fynn Doyle');
INSERT INTO taxa.player_url_slugs VALUES (3632, '5b5bcc6c-d011-490f-b084-6fdc2c52f958', 'simba-davis', 'Simba Davis');
INSERT INTO taxa.player_url_slugs VALUES (3633, 'f73009c5-2ede-4dc4-b96d-84ba93c8a429', 'thomas-kirby', 'Thomas Kirby');
INSERT INTO taxa.player_url_slugs VALUES (3634, '27faa5a7-d3a8-4d2d-8e62-47cfeba74ff0', 'spears-nolan', 'Spears Nolan');
INSERT INTO taxa.player_url_slugs VALUES (3635, 'b7ca8f3f-2fdc-477b-84f4-157f2802e9b5', 'leach-herman', 'Leach Herman');
INSERT INTO taxa.player_url_slugs VALUES (3636, '0daf04fc-8d0d-4513-8e98-4f610616453b', 'lee-mist', 'Lee Mist');
INSERT INTO taxa.player_url_slugs VALUES (3637, 'ad1e670a-f346-4bf7-a02f-a91649c41ccb', 'stephanie-winters', 'Stephanie Winters');
INSERT INTO taxa.player_url_slugs VALUES (3638, '2da49de2-34e5-49d0-b752-af2a2ee061be', 'cory-twelve', 'Cory Twelve');
INSERT INTO taxa.player_url_slugs VALUES (3639, 'd97835fd-2e92-4698-8900-1f5abea0a3b6', 'king-roland', 'King Roland');
INSERT INTO taxa.player_url_slugs VALUES (3640, '26f01324-9d1c-470b-8eaa-1b9bfbcd8b65', 'nerd-james', 'Nerd James');
INSERT INTO taxa.player_url_slugs VALUES (3641, '9f85676a-7411-444a-8ae2-c7f8f73c285c', 'lachlan-shelton', 'Lachlan Shelton');
INSERT INTO taxa.player_url_slugs VALUES (3642, '5ca7e854-dc00-4955-9235-d7fcd732ddcf', 'taiga-quitter', 'Taiga Quitter');
INSERT INTO taxa.player_url_slugs VALUES (3643, '62823073-84b8-46c2-8451-28fd10dff250', 'mckinney-vaughan', 'Mckinney Vaughan');
INSERT INTO taxa.player_url_slugs VALUES (3644, '740d5fef-d59f-4dac-9a75-739ec07f91cf', 'conner-haley', 'Conner Haley');
INSERT INTO taxa.player_url_slugs VALUES (3645, 'f4ca437c-c31c-4508-afe7-6dae4330d717', 'fran-beans', 'Fran Beans');
INSERT INTO taxa.player_url_slugs VALUES (3646, '503a235f-9fa6-41b5-8514-9475c944273f', 'reese-clark', 'Reese Clark');
INSERT INTO taxa.player_url_slugs VALUES (3647, '75f9d874-5e69-438d-900d-a3fcb1d429b3', 'wyatt-mason-8', 'Wyatt Mason');
INSERT INTO taxa.player_url_slugs VALUES (3648, '6fc3689f-bb7d-4382-98a2-cf6ddc76909d', 'cedric-gonzalez', 'Cedric Gonzalez');
INSERT INTO taxa.player_url_slugs VALUES (3649, '84a2b5f6-4955-4007-9299-3d35ae7135d3', 'kennedy-loser', 'Kennedy Loser');
INSERT INTO taxa.player_url_slugs VALUES (3650, '5fbf04bb-f5ec-4589-ab19-1d89cda056bd', 'donia-dollie', 'Donia Dollie');
INSERT INTO taxa.player_url_slugs VALUES (3651, 'de21c97e-f575-43b7-8be7-ecc5d8c4eaff', 'pitching-machine', 'Pitching Machine');
INSERT INTO taxa.player_url_slugs VALUES (3652, 'e4f1f358-ee1f-4466-863e-f329766279d0', 'ronan-combs', 'Ronan Combs');
INSERT INTO taxa.player_url_slugs VALUES (3653, '5b3f0a43-45e7-44e7-9496-512c24c040f0', 'rhys-rivera', 'Rhys Rivera');
INSERT INTO taxa.player_url_slugs VALUES (3654, '611d18e0-b972-4cdd-afc2-793c56bfe5a9', 'alston-cerveza', 'Alston Cerveza');
INSERT INTO taxa.player_url_slugs VALUES (3655, '13cfbadf-b048-4c4f-903d-f9b52616b15c', 'bennett-bowen', 'Bennett Bowen');
INSERT INTO taxa.player_url_slugs VALUES (3656, '81b25b16-3370-4eb0-9d1b-6d630194c680', 'zeboriah-whiskey', 'Zeboriah Whiskey');
INSERT INTO taxa.player_url_slugs VALUES (3657, 'a311c089-0df4-46bd-9f5d-8c45c7eb5ae2', 'mclaughlin-scorpler', 'Mclaughlin Scorpler');
INSERT INTO taxa.player_url_slugs VALUES (3658, 'f071889c-f10f-4d2f-a1dd-c5dda34b3e2b', 'zion-facepunch', 'Zion Facepunch');
INSERT INTO taxa.player_url_slugs VALUES (3659, 'c6146c45-3d9b-4749-9f03-d4faae61e2c3', 'atlas-diaz', 'Atlas Diaz');
INSERT INTO taxa.player_url_slugs VALUES (3660, '6e373fca-b8ab-4848-9dcc-50e92cd732b7', 'conrad-bates', 'Conrad Bates');
INSERT INTO taxa.player_url_slugs VALUES (3661, 'dd7e710f-da4e-475b-b870-2c29fe9d8c00', 'itsuki-weeks', 'Itsuki Weeks');
INSERT INTO taxa.player_url_slugs VALUES (3662, '4f7d7490-7281-4f8f-b62e-37e99a7c46a0', 'annie-roland', 'Annie Roland');
INSERT INTO taxa.player_url_slugs VALUES (3663, 'f10ba06e-d509-414b-90cd-4d70d43c75f9', 'hernando-winter', 'Hernando Winter');
INSERT INTO taxa.player_url_slugs VALUES (3664, '90c2cec7-0ed5-426a-9de8-754f34d59b39', 'tot-fox', 'Tot Fox');
INSERT INTO taxa.player_url_slugs VALUES (3665, '7afedcd8-870d-4655-9659-3bdfb2e17730', 'pierre-haley', 'Pierre Haley');
INSERT INTO taxa.player_url_slugs VALUES (3666, '3de17e21-17db-4a6b-b7ab-0b2f3c154f42', 'brewer-vapor', 'Brewer Vapor');
INSERT INTO taxa.player_url_slugs VALUES (3667, 'e3e1d190-2b94-40c0-8e88-baa3fd198d0f', 'chambers-kennedy', 'Chambers Kennedy');
INSERT INTO taxa.player_url_slugs VALUES (3668, '27c68d7f-5e40-4afa-8b6f-9df47b79e7dd', 'wyatt-mason-5', 'Wyatt Mason');
INSERT INTO taxa.player_url_slugs VALUES (3669, '5eac7fd9-0d19-4bf4-a013-994acc0c40c0', 'sutton-bishop', 'Sutton Bishop');
INSERT INTO taxa.player_url_slugs VALUES (3670, '27c68d7f-5e40-4afa-8b6f-9df47b79e7dd', 'basilio-preston', 'Basilio Preston');
INSERT INTO taxa.player_url_slugs VALUES (3671, '8e1fd784-99d5-41c1-a6c5-6b947cec6714', 'velasquez-meadows', 'Velasquez Meadows');
INSERT INTO taxa.player_url_slugs VALUES (3672, '5ca7e854-dc00-4955-9235-d7fcd732ddcf', 'wyatt-quitter', 'Wyatt Quitter');
INSERT INTO taxa.player_url_slugs VALUES (3673, 'ea44bd36-65b4-4f3b-ac71-78d87a540b48', 'wanda-pothos', 'Wanda Pothos');
INSERT INTO taxa.player_url_slugs VALUES (3674, '18af933a-4afa-4cba-bda5-45160f3af99b', 'felix-garbage', 'Felix Garbage');
INSERT INTO taxa.player_url_slugs VALUES (3675, '093af82c-84aa-4bd6-ad1a-401fae1fce44', 'elijah-glover', 'Elijah Glover');
INSERT INTO taxa.player_url_slugs VALUES (3676, '0c83e3b6-360e-4b7d-85e3-d906633c9ca0', 'penelope-mathews', 'Penelope Mathews');
INSERT INTO taxa.player_url_slugs VALUES (3677, 'e16c3f28-eecd-4571-be1a-606bbac36b2b', 'wyatt-glover', 'Wyatt Glover');
INSERT INTO taxa.player_url_slugs VALUES (3678, 'd5b6b11d-3924-4634-bd50-76553f1f162b', 'ogden-mendoza', 'Ogden Mendoza');
INSERT INTO taxa.player_url_slugs VALUES (3679, '05bd08d5-7d9f-450b-abfa-1788b8ee8b91', 'stevenson-monstera', 'Stevenson Monstera');
INSERT INTO taxa.player_url_slugs VALUES (3680, 'e6114fd4-a11d-4f6c-b823-65691bb2d288', 'bevan-underbuck', 'Bevan Underbuck');
INSERT INTO taxa.player_url_slugs VALUES (3681, '721fb947-7548-49ea-8cbe-7721b0ed49e0', 'tamara-lopez', 'Tamara Lopez');
INSERT INTO taxa.player_url_slugs VALUES (3682, 'f7715b05-ee69-43e5-a0e5-8e3d34270c82', 'caligula-lotus', 'Caligula Lotus');
INSERT INTO taxa.player_url_slugs VALUES (3683, '7310c32f-8f32-40f2-b086-54555a2c0e86', 'dominic-marijuana', 'Dominic Marijuana');
INSERT INTO taxa.player_url_slugs VALUES (3684, 'e4e4c17d-8128-4704-9e04-f244d4573c4d', 'wesley-poole', 'Wesley Poole');
INSERT INTO taxa.player_url_slugs VALUES (3685, '44c92d97-bb39-469d-a13b-f2dd9ae644d1', 'francisco-preston', 'Francisco Preston');
INSERT INTO taxa.player_url_slugs VALUES (3686, 'f967d064-0eaf-4445-b225-daed700e044b', 'wesley-dudley', 'Wesley Dudley');
INSERT INTO taxa.player_url_slugs VALUES (3687, '10ea5d50-ec88-40a0-ab53-c6e11cc1e479', 'nicholas-vincent', 'Nicholas Vincent');
INSERT INTO taxa.player_url_slugs VALUES (3688, '766dfd1e-11c3-42b6-a167-9b2d568b5dc0', 'sandie-turner', 'Sandie Turner');
INSERT INTO taxa.player_url_slugs VALUES (3689, '9abe02fb-2b5a-432f-b0af-176be6bd62cf', 'nagomi-meng', 'Nagomi Meng');
INSERT INTO taxa.player_url_slugs VALUES (3690, 'e4034192-4dc6-4901-bb30-07fe3cf77b5e', 'wyatt-mason-12', 'Wyatt Mason');
INSERT INTO taxa.player_url_slugs VALUES (3691, '07ac91e9-0269-4e2c-a62d-a87ef61e3bbe', 'eduardo-perez', 'Eduardo Perez');
INSERT INTO taxa.player_url_slugs VALUES (3692, '41949d4d-b151-4f46-8bf7-73119a48fac8', 'ron-monstera', 'Ron Monstera');
INSERT INTO taxa.player_url_slugs VALUES (3693, '1af239ae-7e12-42be-9120-feff90453c85', 'melton-telephone', 'Melton Telephone');
INSERT INTO taxa.player_url_slugs VALUES (3694, 'b8ab86c6-9054-4832-9b96-508dbd4eb624', 'esme-ramsey', 'Esme Ramsey');
INSERT INTO taxa.player_url_slugs VALUES (3695, 'a7edbf19-caf6-45dd-83d5-46496c99aa88', 'rush-valenzuela', 'Rush Valenzuela');
INSERT INTO taxa.player_url_slugs VALUES (3696, '20fd71e7-4fa0-4132-9f47-06a314ed539a', 'lars-taylor', 'Lars Taylor');
INSERT INTO taxa.player_url_slugs VALUES (3697, '64f59d5f-8740-4ebf-91bd-d7697b542a9f', 'zeke-wallace', 'Zeke Wallace');
INSERT INTO taxa.player_url_slugs VALUES (3698, '69196296-f652-42ff-b2ca-0d9b50bd9b7b', 'joshua-butt', 'Joshua Butt');
INSERT INTO taxa.player_url_slugs VALUES (3699, '7007cbd3-7c7b-44fd-9d6b-393e82b1c06e', 'rafael-davids', 'Rafael Davids');
INSERT INTO taxa.player_url_slugs VALUES (3700, 'bfd9ff52-9bf6-4aaf-a859-d308d8f29616', 'declan-suzanne', 'Declan Suzanne');
INSERT INTO taxa.player_url_slugs VALUES (3701, 'c675fcdf-6117-49a6-ac32-99a89a3a88aa', 'valentine-games', 'Valentine Games');
INSERT INTO taxa.player_url_slugs VALUES (3702, '0d5300f6-0966-430f-903f-a4c2338abf00', 'lee-davenport', 'Lee Davenport');
INSERT INTO taxa.player_url_slugs VALUES (3703, '81d7d022-19d6-427d-aafc-031fcb79b29e', 'patty-fox', 'Patty Fox');
INSERT INTO taxa.player_url_slugs VALUES (3704, '061b209a-9cda-44e8-88ce-6a4a37251970', 'mcdowell-karim', 'Mcdowell Karim');
INSERT INTO taxa.player_url_slugs VALUES (3705, 'a8a5cf36-d1a9-47d1-8d22-4a665933a7cc', 'helga-washington', 'Helga Washington');
INSERT INTO taxa.player_url_slugs VALUES (3706, '4204c2d1-ca48-4af7-b827-e99907f12d61', 'axel-cardenas', 'Axel Cardenas');
INSERT INTO taxa.player_url_slugs VALUES (3707, '2b157c5c-9a6a-45a6-858f-bf4cf4cbc0bd', 'ortiz-lopez', 'Ortiz Lopez');
INSERT INTO taxa.player_url_slugs VALUES (3708, '732899a3-2082-4d9f-b1c2-74c8b75e15fb', 'minato-ito', 'Minato Ito');
INSERT INTO taxa.player_url_slugs VALUES (3709, '678170e4-0688-436d-a02d-c0467f9af8c0', 'baby-doyle', 'Baby Doyle');
INSERT INTO taxa.player_url_slugs VALUES (3710, '206bd649-4f5f-4707-ad85-92784be4eb95', 'newton-underbuck', 'Newton Underbuck');
INSERT INTO taxa.player_url_slugs VALUES (3711, 'c182f33c-aea5-48a2-97ed-dc74fa29b3c0', 'swamuel-mora', 'Swamuel Mora');
INSERT INTO taxa.player_url_slugs VALUES (3712, 'd0d7b8fe-bad8-481f-978e-cb659304ed49', 'adalberto-tosser', 'Adalberto Tosser');
INSERT INTO taxa.player_url_slugs VALUES (3713, '8d81b190-d3b8-4cd9-bcec-0e59fdd7f2bc', 'albert-stink', 'Albert Stink');
INSERT INTO taxa.player_url_slugs VALUES (3714, '54e5f222-fb16-47e0-adf9-21813218dafa', 'grit-watson', 'Grit Watson');
INSERT INTO taxa.player_url_slugs VALUES (3715, 'a647388d-fc59-4c1b-90d3-8c1826e07775', 'chambers-simmons', 'Chambers Simmons');
INSERT INTO taxa.player_url_slugs VALUES (3716, '4e6ad1a1-7c71-49de-8bd5-c286712faf9e', 'sutton-picklestein', 'Sutton Picklestein');
INSERT INTO taxa.player_url_slugs VALUES (3717, '8a6fc67d-a7fe-443b-a084-744294cec647', 'terrell-bradley', 'Terrell Bradley');
INSERT INTO taxa.player_url_slugs VALUES (3718, '8f11ad58-e0b9-465c-9442-f46991274557', 'amos-melon', 'Amos Melon');
INSERT INTO taxa.player_url_slugs VALUES (3719, '9965eed5-086c-4977-9470-fe410f92d353', 'bates-bentley', 'Bates Bentley');
INSERT INTO taxa.player_url_slugs VALUES (3720, 'cf8e152e-2d27-4dcc-ba2b-68127de4e6a4', 'hendricks-richardson', 'Hendricks Richardson');
INSERT INTO taxa.player_url_slugs VALUES (3721, 'e111a46d-5ada-4311-ac4f-175cca3357da', 'alexandria-rosales', 'Alexandria Rosales');
INSERT INTO taxa.player_url_slugs VALUES (3722, '17397256-c28c-4cad-85f2-a21768c66e67', 'cory-ross', 'Cory Ross');
INSERT INTO taxa.player_url_slugs VALUES (3723, '2ae8cbfc-2155-4647-9996-3f2591091baf', 'forrest-bookbaby', 'Forrest Bookbaby');
INSERT INTO taxa.player_url_slugs VALUES (3724, '718dea1a-d9a8-4c2b-933a-f0667b5250e6', 'margarito-nava', 'Margarito Nava');
INSERT INTO taxa.player_url_slugs VALUES (3725, '1513aab6-142c-48c6-b43e-fbda65fd64e8', 'caleb-alvarado', 'Caleb Alvarado');
INSERT INTO taxa.player_url_slugs VALUES (3726, '4e63cb5d-4fce-441b-b9e4-dc6a467cf2fd', 'axel-campbell', 'Axel Campbell');
INSERT INTO taxa.player_url_slugs VALUES (3727, 'db33a54c-3934-478f-bad4-fc313ac2580e', 'percival-wheeler', 'Percival Wheeler');
INSERT INTO taxa.player_url_slugs VALUES (3728, '32c9bce6-6e52-40fa-9f64-3629b3d026a8', 'ren-morin', 'Ren Morin');
INSERT INTO taxa.player_url_slugs VALUES (3729, 'b019fb2b-9f4b-4deb-bf78-6bee2f16d98d', 'gloria-bentley', 'Gloria Bentley');
INSERT INTO taxa.player_url_slugs VALUES (3730, '1750de38-8f5f-426a-9e23-2899a15a2031', 'kline-nightmare', 'Kline Nightmare');
INSERT INTO taxa.player_url_slugs VALUES (3731, 'a5f8ce83-02b2-498c-9e48-533a1d81aebf', 'evelton-mcblase', 'Evelton McBlase');
INSERT INTO taxa.player_url_slugs VALUES (3732, 'f70dd57b-55c4-4a62-a5ea-7cc4bf9d8ac1', 'tillman-henderson', 'Tillman Henderson');
INSERT INTO taxa.player_url_slugs VALUES (3733, '63df8701-1871-4987-87d7-b55d4f1df2e9', 'wyatt-mason-7', 'Wyatt Mason');
INSERT INTO taxa.player_url_slugs VALUES (3734, 'e376a90b-7ffe-47a2-a934-f36d6806f17d', 'howell-rocha', 'Howell Rocha');
INSERT INTO taxa.player_url_slugs VALUES (3735, '7dcf6902-632f-48c5-936a-7cf88802b93a', 'parker-parra', 'Parker Parra');
INSERT INTO taxa.player_url_slugs VALUES (3736, 'c57222fd-df55-464c-a44e-b15443e61b70', 'natha-spruce', 'Natha Spruce');
INSERT INTO taxa.player_url_slugs VALUES (3737, '9397ed91-608e-4b13-98ea-e94c795f651e', 'yeongho-garcia', 'Yeong-Ho Garcia');
INSERT INTO taxa.player_url_slugs VALUES (3738, '960f041a-f795-4001-bd88-5ddcf58ee520', 'mayra-buckley', 'Mayra Buckley');
INSERT INTO taxa.player_url_slugs VALUES (3739, '9820f2c5-f9da-4a07-b610-c2dd7bee2ef6', 'peanut-bong', 'Peanut Bong');
INSERT INTO taxa.player_url_slugs VALUES (3740, '97dfc1f6-ac94-4cdc-b0d5-1cb9f8984aa5', 'brock-forbes', 'Brock Forbes');
INSERT INTO taxa.player_url_slugs VALUES (3741, 'bf6a24d1-4e89-4790-a4ba-eeb2870cbf6f', 'wyatt-mason-10', 'Wyatt Mason');
INSERT INTO taxa.player_url_slugs VALUES (3742, '5e4dfa16-f1b9-400f-b8ef-a1613c2b026a', 'snyder-briggs', 'Snyder Briggs');
INSERT INTO taxa.player_url_slugs VALUES (3743, '3d3be7b8-1cbf-450d-8503-fce0daf46cbf', 'zack-sanders', 'Zack Sanders');
INSERT INTO taxa.player_url_slugs VALUES (3744, 'a98917bc-e9df-4b0e-bbde-caa6168aa3d7', 'jenkins-ingram', 'Jenkins Ingram');
INSERT INTO taxa.player_url_slugs VALUES (3745, '667cb445-c288-4e62-b603-27291c1e475d', 'peanut-holloway', 'Peanut Holloway');
INSERT INTO taxa.player_url_slugs VALUES (3746, '98f26a25-905f-4850-8960-b741b0c583a4', 'stu-mcdaniel', 'Stu Mcdaniel');
INSERT INTO taxa.player_url_slugs VALUES (3747, '3afb30c1-1b12-466a-968a-5a9a21458c7f', 'dickerson-greatness', 'Dickerson Greatness');
INSERT INTO taxa.player_url_slugs VALUES (3748, 'bc4187fa-459a-4c06-bbf2-4e0e013d27ce', 'sixpack-dogwalker', 'Sixpack Dogwalker');
INSERT INTO taxa.player_url_slugs VALUES (3749, '906a5728-5454-44a0-adfe-fd8be15b8d9b', 'jefferson-delacruz', 'Jefferson Delacruz');
INSERT INTO taxa.player_url_slugs VALUES (3750, '413b3ddb-d933-4567-a60e-6d157480239d', 'winnie-mccall', 'Winnie Mccall');
INSERT INTO taxa.player_url_slugs VALUES (3751, '5703141c-25d9-46d0-b680-0cf9cfbf4777', 'sandoval-crossing', 'Sandoval Crossing');
INSERT INTO taxa.player_url_slugs VALUES (3752, 'd89da2d2-674c-4b85-8959-a4bd406f760a', 'fish-summer', 'Fish Summer');
INSERT INTO taxa.player_url_slugs VALUES (3753, 'db53211c-f841-4f33-accf-0c3e167889a0', 'travis-bendie', 'Travis Bendie');
INSERT INTO taxa.player_url_slugs VALUES (3754, 'a8530be5-8923-4f74-9675-bf8a1a8f7878', 'mohammed-picklestein', 'Mohammed Picklestein');
INSERT INTO taxa.player_url_slugs VALUES (3755, 'b77dffaa-e0f5-408f-b9f2-1894ed26e744', 'tucker-lenny', 'Tucker Lenny');
INSERT INTO taxa.player_url_slugs VALUES (3756, '495a6bdc-174d-4ad6-8d51-9ee88b1c2e4a', 'shaquille-torres', 'Shaquille Torres');
INSERT INTO taxa.player_url_slugs VALUES (3757, '80e474a3-7d2b-431d-8192-2f1e27162607', 'wyatt-mason-15', 'Wyatt Mason');
INSERT INTO taxa.player_url_slugs VALUES (3758, 'bd549bfe-b395-4dc0-8546-5c04c08e24a5', 'sam-solis', 'Sam Solis');
INSERT INTO taxa.player_url_slugs VALUES (3759, '43d5da5f-c6a1-42f1-ab7f-50ea956b6cd5', 'justice-spoon', 'Justice Spoon');
INSERT INTO taxa.player_url_slugs VALUES (3760, '8ecea7e0-b1fb-4b74-8c8c-3271cb54f659', 'fitzgerald-blackburn', 'Fitzgerald Blackburn');
INSERT INTO taxa.player_url_slugs VALUES (3761, 'ec68845f-3b26-412f-8446-4fef34e09c77', 'nandy-fantastic', 'Nandy Fantastic');
INSERT INTO taxa.player_url_slugs VALUES (3762, '2e13249e-38ff-46a2-a55e-d15fa692468a', 'vito-kravitz', 'Vito Kravitz');
INSERT INTO taxa.player_url_slugs VALUES (3763, '93502db3-85fa-4393-acae-2a5ff3980dde', 'rodriguez-sunshine', 'Rodriguez Sunshine');
INSERT INTO taxa.player_url_slugs VALUES (3764, '9a031b9a-16f8-4165-a468-5d0e28a81151', 'tiana-wheeler', 'Tiana Wheeler');
INSERT INTO taxa.player_url_slugs VALUES (3765, 'c83f0fe0-44d1-4342-81e8-944bb38f8e23', 'langley-wheeler', 'Langley Wheeler');
INSERT INTO taxa.player_url_slugs VALUES (3766, '16aff709-e855-47c8-8818-b9ba66e90fe8', 'mullen-peterson', 'Mullen Peterson');
INSERT INTO taxa.player_url_slugs VALUES (3767, '19af0d67-c73b-4ef2-bc84-e923c1336db5', 'grit-ramos', 'Grit Ramos');
INSERT INTO taxa.player_url_slugs VALUES (3768, '0cc5bd39-e90d-42f9-9dd8-7e703f316436', 'don-elliott', 'Don Elliott');
INSERT INTO taxa.player_url_slugs VALUES (3769, 'ab36c776-b520-429b-a85f-bf633d7b081a', 'goobie-ballson', 'Goobie Ballson');
INSERT INTO taxa.player_url_slugs VALUES (3770, 'bca38809-81de-42ff-94e3-1c0ebfb1e797', 'famous-oconnor', 'Famous Oconnor');
INSERT INTO taxa.player_url_slugs VALUES (3771, '0bb35615-63f2-4492-80ec-b6b322dc5450', 'sexton-wheerer', 'Sexton Wheerer');
INSERT INTO taxa.player_url_slugs VALUES (3772, '5a26fc61-d75d-4c01-9ce2-1880ffb5550f', 'randy-dennis', 'Randy Dennis');
INSERT INTO taxa.player_url_slugs VALUES (3773, 'f741dc01-2bae-4459-bfc0-f97536193eea', 'wyatt-mason-14', 'Wyatt Mason');
INSERT INTO taxa.player_url_slugs VALUES (3774, '7663c3ca-40a1-4f13-a430-14637dce797a', 'polkadot-zavala', 'PolkaDot Zavala');
INSERT INTO taxa.player_url_slugs VALUES (3775, 'f44a8b27-85c1-44de-b129-1b0f60bcb99c', 'atlas-jonbois', 'Atlas Jonbois');
INSERT INTO taxa.player_url_slugs VALUES (3776, 'd8758c1b-afbb-43a5-b00b-6004d419e2c5', 'ortiz-nelson', 'Ortiz Nelson');
INSERT INTO taxa.player_url_slugs VALUES (3777, '21d52455-6c2c-4ee4-8673-ab46b4b926b4', 'wyatt-owens', 'Wyatt Owens');
INSERT INTO taxa.player_url_slugs VALUES (3778, 'a7b0bef3-ee3c-42d4-9e6d-683cd9f5ed84', 'haruta-byrd', 'Haruta Byrd');
INSERT INTO taxa.player_url_slugs VALUES (3779, '4fe28bc1-f690-4ad6-ad09-1b2e984bf30b', 'cell-longarms', 'Cell Longarms');
INSERT INTO taxa.player_url_slugs VALUES (3780, 'bd24e18b-800d-4f15-878d-e334fb4803c4', 'helga-burton', 'Helga Burton');
INSERT INTO taxa.player_url_slugs VALUES (3781, '86adac6f-c694-44ac-9560-758de7eac937', 'quack-enjoyable', 'Quack Enjoyable');
INSERT INTO taxa.player_url_slugs VALUES (3782, 'da0bbbe6-d13c-40cc-9594-8c476975d93d', 'lang-richardson', 'Lang Richardson');
INSERT INTO taxa.player_url_slugs VALUES (3783, 'e4034192-4dc6-4901-bb30-07fe3cf77b5e', 'baldwin-breadwinner', 'Baldwin Breadwinner');
INSERT INTO taxa.player_url_slugs VALUES (3784, '5b9727f7-6a20-47d2-93d9-779f0a85c4ee', 'kennedy-alstott', 'Kennedy Alstott');
INSERT INTO taxa.player_url_slugs VALUES (3785, 'c0177f76-67fc-4316-b650-894159dede45', 'paula-mason', 'Paula Mason');
INSERT INTO taxa.player_url_slugs VALUES (3786, '855775c1-266f-40f6-b07b-3a67ccdf8551', 'nic-winkler', 'Nic Winkler');
INSERT INTO taxa.player_url_slugs VALUES (3787, '1301ee81-406e-43d9-b2bb-55ca6e0f7765', 'malik-destiny', 'Malik Destiny');
INSERT INTO taxa.player_url_slugs VALUES (3788, '0bb35615-63f2-4492-80ec-b6b322dc5450', 'wyatt-mason-2', 'Wyatt Mason');
INSERT INTO taxa.player_url_slugs VALUES (3789, 'a7d8196a-ca6b-4dab-a9d7-c27f3e86cc21', 'commissioner-vapor', 'Commissioner Vapor');
INSERT INTO taxa.player_url_slugs VALUES (3790, 'efa73de4-af17-4f88-99d6-d0d69ed1d200', 'antonio-mccall', 'Antonio Mccall');
INSERT INTO taxa.player_url_slugs VALUES (3791, '472f50c0-ef98-4d05-91d0-d6359eec3946', 'rhys-trombone', 'Rhys Trombone');
INSERT INTO taxa.player_url_slugs VALUES (3792, 'fbb5291c-2438-400e-ab32-30ce1259c600', 'cory-novak', 'Cory Novak');
INSERT INTO taxa.player_url_slugs VALUES (3793, '26cfccf2-850e-43eb-b085-ff73ad0749b8', 'beasley-day', 'Beasley Day');
INSERT INTO taxa.player_url_slugs VALUES (3794, 'aa7ac9cb-e9db-4313-9941-9f3431728dce', 'matteo-cash', 'Matteo Cash');
INSERT INTO taxa.player_url_slugs VALUES (3795, 'f245f6c6-4613-40f5-bc3b-85aa9ee3cf7e', 'usurper-violet', 'Usurper Violet');
INSERT INTO taxa.player_url_slugs VALUES (3796, 'f9930cb1-7ed2-4b9a-bf4f-7e35f2586d71', 'finn-james', 'Finn James');
INSERT INTO taxa.player_url_slugs VALUES (3797, 'ff5a37d9-a6dd-49aa-b6fb-b935fd670820', 'dunn-keyes', 'Dunn Keyes');
INSERT INTO taxa.player_url_slugs VALUES (3798, '63df8701-1871-4987-87d7-b55d4f1df2e9', 'mcdowell-mason', 'Mcdowell Mason');
INSERT INTO taxa.player_url_slugs VALUES (3799, '3be2c730-b351-43f7-a832-a5294fe8468f', 'amaya-jackson', 'Amaya Jackson');
INSERT INTO taxa.player_url_slugs VALUES (3800, '7853aa8c-e86d-4483-927d-c1d14ea3a34d', 'tucker-flores', 'Tucker Flores');
INSERT INTO taxa.player_url_slugs VALUES (3801, '8cf78b49-d0ca-4703-88e8-4bcad26c44b1', 'avila-guzman', 'Avila Guzman');
INSERT INTO taxa.player_url_slugs VALUES (3802, '805ba480-df4d-4f56-a4cf-0b99959111b5', 'leticia-lozano', 'Leticia Lozano');
INSERT INTO taxa.player_url_slugs VALUES (3803, '31f83a89-44e3-47b7-8c9e-0dfdcd8bd30f', 'tyreek-olive', 'Tyreek Olive');
INSERT INTO taxa.player_url_slugs VALUES (3804, '8ba7e1ff-4c6d-4963-8e0f-7096d14f4b12', 'jenna-maldonado', 'Jenna Maldonado');
INSERT INTO taxa.player_url_slugs VALUES (3805, 'a071a713-a6a1-4b4c-bb3f-45d9fba7a08c', 'nora-perez', 'Nora Perez');
INSERT INTO taxa.player_url_slugs VALUES (3806, 'bc4187fa-459a-4c06-bbf2-4e0e013d27ce', 'sixpack-dogwalker-deprecated', 'Sixpack Dogwalker');
INSERT INTO taxa.player_url_slugs VALUES (3807, 'c6a19154-7438-4c4f-b786-2dfaf5951f0f', 'silvaire-roadhouse', 'Silvaire Roadhouse');
INSERT INTO taxa.player_url_slugs VALUES (3808, 'ef32eb48-4866-49d0-ae58-9c4982e01142', 'fitzgerald-massey', 'Fitzgerald Massey');

