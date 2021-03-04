-- LAST UPDATE: 3/3/2021   

DROP TABLE IF EXISTS taxa.weather CASCADE;
DROP SEQUENCE IF EXISTS taxa.vibe_to_arrows_vibe_to_arrow_id_seq CASCADE;
DROP TABLE IF EXISTS taxa.vibe_to_arrows CASCADE;
DROP SEQUENCE IF EXISTS taxa.team_divine_favor_team_divine_favor_id_seq CASCADE;
DROP TABLE IF EXISTS taxa.team_divine_favor CASCADE;
DROP SEQUENCE IF EXISTS taxa.team_abbreviations_team_abbreviation_id_seq CASCADE;
DROP SEQUENCE IF EXISTS taxa.player_url_slugs_player_url_slug_id_seq CASCADE;
DROP SEQUENCE IF EXISTS taxa.team_additional_info_team_additional_info_id_seq CASCADE;
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
DROP TABLE IF EXISTS taxa.additional_info CASCADE;
DROP TABLE IF EXISTS taxa.player_url_slugs CASCADE;
DROP TABLE IF EXISTS taxa.position_types CASCADE;
DROP TABLE IF EXISTS taxa.coffee CASCADE;
DROP TABLE IF EXISTS taxa.blood CASCADE;
DROP TABLE IF EXISTS taxa.team_abbreviations CASCADE;
DROP TABLE IF EXISTS taxa.team_additional_info CASCADE;
DROP TABLE IF EXISTS taxa.leagues CASCADE;
DROP TABLE IF EXISTS taxa.divisions CASCADE;
DROP TABLE IF EXISTS taxa.division_teams CASCADE;
DROP TABLE IF EXISTS taxa.event_types CASCADE;
DROP TABLE IF EXISTS taxa.tournaments CASCADE;
DROP TABLE IF EXISTS taxa.tournament_teams CASCADE;
DROP SEQUENCE IF EXISTS taxa.tournaments_tournament_db_id_seq CASCADE;
DROP SEQUENCE IF EXISTS taxa.tournament_teams_tournament_team_id_seq CASCADE;
DROP TABLE IF EXISTS taxa.player_incinerations_unrecorded CASCADE;

--
-- Name: player_incinerations_unrecorded; Type: TABLE; Schema: taxa; Owner: -
--
CREATE TABLE taxa.player_incinerations_unrecorded (
	season INTEGER NULL DEFAULT NULL,
	"day" INTEGER NULL DEFAULT NULL,
	tournament INTEGER NULL DEFAULT NULL,
	phase VARCHAR NULL DEFAULT NULL,
	player_name VARCHAR NULL DEFAULT NULL,
	player_id VARCHAR(36) NULL DEFAULT NULL
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
-- Name: team_abbreviations; Type: TABLE; Schema: taxa; Owner: -
--
CREATE TABLE taxa.team_additional_info (
	team_additional_info_id INTEGER NOT NULL,
	team_id character varying,
	team_abbreviation character varying,
	team_main_color character varying,
	team_secondary_color character varying,
	team_emoji character varying,
	team_slogan character varying
);
--
-- Name: team_abbreviations_team_abbreviation_id_seq; Type: SEQUENCE; Schema: taxa; Owner: -
--
CREATE SEQUENCE taxa.team_additional_info_team_additional_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
--
-- Name: team_additional_info_team_additional_info_id_seq; Type: SEQUENCE OWNED BY; Schema: taxa; Owner: -
--
ALTER SEQUENCE taxa.team_additional_info_team_additional_info_id_seq OWNED BY taxa.team_additional_info.team_additional_info_id;
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
    attribute character varying,
    attribute_desc character varying,
    attribute_category character varying,
    attribute_short character varying,
	attribute_datatype character varying,
	attribute_directionality character varying
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

INSERT INTO taxa.attributes 
VALUES 
(1,'base_thirst','Increases stolen base attempts.','baserunning','Bt','NUMERIC','larger'),
(2,'continuation','Whether the runner advances 1 or 2 bases on a hit. (also linked to indulgence somewhat).','baserunning','Cn','NUMERIC','larger'),
(3,'ground_friction','Appears to govern the rate of triples, slight negative correlation with doubles hit, possibly by stretching them into triples instead?','baserunning','G','NUMERIC','larger'),
(4,'indulgence','Seems to be related to runner advancement on an out (base advancement, scoring on a sacrifice), in concert with laserlikeness.','baserunning','I','NUMERIC','larger'),
(5,'laserlikeness','Steal success, steal attempts (correlation stronger than base_thirst); along with Indulgence, appears to impact runner advancement on outs (and may just be a general running speed/ability).','baserunning','L','NUMERIC','larger'),
(6,'divinity','Home run frequency.  Also part of Soulscream formula.','batting','Dv','NUMERIC','larger'),
(7,'martyrdom','Determines whether a runner advances or whether an out is a Fielder’s Choice.','batting','Mr','NUMERIC','larger'),
(8,'moxie','Ability to draw walks - (current theory is it represents some kind of plate discipline, as opposed to impacting the rate of pitcher balls).','batting','Mo','NUMERIC','larger'),
(9,'musclitude','Extra base hits (specifically seems to be for doubles), also appears to impact fouls.','batting','Ms','NUMERIC','larger'),
(10,'patheticism','Likelihood of the batter making contact with the ball; generally correlates with high strikeout rate.','batting','Pa','NUMERIC','smaller'),
(11,'thwackability','Quality of contact with the ball, reducing the chance of balls being fielded (probably in some kind of thwack vs unthwack contest).','batting','Tw','NUMERIC','larger'),
(12,'tragicness','Direct use unknown, but gets set to 0.1 at the start of seasons and upon siestas/delays etc throughout the season.  Also part of Soulscream formula.','batting','Tr','NUMERIC','smaller'),
(13,'anticapitalism','Related to steal attempts in some form.','defense','A','NUMERIC','larger'),
(14,'chasiness','Defensive ability to prevent extra base hits (by holding runners to first?)','defense','Ch','NUMERIC','larger'),
(15,'omniscience','Defensive odds on turning a batted ball into an out.','defense','Om','NUMERIC','larger'),
(16,'tenaciousness','Related to steal attempts in some form.','defense','Te','NUMERIC','larger'),
(17,'watchfulness','Reduces baserunner attempts to steal (impact on success rate not known).','defense','W','NUMERIC','larger'),
(18,'coldness','Unknown.','pitching','Co','NUMERIC','larger'),
(19,'overpowerment','Lowers home runs - seems to be involved in all hit types, potentially used to counter triples and doubles as well (likely by reducing the power of batted balls).','pitching','Ov','NUMERIC','larger'),
(20,'ruthlessness','Reduces walks and increases strikeouts - seems to essentially determine whether a given pitch is in or out of the strike zone.  Also part of Soulscream formula.','pitching','R','NUMERIC','larger'),
(21,'shakespearianism','“is linked to Tragicness” for whatever use that is (basically none).  Also part of Soulscream formula.  The White Whale of attributes.','pitching','S','NUMERIC','larger'),
(22,'suppression','Appears to be opposed to Buoyancy and helps determine if a ball in play will become a groundout or a fly out.  Not part of pitching rating formula.','pitching','','NUMERIC','larger'),
(23,'unthwackability','Lowers hits allowed - reduces “quality” of batter contact, increasing likelihood of a ball being fielded .','pitching','Un','NUMERIC','larger'),
(24,'buoyancy','Determines frequency of curve in Vibes.','vibes','Bu','NUMERIC','larger'),
(25,'cinnamon','Determines maximum level of Vibes.','vibes','Ci','NUMERIC','larger'),
(26,'pressurization','Determines minimum level of Vibes.  Also part of Soulscream formula.','vibes','Pr','NUMERIC','larger'),
(27,'fate','Unknown; appears to re-roll for most (but not all) stat, modification or Feedback changes.',NULL, NULL,'INTEGER','See taxonomy'),
(28,'peanut_allergy','Determines whether a peanut interaction affects player positively or negatively.',NULL, NULL,'BOOLEAN',''),
(29,'soul','Determines length of Soulscream/Soulsong; only has changed for one player once (Chorby Soul, which results in broken Soulscream).',NULL, NULL,'INTEGER','See taxonomy'),
(30,'total_fingers','Represents instances of change to pitching stats. Players impacted by general stat buffs all receive +1 finger, regardless of the size of their buff. EPT seems to not grant fingers.',NULL, NULL,'INTEGER','See taxonomy');

--
-- Data for Name: blood; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.blood 
VALUES
(0, 'A'),
(1, 'AAA'),
(2, 'AA'),
(3, 'Acidic'),
(4, 'Basic'),
(5, 'O'),
(6, 'O No'),
(7, 'H₂O'),
(8, 'Electric'),
(9, 'Love'),
(10, 'Fire'),
(11, 'Psychic'),
(12, 'Grass');


--
-- Data for Name: card; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.card 
VALUES 
(0, 'I The Magician', NULL),
(1, 'II The High Priestess', NULL),
(2, 'III The Empress', NULL),
(3, 'IIII The Emperor', NULL),
(4, 'V The Pope', NULL),
(5, 'VI The Lover ', NULL),
(6, 'VII The Chariot', NULL),
(7, 'VIII Justice', NULL),
(8, 'VIIII The Hermit', NULL),
(9, 'X The Wheel of Fortune', NULL),
(10, 'XI Strength', NULL),(11, 'XII The Hanged Man', NULL),
(12, 'XIII', NULL),
(13, 'XIIII Temperance', NULL),
(14, 'XV The Devil', NULL),
(15, 'XVI The Tower', NULL),
(16, 'XVII The Star', NULL),
(17, 'XVIII The Moon', NULL),
(18, 'XVIIII The Sun', NULL),
(19, 'XX Judgment', NULL);


--
-- Data for Name: coffee; Type: TABLE DATA; Schema: taxa; Owner: -
--
INSERT INTO taxa.coffee 
VALUES 
(0, 'Black'),
(1, 'Light & Sweet'),
(2, 'Macchiato'),
(3, 'Cream & Sugar'),
(4, 'Cold Brew'),
(5, 'Flat White'),
(6, 'Americano'),
(7, 'Espresso'),
(8, 'Heavy Foam'),
(9, 'Latte'),
(10, 'Decaf'),
(11, 'Milk Substitute'),
(12, 'Plenty of Sugar'),
(13, 'Anything');

--
-- Data for Name: division_teams; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.division_teams 
VALUES 
(1, 'fadc9684-45b3-47a6-b647-3be3f0735a84', '57ec08cc-0411-4643-b304-0e80dbc15ac7', '2020-09-06 15:26:39.925823', '2020-10-19 15:00:01.023128'),
(2, 'fadc9684-45b3-47a6-b647-3be3f0735a84', '979aee4a-6d80-4863-bf1c-ee1a78e06024', '2020-09-06 15:26:39.925823', NULL),
(3, 'fadc9684-45b3-47a6-b647-3be3f0735a84', '23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7', '2020-09-06 15:26:39.925823', '2020-10-19 15:00:01.023128'),
(4, 'fadc9684-45b3-47a6-b647-3be3f0735a84', 'bfd38797-8404-4b38-8b82-341da28b1f83', '2020-09-06 15:26:39.925823', NULL),
(5, 'fadc9684-45b3-47a6-b647-3be3f0735a84', '7966eb04-efcc-499b-8f03-d13916330531', '2020-09-06 15:26:39.925823', NULL),
(6, 'f711d960-dc28-4ae2-9249-e1f320fec7d7', 'b72f3061-f573-40d7-832a-5ad475bd7909', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(7, 'f711d960-dc28-4ae2-9249-e1f320fec7d7', '878c1bf6-0d21-4659-bfee-916c8314d69c', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(8, 'f711d960-dc28-4ae2-9249-e1f320fec7d7', 'b024e975-1c4a-4575-8936-a3754a08806a', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(9, 'f711d960-dc28-4ae2-9249-e1f320fec7d7', 'adc5b394-8f76-416d-9ce9-813706877b84', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(10, 'f711d960-dc28-4ae2-9249-e1f320fec7d7', 'ca3f1c8c-c025-4d8e-8eef-5be6accbeb16', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(11, '5eb2271a-3e49-48dc-b002-9cb615288836', 'bfd38797-8404-4b38-8b82-341da28b1f83', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(12, '5eb2271a-3e49-48dc-b002-9cb615288836', '3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(13, '5eb2271a-3e49-48dc-b002-9cb615288836', '979aee4a-6d80-4863-bf1c-ee1a78e06024', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(14, '5eb2271a-3e49-48dc-b002-9cb615288836', '7966eb04-efcc-499b-8f03-d13916330531', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(15, '5eb2271a-3e49-48dc-b002-9cb615288836', '36569151-a2fb-43c1-9df7-2df512424c82', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(16, '765a1e03-4101-4e8e-b611-389e71d13619', '8d87c468-699a-47a8-b40d-cfb73a5660ad', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(17, '765a1e03-4101-4e8e-b611-389e71d13619', '23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(18, '765a1e03-4101-4e8e-b611-389e71d13619', 'f02aeae2-5e6a-4098-9842-02d2273f25c7', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(19, '765a1e03-4101-4e8e-b611-389e71d13619', '57ec08cc-0411-4643-b304-0e80dbc15ac7', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(20, '765a1e03-4101-4e8e-b611-389e71d13619', '747b8e4a-7e50-4638-a973-ea7950a3e739', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(21, '7fbad33c-59ab-4e80-ba63-347177edaa2e', 'eb67ae5e-c4bf-46ca-bbbc-425cd34182ff', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(22, '7fbad33c-59ab-4e80-ba63-347177edaa2e', '9debc64f-74b7-4ae1-a4d6-fce0144b6ea5', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(23, '7fbad33c-59ab-4e80-ba63-347177edaa2e', 'b63be8c2-576a-4d6e-8daf-814f8bcea96f', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(24, '7fbad33c-59ab-4e80-ba63-347177edaa2e', '105bc3ff-1320-4e37-8ef0-8d595cb95dd0', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(25, '7fbad33c-59ab-4e80-ba63-347177edaa2e', 'a37f9158-7f82-46bc-908c-c9e2dda7c33b', '2020-07-29 08:12:22.438', '2020-09-06 15:26:39.925823'),
(26, 'd4cc18de-a136-4271-84f1-32516be91a80', 'b72f3061-f573-40d7-832a-5ad475bd7909', '2020-09-06 15:26:39.925823', '2020-10-19 15:00:01.023128'),
(27, 'd4cc18de-a136-4271-84f1-32516be91a80', '8d87c468-699a-47a8-b40d-cfb73a5660ad', '2020-09-06 15:26:39.925823', '2020-10-18 19:00:09.443928'),
(28, 'd4cc18de-a136-4271-84f1-32516be91a80', '36569151-a2fb-43c1-9df7-2df512424c82', '2020-09-06 15:26:39.925823', '2020-10-19 15:00:01.023128'),
(29, 'd4cc18de-a136-4271-84f1-32516be91a80', 'ca3f1c8c-c025-4d8e-8eef-5be6accbeb16', '2020-09-06 15:26:39.925823', NULL),
(30, 'd4cc18de-a136-4271-84f1-32516be91a80', 'a37f9158-7f82-46bc-908c-c9e2dda7c33b', '2020-09-06 15:26:39.925823', NULL),
(31, '98c92da4-0ea7-43be-bd75-c6150e184326', '9debc64f-74b7-4ae1-a4d6-fce0144b6ea5', '2020-09-06 15:26:39.925823', NULL),
(32, '98c92da4-0ea7-43be-bd75-c6150e184326', '3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e', '2020-09-06 15:26:39.925823', NULL),
(33, '98c92da4-0ea7-43be-bd75-c6150e184326', 'b63be8c2-576a-4d6e-8daf-814f8bcea96f', '2020-09-06 15:26:39.925823', NULL),
(34, '98c92da4-0ea7-43be-bd75-c6150e184326', 'f02aeae2-5e6a-4098-9842-02d2273f25c7', '2020-09-06 15:26:39.925823', NULL),
(35, '98c92da4-0ea7-43be-bd75-c6150e184326', '878c1bf6-0d21-4659-bfee-916c8314d69c', '2020-09-06 15:26:39.925823', NULL),
(36, '456089f0-f338-4620-a014-9540868789c9', '747b8e4a-7e50-4638-a973-ea7950a3e739', '2020-09-06 15:26:39.925823', '2020-10-19 15:00:01.023128'),
(37, '456089f0-f338-4620-a014-9540868789c9', 'eb67ae5e-c4bf-46ca-bbbc-425cd34182ff', '2020-09-06 15:26:39.925823', '2020-10-19 15:00:01.023128'),
(38, '456089f0-f338-4620-a014-9540868789c9', '105bc3ff-1320-4e37-8ef0-8d595cb95dd0', '2020-09-06 15:26:39.925823', NULL),
(39, '456089f0-f338-4620-a014-9540868789c9', 'b024e975-1c4a-4575-8936-a3754a08806a', '2020-09-06 15:26:39.925823', NULL),
(40, '456089f0-f338-4620-a014-9540868789c9', 'adc5b394-8f76-416d-9ce9-813706877b84', '2020-09-06 15:26:39.925823', '2020-10-19 15:00:01.023128'),
(41, 'd4cc18de-a136-4271-84f1-32516be91a80', 'c73b705c-40ad-4633-a6ed-d357ee2e2bcf', '2020-10-18 19:00:09.443928', NULL),
(42, 'fadc9684-45b3-47a6-b647-3be3f0735a84', 'eb67ae5e-c4bf-46ca-bbbc-425cd34182ff', '2020-10-19 15:00:01.023128', NULL),
(43, 'd4cc18de-a136-4271-84f1-32516be91a80', '747b8e4a-7e50-4638-a973-ea7950a3e739', '2020-10-19 15:00:01.023128', NULL),
(44, '456089f0-f338-4620-a014-9540868789c9', '23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7', '2020-10-19 15:00:01.023128', NULL),
(45, 'd4cc18de-a136-4271-84f1-32516be91a80', '57ec08cc-0411-4643-b304-0e80dbc15ac7', '2020-10-19 15:00:01.023128', NULL),
(46, '456089f0-f338-4620-a014-9540868789c9', 'b72f3061-f573-40d7-832a-5ad475bd7909', '2020-10-19 15:00:01.023128', NULL),
(47, '456089f0-f338-4620-a014-9540868789c9', '36569151-a2fb-43c1-9df7-2df512424c82', '2020-10-19 15:00:01.023128', NULL),
(48, 'fadc9684-45b3-47a6-b647-3be3f0735a84', 'adc5b394-8f76-416d-9ce9-813706877b84', '2020-10-19 15:00:01.023128', NULL),
(49, NULL, '8d87c468-699a-47a8-b40d-cfb73a5660ad', '2020-10-18 19:00:09.443928', NULL);

--
-- Data for Name: divisions; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.divisions 
VALUES 
(1, 'Lawful Good', 1, '2020-09-06 15:26:39.925823', '{0,1,2,3,4}', 'f711d960-dc28-4ae2-9249-e1f320fec7d7', '2020-07-29 08:12:22.438'),
(2, 'Chaotic Good', 1, '2020-09-06 15:26:39.925823', '{0,1,2,3,4}', '5eb2271a-3e49-48dc-b002-9cb615288836', '2020-07-29 08:12:22.438'),
(3, 'Lawful Evil', 2, '2020-09-06 15:26:39.925823', '{0,1,2,3,4}', '765a1e03-4101-4e8e-b611-389e71d13619', '2020-07-29 08:12:22.438'),
(4, 'Chaotic Evil', 2, '2020-09-06 15:26:39.925823', '{0,1,2,3,4}', '7fbad33c-59ab-4e80-ba63-347177edaa2e', '2020-07-29 08:12:22.438'),
(5, 'Wild High', 3, NULL, '{5}', 'd4cc18de-a136-4271-84f1-32516be91a80', '2020-09-06 15:26:34.254566'),
(6, 'Wild Low', 3, NULL, '{5}', '98c92da4-0ea7-43be-bd75-c6150e184326', '2020-09-06 15:26:34.254566'),
(7, 'Mild High', 4, NULL, '{5}', '456089f0-f338-4620-a014-9540868789c9', '2020-09-06 15:26:34.254566'),
(8, 'Mild Low', 4, NULL, '{5}', 'fadc9684-45b3-47a6-b647-3be3f0735a84', '2020-09-06 15:26:34.254566');

--
-- Data for Name: event_types; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.event_types 
VALUES 
(1, 'CAUGHT_STEALING', 0, 0, 0, 0, 1),
(2, 'OUT', 1, 1, 0, 0, 1),
(3, 'STRIKEOUT', 1, 1, 0, 0, 1),
(4, 'DOUBLE', 1, 1, 1, 2, 0),
(5, 'HOME_RUN', 1, 1, 1, 4, 0),
(6, 'SINGLE', 1, 1, 1, 1, 0),
(7, 'STOLEN_BASE', 0, 0, 0, 0, 0),
(8, 'TRIPLE', 1, 1, 1, 3, 0),
(9, 'SACRIFICE', 1, 0, 0, 0, 1),
(10, 'QUADRUPLE', 1, 1, 1, 4, 0),
(11, 'FIELDERS_CHOICE', 1, 1, 0, 0, 1),
(12, 'GAME_OVER', 0, 0, 0, 0, 0),
(13, 'UNKNOWN_OUT', 0, 0, 0, 0, 1),
(14, 'UNKNOWN', 0, 0, 0, 0, 0),
(15, 'DOUBLE WALK', 1, 0, 0, 2, 0),
(16, 'HIT_BY_PITCH', 1, 0, 0, 1, 0),
(17, 'TRIPLE_WALK', 1, 0, 0, 3, 0),
(18, 'WALK', 1, 0, 0, 1, 0),
(19, 'WILD_PITCH', 0, 0, 0, 0, 0),
(20, 'HOME_RUN_5', 1, 1, 1, 5, 0),
(21, 'CHARM_STRIKEOUT', 1, 1, 0, 0, 1),
(22, 'CHARM_WALK', 1, 0, 0, 1, 0);


--
-- Data for Name: leagues; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.leagues 
VALUES 
(1, 'Good', '{0,1,2,3,4}', '2020-09-06 15:26:34.254566', '7d3a3dd6-9ea1-4535-9d91-bde875c85e80', '2020-07-29 08:12:22.438'),
(2, 'Evil', '{0,1,2,3,4}', '2020-09-06 15:26:34.254566', '93e58443-9617-44d4-8561-e254a1dbd450', '2020-07-29 08:12:22.438'),
(3, 'Wild', '{5}', NULL, 'aabc11a1-81af-4036-9f18-229c759ca8a9', '2020-09-06 15:26:34.254566'),
(4, 'Mild', '{5}', NULL, '4fe65afa-804f-4bb2-9b15-1281b2eab110', '2020-09-06 15:26:34.254566');


--
-- Data for Name: modifications; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.modifications 
VALUES 
(1, 'EXTRA_STRIKE', '#f77c9f', '#f77c9f', '#8c1839', 'The Fourth Strike', 'Those with the Fourth Strike will get an extra strike in each at bat.', 'team'),
(2, 'SHAME_PIT', '#b96dbd', '#b96dbd', '#3d1539', 'Targeted Shame', 'Teams with Targeted Shame will start with negative runs the game after being shamed.', 'team'),
(3, 'HOME_FIELD', '#f9ff54', '#f9ff54', '#4f9c30', 'Home Field Advantage', 'Teams with Home Field Advantage will start each home game with one run.', 'team'),
(4, 'FIREPROOF', '#a5c5f0', '#a5c5f0', '#4c77b0', 'Fireproof', 'A Fireproof player can not be incinerated.', 'player'),
(5, 'ALTERNATE', '#fffd85', '#fffd85', '#404040', 'Alternate', 'This player is an Alternate...', 'player'),
(6, 'SOUNDPROOF', '#c92080', '#c92080', '#000000', 'Soundproof', 'A Soundproof player can not be caught in Feedback''s reality flickers.', 'player'),
(7, 'SHELLED', '#fffd85', '#fffd85', '#404040', 'Shelled', 'A Shelled player is trapped in a big Peanut is unable to bat or pitch.', 'player'),
(8, 'REVERBERATING', '#61b3ff', '#61b3ff', '#756773', 'Reverberating', 'A Reverberating player has a small chance of batting again after each of their At-Bats end.', 'player'),
(9, 'BLOOD_DONOR', '#ff1f3c', '#ff1f3c', '#52050f', 'Blood Donor', 'In the Blood Bath, this team will donate Stars to a division opponent that finished behind them in the standings.', 'team'),
(10, 'BLOOD_THIEF', '#ff1f3c', '#ff1f3c', '#52050f', 'Blood Thief', 'In the Blood Bath, this team will steal Stars from a division opponent that finished ahead of them in the standings.', 'team'),
(11, 'BLOOD_PITY', '#ff1f3c', '#ff1f3c', '#52050f', 'Blood Pity', 'In the Blood Bath, this team must give Stars to the team that finished last in their division.', 'team'),
(12, 'BLOOD_WINNER', '#ff1f3c', '#ff1f3c', '#52050f', 'Blood Winner', 'In the Blood Bath, this team must give Stars to the team that finished first in their division.', 'team'),
(13, 'BLOOD_FAITH', '#ff1f3c', '#ff1f3c', '#52050f', 'Blood Faith', 'In the Blood Bath, this player will receive a small boost to a random stat.', 'player'),
(14, 'BLOOD_LAW', '#ff1f3c', '#ff1f3c', '#52050f', 'Blood Law', 'In the Blood Bath, this team will gain or lose Stars depending on how low or high they finish in their division.', 'team'),
(15, 'BLOOD_CHAOS', '#ff1f3c', '#ff1f3c', '#52050f', 'Blood Chaos', 'In the Blood Bath, each player on this team will gain or lose a random amount of Stars.', 'team'),
(16, 'RETURNED', '#fbff8a', '#fbff8a', '#1b1c80', 'Returned', 'This player has Returned from the void. At the end of each season, this player has a chance of being called back to the Void.', 'player'),
(17, 'INWARD', '#d3d8de', '#d3d8de', '#38080d', 'Inward', 'This player has turned Inward.', 'player'),
(18, 'MARKED', '#eaabff', '#eaabff', '#1b1c80', 'Unstable', 'Unstable players have a much higher chance of being incinerated in a Solar Eclipse.', 'player'),
(19, 'PARTY_TIME', '#ff66f9', '#ff66f9', '#fff947', 'Party Time', 'This team is mathematically eliminated from the Postseason, and will occasionally receive permanent stats boost in their games.', 'team'),
(20, 'LIFE_OF_PARTY', '#fff45e', '#fff45e', '#9141ba', 'Life of the Party', 'This team gets 10% more from their Party Time stat boosts.', 'team'),
(21, 'DEBT_ZERO', '#ff1f3c', '#ff1f3c', '#1b1c80', 'Debt', 'This player must fulfill a debt.', 'player'),
(22, 'DEBT', '#ff1f3c', '#ff1f3c', '#363738', 'Refinanced Debt', 'This player must fulfill a debt.', 'player'),
(23, 'DEBT_TWO', '#ff1f3c', '#ff1f3c', '#612273', 'Consolidated Debt', 'This player must fulfill a debt.', 'player'),
(24, 'SPICY', '#9e0022', '#9e0022', '#d15700', 'Spicy', 'Spicy batters will be Red Hot when they get three consecutive hits.', 'player'),
(25, 'HEATING_UP', '#9e0022', '#9e0022', '#d15700', 'Heating Up...', 'This batter needs one more consecutive hit to enter Fire mode. This mod will disappear if the batter gets out.', 'player'),
(26, 'ON_FIRE', '#fff982', '#fff982', '#e32600', 'Red Hot!', 'Red Hot! This player''s batting is greatly boosted. This mod will disappear if the batter gets out.', 'player'),
(27, 'HONEY_ROASTED', '#ffda75', '#ffda75', '#b5831f', 'Honey Roasted', 'This player has been Honey-Roasted.', 'player'),
(28, 'FIRST_BORN', '#fffea8', '#fffea8', '#517063', 'First Born', 'This player was the first born from the New Field of Eggs.', 'player'),
(29, 'SUPERALLERGIC', '#bd224e', '#bd224e', '#45003d', 'Superallergic', 'This player is Superallergic', 'player'),
(30, 'SUPERYUMMY', '#ffdb59', '#ffdb59', '#c96faa', 'Superyummy', 'This player seriously loves peanuts', 'player'),
(31, 'EXTRA_BASE', '#d9d9d9', '#d9d9d9', '#4a001a', 'Fifth Base', 'This team must run five bases instead of four in order to score.', 'team'),
(32, 'BLESS_OFF', '#e0cafa', '#e0cafa', '#7d58a8', 'Bless Off', 'This team cannot win any Blessings in the upcoming Election.', 'team'),
(33, 'NON_IDOLIZED', '#fffaba', '#fffaba', '#540e43', 'Idol Immune', 'Idol Immune players cannot be Idolized by Fans.', 'player'),
(34, 'GRAVITY', '#759bc9', '#759bc9', '#4c5052', 'Gravity', 'This player cannot be affected by Reverb.', 'player'),
(35, 'ELECTRIC', '#fff199', '#fff199', '#04144a', 'Electric', 'Electric teams have a chance of zapping away Strikes.', 'team'),
(36, 'DOUBLE_PAYOUTS', '#fffaba', '#fffaba', '#786600', 'Super Idol', 'This player will earn Fans double the rewards from all Idol Pendants.', 'player'),
(37, 'FIRE_PROTECTOR', '#c4ff85', '#c4ff85', '#1f474f', 'Fire Protector', 'This player will protect their team from incinerations.', 'player'),
(38, 'RECEIVER', '#ff007b', '#ff007b', '#383838', 'Receiver', 'This player is a Receiver.', 'player'),
(39, 'FLICKERING', '#ff007b', '#ff007b', '#383838', 'Flickering', 'Flickering players have a much higher chance of being Feedbacked to their opponent.', 'player'),
(40, 'GROWTH', '#52a17b', '#52a17b', '#13422b', 'Growth', 'Growth teams will play better as the season goes on, up to a 5% global boost by season''s end.', 'team'),
(41, 'BASE_INSTINCTS', '#dedede', '#dedede', '#329c98', 'Base Instincts', 'Batters with Base Instincts will have a chance of heading past first base when getting walked.', 'team'),
(42, 'STABLE', '#91b5a3', '#91b5a3', '#335980', 'Stable', 'Stable players cannot be made Unstable.', 'player'),
(44, 'CURSE_OF_CROWS', '#915387', '#915387', '#3d2830', 'Curse of Crows', 'This team or player will be occasionally attacked by Birds.', 'both'),
(45, 'SQUIDDISH', '#5988ff', '#5988ff', '#163073', 'Squiddish', 'When a Squiddish player is incinerated, they''ll be replaced by a random Hall of Flame player.', 'player'),
(46, 'CRUNCHY', '#f5eb5d', '#f5eb5d', '#de8123', 'Crunchy', 'The Honey-Roasted players on a Crunchy team will hit 100% better and with +200% Power.', 'player'),
(47, 'PITY', '#ffffff', '#ffffff', '#000000', 'Pity', 'This team is holding back, out of Pity.', 'team'),
(48, 'GOD', '#ff4d90', '#ff4d90', '#fffc57', 'God', 'This team will start with 1,000x the amount of Team Spirit', 'team'),
(49, 'REPEATING', '#61b3ff', '#61b3ff', '#3d5982', 'Repeating', 'In Reverb Weather, this player will Repeat.', 'player'),
(50, 'SUBJECTION', '#d16f6f', '#d16f6f', '#2e2f33', 'Subjection', 'Players leaving a team with Subjection will gain the Liberated modification.', 'team'),
(51, 'LIBERATED', '#90eb07', '#90eb07', '#07a1a3', 'Liberated', 'Liberated players will be guaranteed extra bases when they get a hit.', 'player'),
(52, 'FIRE_EATER', '#f50a31', '#f50a31', '#e3d514', 'Fire Eater', 'Fire Eaters swallow fire instead of being incinerated.', 'player'),
(53, 'MAGMATIC', '#e63200', '#e63200', '#6b0004', 'Magmatic', 'Magmatic players are guaranteed to hit a home run in their next At Bat.', 'player'),
(54, 'LOYALTY', '#ff61a5', '#ff61a5', '#2c1240', 'Loyalty', 'Players leaving a team with Loyalty will gain the Saboteur modification.', 'player'),
(43, 'AFFINITY_FOR_CROWS', '#cb80d9', '#cb80d9', '#240c36', 'Affinity for Crows', 'Players with Affinity for Crows will hit and pitch 50% better during Birds weather.', 'player'),
(55, 'SABOTEUR', '#6b6a6a', '#6b6a6a', '#240c36', 'Saboteur', 'A Saboteur has a chance of intentionally failing.', 'player'),
(56, 'CREDIT_TO_THE_TEAM', '#fffaba', '#fffaba', '#786600', 'Credit to the Team', 'This player will earn Fans 5x the rewards from all Idol Pendants.', 'player'),
(57, 'LOVE', '#ff2b6b', '#ff2b6b', '#732652', 'Charm', 'Players with Charm have a chance of convincing their opponents to fail.', 'team'),
(58, 'PEANUT_RAIN', '#fff199', '#fff199', '#04144a', 'Peanut Rain', 'This Team weaponizes Peanut weather against their enemies.', 'team'),
(59, 'FLINCH', '#219ccc', '#219ccc', '#5e5e5e', 'Flinch', 'Hitters with Flinch cannot swing until a strike has been thrown in the At Bat.', 'player'),
(60, 'WILD', '#219ccc', '#219ccc', '#361a57', 'Mild', 'Pitchers with Mild have a chance of throwing a Mild Pitch.', 'player'),
(61, 'DESTRUCTION', '#ff8a24', '#ff8a24', '#802d00', 'Destruction', 'Teams with Destruction will add a bunch of Curses to their Opponent when defeating them in battle.', 'team'),
(62, 'SIPHON', '#e30000', '#e30000', '#2b0000', 'Siphon', 'Siphons will steal blood more often in Blooddrain and use it in more ways.', 'player'),
(63, 'FLIICKERRRIIING', '#80fffb', '#80fffb', '#383838', 'Fliickerrriiing', 'Fliickerrriiing players are Flickering a lot.', 'player'),
(64, 'FRIEND_OF_CROWS', '#ff7ae7', '#ff7ae7', '#570026', 'Friend of Crows', 'In Birds weather, pitchers with Friend of Crows will encourage the Birds to attack hitters.', 'player'),
(65, 'BLASERUNNING', '#fffaa3', '#fffaa3', '#570026', 'Blaserunning', 'Blaserunners will score .2 Runs for their Team whenever they steal a base.', 'player'),
(66, 'WALK_IN_THE_PARK', '#faff9c', '#faff9c', '#275c2a', 'Walk in the Park', 'Those with Walk in the Park will walk to first base on one less Ball.', 'team'),
(67, 'BIRD_SEED', '#1e0036', '#dca8f7', '#dca8f7', 'Bird Seed', 'Birds like to eat Bird Seed. They''ll peck those with Bird Seed out of peanut shells more often. Because they like to eat Bird Seed.', 'team'),
(68, 'HAUNTED', '#b59c9c', '#b59c9c', '#1c1c1c', 'Haunted', 'Haunted players will occasionally be Inhabited.', 'player'),
(69, 'TRAVELING', '#cfebff', '#cfebff', '#1c1c1c', 'Traveling', 'Traveling teams will play 5% better in Away games.', 'team'),
(70, 'SEALANT', '#eded91', '#eded91', '#571f26', 'Sealant', 'Players with Sealant cannot have blood drained in Blooddrain.', 'team'),
(71, 'O_NO', '#cffff0', '#cffff0', '#485099', '0 No', 'Players with 0 No cannot be struck out when there are 0 Balls in the Count.', 'team'),
(72, 'FAIRNESS', '#12b300', '#12b300', '#ffdb0f', 'Total Fairness', 'This Season, each team will win only one Blessing, and will be Happy with what they get.', 'team'),
(73, 'ESCAPE', '#ffe521', '#ffe521', '#0d0d0d', 'Pending', 'The players on this Team are Pending...', 'team'),
(74, 'UNFLAMED', '#eaabff', '#eaabff', '#1b1c80', 'Chaotic', 'The Unstable players on a Chaotic team will hit 100% better.', 'team'),
(75, 'TRIBUTE', '#dbce6e', '#dbce6e', '#362803', 'Tribute', 'When Hall of Flame players join this team, they''ll add their Tribute as Team Spirit.', 'team'),
(76, 'SQUIDDEST', '#e6eaeb', '#e6eaeb', '#163073', 'Squiddest', 'This Team is the Squiddest. When a player joins the Team, they''ll become Squiddish.', 'team'),
(77, 'CONTAINMENT', '#91ab91', '#91ab91', '#023802', 'Containment', 'When an Unstable player on this team is incinerated, the Instability cannot chain to their opponent.', 'team'),
(78, 'RETIRED', '#d3ede5', '#d3ede5', '#000e33', 'Released', '', 'player'),
(79, 'RESTING', '#5988ff', '#5988ff', '#163073', 'Resting', '', 'player'),
(80, 'INHABITING', '#b59c9c', '#b59c9c', '#1c1c1c', 'Inhabiting', 'This player is temporarily Inhabiting a Haunted player.', 'player');

--
-- Data for Name: phases; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.phases 
VALUES 
(1, 'PRESEASON', 0),
(2, 'GAMEDAY', 1),
(3, 'END_REGULAR_SEASON', 2),
(7, 'END_REGULAR_SEASON', 2),
(4, 'POSTSEASON', 3),
(10, 'POSTSEASON', 3),
(11, 'POSTSEASON', 3),
(9, 'BOSS_FIGHT', 4),
(0, 'ELECTION_RESULTS', 5),
(5, 'END_POSTSEASON', 5),
(6, 'END_POSTSEASON', 5),
(8, 'UNKNOWN_THE_OCHO', 99),
(99, 'SIESTA', 99),
(12, 'TOURNAMENT_PRESEASON', 6),
(13, 'TOURNAMENT_GAMEDAY', 7),
(14, 'TOURNAMENT_GAMEDAY', 7),
(15, 'TOURNAMENT_POSTSEASON', 8),
(16, 'END_TOURNAMENT', 9);

--
-- Data for Name: pitch_types; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.pitch_types 
VALUES 
('F', 'Foul Ball', 0, 0),
('X', 'Ball in play', 0, 0),
('A', 'Ball - Assumed', 1, 0),
('B', 'Ball', 1, 0),
('C', 'Called Strike', 0, 1),
('K', 'Strike - Assumed', 0, 1),
('S', 'Swinging Strike', 0, 1);

--
-- Data for Name: position_types; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.position_types
VALUES 
(0, 'BATTER'),
(1, 'PITCHER'),
(2, 'BULLPEN'),
(3, 'BENCH');

--
-- Data for Name: team_additional_info; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.team_additional_info
VALUES 
(1,'8d87c468-699a-47a8-b40d-cfb73a5660ad','CRAB','#593037','#b05c6b','0x1F980','Claws Up!'),
(2,'c73b705c-40ad-4633-a6ed-d357ee2e2bcf','LIFT','#e830ab','#e830ab','🏋️‍♀️','We''ve got swole'),
(3,'878c1bf6-0d21-4659-bfee-916c8314d69c','TACO','#64376e','#b063c1','0x1F32E','72° and Infinite'),
(4,'7fcb63bc-11f2-40b9-b465-f1d458692a63',NULL,'#de0000','#de0000','0x1F579','what'),
(5,'e3f90fa1-0bbe-40df-88ce-578d0723a23b',NULL,'#505050','#b8b8b8','0x1F3F3','We Forfeit!'),
(6,'a3ea6358-ce03-4f23-85f9-deb38cb81b20',NULL,'#ffc6df','#ffc6df','0x1F42E','moo'),
(7,'f29d6e60-8fce-4ac6-8bc2-b5e3cabc5696',NULL,'#231709','#7f6f5c','0x1F50D','Drink In the Darkness'),
(8,'b63be8c2-576a-4d6e-8daf-814f8bcea96f','DALE','#9141ba','#cd76fa','0x1F6A4','¡Dale!'),
(9,'3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e','BOS','#f7d1ff','#f7d1ff','0x1F339','Bloom Goes The Dynamite!'),
(10,'36569151-a2fb-43c1-9df7-2df512424c82','NYM','#ffd4d8','#ffd4d8','0x1F4F1','Youth Will Save Us'),
(11,'eb67ae5e-c4bf-46ca-bbbc-425cd34182ff','CAN','#f5feff','#f5feff','0x1F5E3','SPRAY IT, DON''T SAY IT'),
(12,'49181b72-7f1c-4f1c-929f-928d763ad7fb',NULL,'#094f12','#36ad45','0x1F3C6','Teamwork makes the steam work'),
(13,'4d921519-410b-41e2-882e-9726a4e54a6a',NULL,'#2a5e6c','#92c7d6','0x2744','Blaseball Go Brrrrrr'),
(14,'bfd38797-8404-4b38-8b82-341da28b1f83','CHST','#ffce0a','#ffce0a','0x1F45F','Your Kicks are My Kicks.'),
(15,'7966eb04-efcc-499b-8f03-d13916330531','YELL','#bf0043','#f60f63','0x2728','As Above, So Below'),
(16,'9a5ab308-41f2-4889-a3c3-733b9aab806e',NULL,'#470094','#a959ff','0x1F451','Oh, Sweet'),
(17,'b3b9636a-f88a-47dc-a91d-86ecc79f9934',NULL,'#b89600','#ffd20f','0x1F91D','There''s no I in Cream ... or Sugar'),
(18,'3b0a289b-aebd-493c-bc11-96793e7216d5',NULL,'#000000','#ffffff','0x1F3A8','Paint the Town Dead!'),
(19,'d2634113-b650-47b9-ad95-673f8e28e687',NULL,'#691a8f','#bc60e2','0x1F52E','Derive the Stars'),
(20,'b024e975-1c4a-4575-8936-a3754a08806a','STK','#8c8d8f','#b2b3b5','0x1F969','Well Done.'),
(21,'b72f3061-f573-40d7-832a-5ad475bd7909','LVRS','#780018','#da0000','0x1F48B','Let''s Go All The Way!'),
(22,'979aee4a-6d80-4863-bf1c-ee1a78e06024','FRI','#3ee652','#3ee652','0x1F3DD','It''s Island Time!'),
(23,'d8f82163-2e74-496b-8e4b-2ab35b2d3ff1',NULL,'#8a2444','#e6608b','0x274C','We''ve got a Shot!'),
(24,'a7592bd7-1d3c-4ffb-8b3a-0b1e4bc321fd',NULL,'#ffffff','#ffffff','0x1F95B','Not Milk?'),
(25,'9e42c12a-7561-42a2-b2d0-7cf81a817a5e',NULL,'#1f1636','#b5abd1','0x1F303','We Don''t Sleep. We Can''t Sleep'),
(26,'70eab4ab-6cb1-41e7-ac8b-1050ee12eecc',NULL,'#f07800','#ffd86e','0x1F4A1','Power Up!'),
(27,'4e5d0063-73b4-440a-b2d1-214a7345cf16',NULL,'#005d9c','#8dd4f0','0x1F4A7','Water Down!'),
(28,'e8f7ffee-ec53-4fe0-8e87-ea8ff1d0b4a9',NULL,'#a9e8c9','#a9e8c9','0x2693','[FOGHORN SOUND]'),
(29,'23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7','PIES','#399d8f','#58c3b4','0x1F967','Pie or Die.'),
(30,'105bc3ff-1320-4e37-8ef0-8d595cb95dd0','SEA','#2b4075','#5a83ea','0x1F3B8','Smells like Team Spirit.'),
(31,'a37f9158-7f82-46bc-908c-c9e2dda7c33b','JAZZ','#6388ad','#7ba9d7','0x1F450','We’ve Got Winning to Do. Just for You.'),
(32,'f02aeae2-5e6a-4098-9842-02d2273f25c7','HELL','#fffbab','#fffbab','0x1F31E','Stare into the Sun...'),
(33,'ca3f1c8c-c025-4d8e-8eef-5be6accbeb16','CHI','#8c2a3e','#d13757','0x1F525','We Are From Chicago'),
(34,'c6c01051-cdd4-47d6-8a98-bb5b754f937f','STAR','#5988ff','#5988ff','0x1F991','Hey now, you''re a Hall Star'),
(35,'adc5b394-8f76-416d-9ce9-813706877b84','KCBM','#178f55','#178f55','0x1F36C','Fresh Breath, Here We Come.'),
(36,'747b8e4a-7e50-4638-a973-ea7950a3e739','TGRS','#5c1c1c','#e83622','0x1F405','Never Look Back.'),
(37,'9debc64f-74b7-4ae1-a4d6-fce0144b6ea5','SPY','#67556b','#9e82a4','0x1F575','Bang BANG'),
(38,'57ec08cc-0411-4643-b304-0e80dbc15ac7','CDMX','#d15700','#ee6300','0x1F357','Wings. Beer. Blaseball.'),
(39,'40b9ec2a-cb43-4dbb-b836-5accb62e7c20','PODS','#ff0000','#ff0000','0x1F95C','TREMBLE BEFORE MY PODS');


--
-- Data for Name: team_divine_favor; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.team_divine_favor 
VALUES 
(1, 'b72f3061-f573-40d7-832a-5ad475bd7909', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 1),
(2, '878c1bf6-0d21-4659-bfee-916c8314d69c', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 2),
(3, 'b024e975-1c4a-4575-8936-a3754a08806a', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 3),
(5, 'ca3f1c8c-c025-4d8e-8eef-5be6accbeb16', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 5),
(6, 'bfd38797-8404-4b38-8b82-341da28b1f83', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 6),
(7, '3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 7),
(8, '979aee4a-6d80-4863-bf1c-ee1a78e06024', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 8),
(9, '7966eb04-efcc-499b-8f03-d13916330531', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 9),
(11, '8d87c468-699a-47a8-b40d-cfb73a5660ad', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 11),
(12, '23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 12),
(13, 'f02aeae2-5e6a-4098-9842-02d2273f25c7', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 13),
(14, '57ec08cc-0411-4643-b304-0e80dbc15ac7', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 14),
(15, '747b8e4a-7e50-4638-a973-ea7950a3e739', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 15),
(16, 'eb67ae5e-c4bf-46ca-bbbc-425cd34182ff', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 16),
(17, '9debc64f-74b7-4ae1-a4d6-fce0144b6ea5', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 17),
(18, 'b63be8c2-576a-4d6e-8daf-814f8bcea96f', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 18),
(19, '105bc3ff-1320-4e37-8ef0-8d595cb95dd0', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 19),
(4, 'adc5b394-8f76-416d-9ce9-813706877b84', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 4),
(10, '36569151-a2fb-43c1-9df7-2df512424c82', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 10),
(20, 'a37f9158-7f82-46bc-908c-c9e2dda7c33b', '2020-07-29 08:12:22.438', '2020-08-03 07:59:00', 20),
(21, '23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 1),
(41, 'b72f3061-f573-40d7-832a-5ad475bd7909', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 2),
(42, '878c1bf6-0d21-4659-bfee-916c8314d69c', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 3),
(43, 'b024e975-1c4a-4575-8936-a3754a08806a', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 4),
(44, 'ca3f1c8c-c025-4d8e-8eef-5be6accbeb16', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 6),
(45, 'bfd38797-8404-4b38-8b82-341da28b1f83', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 7),
(46, '3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 8),
(47, '979aee4a-6d80-4863-bf1c-ee1a78e06024', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 9),
(48, '7966eb04-efcc-499b-8f03-d13916330531', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 10),
(49, '8d87c468-699a-47a8-b40d-cfb73a5660ad', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 12),
(50, 'f02aeae2-5e6a-4098-9842-02d2273f25c7', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 13),
(51, '57ec08cc-0411-4643-b304-0e80dbc15ac7', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 14),
(52, '747b8e4a-7e50-4638-a973-ea7950a3e739', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 15),
(53, 'eb67ae5e-c4bf-46ca-bbbc-425cd34182ff', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 16),
(54, '9debc64f-74b7-4ae1-a4d6-fce0144b6ea5', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 17),
(55, 'b63be8c2-576a-4d6e-8daf-814f8bcea96f', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 18),
(56, '105bc3ff-1320-4e37-8ef0-8d595cb95dd0', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 19),
(57, 'adc5b394-8f76-416d-9ce9-813706877b84', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 5),
(58, '36569151-a2fb-43c1-9df7-2df512424c82', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 11),
(59, 'a37f9158-7f82-46bc-908c-c9e2dda7c33b', '2020-08-03 07:59:00', '2020-09-14 07:59:00', 20),
(60, 'ca3f1c8c-c025-4d8e-8eef-5be6accbeb16', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 1),
(61, 'a37f9158-7f82-46bc-908c-c9e2dda7c33b', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 2),
(62, 'b63be8c2-576a-4d6e-8daf-814f8bcea96f', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 3),
(63, '979aee4a-6d80-4863-bf1c-ee1a78e06024', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 4),
(64, 'bfd38797-8404-4b38-8b82-341da28b1f83', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 5),
(65, 'b72f3061-f573-40d7-832a-5ad475bd7909', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 6),
(66, '23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 7),
(67, '747b8e4a-7e50-4638-a973-ea7950a3e739', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 8),
(68, '105bc3ff-1320-4e37-8ef0-8d595cb95dd0', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 9),
(69, 'f02aeae2-5e6a-4098-9842-02d2273f25c7', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 10),
(70, '36569151-a2fb-43c1-9df7-2df512424c82', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 11),
(71, '9debc64f-74b7-4ae1-a4d6-fce0144b6ea5', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 12),
(72, 'adc5b394-8f76-416d-9ce9-813706877b84', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 13),
(73, '7966eb04-efcc-499b-8f03-d13916330531', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 14),
(74, 'b024e975-1c4a-4575-8936-a3754a08806a', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 15),
(75, '8d87c468-699a-47a8-b40d-cfb73a5660ad', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 16),
(76, '57ec08cc-0411-4643-b304-0e80dbc15ac7', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 17),
(77, '3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 18),
(78, 'eb67ae5e-c4bf-46ca-bbbc-425cd34182ff', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 19),
(79, '878c1bf6-0d21-4659-bfee-916c8314d69c', '2020-09-14 07:59:00', '2020-09-26 10:29:31.561294', 20),
(80, '878c1bf6-0d21-4659-bfee-916c8314d69c', '2020-09-26 10:30:06.338053', NULL, 1),
(81, 'b72f3061-f573-40d7-832a-5ad475bd7909', '2020-09-26 10:30:06.344018', NULL, 2),
(82, '979aee4a-6d80-4863-bf1c-ee1a78e06024', '2020-09-26 10:30:06.354634', NULL, 3),
(83, 'bfd38797-8404-4b38-8b82-341da28b1f83', '2020-09-26 10:30:06.360136', NULL, 4),
(84, 'adc5b394-8f76-416d-9ce9-813706877b84', '2020-09-26 10:30:06.3678', NULL, 5),
(85, '747b8e4a-7e50-4638-a973-ea7950a3e739', '2020-09-26 10:30:06.372765', NULL, 6),
(86, '7966eb04-efcc-499b-8f03-d13916330531', '2020-09-26 10:30:06.37793', NULL, 7),
(87, 'a37f9158-7f82-46bc-908c-c9e2dda7c33b', '2020-09-26 10:30:06.386655', NULL, 8),
(88, '23e4cbc1-e9cd-47fa-a35b-bfa06f726cb7', '2020-09-26 10:30:06.393127', NULL, 9),
(89, 'f02aeae2-5e6a-4098-9842-02d2273f25c7', '2020-09-26 10:30:06.401098', NULL, 10),
(90, 'b63be8c2-576a-4d6e-8daf-814f8bcea96f', '2020-09-26 10:30:06.406416', NULL, 11),
(91, '36569151-a2fb-43c1-9df7-2df512424c82', '2020-09-26 10:30:06.412655', NULL, 12),
(92, 'eb67ae5e-c4bf-46ca-bbbc-425cd34182ff', '2020-09-26 10:30:06.419253', NULL, 13),
(93, '3f8bbb15-61c0-4e3f-8e4a-907a5fb1565e', '2020-09-26 10:30:06.424344', NULL, 14),
(94, 'b024e975-1c4a-4575-8936-a3754a08806a', '2020-09-26 10:30:06.43123', NULL, 15),
(95, '105bc3ff-1320-4e37-8ef0-8d595cb95dd0', '2020-09-26 10:30:06.438918', NULL, 16),
(96, 'ca3f1c8c-c025-4d8e-8eef-5be6accbeb16', '2020-09-26 10:30:06.444359', NULL, 17),
(97, '8d87c468-699a-47a8-b40d-cfb73a5660ad', '2020-09-26 10:30:06.451267', NULL, 18),
(98, '57ec08cc-0411-4643-b304-0e80dbc15ac7', '2020-09-26 10:30:06.456357', NULL, 19),
(99, '9debc64f-74b7-4ae1-a4d6-fce0144b6ea5', '2020-09-26 10:30:06.46395', NULL, 20);

--
-- Data for Name: tournament_teams; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.tournament_teams 
VALUES 
(1, 1, '4e5d0063-73b4-440a-b2d1-214a7345cf16', NULL, NULL),
(2, 1, '49181b72-7f1c-4f1c-929f-928d763ad7fb', NULL, NULL),
(3, 1, 'f29d6e60-8fce-4ac6-8bc2-b5e3cabc5696', NULL, NULL),
(4, 1, 'a3ea6358-ce03-4f23-85f9-deb38cb81b20', NULL, NULL),
(5, 1, '4d921519-410b-41e2-882e-9726a4e54a6a', NULL, NULL),
(6, 1, 'b3b9636a-f88a-47dc-a91d-86ecc79f9934', NULL, NULL),
(7, 1, 'e3f90fa1-0bbe-40df-88ce-578d0723a23b', NULL, NULL),
(8, 1, 'e8f7ffee-ec53-4fe0-8e87-ea8ff1d0b4a9', NULL, NULL),
(9, 1, 'd8f82163-2e74-496b-8e4b-2ab35b2d3ff1', NULL, NULL),
(10, 1, '70eab4ab-6cb1-41e7-ac8b-1050ee12eecc', NULL, NULL),
(11, 1, '9e42c12a-7561-42a2-b2d0-7cf81a817a5e', NULL, NULL),
(12, 1, 'a7592bd7-1d3c-4ffb-8b3a-0b1e4bc321fd', NULL, NULL),
(13, 1, '3b0a289b-aebd-493c-bc11-96793e7216d5', NULL, NULL),
(14, 1, '7fcb63bc-11f2-40b9-b465-f1d458692a63', NULL, NULL),
(15, 1, '9a5ab308-41f2-4889-a3c3-733b9aab806e', NULL, NULL),
(16, 1, 'd2634113-b650-47b9-ad95-673f8e28e687', NULL, NULL);

--
-- Data for Name: tournaments; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.tournaments VALUES (1, 0, 'The Coffee Cup', NULL, NULL);


--
-- Data for Name: vibe_to_arrows; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.vibe_to_arrows 
VALUES 
(1, 3, 0.8, 999),
(2, 2, 0.4, 0.8),
(3, 1, 0.1, 0.4),
(6, 0, -0.1, 0.1),
(7, -1, -0.4, -0.1),
(8, -2, -0.8, -0.4),
(9, 0, -999, -0.8);

--
-- Data for Name: weather; Type: TABLE DATA; Schema: taxa; Owner: -
--

INSERT INTO taxa.weather 
VALUES 
(0, 'Void'),
(1, 'Sun 2'),
(2, 'Overcast'),
(3, 'Rainy'),
(4, 'Sandstorm'),
(5, 'Snowy'),
(6, 'Acidic'),
(7, 'Solar Eclipse'),
(8, 'Glitter'),
(9, 'Blooddrain'),
(10, 'Peanuts'),
(11, 'Birds'),
(12, 'Feedback'),
(13, 'Reverb'),
(14, 'Black Hole'),
(15, 'Coffee'),
(16, 'Coffee 2'),
(17, 'Coffee 3s');

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

INSERT INTO taxa.player_url_slugs 
VALUES 
(2, '0bb35615-63f2-4492-80ec-b6b322dc5450', 'wyatt-mason-2', 'Wyatt Mason'),
(3, '0d5300f6-0966-430f-903f-a4c2338abf00', 'wyatt-mason-3', 'Wyatt Mason'),
(4, '21d52455-6c2c-4ee4-8673-ab46b4b926b4', 'wyatt-mason-4', 'Wyatt Mason'),
(5, '27c68d7f-5e40-4afa-8b6f-9df47b79e7dd', 'wyatt-mason-5', 'Wyatt Mason'),
(6, '5ca7e854-dc00-4955-9235-d7fcd732ddcf', 'wyatt-mason-6', 'Wyatt Mason'),
(7, '63df8701-1871-4987-87d7-b55d4f1df2e9', 'wyatt-mason-7', 'Wyatt Mason'),
(8, '75f9d874-5e69-438d-900d-a3fcb1d429b3', 'wyatt-mason-8', 'Wyatt Mason'),
(9, 'a1ed3396-114a-40bc-9ff0-54d7e1ad1718', 'wyatt-mason-9', 'Wyatt Mason'),
(10, 'bf6a24d1-4e89-4790-a4ba-eeb2870cbf6f', 'wyatt-mason-10', 'Wyatt Mason'),
(11, 'e16c3f28-eecd-4571-be1a-606bbac36b2b', 'wyatt-mason-11', 'Wyatt Mason'),
(12, 'e4034192-4dc6-4901-bb30-07fe3cf77b5e', 'wyatt-mason-12', 'Wyatt Mason'),
(13, 'ea44bd36-65b4-4f3b-ac71-78d87a540b48', 'wyatt-mason-13', 'Wyatt Mason'),
(14, 'f741dc01-2bae-4459-bfc0-f97536193eea', 'wyatt-mason-14', 'Wyatt Mason'),
(15, '80e474a3-7d2b-431d-8192-2f1e27162607', 'wyatt-mason-15', 'Wyatt Mason');

INSERT INTO taxa.player_incinerations_unrecorded
VALUES
(1, 87, -1, 'GAMEDAY', 'Aldon Anthony', (SELECT distinct player_id from data.players where player_name = 'Aldon Anthony')),
(1, 79, -1, 'GAMEDAY', 'Alexandria Dracaena', (SELECT distinct player_id from data.players where player_name = 'Alexandria Dracaena')),
(1, 92, -1, 'GAMEDAY', 'Cedric Gonzalez', (SELECT distinct player_id from data.players where player_name = 'Cedric Gonzalez')),
(1, 64, -1, 'GAMEDAY', 'Dickerson Greatness', (SELECT distinct player_id from data.players where player_name = 'Dickerson Greatness')),
(1, 64, -1, 'GAMEDAY', 'Famous Oconnor', (SELECT distinct player_id from data.players where player_name = 'Famous Oconnor')),
(1, 12, -1, 'GAMEDAY', 'Fitzgerald Massey', (SELECT distinct player_id from data.players where player_name = 'Fitzgerald Massey')),
(1, 75, -1, 'GAMEDAY', 'Hurley Pacheco', (SELECT distinct player_id from data.players where player_name = 'Hurley Pacheco')),
(1, 21, -1, 'GAMEDAY', 'Jenna Maldonado', (SELECT distinct player_id from data.players where player_name = 'Jenna Maldonado')),
(1, 73, -1, 'GAMEDAY', 'Jessi Wise', (SELECT distinct player_id from data.players where player_name = 'Jessi Wise')),
(1, 51, -1, 'GAMEDAY', 'Lars Mendoza', (SELECT distinct player_id from data.players where player_name = 'Lars Mendoza')),
(1, 24, -1, 'GAMEDAY', 'Nora Perez', (SELECT distinct player_id from data.players where player_name = 'Nora Perez')),
(1, 39, -1, 'GAMEDAY', 'Scrap Murphy', (SELECT distinct player_id from data.players where player_name = 'Scrap Murphy')),
(1, 63, -1, 'GAMEDAY', 'Sosa Elftower', (SELECT distinct player_id from data.players where player_name = 'Sosa Elftower')),
(1, 71, -1, 'GAMEDAY', 'Trevino Merritt', (SELECT distinct player_id from data.players where player_name = 'Trevino Merritt')),
(1, 23, -1, 'GAMEDAY', 'Tyreek Olive', (SELECT distinct player_id from data.players where player_name = 'Tyreek Olive')),
(1, 71, -1, 'GAMEDAY', 'Zi Delacruz', (SELECT distinct player_id from data.players where player_name = 'Zi Delacruz')),
(7, NULL, -1, 'ELECTION_RESULTS', 'Ron Monstera','41949d4d-b151-4f46-8bf7-73119a48fac8'),
(8, NULL, -1, 'ELECTION_RESULTS', 'August Mina','c17a4397-4dcc-440e-8c53-d897e971cae9'),
(8, NULL, -1, 'ELECTION_RESULTS', 'Thomas Kirby','f73009c5-2ede-4dc4-b96d-84ba93c8a429'),
(0, NULL, -1, 'ELECTION_RESULTS', 'Jaylen Hotdogfingers','04e14d7b-5021-4250-a3cd-932ba8e0a889');