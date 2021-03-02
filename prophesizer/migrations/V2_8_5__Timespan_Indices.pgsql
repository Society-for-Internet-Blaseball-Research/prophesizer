CREATE INDEX IF NOT EXISTS players_indx_player_id_timespan
ON data.players (player_id, valid_from, valid_until DESC);

CREATE INDEX IF NOT EXISTS team_roster_indx_player_id_timespan
ON data.team_roster (player_id, valid_from, valid_until DESC);

CLUSTER data.players USING players_indx_player_id_timespan;

CREATE INDEX IF NOT EXISTS player_modifications_indx_player_id_timespan
ON data.player_modifications (player_id, valid_from, valid_until DESC);

CLUSTER data.player_modifications USING player_modifications_indx_player_id_timespan;