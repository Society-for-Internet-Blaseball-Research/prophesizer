--tourney shadows
--because of the change from bullpen/bench to shadows, Coffee Cup teams are creating new records on team_roster

--NOTE: Made redundant by update to tourney_timestamps on 6/25.  I know it ain't great.  Can we remove this eventually?

update DATA.team_roster
SET tournament = 0
where team_id IN (SELECT team_id FROM taxa.tournament_teams);