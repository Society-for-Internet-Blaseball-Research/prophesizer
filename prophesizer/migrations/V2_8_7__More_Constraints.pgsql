

ALTER TABLE ONLY data.players
    ADD CONSTRAINT players_no_dupes UNIQUE (player_id, valid_from);


ALTER TABLE ONLY data.teams
    ADD CONSTRAINT teams_no_dupes UNIQUE (team_id, valid_from);
