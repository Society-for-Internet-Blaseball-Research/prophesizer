-- LAST UPDATE: 3/5/2021   

DROP PROCEDURE IF EXISTS data.wipe_hourly();
DROP PROCEDURE IF EXISTS data.wipe_events();
DROP PROCEDURE IF EXISTS data.wipe_all();
DROP PROCEDURE IF EXISTS data.refresh_materialized_views();
DROP PROCEDURE IF EXISTS data.refresh_materialized_views_concurrently();

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
-- Name: refresh_materialized_views_concurrently(); Type: PROCEDURE; Schema: data; Owner: -
--
CREATE PROCEDURE data.refresh_materialized_views_concurrently()
    LANGUAGE plpgsql
    AS $$
begin
perform data.refresh_matviews_concurrently();
end;
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
    truncate data.applied_patches;
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
    truncate data.applied_patches;
end;
$$;