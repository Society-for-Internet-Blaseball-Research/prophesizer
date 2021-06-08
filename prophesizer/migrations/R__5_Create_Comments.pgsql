-- LAST UPDATE: 6/7/2021 add-stadium-to-teams

--Public schema
COMMENT ON table public.changelog IS 'Used by Prophesizer to keep track of versioining and migration scripts.  Should be truncated (As well as dropping data and taxa schemas) before a full database refresh.';

--Data schema
COMMENT ON SCHEMA data is 'Base level tables and data from Prophesizer.  Most views/functions are reformation of data tables.';
COMMENT ON table data.chronicler_hash_game_event IS 'Base table populated by Prophesizer.  Used to link data.game_events to Reblase.';
COMMENT ON table data.games IS 'Base table populated by Prophesizer.';
COMMENT ON table data.game_events IS '2nd level table populated by Prophesizer.  Child of data.games.';
COMMENT ON table data.game_event_base_runners IS '2nd level table populated by Prophesizer.  Child of data.game_events.';
COMMENT ON table data.outcomes IS '2nd level table populated by Prophesizer.  Child of data.game_events.';
COMMENT ON table data.players IS 'Base table populated by Prophesizer.';
COMMENT ON table data.player_modifications IS '2nd level table populated by Prophesizer.  Child of data.players.';
COMMENT ON table data.stadiums IS 'Base table populated by Prophesizer.';
COMMENT ON table data.stadium_modifications IS '2nd level table populated by Prophesizer.  Child of data.stadiums.';
COMMENT ON table data.teams IS 'Base table populated by Prophesizer.';
COMMENT ON table data.team_modifications IS '2nd level table populated by Prophesizer.  Child of data.teams.';
COMMENT ON table data.team_roster IS '2nd level table populated by Prophesizer.  Child of data.players and data.teams.';
COMMENT ON table data.time_map IS 'Base table populated by Prophesizer.  Used to determine start/end times for games, phases, seasons.';

--Taxa schema
COMMENT ON SCHEMA taxa IS 'Manually added tables and data for database functionality and improved lookups.  Please request updates/changes in SIBR''s #datablase channel';
COMMENT ON table taxa.attributes IS 'Player attributes.  Descriptions determined over time by SIBR research.  IDs line up to stats value on items.';
COMMENT ON table taxa.blood IS 'Used to label blood text on players_info_expanded_all.';
COMMENT ON table taxa.coffee IS 'Used to label coffee text on players_info_expanded_all.';
COMMENT ON table taxa.divisions IS 'To be deprecated and replaced with data.divisions (currently used on teams_info_expanded_all)';
COMMENT ON table taxa.division_teams IS 'To be deprecated and replaced with data.division_teams (currently used on teams_info_expanded_all)';
COMMENT ON table taxa.leagues IS 'To be deprecated and replaced with data.leagues (currently used on teams_info_expanded_all)';
COMMENT ON table taxa.modifications IS 'Manually pulled on occasion from main.js.  Please note some of these Modifications may still be FK. Last update: 5/4/2021';
COMMENT on table taxa.player_incinerations_unrecorded IS 'Manually input data for pre-dB player incinerations.';
COMMENT ON table taxa.player_url_slugs IS 'Manually created unique player url slugs for initial Wyatt Masoning.';
COMMENT ON table taxa.position_types IS 'Used to label position_type text on players_info_expanded_all.';
COMMENT ON table taxa.team_additional_info IS 'Created by SIBR poll to teams.  Used to add team short name to teams_info_expanded_all.';
