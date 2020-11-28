DROP MATERIALIZED VIEW IF EXISTS data.players_ratings CASCADE;
DROP VIEW IF EXISTS data.stars_team_all_current CASCADE;
DROP VIEW IF EXISTS data.running_stats_player_season CASCADE;
DROP VIEW IF EXISTS data.running_stats_player_lifetime CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.running_stats_all_events CASCADE;
DROP VIEW IF EXISTS data.rosters_extended_current CASCADE;
DROP VIEW IF EXISTS data.rosters_current CASCADE;
DROP VIEW IF EXISTS data.players_extended_current CASCADE;
DROP VIEW IF EXISTS data.pitching_stats_player_season CASCADE;
DROP VIEW IF EXISTS data.pitching_stats_player_lifetime CASCADE;
DROP VIEW IF EXISTS data.pitching_records_player_single_game CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.pitching_stats_all_appearances CASCADE;
DROP VIEW IF EXISTS data.fielder_stats_season CASCADE;
DROP VIEW IF EXISTS data.fielder_stats_playoffs_season CASCADE;
DROP VIEW IF EXISTS data.fielder_stats_playoffs_lifetime CASCADE;
DROP VIEW IF EXISTS data.fielder_stats_lifetime CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.fielder_stats_all_events CASCADE;
DROP VIEW IF EXISTS data.charm_counts CASCADE;
DROP VIEW IF EXISTS data.batting_stats_player_season CASCADE;
DROP VIEW IF EXISTS data.batting_stats_player_playoffs_season CASCADE;
DROP VIEW IF EXISTS data.batting_stats_player_lifetime CASCADE;
DROP VIEW IF EXISTS data.batting_records_team_single_game CASCADE;
DROP VIEW IF EXISTS data.batting_records_team_season CASCADE;
DROP VIEW IF EXISTS data.batting_records_team_playoffs_single_game CASCADE;
DROP VIEW IF EXISTS data.batting_records_team_playoffs_season CASCADE;
DROP VIEW IF EXISTS data.batting_records_player_single_game CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.batting_stats_player_single_game CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.batting_stats_all_events CASCADE;
DROP VIEW IF EXISTS data.batting_records_player_season CASCADE;
DROP VIEW IF EXISTS data.batting_records_player_playoffs_single_game CASCADE;
DROP VIEW IF EXISTS data.batting_records_player_playoffs_season CASCADE;
DROP MATERIALIZED VIEW IF EXISTS data.players_info_expanded_all CASCADE;
DROP VIEW IF EXISTS data.player_status_flags CASCADE;
DROP VIEW IF EXISTS data.teams_info_expanded_all CASCADE;
DROP VIEW IF EXISTS data.batting_records_league_season CASCADE;
DROP VIEW IF EXISTS data.batting_records_league_playoffs_season CASCADE;
DROP VIEW IF EXISTS data.batting_records_combined_teams_single_game CASCADE;
DROP VIEW IF EXISTS data.batting_records_combined_teams_playoffs_single_game CASCADE;
DROP INDEX IF EXISTS data.batting_stats_all_events_indx_season CASCADE;
DROP INDEX IF EXISTS data.batting_stats_all_events_indx_player_id CASCADE;
DROP VIEW IF EXISTS data.running_stats_player_tournament_lifetime CASCADE;
DROP VIEW IF EXISTS data.fielder_stats_tournament CASCADE;
DROP VIEW IF EXISTS data.batting_stats_player_tournament_lifetime CASCADE;
DROP VIEW IF EXISTS data.batting_stats_player_tournament CASCADE;
DROP VIEW IF EXISTS data.batting_records_team_tournmament CASCADE;
DROP VIEW IF EXISTS data.batting_records_team_tournament_single_game CASCADE;
DROP VIEW IF EXISTS data.batting_records_team_tournament CASCADE;

--
-- Name: players_ratings; Type: VIEW; Schema: data; Owner: -
--
CREATE MATERIALIZED VIEW data.players_ratings AS
 SELECT p.player_id,
    data.batting_rating_raw(p.tragicness, p.patheticism, p.thwackability, p.divinity, p.moxie, p.musclitude, p.martyrdom) AS batting_rating,
    data.baserunning_rating_raw(p.laserlikeness, p.continuation, p.base_thirst, p.indulgence, p.ground_friction) AS baserunning_rating,
    data.defense_rating_raw(p.omniscience, p.tenaciousness, p.watchfulness, p.anticapitalism, p.chasiness) AS defense_rating,
    data.pitching_rating_raw(p.unthwackability, p.ruthlessness, p.overpowerment, p.shakespearianism, p.coldness) AS pitching_rating,
    data.rating_to_star(data.batting_rating_raw(p.tragicness, p.patheticism, p.thwackability, p.divinity, p.moxie, p.musclitude, p.martyrdom)) AS batting_stars,
    data.rating_to_star(data.baserunning_rating_raw(p.laserlikeness, p.continuation, p.base_thirst, p.indulgence, p.ground_friction)) AS baserunning_stars,
    data.rating_to_star(data.defense_rating_raw(p.omniscience, p.tenaciousness, p.watchfulness, p.anticapitalism, p.chasiness)) AS defense_stars,
    data.rating_to_star(data.pitching_rating_raw(p.unthwackability, p.ruthlessness, p.overpowerment, p.shakespearianism, p.coldness)) AS pitching_stars
   FROM data.players p
  WHERE (p.valid_until IS NULL)
  WITH NO DATA;
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
            WHEN (EXISTS ( SELECT 1
               FROM taxa.tournament_teams xtt
              WHERE ((xtt.team_id)::text = (ts.team_id)::text))) THEN 'tournament'::text
            WHEN (NOT (EXISTS ( SELECT 1
               FROM taxa.division_teams xdt
              WHERE ((xdt.team_id)::text = (ts.team_id)::text)))) THEN 'disbanded'::text
            WHEN (EXISTS ( SELECT 1
               FROM taxa.division_teams xdt
              WHERE (((xdt.team_id)::text = (ts.team_id)::text) AND (xdt.division_id IS NOT NULL) AND (xdt.valid_until IS NULL)))) THEN 'active'::text
            ELSE 'ascended'::text
        END AS current_team_status,
    ts.timestampd AS valid_from,
    lead(ts.timestampd) OVER (PARTITION BY ts.team_id ORDER BY ts.timestampd) AS valid_until,
    ( SELECT gt.gameday
           FROM data.gameday_from_timestamp(ts.timestampd) gt(season, gameday)) AS gameday_from,
    ( SELECT gt.season
           FROM data.gameday_from_timestamp(ts.timestampd) gt(season, gameday)) AS season_from,
    d.division_text AS division,
    d.division_id,
    l.league_text AS league,
    l.league_id,
    xt.tournament_name,
    ( SELECT array_agg(DISTINCT m.modification ORDER BY m.modification) AS array_agg
           FROM data.team_modifications m
          WHERE (((m.team_id)::text = (ts.team_id)::text) AND (m.valid_from <= ts.timestampd) AND (ts.timestampd < COALESCE((m.valid_until)::timestamp with time zone, ((timezone('utc'::text, now()) + '00:00:00.001'::interval))::timestamp with time zone)))
          GROUP BY m.team_id) AS modifications
   FROM (((((((( SELECT DISTINCT x.team_id,
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
                           FROM data.gameday_from_timestamp(COALESCE(tm.valid_from, timezone('utc'::text, now()))) gameday_from_timestamp(season, gameday)) >= 98) AND ((tm.modification)::text = 'PARTY_TIME'::text)))) x) ts
     JOIN data.teams t ON ((((ts.team_id)::text = (t.team_id)::text) AND (t.valid_from <= (ts.timestampd + '00:00:00.001'::interval)) AND (ts.timestampd < COALESCE((t.valid_until)::timestamp with time zone, ((timezone('utc'::text, now()) + '00:00:00.001'::interval))::timestamp with time zone)))))
     LEFT JOIN taxa.team_abbreviations ta ON (((ts.team_id)::text = (ta.team_id)::text)))
     LEFT JOIN taxa.division_teams dt ON ((((ts.team_id)::text = (dt.team_id)::text) AND (dt.valid_from <= (ts.timestampd + '00:00:00.001'::interval)) AND (ts.timestampd < COALESCE((dt.valid_until)::timestamp with time zone, ((timezone('utc'::text, now()) + '00:00:00.001'::interval))::timestamp with time zone)))))
     LEFT JOIN taxa.divisions d ON (((dt.division_id)::text = (d.division_id)::text)))
     LEFT JOIN taxa.leagues l ON ((d.league_id = l.league_db_id)))
     LEFT JOIN taxa.tournament_teams tt ON (((ts.team_id)::text = (tt.team_id)::text)))
     LEFT JOIN taxa.tournaments xt ON ((tt.tournament_db_id = xt.tournament_db_id)))
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
              WHERE (((rc.player_id)::text = (p.player_id)::text) AND (rc.valid_until IS NULL) AND (t.current_team_status = 'active'::text)))) THEN 'active'::text
            WHEN (EXISTS ( SELECT 1
               FROM (data.team_roster rc
                 JOIN data.teams_info_expanded_all t ON (((rc.team_id)::text = (t.team_id)::text)))
              WHERE (((rc.player_id)::text = (p.player_id)::text) AND (rc.valid_until IS NULL) AND (t.current_team_status = 'ascended'::text)))) THEN 'ascended'::text
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
              WHERE (((rc.player_id)::text = (p.player_id)::text) AND (rc.valid_until IS NULL) AND (t.current_team_status = 'ascended'::text))))) AND (NOT (EXISTS ( SELECT 1
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
    ( SELECT gd1.gameday
           FROM data.gameday_from_timestamp(ts.timestampd) gd1(season, gameday)) AS gameday_from,
    ( SELECT gd2.season
           FROM data.gameday_from_timestamp(ts.timestampd) gd2(season, gameday)) AS season_from,
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
    ( SELECT array_agg(DISTINCT m.modification ORDER BY m.modification) AS modifications
           FROM data.player_modifications m
          WHERE (((m.player_id)::text = (ts.player_id)::text) AND (m.valid_from <= ts.timestampd) AND (ts.timestampd < COALESCE(m.valid_until, (timezone('utc'::text, now()) + '00:00:00.001'::interval))))
          GROUP BY m.player_id) AS modifications,
    pr.batting_rating,
    pr.baserunning_rating,
    pr.defense_rating,
    pr.pitching_rating,
    pr.batting_stars,
    pr.baserunning_stars,
    pr.defense_stars,
    pr.pitching_stars
   FROM ((((((((( SELECT DISTINCT x.player_id,
            unnest(x.a) AS timestampd
           FROM ( SELECT DISTINCT players.player_id,
                    ARRAY[players.valid_from, COALESCE(players.valid_until, timezone('utc'::text, now()))] AS a
                   FROM data.players
                UNION
                 SELECT DISTINCT player_modifications.player_id,
                    ARRAY[player_modifications.valid_from, COALESCE(player_modifications.valid_until, timezone('utc'::text, now()))] AS a
                   FROM data.player_modifications
                UNION
                 SELECT DISTINCT team_roster.player_id,
                    ARRAY[team_roster.valid_from, COALESCE(team_roster.valid_until, timezone('utc'::text, now()))] AS a
                   FROM data.team_roster
                  WHERE (NOT ((team_roster.team_id)::text IN ( SELECT tournament_teams.team_id
                           FROM taxa.tournament_teams)))) x) ts
     JOIN data.players p ON ((((p.player_id)::text = (ts.player_id)::text) AND (p.valid_from <= (ts.timestampd + '00:00:00.001'::interval)) AND (ts.timestampd < COALESCE(p.valid_until, (timezone('utc'::text, now()) + '00:00:00.001'::interval))))))
     JOIN data.player_status_flags ps ON (((ts.player_id)::text = (ps.player_id)::text)))
     JOIN data.players_ratings pr ON (((ts.player_id)::text = (pr.player_id)::text)))
     LEFT JOIN data.team_roster r ON ((((ts.player_id)::text = (r.player_id)::text) AND (r.valid_from <= COALESCE(ts.timestampd, timezone('utc'::text, now()))) AND (COALESCE(ts.timestampd, timezone('utc'::text, now())) < COALESCE(r.valid_until, (timezone('utc'::text, now()) + '00:00:00.001'::interval))) AND (NOT ((r.team_id)::text IN ( SELECT tournament_teams.team_id
           FROM taxa.tournament_teams))))))
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
                  WHERE ((ge.runs_batted_in > (0)::numeric) AND (ge.day < 99))
                  GROUP BY 'RBIS'::text, ge.batter_team_id, ge.season) x) y
     JOIN data.teams_info_expanded_all t ON ((((y.team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
  WHERE ((y.this = 1) AND (y.season < 0))
  ORDER BY y.event, y.season, t.nickname;

--
-- Name: batting_records_team_tournament_single_game; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_records_team_tournament_single_game AS
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
                  WHERE ((ge.runs_batted_in >= (0)::numeric) AND (ge.day < 99))
                  GROUP BY ge.game_id, 'RBIS'::text, ge.batter_team_id, ge.season, ge.day) x) y
     JOIN data.teams_info_expanded_all t ON ((((y.team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
  WHERE ((y.this = 1) AND (y.season < 0))
  ORDER BY y.event, y.season, y.day, t.nickname;

--
-- Name: batting_records_team_tournmament; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_records_team_tournmament AS
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
                  WHERE ((ge.runs_batted_in > (0)::numeric) AND (ge.day >= 99))
                  GROUP BY 'RBIS'::text, ge.batter_team_id, ge.season) x) y
     JOIN data.teams_info_expanded_all t ON ((((y.team_id)::text = (t.team_id)::text) AND (t.valid_until IS NULL))))
  WHERE ((y.this = 1) AND (y.season < 0))
  ORDER BY y.event, y.season, t.nickname;


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
  WHERE ((NOT a.is_postseason) AND (a.season > 0))
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
  WHERE ((NOT a.is_postseason) AND (a.season > 0))
  GROUP BY a.player_id, p.player_name, a.season, t.nickname, t.team_id;

--
-- Name: batting_stats_player_tournament; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_player_tournament AS
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
  WHERE ((NOT a.is_postseason) AND (a.season < 0))
  GROUP BY a.player_id, p.player_name, a.season, t.nickname, t.team_id;

--
-- Name: batting_stats_player_tournament_lifetime; Type: VIEW; Schema: data; Owner: -
--

CREATE VIEW data.batting_stats_player_tournament_lifetime AS
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
  WHERE ((NOT a.is_postseason) AND (a.season < 0))
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
  WHERE ((NOT p.is_postseason) AND (p.season > 0))
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
  WHERE ((NOT p.is_postseason) AND (p.season > 0))
  GROUP BY a.player_name, p.player_id, p.season;


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
  WHERE ((rs.day < 99) AND (rs.season > 0))
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
  WHERE ((rs.day < 99) AND (rs.season > 0))
  GROUP BY rs.player_id, rs.season, p.player_name;

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
     JOIN data.players_info_expanded_all p ON ((((rs.player_id)::text = (p.player_id)::text) AND (p.valid_until IS NULL))))
  WHERE (rs.season < 0)
  GROUP BY rs.player_id, p.player_name;

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