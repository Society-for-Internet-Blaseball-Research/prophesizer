-- LAST UPDATE: 6/8/2021:
-- games_info_expanded_all matview (& sequence), team_seasonal_standings view
-- teams_info_expanded_all sequence created and added to view
-- update sequences from int to bigint
-- added legendary, replica, dust to player_status_flags

DROP VIEW IF EXISTS DATA.team_seasonal_standings CASCADE;
DROP VIEW IF EXISTS DATA.ref_leaderboard_lifetime_batting CASCADE;
DROP VIEW IF EXISTS DATA.ref_recordboard_player_season_batting CASCADE;
DROP VIEW IF EXISTS DATA.ref_leaderboard_lifetime_pitching CASCADE;
DROP VIEW IF EXISTS DATA.ref_recordboard_player_season_pitching CASCADE;
DROP VIEW IF EXISTS data.stars_team_all_current CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.games_info_expanded_all CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.teams_info_expanded_all CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.running_stats_all_events CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.running_stats_player_season CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.running_stats_player_season_combined CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.running_stats_player_playoffs_season CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.running_stats_team_season CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.running_stats_team_playoffs_season CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.running_stats_player_lifetime CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.running_stats_player_playoffs_lifetime CASCADE;
DROP VIEW IF EXISTS data.rosters_extended_current CASCADE;
DROP VIEW IF EXISTS data.rosters_current CASCADE;
DROP VIEW IF EXISTS data.players_extended_current CASCADE;
DROP VIEW IF EXISTS data.pitching_records_player_single_game CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.pitching_stats_all_appearances CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.pitching_stats_player_season CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.pitching_stats_player_season_combined CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.pitching_stats_team_season CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.pitching_stats_team_playoffs_season CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.pitching_stats_player_playoffs_season CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.pitching_stats_player_lifetime CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.pitching_stats_player_playoffs_lifetime CASCADE;
DROP VIEW IF EXISTS data.fielder_stats_season CASCADE;
DROP VIEW IF EXISTS data.fielder_stats_playoffs_season CASCADE;
DROP VIEW IF EXISTS data.fielder_stats_playoffs_lifetime CASCADE;
DROP VIEW IF EXISTS data.fielder_stats_lifetime CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.fielder_stats_all_events CASCADE;
DROP VIEW IF EXISTS data.charm_counts CASCADE;
DROP VIEW IF EXISTS data.batting_records_team_single_game CASCADE;
DROP VIEW IF EXISTS data.batting_records_team_season CASCADE;
DROP VIEW IF EXISTS data.batting_records_team_playoffs_single_game CASCADE;
DROP VIEW IF EXISTS data.batting_records_team_playoffs_season CASCADE;
DROP VIEW IF EXISTS data.batting_records_player_single_game CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.batting_stats_player_season CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.batting_stats_player_season_combined CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.batting_stats_player_single_game CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.batting_stats_player_playoffs_season CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.batting_stats_player_playoffs_lifetime CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.batting_stats_player_lifetime CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.batting_stats_all_events CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.batting_stats_team_season CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.batting_stats_team_playoffs_season CASCADE;
DROP VIEW IF EXISTS data.batting_records_player_season CASCADE;
DROP VIEW IF EXISTS data.batting_records_player_playoffs_single_game CASCADE;
DROP VIEW IF EXISTS data.batting_records_player_playoffs_season CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.players_info_expanded_all CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.players_info_expanded_tourney CASCADE;
DROP VIEW IF EXISTS data.player_status_flags CASCADE;
DROP VIEW IF EXISTS data.player_incinerations CASCADE;
DROP VIEW IF EXISTS data.batting_records_league_season CASCADE;
DROP VIEW IF EXISTS data.batting_records_league_playoffs_season CASCADE;
DROP VIEW IF EXISTS data.batting_records_combined_teams_single_game CASCADE;
DROP VIEW IF EXISTS data.batting_records_combined_teams_playoffs_single_game CASCADE;
DROP INDEX IF EXISTS data.batting_stats_all_events_indx_season CASCADE;
DROP INDEX IF EXISTS data.batting_stats_all_events_indx_player_id CASCADE;
DROP INDEX IF EXISTS data.running_stats_all_events_indx_player_id CASCADE;
DROP INDEX IF EXISTS data.fielder_stats_all_events_player_id CASCADE;
DROP INDEX IF EXISTS data.pitching_stats_all_appearances_indx_player_id CASCADE;
DROP VIEW IF EXISTS data.running_stats_player_tournament_lifetime CASCADE;
DROP VIEW IF EXISTS data.fielder_stats_tournament CASCADE;
DROP VIEW IF EXISTS data.batting_stats_player_tournament_lifetime CASCADE;
DROP VIEW IF EXISTS data.batting_stats_player_tournament CASCADE;
DROP VIEW IF EXISTS data.batting_records_team_tournmament CASCADE;
DROP VIEW IF EXISTS data.batting_records_team_tournament_single_game CASCADE;
DROP VIEW IF EXISTS data.batting_records_team_tournament CASCADE;
DROP VIEW IF EXISTS data.pitching_stats_player_tournament CASCADE;
DROP SEQUENCE IF EXISTS data.player_debuts_id_seq CASCADE;
DROP SEQUENCE IF EXISTS data.players_info_expanded_all_id_seq CASCADE;
DROP SEQUENCE IF EXISTS data.games_info_expanded_all_id_seq CASCADE;
DROP SEQUENCE IF EXISTS data.teams_info_expanded_all_id_seq CASCADE;
DROP SEQUENCE IF EXISTS data.players_info_expanded_tourney_id_seq CASCADE;
DROP SEQUENCE IF EXISTS data.batting_stats_all_events_id_seq CASCADE;
DROP SEQUENCE IF EXISTS data.batting_stats_player_single_game_id_seq CASCADE;
DROP SEQUENCE IF EXISTS data.fielder_stats_all_events_id_seq CASCADE;
DROP SEQUENCE IF EXISTS data.pitching_stats_all_appearances_id_seq CASCADE;
DROP SEQUENCE IF EXISTS data.running_stats_all_events_id_seq CASCADE;

--
-- Name: player_debuts_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.player_debuts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
	
--
-- Name: games_info_expanded_all_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.games_info_expanded_all_id_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;	
	
--
-- Name: teams_info_expanded_all_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.teams_info_expanded_all_id_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
	
--
-- Name: players_info_expanded_all_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.players_info_expanded_all_id_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
	
--
-- Name: players_info_expanded_tourney_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.players_info_expanded_tourney_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
	
--
-- Name: batting_stats_all_events_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.batting_stats_all_events_id_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
	
--
-- Name: batting_stats_player_single_game_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.batting_stats_player_single_game_id_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
	
--
-- Name: fielder_stats_all_events_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.fielder_stats_all_events_id_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
	
--
-- Name: pitching_stats_all_appearances_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.pitching_stats_all_appearances_id_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: running_stats_all_events_id_seq; Type: SEQUENCE; Schema: data; Owner: -
--

CREATE SEQUENCE data.running_stats_all_events_id_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: player_debuts; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--

DROP MATERIALIZED VIEW IF EXISTS data.player_debuts CASCADE;

CREATE MATERIALIZED VIEW data.player_debuts
AS
SELECT DISTINCT NEXTVAL('DATA.player_debuts_id_seq') as player_debuts_id, 
game_id AS debut_game_id, player_id, season AS debut_season, DAY AS debut_gameday, tournament AS debut_tournament
FROM DATA.game_events ge
JOIN
(
    SELECT MIN(first_appearance) AS perceived_at, 
    player_id
    FROM
    (
        SELECT batter_id AS player_id, min(perceived_at) AS first_appearance
        FROM DATA.game_events
        WHERE batter_id NOT IN ('','UNKNOWN')
        GROUP BY batter_id
        UNION
        SELECT pitcher_id AS player_id, min(perceived_at) AS first_appearance
        FROM DATA.game_events
        WHERE pitcher_id NOT IN ('','UNKNOWN')
        GROUP BY pitcher_id
    ) a
    GROUP BY player_id
) b
ON (ge.perceived_at = b.perceived_at AND (b.player_id = ge.batter_id OR b.player_id = ge.pitcher_id))
ORDER BY tournament, season, DAY, player_id
WITH NO DATA;

--
-- Name: games_info_expanded_all; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--

CREATE MATERIALIZED VIEW data.games_info_expanded_all AS
	SELECT 
	
	NEXTVAL('DATA.games_info_expanded_all_id_seq') as games_info_expanded_all_id,
	ga.game_id, ga.day, ga.season, ga.home_score, ga.away_score, 
	(
		SELECT COUNT(1)
		FROM DATA.game_events ge
		WHERE event_type = 'SUN_2'
		AND ge.batter_team_id = ga.home_team AND ge.game_id = ga.game_id
	) 
	+
	(
		SELECT COUNT(1) * -1
		FROM DATA.game_events ge
		WHERE event_type = 'BLACK_HOLE'
		AND ge.batter_team_id = ga.away_team AND ge.game_id = ga.game_id
	)
	+
	(
		CASE WHEN home_score > away_score THEN 1 ELSE 0 END
		*
		CASE WHEN season = 18 THEN -1 ELSE 1 END 
	)
	AS home_win_objects,
	(
		SELECT COUNT(1)
		FROM DATA.game_events ge
		WHERE event_type = 'SUN_2'
		AND ge.batter_team_id = ga.away_team AND ge.game_id = ga.game_id
	) 
	+
	(
		SELECT COUNT(1) * -1
		FROM DATA.game_events ge
		WHERE event_type = 'BLACK_HOLE'
		AND ge.batter_team_id = ga.home_team AND ge.game_id = ga.game_id
	)
	+
	(
		CASE WHEN home_score < away_score THEN 1 ELSE 0 END
		*
		CASE WHEN season = 18 THEN -1 ELSE 1 END 
	)
	AS away_win_objects,
	ga.is_postseason, 
	ga.home_team, ga.away_team,
	ga.home_odds, ga.away_odds, 
	xw.weather_id, 
	CASE
		when season = 0 THEN 'Sunny'
		else xw.weather_text 
	end AS weather, 
	s.stadium_id, s.hype, s.name AS stadium_name, s.birds, s.nickname AS stadium_nickname,
	s.mysticism, s.viscosity, s.elongation, s.obtuseness, s.forwardness, s.grandiosity, 
	s.ominousness, s.fortification, s.inconvenience
	
	FROM DATA.games ga
	JOIN taxa.weather xw
	ON (ga.weather = xw.weather_id)
	LEFT JOIN DATA.stadiums s
	ON 
	(
		ga.home_team = s.team_id AND DATA.timestamp_from_gameday(ga.season, ga.day) 
		BETWEEN s.valid_from AND COALESCE(s.valid_until,NOW())
	)
	WHERE home_score <> away_score
	AND tournament = -1
	WITH NO DATA;

--
-- Name: team_seasonal_standings; Type: VIEW; Schema: data; Owner: -
--
CREATE VIEW DATA.team_seasonal_standings AS
	SELECT 
	h.season, h.team_id, 
	t.nickname, t.division, t.league,
	home_win_objects+away_win_objects AS win_objects,
	home_wins+away_wins AS wins, home_losses+away_losses AS losses, 
	ROUND((home_wins+away_wins)::DECIMAL/(home_wins+away_wins+home_losses+away_losses)::DECIMAL,3) AS win_pct,
	home_win_objects, home_wins, home_losses, away_win_objects, away_wins, away_losses,
	(SELECT ROUND(runs_batted_in,1) FROM DATA.batting_stats_team_season rb WHERE rb.season = h.season AND rb.team_id = h.team_id)
	AS runs_scored,
	(SELECT round(runs_allowed,1) FROM DATA.pitching_stats_team_season rp WHERE rp.season = h.season AND rp.team_id = h.team_id) 
	AS runs_allowed
	FROM
	
	(
		SELECT 
		season, home_team AS team_id, SUM(home_win_objects) AS home_win_objects, 
		SUM
		(
			CASE WHEN home_score > away_score THEN 1 ELSE 0 end
		) AS home_wins,
		SUM
		(
			CASE WHEN home_score < away_score THEN 1 ELSE 0 end
		) AS home_losses
		FROM
		data.games_info_expanded_all
		WHERE NOT is_postseason
		AND home_score <> away_score
		GROUP BY season, home_team
	) h
	JOIN
	(
		SELECT 
		season, away_team AS team_id, SUM(away_win_objects) AS away_win_objects, 
		SUM
		(
			CASE WHEN home_score < away_score THEN 1 ELSE 0 end
		) AS away_wins,
		SUM
		(
			CASE WHEN home_score > away_score THEN 1 ELSE 0 end
		) AS away_losses
		FROM
		data.games_info_expanded_all
		WHERE NOT is_postseason
		AND home_score <> away_score
		GROUP BY season, away_team
	) a
	ON (h.team_id = a.team_id AND h.season = a.season)
	left JOIN DATA.teams_info_expanded_all t
	ON 
	(
		h.team_id = t.team_id AND 
		case
			WHEN h.season < 2 THEN DATA.timestamp_from_gameday(2, 0) BETWEEN t.valid_from AND COALESCE(t.valid_until,NOW())
			else DATA.timestamp_from_gameday(h.season, 0) BETWEEN t.valid_from AND COALESCE(t.valid_until,NOW())
		end
	)
	ORDER BY season, division, home_win_objects+away_win_objects DESC, home_wins+away_wins DESC, nickname;
	
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
                  WHERE ((ge.runs_batted_in > (0)::numeric) AND (ge.day >= 99))
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
                  WHERE ((ge.runs_batted_in > (0)::numeric) AND (ge.day < 99))
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
                  WHERE ((ge.runs_batted_in > (0)::numeric) AND (ge.day >= 99))
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
                  WHERE ((ge.runs_batted_in > (0)::numeric) AND (ge.day < 99))
                  GROUP BY 'RBIS'::text, ge.season) x) y
  WHERE (y.this = 1)
  ORDER BY y.event, y.season;

--
-- Name: teams_info_expanded_all; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.teams_info_expanded_all AS
SELECT 
NEXTVAL('DATA.teams_info_expanded_all_id_seq') as teams_info_expanded_all_id,
ts.team_id,
t.location,
t.nickname,
t.full_name,
ta.team_abbreviation,
t.url_slug,
CASE
	WHEN EXISTS 
	(
		SELECT 1
		FROM taxa.tournament_teams xtt
		WHERE xtt.team_id = ts.team_id
	) 
	THEN 'tournament'
	WHEN t.nickname IN ('PODS','Hall Stars')
	THEN 'disbanded'
   ELSE 'active'
END AS current_team_status,
ts.timestampd AS valid_from,
lead(ts.timestampd) OVER (PARTITION BY ts.team_id ORDER BY ts.timestampd) AS valid_until,
    ( SELECT gd1.gameday
           FROM data.gamephase_from_timestamp(ts.timestampd) gd1) AS gameday_from,
    ( SELECT gd2.season
           FROM data.gamephase_from_timestamp(ts.timestampd) gd2) AS season_from,
    ( SELECT gd3.tournament
           FROM data.gamephase_from_timestamp(ts.timestampd) gd3) AS tournament_from,
    ( SELECT gd4.phase_type
           FROM data.gamephase_from_timestamp(ts.timestampd) gd4) AS phase_type_from,
t.team_main_color,
t.team_secondary_color,
t.team_slogan,
t.team_emoji,
d.division_text AS division,
d.division_id,
l.league_text AS league,
l.league_id,
xt.tournament_name,
(
	SELECT array_agg(DISTINCT m.modification ORDER BY m.modification)
	FROM data.team_modifications m
	WHERE m.team_id = ts.team_id 
	AND m.valid_from <= ts.timestampd
	AND ts.timestampd < COALESCE(m.valid_until, timezone('utc', now()) + '1 MILLISECONDS'::interval)
	GROUP BY m.team_id
) AS modifications,
s.stadium_id,
s.name AS stadium_name,
s.nickname AS stadium_nickname
FROM 
(
	SELECT DISTINCT x.team_id,
	unnest(x.a) AS timestampd
	FROM 
	( 
		SELECT DISTINCT xt.team_id,
		ARRAY[xt.valid_from, COALESCE(xt.valid_until, timezone('utc', now()))] AS a
		FROM data.teams xt
		UNION
		SELECT DISTINCT xdt.team_id,
		ARRAY[xdt.valid_from, COALESCE(xdt.valid_until, timezone('utc', now()))] AS a
		FROM taxa.division_teams xdt
		UNION
		SELECT DISTINCT xtm.team_id,
		ARRAY[xtm.valid_from, COALESCE(xtm.valid_until, timezone('utc', now()))] AS a
		FROM data.team_modifications xtm
		UNION
		SELECT DISTINCT xs.team_id,
		ARRAY[xs.valid_from, xs.valid_until] AS a
		FROM (
			SELECT xxs.team_id, xxs.name, xxs.nickname, xxs.grp, MIN(xxs.valid_from) AS valid_from, MAX(COALESCE(xxs.valid_until, timezone('utc', now()))) AS valid_until
			FROM (
				SELECT *,
					ROW_NUMBER() OVER (ORDER BY xxxs.team_id, xxxs.valid_from) - ROW_NUMBER() OVER (PARTITION BY xxxs.team_id, xxxs.name, xxxs.nickname ORDER BY xxxs.team_id, xxxs.valid_from) AS grp
				FROM data.stadiums xxxs
			) xxs
			GROUP BY xxs.team_id, xxs.name, xxs.nickname, xxs.grp
		) xs
	) x
) ts
JOIN data.teams t ON 
(
	ts.team_id = t.team_id
	AND t.valid_from <= ts.timestampd
	AND ts.timestampd < COALESCE(t.valid_until, timezone('utc', now()) + '1 MILLISECONDS'::interval)
)
LEFT JOIN taxa.team_additional_info ta ON (ts.team_id = ta.team_id)
LEFT JOIN taxa.division_teams dt ON 
(
	ts.team_id = dt.team_id 
	AND dt.valid_from <= ts.timestampd
	AND ts.timestampd < COALESCE(dt.valid_until, timezone('utc', now()) + '1 MILLISECONDS'::interval)
)
LEFT JOIN taxa.divisions d ON (dt.division_id = d.division_id)
LEFT JOIN taxa.leagues l ON (d.league_id = l.league_db_id)
LEFT JOIN taxa.tournament_teams tt ON (ts.team_id = tt.team_id)
LEFT JOIN taxa.tournaments xt ON (tt.tournament_db_id = xt.tournament_db_id)
LEFT JOIN data.stadiums s ON
(
	ts.team_id = s.team_id
	AND s.valid_from <= ts.timestampd
	AND ts.timestampd < COALESCE(s.valid_until, timezone('utc', now()) + '1 MILLISECONDS'::interval)
)
WHERE ts.timestampd <> timezone('utc', now())
ORDER BY t.full_name, ts.timestampd
WITH NO DATA;

--
-- Name: player_status_flags; Type: VIEW; Schema: data; Owner: -
--
CREATE VIEW data.player_status_flags AS
SELECT DISTINCT p.player_id, p.player_name,
CASE
	WHEN p.player_id = 'bc4187fa-459a-4c06-bbf2-4e0e013d27ce' 
	THEN 'deprecated'
	WHEN 
	( 
		SELECT ip.deceased
		FROM data.players ip
		WHERE ip.player_id = p.player_id AND ip.valid_until IS NULL
	) 
	THEN 'deceased'
	WHEN EXISTS 
	( 
		SELECT 1
		FROM data.player_modifications pm
		WHERE pm.player_id = p.player_id AND pm.valid_until IS NULL AND pm.modification in ('COFFEE_EXIT','RETIRED')
	) 
	THEN 'retired'
	WHEN EXISTS 
	( 
		SELECT 1
		FROM data.player_modifications pm
		WHERE pm.player_id = p.player_id AND pm.valid_until IS NULL AND pm.modification in ('REDACTED')
	) 
	THEN 'redacted'
	WHEN EXISTS 
	( 
		SELECT 1
		FROM data.player_modifications pm
		WHERE pm.player_id = p.player_id AND pm.valid_until IS NULL AND pm.modification = ('LEGENDARY')
	) 	
	AND NOT EXISTS 
	( 
		SELECT 1
		FROM data.player_modifications pm
		WHERE pm.player_id = p.player_id AND pm.valid_until IS NULL AND pm.modification in ('DUST','REPLICA')
	) 
	THEN 'legendary'
	WHEN EXISTS 
	( 
		SELECT 1
		FROM data.player_modifications pm
		WHERE pm.player_id = p.player_id AND pm.valid_until IS NULL AND pm.modification = ('REPLICA')
	) 	
	AND NOT EXISTS 
	( 
		SELECT 1
		FROM data.player_modifications pm
		WHERE pm.player_id = p.player_id AND pm.valid_until IS NULL AND pm.modification in ('DUST')
	) 
	THEN 'replica'
	WHEN EXISTS 
	( 
		SELECT 1
		FROM data.player_modifications pm
		WHERE pm.player_id = p.player_id AND pm.valid_until IS NULL AND pm.modification = ('DUST')
	) 	
	THEN 'dust'		
	ELSE 'active'
END AS current_state,
CASE
	WHEN player_id = '555b0a07-a3e0-41bc-b3db-ca8f520857bc' THEN 'outer_space'
	WHEN 
	( 
		SELECT ip.deceased
		FROM data.players ip
		WHERE ip.player_id = p.player_id AND ip.valid_until IS NULL
	) 
	AND NOT EXISTS
	( 
		SELECT 1
		FROM data.player_modifications pm
		WHERE pm.player_id = p.player_id AND pm.valid_until IS NULL AND pm.modification = 'COFFEE_EXIT'
	)	
	THEN NULL
	WHEN EXISTS 
	( 
		SELECT 1
		FROM data.player_modifications pm
		WHERE pm.player_id = p.player_id AND pm.valid_until IS NULL AND pm.modification = 'COFFEE_EXIT'
	)
	THEN 'percolated'
	WHEN EXISTS 
	( 
		SELECT 1
		FROM data.player_modifications pm
		WHERE pm.player_id = p.player_id AND pm.valid_until IS NULL AND pm.modification in ('REDACTED','RETIRED')
	)
	THEN NULL	
	WHEN EXISTS 
	(
		SELECT 1
		FROM data.team_roster rc
		WHERE rc.player_id = p.player_id AND rc.valid_until IS NULL AND rc.position_type_id < 2 AND rc.tournament = -1
		AND NOT EXISTS 
		(
			SELECT 1
			FROM data.team_roster rc
			JOIN data.teams_info_expanded_all t ON (rc.team_id = t.team_id)
			WHERE rc.player_id = p.player_id AND rc.valid_until IS NULL AND t.current_team_status = 'ascended'
			AND NOT EXISTS
			(
				SELECT 1
				FROM data.player_modifications pm
				WHERE pm.player_id = p.player_id AND pm.valid_until IS NULL AND pm.modification = 'RETIRED'
			)
		)
		AND NOT EXISTS
		(
			SELECT 1
			FROM data.team_roster rc
			WHERE rc.player_id = p.player_id AND rc.valid_until IS NULL AND rc.position_type_id >= 2 AND rc.tournament = -1
		)
	)
	THEN 'main_roster'
	WHEN EXISTS 
	(
		SELECT 1
		FROM data.team_roster rc
		WHERE rc.player_id = p.player_id AND rc.valid_until IS NULL AND rc.position_type_id > 1
	)
	THEN 'shadows'
	ELSE NULL::text
END AS current_location
FROM data.players p
WHERE valid_until IS null;

--
-- Name: player_incinerations; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE VIEW DATA.player_incinerations 
AS

	SELECT b.*, p.player_id FROM
	(
		SELECT season, DAY, tournament, phase_type,
		CASE
			WHEN season < 11 AND POSITION('hitter' IN outcome) > 0 
			THEN right(left(outcome, POSITION('!' IN outcome) - 1),length(left(outcome, POSITION('!' IN outcome) - 1)) - POSITION('hitter' IN outcome) - 6)
			WHEN season < 11 AND POSITION('hitter' IN outcome) = 0
			THEN right(left(outcome, POSITION('!' IN outcome) - 1),length(left(outcome, POSITION('!' IN outcome) - 1)) - POSITION('pitcher' IN outcome) - 7)
			ELSE replace(REPLACE(outcome, 'Rogue Umpire incinerated ',''),'!','')
		END AS player_name
		FROM
		(
			SELECT game_id, ga.season, ga.DAY, ga.tournament, unnest(outcomes) AS outcome, 'GAMEDAY' AS phase_type
			FROM DATA.games ga			
		) a
			WHERE 
		--Needs 'Umpire ' to exclude Iffey Jr scenario
		POSITION('Umpire incinerated' IN outcome) > 0
	) b
	JOIN DATA.players p	ON (b.player_name = p.player_name AND p.valid_until IS NULL)
	ORDER BY season DESC, DAY DESC;

--
-- Name: players_info_expanded_all; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--

CREATE MATERIALIZED VIEW data.players_info_expanded_all AS
SELECT 
NEXTVAL('DATA.players_info_expanded_all_id_seq') as players_info_expanded_all_id,
p.player_id,
p.player_name,
p.evolution,
ps.current_state,
ps.current_location,
pd.debut_gameday,
pd.debut_season,
pd.debut_tournament,
r.team_id,
t.team_abbreviation,
t.nickname AS team,
r.position_id,
xp.position_type,
ts.timestampd AS valid_from,
CASE
	WHEN lead(ts.timestampd) OVER (PARTITION BY ts.player_id ORDER BY ts.timestampd) = timezone('utc', now())
	THEN NULL
	ELSE lead(ts.timestampd) OVER (PARTITION BY ts.player_id ORDER BY ts.timestampd) 
END AS valid_until,
    ( SELECT gd1.gameday
           FROM data.gamephase_from_timestamp(ts.timestampd) gd1) AS gameday_from,
    ( SELECT gd2.season
           FROM data.gamephase_from_timestamp(ts.timestampd) gd2) AS season_from,
    ( SELECT gd3.tournament
           FROM data.gamephase_from_timestamp(ts.timestampd) gd3) AS tournament_from,
    ( SELECT gd4.phase_type
           FROM data.gamephase_from_timestamp(ts.timestampd) gd4) AS phase_type_from,
p.deceased,
pi.season as incineration_season,
pi.day as incineration_gameday,
pi.phase_type as incineration_phase,
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
(
	SELECT array_agg(DISTINCT m.modification ORDER BY m.modification) AS modifications
	FROM data.player_modifications m
	WHERE m.player_id = ts.player_id 
	AND m.valid_from <= ts.timestampd
	AND ts.timestampd < COALESCE(m.valid_until, timezone('utc', now()) + '1 MILLISECONDS'::interval)
	GROUP BY m.player_id
) AS modifications,
CASE
	when p.batting_rating in (0,-1) THEN data.batting_rating_raw(tragicness, patheticism, thwackability, divinity, moxie, musclitude, martyrdom)
	else p.batting_rating
end as batting_rating,
case
	when p.baserunning_rating in (0,-1) THEN data.baserunning_rating_raw(laserlikeness, continuation, base_thirst, indulgence, ground_friction)
	else p.baserunning_rating
end as baserunning_rating,
case
	when p.defense_rating in (0,-1) THEN data.defense_rating_raw(omniscience, tenaciousness, watchfulness, anticapitalism, chasiness)
	else p.defense_rating
end as defense_rating,
case
	when p.pitching_rating in (0,-1) THEN data.pitching_rating_raw(unthwackability, ruthlessness, overpowerment, shakespearianism, coldness)
	else p.pitching_rating
end as pitching_rating,
CASE
	when p.batting_rating in (0,-1) THEN data.rating_to_star(data.batting_rating_raw(tragicness, patheticism, thwackability, divinity, moxie, musclitude, martyrdom))
	else data.rating_to_star(p.batting_rating)
end as batting_stars,
case
	when p.baserunning_rating in (0,-1) THEN data.rating_to_star(data.baserunning_rating_raw(laserlikeness, continuation, base_thirst, indulgence, ground_friction))
	else data.rating_to_star(p.baserunning_rating)
end as baserunning_stars,
case
	when p.defense_rating in (0,-1) THEN data.rating_to_star(data.defense_rating_raw(omniscience, tenaciousness, watchfulness, anticapitalism, chasiness))
	else data.rating_to_star(p.defense_rating)
end as defense_stars,
case
	when p.pitching_rating in (0,-1) THEN data.rating_to_star(data.pitching_rating_raw(unthwackability, ruthlessness, overpowerment, shakespearianism, coldness))
	else data.rating_to_star(p.pitching_rating)
end as pitching_stars
,items, durabilities, healths
,item_batting_rating, item_defense_rating, item_baserunning_rating, item_pitching_rating
FROM 
(
	SELECT DISTINCT x.player_id,
	unnest(x.a) AS timestampd
	FROM 
	(
		SELECT DISTINCT xp.player_id,
		ARRAY[xp.valid_from, COALESCE(xp.valid_until, timezone('utc', now()))] AS a
		FROM data.players xp
		WHERE tournament = -1
		UNION
		SELECT DISTINCT xpm.player_id,
		ARRAY[xpm.valid_from, COALESCE(xpm.valid_until, timezone('utc', now()))] AS a
		FROM data.player_modifications xpm
		WHERE tournament = -1
		UNION
		SELECT DISTINCT xr.player_id,
		ARRAY[xr.valid_from, COALESCE(xr.valid_until, timezone('utc', now()))] AS a
		FROM data.team_roster xr
		WHERE tournament = -1
		UNION
		SELECT DISTINCT xi.player_id,
		ARRAY[xi.valid_from, COALESCE(xi.valid_until, timezone('utc', now()))] AS a
		FROM data.player_items xi
	) x
) ts
JOIN data.players p ON 
(
	p.player_id = ts.player_id 
	AND p.valid_from <= ts.timestampd
	AND ts.timestampd < COALESCE(p.valid_until, timezone('utc', now()) + '1 MILLISECONDS'::interval)
	AND p.tournament = -1
)
JOIN data.player_status_flags ps ON (ts.player_id = ps.player_id)
LEFT JOIN
(
	SELECT ts.player_id, 
	array_agg(NAME ORDER BY NAME) AS items, 
	array_agg(durability order by NAME) AS durabilities, 
	array_agg(health ORDER BY NAME) AS healths,
	ts.timestampd AS valid_from,
	SUM(hitting_rating) AS item_batting_rating,
	SUM(baserunning_rating) AS item_baserunning_rating,
	SUM(defense_rating) AS item_defense_rating,
	SUM(pitching_rating) AS item_pitching_rating,
	CASE
		WHEN lead(ts.timestampd) OVER (PARTITION BY ts.player_id ORDER BY ts.timestampd) = timezone('utc', now())
		THEN NULL
		ELSE lead(ts.timestampd) OVER (PARTITION BY ts.player_id ORDER BY ts.timestampd) 
	END AS valid_until
	FROM DATA.player_items pit
	JOIN
	(
		SELECT DISTINCT x.player_id,
		unnest(x.a) AS timestampd
		FROM 
		(		SELECT DISTINCT player_id,
			ARRAY[valid_from, COALESCE(valid_until, timezone('utc', now()))] AS a
			FROM data.player_items
		) x
	) ts
	ON 
	(
		ts.player_id = pit.player_id
		AND pit.valid_from <= ts.timestampd
		AND ts.timestampd < COALESCE(pit.valid_until, timezone('utc', now()) + '1 MILLISECONDS'::interval)
	)
	WHERE ts.timestampd <> timezone('utc', now())
	GROUP BY ts.player_id, ts.timestampd
) itm
ON 
(
	ts.player_id = itm.player_id
	AND itm.valid_from <= ts.timestampd
	AND ts.timestampd < COALESCE(itm.valid_until, timezone('utc', now()) + '1 MILLISECONDS'::interval)
)
LEFT JOIN data.player_debuts pd ON (ts.player_id = pd.player_id)
LEFT JOIN data.player_incinerations pi ON (ts.player_id = pi.player_id)
LEFT JOIN 	  
(
	SELECT rt.team_id, rr.player_id, rr.position_type_id, rr.position_id, rr.valid_from, 
	rr.valid_until
	FROM DATA.team_roster rr
	JOIN DATA.teams_info_expanded_all rt
	ON 
	(
		rr.team_id = rt.team_id AND rt.valid_until IS NULL
	)
	WHERE rr.tournament = -1

) r ON 
(
	ts.player_id = r.player_id
	AND r.valid_from <= ts.timestampd
	AND ts.timestampd < COALESCE(r.valid_until, timezone('utc', now()) + '1 MILLISECONDS'::interval)
)
LEFT JOIN taxa.position_types xp ON (r.position_type_id = xp.position_type_id)
LEFT JOIN data.teams_info_expanded_all t ON (r.team_id = t.team_id AND t.valid_until IS NULL)
LEFT JOIN taxa.blood xb ON (p.blood = xb.blood_id)
LEFT JOIN taxa.coffee xc ON (p.coffee = xc.coffee_id)

WHERE ts.timestampd <> timezone('utc', NOW())	 
WITH NO DATA;

--
-- Name: players_info_expanded_tourney; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--

CREATE MATERIALIZED VIEW data.players_info_expanded_tourney AS
SELECT 
NEXTVAL('DATA.players_info_expanded_tourney_id_seq') as players_info_expanded_tourney_id,
p.player_id,
p.player_name,
ps.current_state,
ps.current_location,
pd.debut_gameday,
pd.debut_season,
pd.debut_tournament,
r.team_id,
t.team_abbreviation,
t.nickname AS team,
r.position_id,
xp.position_type,
ts.timestampd AS valid_from,
CASE
	WHEN lead(ts.timestampd) OVER (PARTITION BY ts.player_id ORDER BY ts.timestampd) = timezone('utc', now())
	THEN NULL
	ELSE lead(ts.timestampd) OVER (PARTITION BY ts.player_id ORDER BY ts.timestampd) 
END AS valid_until,
    ( SELECT gd1.gameday
           FROM data.gamephase_from_timestamp(ts.timestampd) gd1) AS gameday_from,
    ( SELECT gd2.season
           FROM data.gamephase_from_timestamp(ts.timestampd) gd2) AS season_from,
    ( SELECT gd3.tournament
           FROM data.gamephase_from_timestamp(ts.timestampd) gd3) AS tournament_from,
    ( SELECT gd4.phase_type
           FROM data.gamephase_from_timestamp(ts.timestampd) gd4) AS phase_type_from,
p.deceased,
pi.season as incineration_season,
pi.day as incineration_gameday,
pi.phase_type as incineration_phase,
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
(
	SELECT array_agg(DISTINCT m.modification ORDER BY m.modification) AS modifications
	FROM data.player_modifications m
	WHERE m.player_id = ts.player_id 
	AND m.valid_from <= ts.timestampd
	AND ts.timestampd < COALESCE(m.valid_until, timezone('utc', now()) + '1 MILLISECONDS'::interval)
	GROUP BY m.player_id
) AS modifications,
p.batting_rating,
p.baserunning_rating,
p.defense_rating,
p.pitching_rating,
data.rating_to_star(p.batting_rating) AS batting_stars,
data.rating_to_star(p.baserunning_rating) AS baserunning_stars,
data.rating_to_star(p.defense_rating) AS defense_stars,
data.rating_to_star(p.pitching_rating) AS pitching_stars
FROM 
(
	SELECT DISTINCT x.player_id,
	unnest(x.a) AS timestampd
	FROM 
	(
		SELECT DISTINCT xp.player_id, ARRAY[xp.valid_from, COALESCE(xp.valid_until, timezone('utc', now()))] AS a
		FROM DATA.players xp
		JOIN DATA.team_roster r
		ON (xp.player_id = r.player_id)
		WHERE xp.tournament = 0
		OR 
		(
			xp.player_id NOT IN
			(
				SELECT DISTINCT player_id
				FROM data.players
				WHERE tournament = 0
			) 
			AND r.team_id IN
			(
				SELECT team_id FROM taxa.tournament_teams
			)
			AND xp.valid_until IS NULL
		)
		UNION
		SELECT DISTINCT xpm.player_id,
		ARRAY[xpm.valid_from, COALESCE(xpm.valid_until, timezone('utc', now()))] AS a
		FROM data.player_modifications xpm
		WHERE tournament > -1
		UNION
		SELECT DISTINCT xr.player_id,
		ARRAY[xr.valid_from, COALESCE(xr.valid_until, timezone('utc', now()))] AS a
		FROM data.team_roster xr
		WHERE tournament > -1
	) x
) ts
JOIN 
(
	SELECT DISTINCT xp.*
	FROM DATA.players xp
	JOIN DATA.team_roster r
	ON (xp.player_id = r.player_id)
	WHERE xp.tournament = 0
	OR 
	(
		xp.player_id NOT IN
		(
			SELECT DISTINCT player_id
			FROM data.players
			WHERE tournament = 0
		) 
		AND r.team_id IN
		(
			SELECT team_id FROM taxa.tournament_teams
		)
		AND xp.valid_until IS NULL
	)
) p ON 
(
	p.player_id = ts.player_id 
	AND p.valid_from <= ts.timestampd
	AND ts.timestampd < COALESCE(p.valid_until, timezone('utc', now()) + '1 MILLISECONDS'::interval)
)
JOIN data.player_status_flags ps ON (ts.player_id = ps.player_id)
JOIN 	  
(
	SELECT rt.team_id, rr.player_id, rr.position_type_id, rr.position_id, rr.valid_from, 
	rr.valid_until
	FROM DATA.team_roster rr
	JOIN DATA.teams_info_expanded_all rt
	ON 
	(
		rr.team_id = rt.team_id AND rt.valid_until IS NULL
	)
	WHERE rr.tournament > -1
	and rt.current_team_status = 'tournament'
) r ON 
(
	ts.player_id = r.player_id
	AND r.valid_from <= ts.timestampd
	AND ts.timestampd < COALESCE(r.valid_until, timezone('utc', now()) + '1 MILLISECONDS'::interval)
)
LEFT JOIN data.player_debuts pd ON (ts.player_id = pd.player_id)
LEFT JOIN data.player_incinerations pi ON (ts.player_id = pi.player_id)

LEFT JOIN taxa.position_types xp ON (r.position_type_id = xp.position_type_id)
LEFT JOIN data.teams_info_expanded_all t ON (r.team_id = t.team_id AND t.valid_until IS NULL)
LEFT JOIN taxa.blood xb ON (p.blood = xb.blood_id)
LEFT JOIN taxa.coffee xc ON (p.coffee = xc.coffee_id)

WHERE ts.timestampd <> timezone('utc', now())	 
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
                  WHERE ((ge.runs_batted_in > (0)::numeric) AND (ge.day >= 99))
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
                  WHERE ((ge.runs_batted_in > (0)::numeric) AND (ge.day >= 99))
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
                  WHERE ((ge.runs_batted_in > (0)::numeric) AND (ge.day < 99))
                  GROUP BY 'RBIS'::text, ge.batter_id, ge.season) x) y
     JOIN data.players_info_expanded_all p ON ((((y.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
  WHERE (y.this = 1)
  ORDER BY y.event, y.season, p.player_name;

--
-- Name: batting_stats_all_events; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.batting_stats_all_events AS
	SELECT 
	NEXTVAL('DATA.batting_stats_all_events_id_seq') as batting_stats_all_events_id,
	ge.batter_team_id,
	ge.batter_id AS player_id,
	ge.pitcher_team_id,
	ge.pitcher_id,
	ge.inning,
	ge.top_of_inning,
	geb.bases_occupied_before,
	case
		WHEN ge.top_of_inning THEN ge.away_score
		ELSE ge.home_score
	END AS batter_team_score,
	case
		WHEN not ge.top_of_inning THEN ge.away_score
		ELSE ge.home_score
	END AS pitcher_team_score,	 
	CASE
		WHEN ge.top_of_inning THEN 'home'
		ELSE 'away'
	END AS ballfield,
	ge.season,
	ge.day,
	ge.game_id,
	CASE 	
		WHEN POSITION('murder of Crows' IN event_text::TEXT) > 0 THEN 0
		else xe.at_bat
	END AS at_bat,
	xe.plate_appearance,
	CASE
		WHEN (ge.top_of_inning AND ((ge.away_base_count - COALESCE(geb.max_base_before, 0)) < 3)) THEN xe.at_bat
		WHEN ((NOT ge.top_of_inning) AND ((ge.home_base_count - COALESCE(geb.max_base_before, 0)) < 3)) THEN xe.at_bat
		ELSE 0
		END AS at_bat_risp,
	CASE
		WHEN (ge.top_of_inning AND ((ge.away_base_count - COALESCE(geb.max_base_before, 0)) < 3)) THEN xe.hit
		WHEN ((NOT ge.top_of_inning) AND ((ge.home_base_count - COALESCE(geb.max_base_before, 0)) < 3)) THEN xe.hit
		ELSE 0
	END AS hits_risp,
	xe.hit,
	xe.total_bases,
	ge.runs_batted_in,
	CASE
		WHEN (ge.event_type = 'SINGLE') THEN 1
		ELSE 0
	END AS single,
	CASE
		WHEN (ge.event_type = 'DOUBLE') THEN 1
		ELSE 0
	END AS double,
	CASE
		WHEN (ge.event_type = 'TRIPLE') THEN 1
		ELSE 0
	END AS triple,
	CASE
		WHEN (ge.event_type = 'QUADRUPLE') THEN 1
		ELSE 0
	END AS quadruple,
	CASE
		WHEN (ge.event_type = ANY (ARRAY['HOME_RUN', 'HOME_RUN_5'])) THEN 1
		ELSE 0
	END AS home_run,
	CASE
		WHEN (ge.event_type = ANY (ARRAY['WALK', 'CHARM_WALK'])) THEN 1
		ELSE 0
	END AS walk,
	CASE
		WHEN (ge.event_type = ANY (ARRAY['STRIKEOUT', 'CHARM_STRIKEOUT'])) THEN 1
		ELSE 0
	END AS strikeout,
	CASE
		WHEN is_sacrifice_hit THEN 1
		ELSE 0
	END AS sacrifice_bunt,
	CASE
		WHEN is_sacrifice_fly THEN 1
		ELSE 0
	END AS sacrifice_fly,
	CASE
		WHEN (ge.event_type = 'HIT_BY_PITCH') THEN 1
		ELSE 0
	END AS hbp,
	CASE
		WHEN ((ge.batted_ball_type = 'GROUNDER') AND (ge.event_type = 'OUT')) THEN 1
		ELSE 0
	END AS ground_out,
	CASE
		WHEN ((ge.batted_ball_type = 'FLY') AND (ge.event_type = 'OUT')) THEN 1
		ELSE 0
	END AS flyout,
	CASE
		WHEN ge.is_double_play THEN 1
		ELSE 0
	END AS gidp,
	ga.is_postseason,
	CASE
		WHEN POSITION(' is Inhabiting' IN event_text::TEXT) > 0 THEN 1
		ELSE 0
	END AS is_haunting,
	CASE
		WHEN POSITION('murder of Crows' IN event_text::TEXT) > 0 THEN 1
		ELSE 0
	END AS is_murder,
	CASE
		WHEN ge.event_type like 'CHARM%' THEN 1
		ELSE 0
	END AS is_charm,
	CASE
		WHEN ge.event_type like 'MINDTRICK%' THEN 1
		ELSE 0
	END AS is_mindtrick,
	CASE
		WHEN POSITION('Base Instincts take them directly to second base!' IN event_text::TEXT) > 0 THEN 1
		WHEN POSITION('Base Instincts take them directly to third base!' IN event_text::TEXT) > 0 THEN 2
		WHEN POSITION('Base Instincts take them directly to fourth base!' IN event_text::TEXT) > 0 THEN 3
		ELSE 0
	END AS instinct_base_count,
	LENGTH(REPLACE(event_text::TEXT,'The Electricity zaps a strike away!','~'))-LENGTH(REPLACE(event_text::text,'The Electricity zaps a strike away!','')) AS zap_count,
	ga.weather AS weather_id
	FROM data.game_events ge
	JOIN taxa.event_types xe 
	ON (ge.event_type = xe.event_type)
	JOIN data.games ga 
	ON (ge.game_id = ga.game_id)
	LEFT JOIN 
	(
		SELECT max(base_before_play) AS max_base_before, 
		case
			when array_length(array_remove(array_agg(DISTINCT base_before_play ORDER BY base_before_play),0),1) is null THEN NULL
			ELSE array_remove(array_agg(DISTINCT base_before_play ORDER BY base_before_play),0)
		end AS bases_occupied_before,
		game_event_id
		FROM data.game_event_base_runners
		GROUP BY game_event_id
	) geb 
	ON (ge.id = geb.game_event_id)
	WHERE xe.plate_appearance = 1
  WITH NO DATA;
  
--
-- Name: batting_stats_player_single_game; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.batting_stats_player_single_game AS
	SELECT 
	NEXTVAL('DATA.batting_stats_player_single_game_id_seq') as batting_stats_player_single_game_id,
	p.player_name,
	a.player_id,
	t.team_id,
	t.nickname AS team,
	t.valid_from as team_valid_from,
	t.valid_until as team_valid_until,
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
		ELSE data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly))
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
	sum(a.sacrifice_bunt) AS sacrifice_bunts,
	sum(a.sacrifice_fly) AS sacrifice_flies,
	sum(a.at_bat_risp) AS at_bats_risp,
	sum(a.hits_risp) AS hits_risp,
	CASE
		WHEN (sum(a.at_bat_risp) = 0) THEN NULL::numeric
		ELSE data.batting_average(sum(a.hits_risp), sum(a.at_bat_risp))
	END AS batting_average_risp,
	CASE
		WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
		ELSE (data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly)) + data.slugging(sum(a.total_bases), sum(a.at_bat)))
	END AS on_base_slugging,
	sum(a.total_bases) AS total_bases,
	sum(a.hbp) AS hit_by_pitches,
	sum(a.ground_out) AS ground_outs,
	sum(a.flyout) AS flyouts,
	sum(a.gidp) AS gidp
	FROM data.batting_stats_all_events a
	JOIN data.players_info_expanded_all p 
	ON (a.player_id = p.player_id AND p.valid_until IS NULL)
	JOIN data.teams_info_expanded_all t 
	ON (a.batter_team_id = t.team_id AND t.valid_until IS NULL)
	JOIN data.games ga 
	ON (a.game_id = ga.game_id)
	GROUP BY a.player_id, a.is_postseason, p.player_name, a.game_id, t.nickname, t.team_id, ga.season, ga.day, t.valid_from, t.valid_until
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
	a.team_valid_from,
	a.team_valid_until,
    c.value,
    c.stat
   FROM (( SELECT x.player_id,
            x.player_name,
            x.season,
            x.day,
            x.team_id,
            x.team,
			x.team_valid_from,
			x.team_valid_until,
            x.game_id,
            x.hits_risp,
            x.walks,
            x.singles,
            x.doubles,
            x.triples,
            x.quadruples,
            x.home_runs,
            x.total_bases,
            x.hits,
            x.runs_batted_in,
            x.sacrifice_bunts,
            x.sacrifice_flies,
            x.strikeouts,
            rank() OVER (ORDER BY x.hits_risp DESC) AS hits_risp_rank,
            rank() OVER (ORDER BY x.walks DESC) AS bb_rank,
            rank() OVER (ORDER BY x.singles DESC) AS sng_rank,
            rank() OVER (ORDER BY x.doubles DESC) AS dbl_rank,
            rank() OVER (ORDER BY x.triples DESC) AS trp_rank,
            rank() OVER (ORDER BY x.home_runs DESC) AS hr_rank,
            rank() OVER (ORDER BY x.total_bases DESC) AS tb_rank,
            rank() OVER (ORDER BY x.quadruples DESC) AS qd_rank,
            rank() OVER (ORDER BY x.hits DESC) AS hits_rank,
            rank() OVER (ORDER BY x.runs_batted_in DESC) AS rbi_rank,
			rank() OVER (ORDER BY x.sacrifice_bunts DESC) AS sacbunts_rank,
            rank() OVER (ORDER BY x.sacrifice_flies DESC) AS sacflies_rank,
            rank() OVER (ORDER BY x.strikeouts DESC) AS k_rank
           FROM data.batting_stats_player_single_game x) a
     CROSS JOIN LATERAL 
	  (
	  VALUES 
	  (a.hits_risp,a.hits_risp_rank,'hits_risp'), 
	  (a.walks,a.bb_rank,'walks'), 
	  (a.singles,a.sng_rank,'singles'), 
	  (a.doubles,a.dbl_rank,'doubles'), 
	  (a.triples,a.trp_rank,'triples'), 
	  (a.quadruples,a.qd_rank,'quadruples'), 
	  (a.home_runs,a.hr_rank,'home_runs'), 
	  (a.total_bases,a.tb_rank,'total_bases'), 
	  (a.hits,a.hits_rank,'hits'), 
	  (a.runs_batted_in,a.rbi_rank,'runs_batted_in'), 
	  (a.sacrifice_bunts,a.sacbunts_rank,'sacrifice_bunts'), 
	  (a.sacrifice_flies,a.sacflies_rank,'sacrifice_flies'), 
	  (a.strikeouts,a.k_rank,'strikeouts')
	  ) c(value, rank, stat))
  WHERE (c.rank = 1)
  ORDER BY c.stat, a.player_name;

--
-- Name: batting_records_team_playoffs_season; Type: VIEW; Schema: data; Owner: -
--
CREATE VIEW data.batting_records_team_playoffs_season AS
 SELECT y.that AS record,
    t.nickname AS team,
    t.team_id,
	t.valid_from as team_valid_from,
	t.valid_until as team_valid_until,
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
                  WHERE ((ge.runs_batted_in > (0)::numeric) AND (ge.day >= 99))
                  GROUP BY 'RBIS'::text, ge.batter_team_id, ge.season) x) y
     JOIN data.teams_info_expanded_all t ON ((((y.team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
  WHERE ((y.this = 1) AND (y.season > 0))
  ORDER BY y.event, y.season, t.nickname;
--
-- Name: batting_records_team_playoffs_single_game; Type: VIEW; Schema: data; Owner: -
--
CREATE VIEW data.batting_records_team_playoffs_single_game AS
 SELECT y.that AS record,
    t.nickname AS team,
    t.team_id,
	t.valid_from as team_valid_from,
	t.valid_until as team_valid_until,
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
                  WHERE ((ge.runs_batted_in >= (0)::numeric) AND (ge.day < 99))
                  GROUP BY ge.game_id, 'RBIS'::text, ge.batter_team_id, ge.season, ge.day) x) y
     JOIN data.teams_info_expanded_all t ON ((((y.team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
  WHERE ((y.this = 1) AND (y.season > 0))
  ORDER BY y.event, y.season, y.day, t.nickname;
--
-- Name: batting_records_team_season; Type: VIEW; Schema: data; Owner: -
--
CREATE VIEW data.batting_records_team_season AS
 SELECT y.that AS record,
    t.nickname AS team,
    t.team_id AS team_id,
	t.valid_from as team_valid_from,
	t.valid_until as team_valid_until,
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
                  WHERE ((ge.runs_batted_in > (0)::numeric) AND (ge.day < 99))
                  GROUP BY 'RBIS'::text, ge.batter_team_id, ge.season) x) y
     JOIN data.teams_info_expanded_all t ON ((((y.team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
  WHERE ((y.this = 1) AND (y.season > 0))
  ORDER BY y.event, y.season, t.nickname;
--
-- Name: batting_records_team_single_game; Type: VIEW; Schema: data; Owner: -
--
CREATE VIEW data.batting_records_team_single_game AS
 SELECT y.that AS record,
    t.nickname AS team,
    t.team_id,
	t.valid_from as team_valid_from,
	t.valid_until as team_valid_until,
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
                  WHERE ((ge.runs_batted_in > (0)::numeric) AND (ge.day < 99))
                  GROUP BY ge.game_id, 'RBIS'::text, ge.batter_team_id, ge.season, ge.day) x) y
     JOIN data.teams_info_expanded_all t ON ((((y.team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
  WHERE ((y.this = 1) AND (y.season > 0))
  ORDER BY y.event, y.season, y.day, t.nickname;

--
-- Name: batting_records_team_tournament; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_records_team_tournament AS
SELECT y.that AS record,
t.nickname AS team,
t.team_id,
t.valid_from as team_valid_from,
t.valid_until as team_valid_until,
y.event,
y.season
FROM 
(
	SELECT x.that,
	x.team_id,
	x.event,
	x.season,
	rank() OVER (PARTITION BY x.event ORDER BY x.that DESC) AS this
	FROM 
	(
		SELECT count(1) AS that,
		ge.batter_team_id AS team_id,
		ge.event_type AS event,
		ge.season
		FROM data.game_events ge
		WHERE ((ge.event_type <> ALL (ARRAY['UNKNOWN'::text, 'OUT'::text, 'GAME_OVER'::text])) AND (ge.season = -1))
		GROUP BY ge.event_type, ge.batter_team_id, ge.season
		UNION
		SELECT sum(xe.hit) AS that,
		ge.batter_team_id AS team_id,
		'HIT'::text AS event,
		ge.season
		FROM (data.game_events ge
		JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
		WHERE ((xe.hit = 1) AND (ge.season = -1))
		GROUP BY 'HIT'::text, ge.batter_team_id, ge.season
		UNION
		SELECT sum(xe.total_bases) AS that,
		ge.batter_team_id AS team_id,
		'TOTAL_BASES'::text AS event,
		ge.season
		FROM (data.game_events ge
		JOIN taxa.event_types xe ON ((ge.event_type = xe.event_type)))
		WHERE ((xe.hit = 1) AND (ge.season = -1))
		GROUP BY 'TOTAL_BASES'::text, ge.batter_team_id, ge.season
		UNION
		SELECT sum(ge.runs_batted_in) AS that,
		ge.batter_team_id AS team_id,
		'RBIS'::text AS event,
		ge.season
		FROM data.game_events ge
		WHERE ((ge.runs_batted_in > (0)::numeric) AND (ge.season = -1))
		GROUP BY 'RBIS'::text, ge.batter_team_id, ge.season
	) x
) y
JOIN data.teams_info_expanded_all t ON ((((y.team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL)))
WHERE (y.this = 1)
ORDER BY y.event, y.season, t.nickname;

--
-- Name: batting_records_team_tournament_single_game; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_records_team_tournament_single_game AS
SELECT y.that AS record,
t.nickname AS team,
t.team_id,
t.valid_from as team_valid_from,
t.valid_until as team_valid_until,
y.event,
y.season,
y.day
FROM 
(
	SELECT x.that,
	x.team_id,
	x.event,
	x.season,
	x.day,
	rank() OVER (PARTITION BY x.event ORDER BY x.that DESC) AS this
	FROM 
	(
		SELECT count(1) AS that,
		ge.batter_team_id AS team_id,
		ge.event_type AS event,
		ge.season,
		ge.day
		FROM data.game_events ge
		WHERE ((ge.event_type <> ALL (ARRAY['UNKNOWN'::text, 'OUT'::text, 'GAME_OVER'::text])) AND (ge.season = -1))
		GROUP BY ge.event_type, ge.batter_team_id, ge.season, ge.day
		UNION
		SELECT sum(xe.hit) AS that,
		ge.batter_team_id AS team_id,
		'HIT'::text AS event,
		ge.season,
		ge.day
		FROM data.game_events ge
		JOIN taxa.event_types xe ON (ge.event_type = xe.event_type)
		WHERE ((xe.hit = 1) AND (ge.season = -1))
		GROUP BY 'HIT'::text, ge.batter_team_id, ge.season, ge.day
		UNION
		SELECT sum(xe.total_bases) AS that,
		ge.batter_team_id AS team_id,
		'TOTAL_BASES'::text AS event,
		ge.season,
		ge.day
		FROM data.game_events ge
		JOIN taxa.event_types xe ON (ge.event_type = xe.event_type)
		WHERE ((xe.hit = 1) AND (ge.season = -1))
		GROUP BY 'TOTAL_BASES'::text, ge.batter_team_id, ge.season, ge.day
		UNION
		SELECT sum(ge.runs_batted_in) AS that,
		ge.batter_team_id AS team_id,
		'RBIS'::text AS event,
		ge.season,
		ge.day
		FROM data.game_events ge
		WHERE ((ge.runs_batted_in > (0)::numeric) AND (ge.season = -1))
		GROUP BY 'RBIS'::text, ge.batter_team_id, ge.season, ge.day
	) x
) y
JOIN data.teams_info_expanded_all t ON ((((y.team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL)))
WHERE (y.this = 1)
ORDER BY y.event, y.season, t.nickname;
--
-- Name: batting_records_team_tournmament; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_records_team_tournmament AS
 SELECT y.that AS record,
    t.nickname AS team,
    t.team_id,
	t.valid_from as team_valid_from,
	t.valid_until as team_valid_until,
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
                  WHERE ((ge.runs_batted_in > (0)::numeric) AND (ge.day >= 99))
                  GROUP BY 'RBIS'::text, ge.batter_team_id, ge.season) x) y
     JOIN data.teams_info_expanded_all t ON ((((y.team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
  WHERE ((y.this = 1) AND (y.season < 0))
  ORDER BY y.event, y.season, t.nickname;


--
-- Name: batting_stats_player_lifetime; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.batting_stats_player_lifetime AS
 SELECT p.player_name,
    a.player_id,
		count(distinct a.game_id) as appearances,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hit), sum(a.at_bat))
        END AS batting_average,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly))
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
    sum(a.sacrifice_bunt) AS sacrifice_bunts,
	sum(a.sacrifice_fly) AS sacrifice_flies,
    sum(a.at_bat_risp) AS at_bats_risp,
    sum(a.hits_risp) AS hits_risp,
        CASE
            WHEN (sum(a.at_bat_risp) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hits_risp), sum(a.at_bat_risp))
        END AS batting_average_risp,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE (data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly)) + data.slugging(sum(a.total_bases), sum(a.at_bat)))
        END AS on_base_slugging,
    sum(a.total_bases) AS total_bases,
    sum(a.hbp) AS hit_by_pitches,
    sum(a.ground_out) AS ground_outs,
    sum(a.flyout) AS flyouts,
    sum(a.gidp) AS gidp
   FROM (data.batting_stats_all_events a
     JOIN data.players_info_expanded_all p ON ((((a.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
  WHERE ((NOT a.is_postseason) AND (a.season > 0))
  GROUP BY a.player_id, p.player_name
  WITH NO DATA;
  
--
-- Name: batting_stats_player_playoffs_lifetime; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.batting_stats_player_playoffs_lifetime AS
 SELECT p.player_name,
    a.player_id,
	
	count(distinct a.game_id) as appearances,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hit), sum(a.at_bat))
        END AS batting_average,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly))
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
    sum(a.sacrifice_bunt) AS sacrifice_bunts,
	sum(a.sacrifice_fly) AS sacrifice_flies,
    sum(a.at_bat_risp) AS at_bats_risp,
    sum(a.hits_risp) AS hits_risp,
        CASE
            WHEN (sum(a.at_bat_risp) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hits_risp), sum(a.at_bat_risp))
        END AS batting_average_risp,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE (data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly)) + data.slugging(sum(a.total_bases), sum(a.at_bat)))
        END AS on_base_slugging,
    sum(a.total_bases) AS total_bases,
    sum(a.hbp) AS hit_by_pitches,
    sum(a.ground_out) AS ground_outs,
    sum(a.flyout) AS flyouts,
    sum(a.gidp) AS gidp
   FROM (data.batting_stats_all_events a
     JOIN data.players_info_expanded_all p ON ((((a.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
  WHERE ((a.is_postseason) AND (a.season > 0))
  GROUP BY a.player_id, p.player_name
  WITH NO DATA;

--
-- Name: batting_stats_player_playoffs_season; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.batting_stats_player_playoffs_season AS
 SELECT p.player_name,
     a.player_id,
	count(distinct a.game_id) as appearances,
    t.team_id,
    t.nickname AS team,
	t.valid_from as team_valid_from,
	t.valid_until as team_valid_until,
    a.season,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hit), sum(a.at_bat))
        END AS batting_average,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly))
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
    sum(a.sacrifice_bunt) AS sacrifice_bunts,
	sum(a.sacrifice_fly) AS sacrifice_flies,
    sum(a.at_bat_risp) AS at_bats_risp,
    sum(a.hits_risp) AS hits_risp,
        CASE
            WHEN (sum(a.at_bat_risp) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hits_risp), sum(a.at_bat_risp))
        END AS batting_average_risp,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE (data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly)) + data.slugging(sum(a.total_bases), sum(a.at_bat)))
        END AS on_base_slugging,
    sum(a.total_bases) AS total_bases,
    sum(a.hbp) AS hit_by_pitches,
    sum(a.ground_out) AS ground_outs,
    sum(a.flyout) AS flyouts,
    sum(a.gidp) AS gidp
   FROM ((data.batting_stats_all_events a
     JOIN data.players_info_expanded_all p ON ((((a.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
     JOIN data.teams_info_expanded_all t ON ((((a.batter_team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
  WHERE a.is_postseason and season > 0
  GROUP BY a.player_id, p.player_name, a.season, t.nickname, t.team_id, t.valid_from, t.valid_until
  WITH NO DATA;
  
--
-- Name: batting_stats_player_season; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.batting_stats_player_season AS
 SELECT 
    p.player_name,
    a.player_id,
    t.team_id,
    t.nickname AS team,
	t.valid_from as team_valid_from,
	t.valid_until as team_valid_until,
    a.season,
	count(distinct a.game_id) as appearances,
	min(a.day) as first_appearance,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hit), sum(a.at_bat))
        END AS batting_average,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly))
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
	sum(a.quadruple) as quadruples,
    sum(a.home_run) AS home_runs,
    sum(a.runs_batted_in) AS runs_batted_in,
    sum(a.strikeout) AS strikeouts,
    sum(a.sacrifice_bunt) AS sacrifice_bunts,
	sum(a.sacrifice_fly) AS sacrifice_flies,
    sum(a.at_bat_risp) AS at_bats_risp,
    sum(a.hits_risp) AS hits_risp,
        CASE
            WHEN (sum(a.at_bat_risp) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hits_risp), sum(a.at_bat_risp))
        END AS batting_average_risp,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE (data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly)) + data.slugging(sum(a.total_bases), sum(a.at_bat)))
        END AS on_base_slugging,
    sum(a.total_bases) AS total_bases,
    sum(a.hbp) AS hit_by_pitches,
    sum(a.ground_out) AS ground_outs,
    sum(a.flyout) AS flyouts,
    sum(a.gidp) AS gidp
   FROM ((data.batting_stats_all_events a
     JOIN data.players_info_expanded_all p ON ((((a.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
     JOIN data.teams_info_expanded_all t ON ((((a.batter_team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
  WHERE ((NOT a.is_postseason) AND (a.season > 0))
  GROUP BY a.player_id, p.player_name, a.season, t.nickname, t.team_id, t.valid_from, t.valid_until
  WITH NO DATA;

--
-- Name: batting_stats_player_season_combined; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.batting_stats_player_season_combined AS
	SELECT 
	p.player_name,
	a.player_id,
	a.season,
	count(distinct a.game_id) as appearances,
	min(a.day) as first_appearance,
	  CASE
	      WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
	      ELSE data.batting_average(sum(a.hit), sum(a.at_bat))
	  END AS batting_average,
	  CASE
	      WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
	      ELSE data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly))
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
	sum(a.quadruple) as quadruples,
	sum(a.home_run) AS home_runs,
	sum(a.runs_batted_in) AS runs_batted_in,
	sum(a.strikeout) AS strikeouts,
	sum(a.sacrifice_bunt) AS sacrifice_bunts,
	sum(a.sacrifice_fly) AS sacrifice_flies,
	sum(a.at_bat_risp) AS at_bats_risp,
	sum(a.hits_risp) AS hits_risp,
	  CASE
	      WHEN (sum(a.at_bat_risp) = 0) THEN NULL::numeric
	      ELSE data.batting_average(sum(a.hits_risp), sum(a.at_bat_risp))
	  END AS batting_average_risp,
	  CASE
	      WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
	      ELSE 
			(
				data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), 
				sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly)) + data.slugging(sum(a.total_bases), sum(a.at_bat))
			)
	  END AS on_base_slugging,
	sum(a.total_bases) AS total_bases,
	sum(a.hbp) AS hit_by_pitches,
	sum(a.ground_out) AS ground_outs,
	sum(a.flyout) AS flyouts,
	sum(a.gidp) AS gidp
	FROM data.batting_stats_all_events a
	JOIN data.players_info_expanded_all p 
	ON 
	(
		a.player_id = p.player_id 
		AND p.valid_until IS null
	) 
	WHERE NOT a.is_postseason AND a.season > 0
	GROUP BY a.player_id, p.player_name, a.season
	ORDER BY season, player_name, appearances DESC
	WITH NO DATA;  
	
--
-- Name: batting_stats_team_playoffs_season; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.batting_stats_team_playoffs_season AS
 SELECT 
    t.team_id,
    t.nickname AS team,
	t.valid_from as team_valid_from,
	t.valid_until as team_valid_until,
    a.season,
	count(distinct a.game_id) as appearances,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hit), sum(a.at_bat))
        END AS batting_average,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly))
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
	sum(a.quadruple) as quadruples,
    sum(a.home_run) AS home_runs,
    sum(a.runs_batted_in) AS runs_batted_in,
    sum(a.strikeout) AS strikeouts,
    sum(a.sacrifice_bunt) AS sacrifice_bunts,
	sum(a.sacrifice_fly) AS sacrifice_flies,
    sum(a.at_bat_risp) AS at_bats_risp,
    sum(a.hits_risp) AS hits_risp,
        CASE
            WHEN (sum(a.at_bat_risp) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hits_risp), sum(a.at_bat_risp))
        END AS batting_average_risp,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE (data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly)) + data.slugging(sum(a.total_bases), sum(a.at_bat)))
        END AS on_base_slugging,
    sum(a.total_bases) AS total_bases,
    sum(a.hbp) AS hit_by_pitches,
    sum(a.ground_out) AS ground_outs,
    sum(a.flyout) AS flyouts,
    sum(a.gidp) AS gidp
   FROM ((data.batting_stats_all_events a
     JOIN data.players_info_expanded_all p ON ((((a.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
     JOIN data.teams_info_expanded_all t ON ((((a.batter_team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
  WHERE ((a.is_postseason) AND (a.season > 0))
  GROUP BY a.season, t.nickname, t.team_id, t.valid_from, t.valid_until
  WITH NO DATA;

--
-- Name: batting_stats_team_season; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.batting_stats_team_season AS
 SELECT 
    t.team_id,
    t.nickname AS team,
	t.valid_from as team_valid_from,
	t.valid_until as team_valid_until,
    a.season,
	count(distinct a.game_id) as appearances,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hit), sum(a.at_bat))
        END AS batting_average,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly))
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
	sum(a.quadruple) as quadruples,
    sum(a.home_run) AS home_runs,
    sum(a.runs_batted_in) AS runs_batted_in,
    sum(a.strikeout) AS strikeouts,
    sum(a.sacrifice_bunt) AS sacrifice_bunts,
	sum(a.sacrifice_fly) AS sacrifice_flies,
    sum(a.at_bat_risp) AS at_bats_risp,
    sum(a.hits_risp) AS hits_risp,
        CASE
            WHEN (sum(a.at_bat_risp) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hits_risp), sum(a.at_bat_risp))
        END AS batting_average_risp,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE (data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly)) + data.slugging(sum(a.total_bases), sum(a.at_bat)))
        END AS on_base_slugging,
    sum(a.total_bases) AS total_bases,
    sum(a.hbp) AS hit_by_pitches,
    sum(a.ground_out) AS ground_outs,
    sum(a.flyout) AS flyouts,
    sum(a.gidp) AS gidp
   FROM ((data.batting_stats_all_events a
     JOIN data.players_info_expanded_all p ON ((((a.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
     JOIN data.teams_info_expanded_all t ON ((((a.batter_team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
  WHERE ((NOT a.is_postseason) AND (a.season > 0))
  GROUP BY a.season, t.nickname, t.team_id, t.valid_from, t.valid_until
  WITH NO DATA;

--
-- Name: batting_stats_player_tournament; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_player_tournament AS
 SELECT p.player_name,
    a.player_id,
    t.team_id,
    t.nickname AS team,
	t.valid_from as team_valid_from,
	t.valid_until as team_valid_until,
    a.season,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hit), sum(a.at_bat))
        END AS batting_average,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly))
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
    sum(a.sacrifice_bunt) AS sacrifice_bunts,
	sum(a.sacrifice_fly) AS sacrifice_flies,
    sum(a.at_bat_risp) AS at_bats_risp,
    sum(a.hits_risp) AS hits_risp,
        CASE
            WHEN (sum(a.at_bat_risp) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hits_risp), sum(a.at_bat_risp))
        END AS batting_average_risp,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE (data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly)) + data.slugging(sum(a.total_bases), sum(a.at_bat)))
        END AS on_base_slugging,
    sum(a.total_bases) AS total_bases,
    sum(a.hbp) AS hit_by_pitches,
    sum(a.ground_out) AS ground_outs,
    sum(a.flyout) AS flyouts,
    sum(a.gidp) AS gidp
   FROM ((data.batting_stats_all_events a
     JOIN data.players_info_expanded_tourney p ON ((((a.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
     JOIN data.teams_info_expanded_all t ON ((((a.batter_team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
  WHERE (a.season < 0)
  GROUP BY a.player_id, p.player_name, a.season, t.nickname, t.team_id, t.valid_from, t.valid_until;

--
-- Name: batting_stats_player_tournament_lifetime; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_player_tournament_lifetime AS
 SELECT p.player_name,
    a.player_id,
	count(distinct a.game_id) as appearances,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hit), sum(a.at_bat))
        END AS batting_average,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly))
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
    sum(a.sacrifice_bunt) AS sacrifice_bunts,
	sum(a.sacrifice_fly) AS sacrifice_flies,
    sum(a.at_bat_risp) AS at_bats_risp,
    sum(a.hits_risp) AS hits_risp,
        CASE
            WHEN (sum(a.at_bat_risp) = 0) THEN NULL::numeric
            ELSE data.batting_average(sum(a.hits_risp), sum(a.at_bat_risp))
        END AS batting_average_risp,
        CASE
            WHEN (sum(a.at_bat) = 0) THEN NULL::numeric
            ELSE (data.on_base_percentage(sum(a.hit), sum(a.at_bat), sum(a.walk), sum(a.sacrifice_bunt) + SUM(a.sacrifice_fly)) + data.slugging(sum(a.total_bases), sum(a.at_bat)))
        END AS on_base_slugging,
    sum(a.total_bases) AS total_bases,
    sum(a.hbp) AS hit_by_pitches,
    sum(a.ground_out) AS ground_outs,
    sum(a.flyout) AS flyouts,
    sum(a.gidp) AS gidp
   FROM (data.batting_stats_all_events a
     JOIN data.players_info_expanded_tourney p ON ((((a.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
  WHERE (a.season < 0)
  GROUP BY a.player_id, p.player_name;
  
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
-- Name: fielder_stats_all_events; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.fielder_stats_all_events AS
 SELECT 
	NEXTVAL('DATA.fielder_stats_all_events_id_seq') as fielder_stats_all_events_id, 
	d.batter,
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
  WHERE ((f.day < 99) AND (f.season > 0))
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
  WHERE ((f.day < 99) AND (f.season > 0))
  GROUP BY f.player_name, f.player_id, f.season;

  --
-- Name: fielder_stats_tournament; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.fielder_stats_tournament AS
 SELECT f.player_name,
    f.player_id,
    count(1) AS plays
   FROM data.fielder_stats_all_events f
  WHERE (f.season < 0)
  GROUP BY f.player_name, f.player_id;

--
-- Name: pitching_stats_all_appearances; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.pitching_stats_all_appearances AS
 SELECT 
	NEXTVAL('DATA.pitching_stats_all_appearances_id_seq') as pitching_stats_all_appearances_id,
	ge.game_id,
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
    sum(array_length(ge.pitches, 1)) AS pitches_thrown,
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
        END) AS home_runs_allowed,
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
  HAVING sum(xe.plate_appearance) > 0 
  WITH NO DATA;
  
--
-- Name: pitching_stats_player_tournament; Type: VIEW; Schema: data; Owner: -
--
CREATE OR REPLACE VIEW data.pitching_stats_player_tournament
 AS
 SELECT a.player_name,
    p.player_id,
    p.season,
    p.team_id,
	t.nickname as team,
	t.valid_from as team_valid_from,
	t.valid_until as team_valid_until,
    count(1) AS games,
    sum(p.win) AS wins,
    sum(p.loss) AS losses,
 	CASE
		WHEN (sum(p.win) + sum(p.loss) = 0) THEN NULL::numeric
		ELSE round(sum(p.win)::numeric / (sum(p.win)::numeric + sum(p.loss)::numeric), 2)
	END AS win_pct,
	sum(p.pitches_thrown) AS pitches_thrown,
    sum(p.batters_faced) AS batters_faced,
    sum(p.outs_recorded) AS outs_recorded,
    round(floor(sum(p.outs_recorded) / 3::numeric) + mod(sum(p.outs_recorded), 3::numeric) / 10::numeric, 1) AS innings,
    sum(p.runs_allowed) AS runs_allowed,
    sum(
        CASE
            WHEN p.runs_allowed = 0::numeric THEN 1
            ELSE 0
        END) AS shutouts,
    sum(
        CASE
            WHEN p.runs_allowed < 4::numeric AND p.outs_recorded > 18 THEN 1
            ELSE 0
        END) AS quality_starts,
    sum(p.strikeouts) AS strikeouts,
    sum(p.walks) AS walks,
    sum(p.home_runs_allowed) AS home_runs_allowed,
    sum(p.hits_allowed) AS hits_allowed,
    sum(p.hit_by_pitches) AS hit_by_pitches,
    round(9::numeric * sum(p.runs_allowed) / (sum(p.outs_recorded) / 3::numeric), 2) AS earned_run_average,
    round(9::numeric * sum(p.walks) / (sum(p.outs_recorded) / 3::numeric), 2) AS walks_per_9,
    round(9::numeric * sum(p.hits_allowed) / (sum(p.outs_recorded) / 3::numeric), 2) AS hits_per_9,
    round(9::numeric * sum(p.strikeouts) / (sum(p.outs_recorded) / 3::numeric), 2) AS strikeouts_per_9,
    round(9::numeric * sum(p.home_runs_allowed) / (sum(p.outs_recorded) / 3::numeric), 2) AS home_runs_per_9,
	round(((sum(p.walks)+sum(p.hits_allowed))/(sum(p.outs_recorded) / (3)::numeric)),3) AS whip,
	case
		WHEN sum(p.walks) = 0 THEN sum(p.strikeouts) ELSE round(sum(p.strikeouts)/sum(p.walks),2)
	end AS strikeouts_per_walk
   FROM data.pitching_stats_all_appearances p
     JOIN data.players_info_expanded_tourney a ON a.player_id::text = p.player_id::text AND a.valid_until IS NULL
	 JOIN data.teams_info_expanded_all t on (p.team_id = t.team_id AND t.valid_until is null)
  WHERE p.season < 0
  GROUP BY a.player_name, p.player_id, p.season, p.team_id, t.nickname, t.valid_from, t.valid_until;  
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
         SELECT rank() OVER (ORDER BY pitching_stats_all_appearances.pitches_thrown DESC) AS rank,
            'pitches_thrown'::text AS event,
            pitching_stats_all_appearances.pitches_thrown AS record,
            pitching_stats_all_appearances.player_id,
            pitching_stats_all_appearances.game_id,
            pitching_stats_all_appearances.season,
            pitching_stats_all_appearances.day
           FROM data.pitching_stats_all_appearances
          WHERE (COALESCE(pitching_stats_all_appearances.pitches_thrown, (0)::bigint) > 0)
        UNION
         SELECT rank() OVER (ORDER BY pitching_stats_all_appearances.runs_allowed DESC) AS rank,
            'runs_allowed'::text AS event,
            pitching_stats_all_appearances.runs_allowed AS record,
            pitching_stats_all_appearances.player_id,
            pitching_stats_all_appearances.game_id,
            pitching_stats_all_appearances.season,
            pitching_stats_all_appearances.day
           FROM data.pitching_stats_all_appearances
          WHERE (COALESCE(pitching_stats_all_appearances.runs_allowed, ((0)::bigint)::numeric) > (0)::numeric)
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
         SELECT rank() OVER (ORDER BY pitching_stats_all_appearances.home_runs_allowed DESC) AS rank,
            'home_runs_allowed'::text AS event,
            pitching_stats_all_appearances.home_runs_allowed AS record,
            pitching_stats_all_appearances.player_id,
            pitching_stats_all_appearances.game_id,
            pitching_stats_all_appearances.season,
            pitching_stats_all_appearances.day
           FROM data.pitching_stats_all_appearances
          WHERE (COALESCE(pitching_stats_all_appearances.home_runs_allowed, (0)::bigint) > 0)
        UNION
         SELECT rank() OVER (ORDER BY pitching_stats_all_appearances.runs_allowed DESC) AS rank,
            'runs_allowed'::text AS event,
            pitching_stats_all_appearances.runs_allowed AS record,
            pitching_stats_all_appearances.player_id,
            pitching_stats_all_appearances.game_id,
            pitching_stats_all_appearances.season,
            pitching_stats_all_appearances.day
           FROM data.pitching_stats_all_appearances
          WHERE (COALESCE(pitching_stats_all_appearances.runs_allowed, ((0)::bigint)::numeric) > (0)::numeric)
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
-- Name: pitching_stats_player_lifetime; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.pitching_stats_player_lifetime AS
 SELECT a.player_name,
    p.player_id,
    count(1) AS games,
    sum(p.win) AS wins,
    sum(p.loss) AS losses,
	CASE
		WHEN (sum(p.win) + sum(p.loss) = 0) THEN NULL::numeric
		ELSE round(sum(p.win)::numeric / (sum(p.win)::numeric + sum(p.loss)::numeric), 2)
	END AS win_pct,
    sum(p.pitches_thrown) AS pitches_thrown,
    sum(p.batters_faced) AS batters_faced,
    sum(p.outs_recorded) AS outs_recorded,
    round((floor((sum(p.outs_recorded) / (3)::numeric)) + (mod(sum(p.outs_recorded), (3)::numeric) / (10)::numeric)), 1) AS innings,
    sum(p.runs_allowed) AS runs_allowed,
    sum(
        CASE
            WHEN (p.runs_allowed = (0)::numeric) THEN 1
            ELSE 0
        END) AS shutouts,
    sum(
        CASE
            WHEN ((p.runs_allowed < (4)::numeric) AND (p.outs_recorded > 18)) THEN 1
            ELSE 0
        END) AS quality_starts,
    sum(p.strikeouts) AS strikeouts,
    sum(p.walks) AS walks,
    sum(p.home_runs_allowed) AS home_runs_allowed,
    sum(p.hits_allowed) AS hits_allowed,
    sum(p.hit_by_pitches) AS hit_by_pitches,
    round((((9)::numeric * sum(p.runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS earned_run_average,
    round((((9)::numeric * sum(p.walks)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS walks_per_9,
    round((((9)::numeric * sum(p.hits_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS hits_per_9,
    round((((9)::numeric * sum(p.strikeouts)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS strikeouts_per_9,
    round((((9)::numeric * sum(p.home_runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS home_runs_per_9,
	round(((sum(p.walks)+sum(p.hits_allowed))/(sum(p.outs_recorded) / (3)::numeric)),3) AS whip,
	case
		WHEN sum(p.walks) = 0 THEN sum(p.strikeouts) ELSE round(sum(p.strikeouts)/sum(p.walks),2)
	end AS strikeouts_per_walk
   FROM (data.pitching_stats_all_appearances p
     JOIN data.players_info_expanded_all a ON ((((a.player_id)::text = (p.player_id)::text) AND (a.valid_until IS NULL))))
  WHERE ((NOT p.is_postseason) AND (p.season > 0))
  GROUP BY a.player_name, p.player_id
  WITH NO DATA;
  
--
-- Name: pitching_stats_player_playoffs_lifetime; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.pitching_stats_player_playoffs_lifetime AS
 SELECT a.player_name,
    p.player_id,
    count(1) AS games,
    sum(p.win) AS wins,
    sum(p.loss) AS losses,
	CASE
		WHEN (sum(p.win) + sum(p.loss) = 0) THEN NULL::numeric
		ELSE round(sum(p.win)::numeric / (sum(p.win)::numeric + sum(p.loss)::numeric), 2)
	END AS win_pct,
    sum(p.pitches_thrown) AS pitches_thrown,	
    sum(p.batters_faced) AS batters_faced,
    sum(p.outs_recorded) AS outs_recorded,
    round((floor((sum(p.outs_recorded) / (3)::numeric)) + (mod(sum(p.outs_recorded), (3)::numeric) / (10)::numeric)), 1) AS innings,
    sum(p.runs_allowed) AS runs_allowed,
    sum(
        CASE
            WHEN (p.runs_allowed = (0)::numeric) THEN 1
            ELSE 0
        END) AS shutouts,
    sum(
        CASE
            WHEN ((p.runs_allowed < (4)::numeric) AND (p.outs_recorded > 18)) THEN 1
            ELSE 0
        END) AS quality_starts,
    sum(p.strikeouts) AS strikeouts,
    sum(p.walks) AS walks,
    sum(p.home_runs_allowed) AS home_runs_allowed,
    sum(p.hits_allowed) AS hits_allowed,
    sum(p.hit_by_pitches) AS hit_by_pitches,
    round((((9)::numeric * sum(p.runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS earned_run_average,
    round((((9)::numeric * sum(p.walks)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS walks_per_9,
    round((((9)::numeric * sum(p.hits_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS hits_per_9,
    round((((9)::numeric * sum(p.strikeouts)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS strikeouts_per_9,
    round((((9)::numeric * sum(p.home_runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS home_runs_per_9,
	round(((sum(p.walks)+sum(p.hits_allowed))/(sum(p.outs_recorded) / (3)::numeric)),3) AS whip,
	case
		WHEN sum(p.walks) = 0 THEN sum(p.strikeouts) ELSE round(sum(p.strikeouts)/sum(p.walks),2)
	end AS strikeouts_per_walk
   FROM (data.pitching_stats_all_appearances p
     JOIN data.players_info_expanded_all a ON ((((a.player_id)::text = (p.player_id)::text) AND (a.valid_until IS NULL))))
  WHERE ((p.is_postseason) AND (p.season > 0))
  GROUP BY a.player_name, p.player_id
  WITH NO DATA;
 
--
-- Name: pitching_stats_player_season; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.pitching_stats_player_season AS
 SELECT a.player_name,
    p.player_id,
    p.season,
    p.team_id,
	t.nickname as team,
	t.valid_from as team_valid_from,
	t.valid_until as team_valid_until,
    count(1) AS games,
    sum(p.win) AS wins,
    sum(p.loss) AS losses,
	CASE
		WHEN (sum(p.win) + sum(p.loss) = 0) THEN NULL::numeric
		ELSE round(sum(p.win)::numeric / (sum(p.win)::numeric + sum(p.loss)::numeric), 2)
	END AS win_pct,
    sum(p.pitches_thrown) AS pitches_thrown,
    sum(p.batters_faced) AS batters_faced,
    sum(p.outs_recorded) AS outs_recorded,
    round((floor((sum(p.outs_recorded) / (3)::numeric)) + (mod(sum(p.outs_recorded), (3)::numeric) / (10)::numeric)), 1) AS innings,
    sum(p.runs_allowed) AS runs_allowed,
    sum(
        CASE
            WHEN (p.runs_allowed = (0)::numeric) THEN 1
            ELSE 0
        END) AS shutouts,
    sum(
        CASE
            WHEN ((p.runs_allowed < (4)::numeric) AND (p.outs_recorded > 18)) THEN 1
            ELSE 0
        END) AS quality_starts,
    sum(p.strikeouts) AS strikeouts,
    sum(p.walks) AS walks,
    sum(p.home_runs_allowed) AS home_runs_allowed,
    sum(p.hits_allowed) AS hits_allowed,
    sum(p.hit_by_pitches) AS hit_by_pitches,
    round((((9)::numeric * sum(p.runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS earned_run_average,
    round((((9)::numeric * sum(p.walks)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS walks_per_9,
    round((((9)::numeric * sum(p.hits_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS hits_per_9,
    round((((9)::numeric * sum(p.strikeouts)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS strikeouts_per_9,
    round((((9)::numeric * sum(p.home_runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS home_runs_per_9,
	round(((sum(p.walks)+sum(p.hits_allowed))/(sum(p.outs_recorded) / (3)::numeric)),3) AS whip,
	case
		WHEN sum(p.walks) = 0 THEN sum(p.strikeouts) ELSE round(sum(p.strikeouts)/sum(p.walks),2)
	end AS strikeouts_per_walk
   FROM (data.pitching_stats_all_appearances p
     JOIN data.players_info_expanded_all a ON ((((a.player_id)::text = (p.player_id)::text) AND (a.valid_until IS NULL)))
	 JOIN data.teams_info_expanded_all t on (p.team_id = t.team_id and t.valid_until is null))
  WHERE ((NOT p.is_postseason) AND (p.season > 0))
  GROUP BY a.player_name, p.player_id, p.season, p.team_id, t.nickname, t.valid_from, t.valid_until
  WITH NO DATA;
  
--
-- Name: pitching_stats_player_season_combined; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.pitching_stats_player_season_combined AS
 SELECT a.player_name,
    p.player_id,
    p.season,
    count(1) AS games,
    sum(p.win) AS wins,
    sum(p.loss) AS losses,
	CASE
		WHEN (sum(p.win) + sum(p.loss) = 0) THEN NULL::numeric
		ELSE round(sum(p.win)::numeric / (sum(p.win)::numeric + sum(p.loss)::numeric), 2)
	END AS win_pct,
    sum(p.pitches_thrown) AS pitches_thrown,
    sum(p.batters_faced) AS batters_faced,
    sum(p.outs_recorded) AS outs_recorded,
    round((floor((sum(p.outs_recorded) / (3)::numeric)) + (mod(sum(p.outs_recorded), (3)::numeric) / (10)::numeric)), 1) AS innings,
    sum(p.runs_allowed) AS runs_allowed,
    sum(
        CASE
            WHEN (p.runs_allowed = (0)::numeric) THEN 1
            ELSE 0
        END) AS shutouts,
    sum(
        CASE
            WHEN ((p.runs_allowed < (4)::numeric) AND (p.outs_recorded > 18)) THEN 1
            ELSE 0
        END) AS quality_starts,
    sum(p.strikeouts) AS strikeouts,
    sum(p.walks) AS walks,
    sum(p.home_runs_allowed) AS home_runs_allowed,
    sum(p.hits_allowed) AS hits_allowed,
    sum(p.hit_by_pitches) AS hit_by_pitches,
    round((((9)::numeric * sum(p.runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS earned_run_average,
    round((((9)::numeric * sum(p.walks)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS walks_per_9,
    round((((9)::numeric * sum(p.hits_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS hits_per_9,
    round((((9)::numeric * sum(p.strikeouts)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS strikeouts_per_9,
    round((((9)::numeric * sum(p.home_runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS home_runs_per_9,
	round(((sum(p.walks)+sum(p.hits_allowed))/(sum(p.outs_recorded) / (3)::numeric)),3) AS whip,
	case
		WHEN sum(p.walks) = 0 THEN sum(p.strikeouts) ELSE round(sum(p.strikeouts)/sum(p.walks),2)
	end AS strikeouts_per_walk
   FROM data.pitching_stats_all_appearances p
     JOIN data.players_info_expanded_all a ON (a.player_id = p.player_id AND a.valid_until IS NULL)
  WHERE NOT p.is_postseason AND p.season > 0
  GROUP BY a.player_name, p.player_id, p.season
  WITH NO DATA;

--
-- Name: pitching_stats_team_playoffs_season; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.pitching_stats_team_playoffs_season AS
 SELECT 
    p.season,
    p.team_id,
	t.nickname as team,
	t.valid_from as team_valid_from,
	t.valid_until as team_valid_until,
    count(distinct game_id) AS games,
    sum(p.win) AS wins,
    sum(p.loss) AS losses,
	CASE
		WHEN (sum(p.win) + sum(p.loss) = 0) THEN NULL::numeric
		ELSE round(sum(p.win)::numeric / (sum(p.win)::numeric + sum(p.loss)::numeric), 2)
	END AS win_pct,
    sum(p.pitches_thrown) AS pitches_thrown,
    sum(p.batters_faced) AS batters_faced,
    sum(p.outs_recorded) AS outs_recorded,
    round((floor((sum(p.outs_recorded) / (3)::numeric)) + (mod(sum(p.outs_recorded), (3)::numeric) / (10)::numeric)), 1) AS innings,
    sum(p.runs_allowed) AS runs_allowed,
    sum(
        CASE
            WHEN (p.runs_allowed = (0)::numeric) THEN 1
            ELSE 0
        END) AS shutouts,
    sum(
        CASE
            WHEN ((p.runs_allowed < (4)::numeric) AND (p.outs_recorded > 18)) THEN 1
            ELSE 0
        END) AS quality_starts,
    sum(p.strikeouts) AS strikeouts,
    sum(p.walks) AS walks,
    sum(p.home_runs_allowed) AS home_runs_allowed,
    sum(p.hits_allowed) AS hits_allowed,
    sum(p.hit_by_pitches) AS hit_by_pitches,
    round((((9)::numeric * sum(p.runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS earned_run_average,
    round((((9)::numeric * sum(p.walks)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS walks_per_9,
    round((((9)::numeric * sum(p.hits_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS hits_per_9,
    round((((9)::numeric * sum(p.strikeouts)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS strikeouts_per_9,
    round((((9)::numeric * sum(p.home_runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS home_runs_per_9,
	round(((sum(p.walks)+sum(p.hits_allowed))/(sum(p.outs_recorded) / (3)::numeric)),3) AS whip,
	case
		WHEN sum(p.walks) = 0 THEN sum(p.strikeouts) ELSE round(sum(p.strikeouts)/sum(p.walks),2)
	end AS strikeouts_per_walk
   FROM (data.pitching_stats_all_appearances p
     JOIN data.players_info_expanded_all a ON ((((a.player_id)::text = (p.player_id)::text) AND (a.valid_until IS NULL)))
	 JOIN data.teams_info_expanded_all t on (p.team_id = t.team_id and t.valid_until is null))
  WHERE ((p.is_postseason) AND (p.season > 0))
  GROUP BY p.season, p.team_id, t.nickname, t.valid_from, t.valid_until
  WITH NO DATA;

--
-- Name: pitching_stats_team_season; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.pitching_stats_team_season AS
 SELECT 
    p.season,
    p.team_id,
	t.nickname as team,
	t.valid_from as team_valid_from,
	t.valid_until as team_valid_until,
    count(distinct game_id) AS games,
    sum(p.win) AS wins,
    sum(p.loss) AS losses,
	CASE
		WHEN (sum(p.win) + sum(p.loss) = 0) THEN NULL::numeric
		ELSE round(sum(p.win)::numeric / (sum(p.win)::numeric + sum(p.loss)::numeric), 2)
	END AS win_pct,
    sum(p.pitches_thrown) AS pitches_thrown,
    sum(p.batters_faced) AS batters_faced,
    sum(p.outs_recorded) AS outs_recorded,
    round((floor((sum(p.outs_recorded) / (3)::numeric)) + (mod(sum(p.outs_recorded), (3)::numeric) / (10)::numeric)), 1) AS innings,
    sum(p.runs_allowed) AS runs_allowed,
    sum(
        CASE
            WHEN (p.runs_allowed = (0)::numeric) THEN 1
            ELSE 0
        END) AS shutouts,
    sum(
        CASE
            WHEN ((p.runs_allowed < (4)::numeric) AND (p.outs_recorded > 18)) THEN 1
            ELSE 0
        END) AS quality_starts,
    sum(p.strikeouts) AS strikeouts,
    sum(p.walks) AS walks,
    sum(p.home_runs_allowed) AS home_runs_allowed,
    sum(p.hits_allowed) AS hits_allowed,
    sum(p.hit_by_pitches) AS hit_by_pitches,
    round((((9)::numeric * sum(p.runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS earned_run_average,
    round((((9)::numeric * sum(p.walks)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS walks_per_9,
    round((((9)::numeric * sum(p.hits_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS hits_per_9,
    round((((9)::numeric * sum(p.strikeouts)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS strikeouts_per_9,
    round((((9)::numeric * sum(p.home_runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS home_runs_per_9,
	round(((sum(p.walks)+sum(p.hits_allowed))/(sum(p.outs_recorded) / (3)::numeric)),3) AS whip,
	case
		WHEN sum(p.walks) = 0 THEN sum(p.strikeouts) ELSE round(sum(p.strikeouts)/sum(p.walks),2)
	end AS strikeouts_per_walk
   FROM (data.pitching_stats_all_appearances p
     JOIN data.players_info_expanded_all a ON ((((a.player_id)::text = (p.player_id)::text) AND (a.valid_until IS NULL)))
	 JOIN data.teams_info_expanded_all t on (p.team_id = t.team_id and t.valid_until is null))
  WHERE ((NOT p.is_postseason) AND (p.season > 0))
  GROUP BY p.season, p.team_id, t.nickname, t.valid_from, t.valid_until
  WITH NO DATA;

--
-- Name: pitching_stats_player_playoffs_season; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.pitching_stats_player_playoffs_season AS
 SELECT a.player_name,
    p.player_id,
    p.season,
    p.team_id,
	t.nickname as team,
	t.valid_from as team_valid_from,
	t.valid_until as team_valid_until,
    count(1) AS games,
    sum(p.win) AS wins,
    sum(p.loss) AS losses,
	CASE
		WHEN (sum(p.win) + sum(p.loss) = 0) THEN NULL::numeric
		ELSE round(sum(p.win)::numeric / (sum(p.win)::numeric + sum(p.loss)::numeric), 2)
	END AS win_pct,
    sum(p.pitches_thrown) AS pitches_thrown,
    sum(p.batters_faced) AS batters_faced,
    sum(p.outs_recorded) AS outs_recorded,
    round((floor((sum(p.outs_recorded) / (3)::numeric)) + (mod(sum(p.outs_recorded), (3)::numeric) / (10)::numeric)), 1) AS innings,
    sum(p.runs_allowed) AS runs_allowed,
    sum(
        CASE
            WHEN (p.runs_allowed = (0)::numeric) THEN 1
            ELSE 0
        END) AS shutouts,
    sum(
        CASE
            WHEN ((p.runs_allowed < (4)::numeric) AND (p.outs_recorded > 18)) THEN 1
            ELSE 0
        END) AS quality_starts,
    sum(p.strikeouts) AS strikeouts,
    sum(p.walks) AS walks,
    sum(p.home_runs_allowed) AS home_runs_allowed,
    sum(p.hits_allowed) AS hits_allowed,
    sum(p.hit_by_pitches) AS hit_by_pitches,
    round((((9)::numeric * sum(p.runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS earned_run_average,
    round((((9)::numeric * sum(p.walks)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS walks_per_9,
    round((((9)::numeric * sum(p.hits_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS hits_per_9,
    round((((9)::numeric * sum(p.strikeouts)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS strikeouts_per_9,
    round((((9)::numeric * sum(p.home_runs_allowed)) / (sum(p.outs_recorded) / (3)::numeric)), 2) AS home_runs_per_9,
	round(((sum(p.walks)+sum(p.hits_allowed))/(sum(p.outs_recorded) / (3)::numeric)),3) AS whip,
	case
		WHEN sum(p.walks) = 0 THEN sum(p.strikeouts) ELSE round(sum(p.strikeouts)/sum(p.walks),2)
	end AS strikeouts_per_walk
   FROM (data.pitching_stats_all_appearances p
     JOIN data.players_info_expanded_all a ON ((((a.player_id)::text = (p.player_id)::text) AND (a.valid_until IS NULL)))
	 JOIN data.teams_info_expanded_all t on (p.team_id = t.team_id and t.valid_until is null))
  WHERE ((p.is_postseason) AND (p.season > 0))
  GROUP BY a.player_name, p.player_id, p.season, p.team_id, t.nickname, t.valid_from, t.valid_until
  WITH NO DATA;

--
-- Name: rosters_current; Type: VIEW; Schema: data; Owner: -
--
CREATE VIEW data.rosters_current AS
 SELECT r.valid_from,
    ( SELECT gd1.gameday
           FROM data.gamephase_from_timestamp(r.valid_from) gd1) AS gameday_from,
    ( SELECT gd2.season
           FROM data.gamephase_from_timestamp(r.valid_from) gd2) AS season_from,
    ( SELECT gd3.tournament
           FROM data.gamephase_from_timestamp(r.valid_from) gd3) AS tournament_from,
    ( SELECT gd4.phase_type
           FROM data.gamephase_from_timestamp(r.valid_from) gd4) AS phase_type_from,
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
    ( SELECT gd1.gameday
           FROM data.gamephase_from_timestamp(r.valid_from) gd1) AS gameday_from,
    ( SELECT gd2.season
           FROM data.gamephase_from_timestamp(r.valid_from) gd2) AS season_from,
    ( SELECT gd3.tournament
           FROM data.gamephase_from_timestamp(r.valid_from) gd3) AS tournament_from,
    ( SELECT gd4.phase_type
           FROM data.gamephase_from_timestamp(r.valid_from) gd4) AS phase_type_from,
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
 SELECT 
	NEXTVAL('DATA.running_stats_all_events_id_seq') as running_stats_all_events_id,	
	geb.runner_id AS player_id,
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
-- Name: running_stats_player_lifetime; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.running_stats_player_lifetime AS
 SELECT rs.player_id,
    p.player_name,
    sum(rs.was_base_stolen) AS stolen_bases,
    sum(rs.was_caught_stealing) AS caught_stealing,
    sum(rs.runner_scored) AS runs
   FROM (data.running_stats_all_events rs
     JOIN data.players_info_expanded_all p ON ((((rs.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
  WHERE ((rs.day < 99) AND (rs.season > 0))
  GROUP BY rs.player_id, p.player_name
  WITH NO DATA;
  
--
-- Name: running_stats_player_playoffs_lifetime; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.running_stats_player_playoffs_lifetime AS
 SELECT rs.player_id,
    p.player_name,
    sum(rs.was_base_stolen) AS stolen_bases,
    sum(rs.was_caught_stealing) AS caught_stealing,
    sum(rs.runner_scored) AS runs
   FROM (data.running_stats_all_events rs
     JOIN data.players_info_expanded_all p ON ((((rs.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
  WHERE ((rs.day > 98) AND (rs.season > 0))
  GROUP BY rs.player_id, p.player_name
  WITH NO DATA;  
  
--
-- Name: running_stats_player_season; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.running_stats_player_season AS
 SELECT rs.player_id,
	p.player_name, 
	(SELECT DISTINCT u.url_slug FROM DATA.players u WHERE rs.player_id = u.player_id AND p.player_name = u.player_name) AS url_slug,
	rs.team_id,
	t.nickname AS team,
	t.valid_from AS team_valid_from,
	t.valid_until AS team_valid_until,
    rs.season,
    sum(rs.was_base_stolen) AS stolen_bases,
    sum(rs.was_caught_stealing) AS caught_stealing,
    sum(rs.runner_scored) AS runs
   FROM ((data.running_stats_all_events rs
     JOIN data.players_info_expanded_all p ON ((((rs.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
     LEFT JOIN data.teams_info_expanded_all t ON ((((rs.team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
  WHERE ((rs.day < 99) AND (rs.season > 0))
  GROUP BY rs.player_id, rs.season, rs.team_id, t.nickname, t.valid_from, t.valid_until, p.player_name
  WITH NO DATA;
  
--
-- Name: running_stats_player_season_combined; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.running_stats_player_season_combined AS
 SELECT rs.player_id,
	p.player_name, 
	(SELECT DISTINCT u.url_slug FROM DATA.players u WHERE rs.player_id = u.player_id AND p.player_name = u.player_name) AS url_slug,
    rs.season,
    sum(rs.was_base_stolen) AS stolen_bases,
    sum(rs.was_caught_stealing) AS caught_stealing,
    sum(rs.runner_scored) AS runs
   FROM data.running_stats_all_events rs
     JOIN data.players_info_expanded_all p ON (rs.player_id = p.player_id AND p.valid_until IS NULL)
  WHERE ((rs.day < 99) AND (rs.season > 0))
  GROUP BY rs.player_id, rs.season, p.player_name
  WITH NO DATA;

--
-- Name: running_stats_team_season; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.running_stats_team_season AS
 SELECT t.nickname AS team,
	rs.team_id,
    rs.season,
    sum(rs.was_base_stolen) AS stolen_bases,
    sum(rs.was_caught_stealing) AS caught_stealing,
    sum(rs.runner_scored) AS runs
   FROM (data.running_stats_all_events rs
     JOIN data.teams_info_expanded_all t ON (((rs.team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL)))
  WHERE ((rs.day < 99) AND (rs.season > 0))
  GROUP BY rs.team_id, rs.season, team
  WITH NO DATA;
  
--
-- Name: running_stats_team_playoffs_season; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.running_stats_team_playoffs_season AS
 SELECT t.nickname AS team,
	rs.team_id,
    rs.season,
    sum(rs.was_base_stolen) AS stolen_bases,
    sum(rs.was_caught_stealing) AS caught_stealing,
    sum(rs.runner_scored) AS runs
   FROM (data.running_stats_all_events rs
     JOIN data.teams_info_expanded_all t ON (((rs.team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL)))
  WHERE ((rs.day >= 99) AND (rs.season > 0))
  GROUP BY rs.team_id, rs.season, team
  WITH NO DATA;

--
-- Name: running_stats_player_playoffs_season; Type: MATERIALIZED VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.running_stats_player_playoffs_season AS
 SELECT rs.player_id,
	p.player_name, 
	(SELECT DISTINCT u.url_slug FROM DATA.players u WHERE rs.player_id = u.player_id AND p.player_name = u.player_name) AS url_slug,
	rs.team_id,
	t.nickname AS team,
	t.valid_from AS team_valid_from,
	t.valid_until AS team_valid_until,
    rs.season,
    sum(rs.was_base_stolen) AS stolen_bases,
    sum(rs.was_caught_stealing) AS caught_stealing,
    sum(rs.runner_scored) AS runs
   FROM ((data.running_stats_all_events rs
     JOIN data.players_info_expanded_all p ON ((((rs.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
     JOIN data.teams_info_expanded_all t ON ((((rs.team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
  WHERE ((rs.day > 98) AND (rs.season > 0))
  GROUP BY rs.player_id, rs.season, rs.team_id, t.nickname, t.valid_from, t.valid_until, p.player_name
  WITH NO DATA;
  
--
-- Name: running_stats_player_tournament_lifetime; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.running_stats_player_tournament_lifetime AS
 SELECT rs.player_id,
    p.player_name,
    sum(rs.was_base_stolen) AS stolen_bases,
    sum(rs.was_caught_stealing) AS caught_stealing,
    sum(rs.runner_scored) AS runs
   FROM (data.running_stats_all_events rs
     JOIN data.players_info_expanded_tourney p ON ((((rs.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
  WHERE (rs.season < 0)
  GROUP BY rs.player_id, p.player_name;

--
-- Name: stars_team_all_current; Type: VIEW; Schema: data; Owner: -
--
CREATE VIEW data.stars_team_all_current AS
	SELECT p.team,
	b.batting,
	b.running,
	b.defense,
	p.pitching,
	(b.batting + b.running + b.defense + p.pitching) AS total
	FROM 
	(
		SELECT sum(data.rating_to_star(batting_rating)) AS batting,
		sum(data.rating_to_star(baserunning_rating)) AS running,
		sum(data.rating_to_star(defense_rating)) AS defense,
		team
		FROM data.players_info_expanded_all
		WHERE position_type = 'BATTER'::text
		AND valid_until is null
		GROUP BY team
	) b
	JOIN 
	( 
		SELECT sum(data.rating_to_star(pitching_rating)) AS pitching,
		team
		FROM data.players_info_expanded_all
		WHERE position_type = 'PITCHER'::text
		AND valid_until is null
		GROUP BY team
	) p ON (b.team = p.team)
	GROUP BY p.team, b.batting, b.running, b.defense, p.pitching
	ORDER BY (b.batting + b.running + b.defense + p.pitching) DESC;

--
-- Name: batting_stats_all_events_indx_player_id; Type: INDEX; Schema: data; Owner: -
--
CREATE INDEX batting_stats_all_events_indx_player_id ON data.batting_stats_all_events USING btree (player_id);

--
-- Name: batting_stats_all_events_indx_season; Type: INDEX; Schema: data; Owner: -
--
CREATE INDEX batting_stats_all_events_indx_season ON data.batting_stats_all_events USING btree (season);

--
-- Name: running_stats_all_events_indx_player_id; Type: INDEX; Schema: data; Owner: -
--
CREATE INDEX running_stats_all_events_indx_player_id ON data.running_stats_all_events USING btree (player_id);

--
-- Name: pitching_stats_all_appearances_indx_player_id; Type: INDEX; Schema: data; Owner: -
--
CREATE INDEX pitching_stats_all_appearances_player_id ON data.pitching_stats_all_appearances USING btree (player_id);

--
-- Name: fielder_stats_all_events_indx_player_id; Type: INDEX; Schema: data; Owner: -
--
CREATE INDEX fielder_stats_all_events_player_id ON data.fielder_stats_all_events USING btree (player_id);

--
-- Name: ref_recordboard_player_season_pitching; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW DATA.ref_recordboard_player_season_pitching AS
	SELECT 
	a.season,
	a.player_id, 
	a.player_name, 
	(SELECT DISTINCT u.url_slug FROM DATA.players u WHERE a.player_id = u.player_id AND a.player_name = u.player_name) AS url_slug,
	a.team_id,
	tt.nickname AS team,
	tt.valid_from AS team_valid_from,
	tt.valid_until AS team_valid_until,
	c.*
	FROM 
	(
		SELECT p.*,
		pa.earned_run_average,
		pa.walks_per_9,
		pa.hits_per_9,
		pa.home_runs_per_9,
		pa.strikeouts_per_9,
		pa.era_rank,
		pa.bb9_rank,
		pa.hits9_rank,
		pa.hr9_rank,
		pa.k9_rank
		from
		(
			SELECT x.player_id,
			x.player_name,
			x.team_id,
			season,
			walks,
			ROUND(walks/batters_faced,3) AS walk_percentage,
			strikeouts,
			case
				WHEN walks = 0 THEN strikeouts ELSE round(strikeouts/walks,2)
			end AS strikeouts_per_walk,
			ROUND(strikeouts/batters_faced,3) AS strikeout_percentage,
			runs_allowed,
			hits_allowed,
			home_runs_allowed,
			innings,
			pitches_thrown,
			hit_by_pitches,
			wins,
			losses,
			shutouts,
			quality_starts,
			whip,
			round(wins::DECIMAL/(wins::DECIMAL+losses::DECIMAL),3) AS win_pct,
			rank() OVER (ORDER BY walks DESC) AS bb_rank,
			rank() OVER (ORDER BY round(walks/batters_faced,3)) AS bbpct_rank,		
			rank() OVER (ORDER BY strikeouts DESC) AS k_rank,
			rank() OVER (ORDER BY CASE WHEN walks = 0 THEN strikeouts ELSE round(strikeouts/walks,2) END DESC) AS kbb_rank,
			rank() OVER (ORDER BY round(strikeouts/batters_faced,3) DESC) AS kpct_rank,		
			rank() OVER (ORDER BY runs_allowed DESC) AS runs_rank,
			rank() OVER (ORDER BY hits_allowed DESC) AS hits_rank,
			rank() OVER (ORDER BY home_runs_allowed DESC) AS hrs_rank,
			rank() OVER (ORDER BY innings DESC) AS inn_rank,
			rank() OVER (ORDER BY pitches_thrown DESC) AS ptch_rank,
			rank() OVER (ORDER BY hit_by_pitches DESC) AS hbp_rank,
			rank() OVER (ORDER BY wins DESC) AS win_rank,
			rank() OVER (ORDER BY losses DESC) AS loss_rank,
			rank() OVER (ORDER BY shutouts DESC) AS shut_rank,
			rank() OVER (ORDER BY quality_starts DESC) AS qual_rank,
			rank() OVER (ORDER BY whip) AS whip_rank
			FROM DATA.pitching_stats_player_season x
		) p
		LEFT JOIN
		(
			SELECT x.player_id,
			season,
			earned_run_average,
			walks_per_9,
			hits_per_9,
			home_runs_per_9,
			strikeouts_per_9,
			rank() OVER (ORDER BY earned_run_average) AS era_rank,
			rank() OVER (ORDER BY walks_per_9) AS bb9_rank,
			rank() OVER (ORDER BY hits_per_9) AS hits9_rank,
			rank() OVER (ORDER BY home_runs_per_9) AS hr9_rank,
			rank() OVER (ORDER BY strikeouts_per_9 DESC) AS k9_rank
			FROM DATA.pitching_stats_player_season x
			
			--at least 1 inning per team's regular season games for averaging stats
			WHERE batters_faced > 299
		) pa
		ON (p.player_id = pa.player_id AND p.season = pa.season)
	) a
	JOIN DATA.teams tt 
	ON (tt.team_id = a.team_id AND tt.valid_until IS null)
	CROSS JOIN LATERAL 
	(
		VALUES 
		(a.walks, a.bb_rank, 'walks'),
		(a.walk_percentage, a.bbpct_rank, 'walk_percentage'),
		(a.strikeouts, a.k_rank, 'strikeouts'),
		(a.strikeouts_per_walk, a.kbb_rank, 'strikeouts_per_walk'),
		(a.strikeout_percentage, a.kpct_rank, 'strikeout_percentage'),
		(a.runs_allowed, a.runs_rank, 'runs_allowed'),
		(a.hits_allowed, a.hits_rank, 'hits_allowed'),
		(a.home_runs_allowed, a.hrs_rank, 'home_runs_allowed'),
		(a.innings, a.inn_rank, 'innings'),
		(a.pitches_thrown, a.ptch_rank, 'pitches_thrown'),
		(a.hit_by_pitches, a.hbp_rank, 'hit_by_pitches'),
		(a.wins, a.win_rank, 'wins'),
		(a.losses, a.loss_rank, 'losses'),
		(a.shutouts, a.shut_rank, 'shutouts'),
		(a.quality_starts, a.qual_rank, 'quality_starts'),
		(a.earned_run_average, a.era_rank, 'earned_run_average'),
		(a.walks_per_9, a.bb9_rank, 'walks_per_9'),
		(a.hits_per_9, a.hits9_rank, 'hits_per_9'),
		(a.home_runs_per_9, a.hr9_rank, 'home_runs_per_9'),
		(a.strikeouts_per_9, a.k9_rank, 'strikeouts_per_9')
	) AS c(value, rank, stat)
	WHERE c.rank = 1
	ORDER BY c.stat, a.season, a.player_name;	

--
-- Name: ref_recordboard_player_season_batting; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW DATA.ref_recordboard_player_season_batting AS
	SELECT 
	a.season,
	a.player_id, 
	a.player_name, 
	(SELECT DISTINCT u.url_slug FROM DATA.players u WHERE a.player_id = u.player_id AND a.player_name = u.player_name) AS url_slug,
	a.team_id,
	tt.nickname AS team,
	tt.valid_from AS team_valid_from,
	tt.valid_until AS team_valid_until,
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
			x.player_name,
			x.team_id,
			season,
			hits_risp,
			walks,
			doubles,
			triples,
			quadruples,
			home_runs,
			total_bases,
			hits,
			runs_batted_in,
			sacrifice_bunts,
			sacrifice_flies,
			strikeouts,
			hit_by_pitches,
			gidp,
			rank() OVER (ORDER BY hits_risp DESC) AS hits_risp_rank,
			rank() OVER (ORDER BY walks DESC) AS bb_rank,
			rank() OVER (ORDER BY doubles DESC) AS dbl_rank,
			rank() OVER (ORDER BY triples DESC) AS trp_rank,
			rank() OVER (ORDER BY home_runs DESC) AS hr_rank,
			rank() OVER (ORDER BY total_bases DESC) AS tb_rank,
			rank() OVER (ORDER BY quadruples DESC) AS qd_rank,
			rank() OVER (ORDER BY hits DESC) AS hits_rank,
			rank() OVER (ORDER BY runs_batted_in DESC) AS rbi_rank,
			rank() OVER (ORDER BY x.sacrifice_bunts DESC) AS sacbunts_rank,
	      rank() OVER (ORDER BY x.sacrifice_flies DESC) AS sacflies_rank,
			rank() OVER (ORDER BY strikeouts DESC) AS k_rank,
			rank() OVER (ORDER BY hit_by_pitches DESC) AS hbp_rank,
			rank() OVER (ORDER BY gidp DESC) AS gidp_rank
			FROM DATA.batting_stats_player_season x
		) b
		LEFT JOIN
		(
			SELECT y.player_id,
			season,
			on_base_percentage,
			slugging,
			batting_average,
			on_base_slugging,
			rank() OVER (ORDER BY on_base_percentage DESC) AS obp_rank,
			rank() OVER (ORDER BY slugging DESC) AS slugging_rank,
			rank() OVER (ORDER BY batting_average DESC) AS ba_rank,           
			rank() OVER (ORDER BY on_base_slugging DESC) AS ops_rank
			FROM DATA.batting_stats_player_season y
			WHERE plate_appearances > 399
		) ba
		ON (b.player_id = ba.player_id AND b.season = ba.season)
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
		) r
		ON (b.player_id = r.player_id AND b.season = r.season)
	) a
	JOIN DATA.teams tt 
	ON (tt.team_id = a.team_id AND tt.valid_until IS null)
	CROSS JOIN LATERAL 
	(
		VALUES 
		(a.on_base_percentage, a.obp_rank, 'on_base_percentage'),
		(a.slugging, a.slugging_rank, 'slugging'),
		(a.batting_average,a.ba_rank,'batting_average'), 
		(a.on_base_slugging,a.ops_rank,'on_base_slugging'),
		(a.hits_risp,a.hits_risp_rank,'hits_risp'), 
		(a.walks,a.bb_rank,'walks'), 
		(a.doubles,a.dbl_rank,'doubles'), 
		(a.triples,a.trp_rank,'triples'), 
		(a.quadruples,a.qd_rank,'quadruples'),
		(a.home_runs,a.hr_rank,'home_runs'), 
		(a.total_bases,a.tb_rank,'total_bases'), 
		(a.hits,a.hits_rank,'hits'), 
		(a.runs_batted_in,a.rbi_rank,'runs_batted_in'), 
		(a.sacrifice_bunts,a.sacbunts_rank,'sacrifice_bunts'), 
		(a.sacrifice_flies,a.sacflies_rank,'sacrifice_flies'),  
		(a.strikeouts,a.k_rank,'strikeouts'),
		(a.hit_by_pitches,a.hbp_rank,'hit_by_pitches'),
		(a.gidp,a.gidp_rank,'gidp'),
		(a.runs,a.runs_rank,'runs_scored'),
		(a.stolen_bases,a.sb_rank,'stolen_bases'),
		(a.caught_stealing,a.cs_rank,'caught_stealing')
	) AS c(value, rank, stat)
	WHERE c.rank = 1
	ORDER BY c.stat, a.season, a.player_name;	
	
--
-- Name: ref_leaderboard_lifetime_batting; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW DATA.ref_leaderboard_lifetime_batting AS
	SELECT distinct
	a.player_id, 
	p.player_name, 
	p.url_slug,
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
			hits_risp,
			walks,
			doubles,
			triples,
			quadruples,
			home_runs,
			total_bases,
			hits,
			runs_batted_in,
			sacrifice_bunts,
			sacrifice_flies,
			strikeouts,
			hit_by_pitches,
			gidp,
			rank() OVER (ORDER BY hits_risp DESC) AS hits_risp_rank,
			rank() OVER (ORDER BY walks DESC) AS bb_rank,
			rank() OVER (ORDER BY doubles DESC) AS dbl_rank,
			rank() OVER (ORDER BY triples DESC) AS trp_rank,
			rank() OVER (ORDER BY home_runs DESC) AS hr_rank,
			rank() OVER (ORDER BY total_bases DESC) AS tb_rank,
			rank() OVER (ORDER BY quadruples DESC) AS qd_rank,
			rank() OVER (ORDER BY hits DESC) AS hits_rank,
			rank() OVER (ORDER BY runs_batted_in DESC) AS rbi_rank,
			rank() OVER (ORDER BY x.sacrifice_bunts DESC) AS sacbunts_rank,
			rank() OVER (ORDER BY x.sacrifice_flies DESC) AS sacflies_rank,
			rank() OVER (ORDER BY strikeouts DESC) AS k_rank,
			rank() OVER (ORDER BY hit_by_pitches DESC) AS hbp_rank,
			rank() OVER (ORDER BY gidp DESC) AS gidp_rank
			FROM DATA.batting_stats_player_lifetime x
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
			FROM DATA.batting_stats_player_lifetime y
			WHERE plate_appearances > 399
		) ba
		ON (b.player_id = ba.player_id)
		LEFT JOIN
		(
			SELECT z.player_id,
			runs,
			stolen_bases,
			caught_stealing,
			rank() OVER (ORDER BY runs DESC) AS runs_rank,
			rank() OVER (ORDER BY stolen_bases DESC) AS sb_rank,
			rank() OVER (ORDER BY caught_stealing DESC) AS cs_rank
			FROM DATA.running_stats_player_lifetime z
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
		(a.hits_risp,a.hits_risp_rank,'hits_risp'), 
		(a.walks,a.bb_rank,'walks'), 
		(a.doubles,a.dbl_rank,'doubles'), 
		(a.triples,a.trp_rank,'triples'), 
		(a.quadruples,a.qd_rank,'quadruples'),
		(a.home_runs,a.hr_rank,'home_runs'), 
		(a.total_bases,a.tb_rank,'total_bases'), 
		(a.hits,a.hits_rank,'hits'), 
		(a.runs_batted_in,a.rbi_rank,'runs_batted_in'), 
		(a.sacrifice_bunts,a.sacbunts_rank,'sacrifice_bunts'), 
		(a.sacrifice_flies,a.sacflies_rank,'sacrifice_flies'), 
		(a.strikeouts,a.k_rank,'strikeouts'),
		(a.hit_by_pitches,a.hbp_rank,'hit_by_pitches'),
		(a.gidp,a.gidp_rank,'gidp'),
		(a.runs,a.runs_rank,'runs_scored'),
		(a.stolen_bases,a.sb_rank,'stolen_bases'),
		(a.caught_stealing,a.cs_rank,'caught_stealing')
	) AS c(value, rank, stat)
	JOIN data.players_info_expanded_all p ON (a.player_id = p.player_id AND p.valid_until IS null)
	WHERE c.rank <= 10 
	ORDER BY c.stat, c.rank, p.player_name;	
	
--
-- Name: ref_leaderboard_lifetime_pitchng; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW DATA.ref_leaderboard_lifetime_pitching AS
	SELECT 
	a.player_id, 
	p.player_name, 
	p.url_slug,
	c.*
	FROM 
	(
		SELECT p.*,
		pa.earned_run_average,
		pa.walks_per_9,
		pa.hits_per_9,
		pa.home_runs_per_9,
		pa.strikeouts_per_9,
		pa.strikeouts_per_walk,
		pa.walk_percentage,
		pa.era_rank,
		pa.bb9_rank,
		pa.hits9_rank,
		pa.hr9_rank,
		pa.k9_rank,
		pa.kbb_rank,
		pa.bbpct_rank
		from
		(
			SELECT x.player_id,
			walks,
			strikeouts,
			ROUND(strikeouts/batters_faced,3) AS strikeout_percentage,
			runs_allowed,
			hits_allowed,
			home_runs_allowed,
			innings,
			pitches_thrown,
			hit_by_pitches,
			wins,
			losses,
			shutouts,
			quality_starts,
			whip,
			round(wins::DECIMAL/(wins::DECIMAL+losses::DECIMAL),3) AS win_pct,
			rank() OVER (ORDER BY walks DESC) AS bb_rank,		
			rank() OVER (ORDER BY strikeouts DESC) AS k_rank,
			rank() OVER (ORDER BY round(strikeouts/batters_faced,3) DESC) AS kpct_rank,		
			rank() OVER (ORDER BY runs_allowed DESC) AS runs_rank,
			rank() OVER (ORDER BY hits_allowed DESC) AS hits_rank,
			rank() OVER (ORDER BY home_runs_allowed DESC) AS hrs_rank,
			rank() OVER (ORDER BY innings DESC) AS inn_rank,
			rank() OVER (ORDER BY pitches_thrown DESC) AS ptch_rank,
			rank() OVER (ORDER BY hit_by_pitches DESC) AS hbp_rank,
			rank() OVER (ORDER BY wins DESC) AS win_rank,
			rank() OVER (ORDER BY losses DESC) AS loss_rank,
			rank() OVER (ORDER BY shutouts DESC) AS shut_rank,
			rank() OVER (ORDER BY quality_starts DESC) AS qual_rank,
			rank() OVER (ORDER BY whip) AS whip_rank
			FROM DATA.pitching_stats_player_lifetime x
		) p
		LEFT JOIN
		(
			SELECT x.player_id,
			earned_run_average,
			walks_per_9,
			hits_per_9,
			home_runs_per_9,
			strikeouts_per_9,
			case
				WHEN walks = 0 THEN strikeouts ELSE round(strikeouts/walks,2)
			end AS strikeouts_per_walk,			
			ROUND(walks/batters_faced,3) AS walk_percentage,
			rank() OVER (ORDER BY earned_run_average) AS era_rank,
			rank() OVER (ORDER BY walks_per_9) AS bb9_rank,
			rank() OVER (ORDER BY hits_per_9) AS hits9_rank,
			rank() OVER (ORDER BY home_runs_per_9) AS hr9_rank,
			rank() OVER (ORDER BY strikeouts_per_9 DESC) AS k9_rank,
			rank() OVER (ORDER BY CASE WHEN walks = 0 THEN strikeouts ELSE round(strikeouts/walks,2) END DESC) AS kbb_rank,
			rank() OVER (ORDER BY round(walks/batters_faced,3)) AS bbpct_rank
			FROM DATA.pitching_stats_player_lifetime x
			WHERE batters_faced > 699
		) pa
		ON (p.player_id = pa.player_id)
	) a
	CROSS JOIN LATERAL 
	(
		VALUES 
		(a.walks, a.bb_rank, 'walks'),
		(a.walk_percentage, a.bbpct_rank, 'walk_percentage'),
		(a.strikeouts, a.k_rank, 'strikeouts'),
		(a.strikeout_percentage, a.kpct_rank, 'strikeout_percentage'),
		(a.runs_allowed, a.runs_rank, 'runs_allowed'),
		(a.hits_allowed, a.hits_rank, 'hits_allowed'),
		(a.home_runs_allowed, a.hrs_rank, 'home_runs_allowed'),
		(a.innings, a.inn_rank, 'innings'),
		(a.pitches_thrown, a.ptch_rank, 'pitches_thrown'),
		(a.hit_by_pitches, a.hbp_rank, 'hit_by_pitches'),
		(a.wins, a.win_rank, 'wins'),
		(a.losses, a.loss_rank, 'losses'),
		(a.shutouts, a.shut_rank, 'shutouts'),
		(a.quality_starts, a.qual_rank, 'quality_starts'),
		(a.earned_run_average, a.era_rank, 'earned_run_average'),
		(a.walks_per_9, a.bb9_rank, 'walks_per_9'),
		(a.hits_per_9, a.hits9_rank, 'hits_per_9'),
		(a.home_runs_per_9, a.hr9_rank, 'home_runs_per_9'),
		(a.strikeouts_per_9, a.k9_rank, 'strikeouts_per_9'),
		(a.strikeouts_per_walk, a.kbb_rank, 'strikeouts_per_walk')
	) AS c(value, rank, stat)
	JOIN data.players_info_expanded_all p ON (a.player_id = p.player_id AND p.valid_until IS NULL)
	WHERE c.rank <= 10 
	ORDER BY c.stat, c.rank, p.player_name;	

CREATE UNIQUE INDEX ON data.player_debuts (player_debuts_id);
CREATE UNIQUE INDEX ON data.players_info_expanded_all (players_info_expanded_all_id);
CREATE UNIQUE INDEX ON data.players_info_expanded_tourney (players_info_expanded_tourney_id);
CREATE UNIQUE INDEX ON data.batting_stats_all_events (batting_stats_all_events_id);
CREATE UNIQUE INDEX ON data.batting_stats_player_single_game (batting_stats_player_single_game_id);
CREATE UNIQUE INDEX ON data.batting_stats_player_season (player_id, season, team_id);
CREATE UNIQUE INDEX ON data.batting_stats_player_season_combined (player_id, season);
CREATE UNIQUE INDEX ON data.batting_stats_player_playoffs_season (player_id, season, team_id);
CREATE UNIQUE INDEX ON data.batting_stats_player_playoffs_lifetime (player_id);
CREATE UNIQUE INDEX ON data.batting_stats_player_lifetime (player_id);
CREATE UNIQUE INDEX ON data.batting_stats_team_season (team_id, season);
CREATE UNIQUE INDEX ON data.batting_stats_team_playoffs_season (team_id, season);
CREATE UNIQUE INDEX ON data.fielder_stats_all_events (fielder_stats_all_events_id);
CREATE UNIQUE INDEX ON data.pitching_stats_all_appearances (pitching_stats_all_appearances_id);
CREATE UNIQUE INDEX ON data.pitching_stats_player_season (player_id, season, team_id);
CREATE UNIQUE INDEX ON data.pitching_stats_player_season_combined (player_id, season);
CREATE UNIQUE INDEX ON data.pitching_stats_player_playoffs_season (player_id, season, team_id);
CREATE UNIQUE INDEX ON data.pitching_stats_player_lifetime (player_id);
CREATE UNIQUE INDEX ON data.pitching_stats_player_playoffs_lifetime (player_id);
CREATE UNIQUE INDEX ON data.pitching_stats_team_season (team_id, season);
CREATE UNIQUE INDEX ON data.pitching_stats_team_playoffs_season (team_id, season);
CREATE UNIQUE INDEX ON data.running_stats_all_events (running_stats_all_events_id);
CREATE UNIQUE INDEX ON data.running_stats_player_season (player_id, season, team_id);
CREATE UNIQUE INDEX ON data.running_stats_player_season_combined (player_id, season);
CREATE UNIQUE INDEX ON data.running_stats_player_playoffs_season (player_id, season, team_id);
CREATE UNIQUE INDEX ON data.running_stats_team_season (team_id, season);
CREATE UNIQUE INDEX ON data.running_stats_team_playoffs_season (team_id, season);
CREATE UNIQUE INDEX ON data.running_stats_player_lifetime (player_id);
CREATE UNIQUE INDEX ON data.running_stats_player_playoffs_lifetime (player_id);
CREATE UNIQUE INDEX ON data.teams_info_expanded_all (team_id, valid_from);