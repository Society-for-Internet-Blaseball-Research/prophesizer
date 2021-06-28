--Clean up time_map to work with our tourney/non-tourney timeline

--
--NOTE: UPDATED 3/9, so Season 12 can be out of the Tournament, curse you Past Me!
--NOTE: UPDATED AGAIN 6/25, the change to Shadows is bringing Cup Shadows players back out again.
--
/*
DELETE FROM data.time_map WHERE first_time in ('2020-12-18 02:05:34.411348','2020-11-16 17:22:13.099255');

INSERT INTO data.time_map
(season, day, phase_id, tournament, first_time)
VALUES
(-1, 15, 99, 0, '2020-12-18 02:05:34.411348'),
(-1, 0, 12, 0, '2020-11-16 17:00:00.000000');
*/
--
--NOTE: No matter how many times I do this, someone will not reset the dB and fix the tourney, so do it by force.
--
UPDATE data.players SET tournament = -1;
UPDATE data.player_modifications SET tournament = -1;
UPDATE data.team_roster SET tournament = -1;

UPDATE data.players SET tournament = 0 WHERE valid_from BETWEEN '2020-11-16 17:00:00' AND '2021-03-01' OR valid_until BETWEEN '2020-11-16 17:00:00' AND '2021-03-01';
UPDATE data.player_modifications SET tournament = 0 WHERE valid_from BETWEEN '2020-11-16 17:00:00' AND '2021-03-01' OR valid_until BETWEEN '2020-11-16 17:00:00' AND '2021-03-01';
update DATA.team_roster SET tournament = 0 where team_id IN (SELECT team_id FROM taxa.tournament_teams); --6/25/2021

--Specifically move Liquid and Uncle out of the Cup
UPDATE data.players SET tournament = -1 WHERE player_id in ('d1a198d6-b05a-47cf-ab8e-39a6fa1ed831','fedbceb8-e2aa-4868-ac35-74cd0445893f');
UPDATE data.player_modifications SET tournament = -1 WHERE modification = 'HARD_BOILED';