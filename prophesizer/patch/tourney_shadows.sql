--tourney shadows
--because of the change from bullpen/bench to shadows, Coffee Cup teams are creating new records on team_roster

update DATA.team_roster
SET tournament = 0
where team_id IN (SELECT team_id FROM taxa.tournament_teams);