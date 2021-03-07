--Clean up time_map to work with our tourney/non-tourney timeline

--
--NOTE: UPDATED 3/5, so Season 12 can be out of the Tournament, curse you Past Me!
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
--NOTE: This will need adjustment and/or another SQL file when S12 starts.
--
UPDATE data.players SET tournament = 0 WHERE valid_from BETWEEN '2020-11-16 17:00:00' AND '2021-03-01' OR valid_until BETWEEN '2020-11-16 17:00:00' AND '2021-03-01';
UPDATE data.player_modifications SET tournament = 0 WHERE valid_from BETWEEN '2020-11-16 17:00:00' AND '2021-03-01' OR valid_until BETWEEN '2020-11-16 17:00:00' AND '2021-03-01';
UPDATE data.team_roster SET tournament = 0 WHERE valid_from BETWEEN '2020-11-16 17:15:00' AND '2021-03-01' OR valid_until BETWEEN '2020-11-16 17:00:00' AND '2021-03-01';