--Case Sports, all Wings records should be regular season, not Coffee Cup
update DATA.team_roster
SET tournament = -1 
WHERE player_id = '8d337b47-2a7d-418d-a44e-ef81e401c2ef'
AND team_id = '57ec08cc-0411-4643-b304-0e80dbc15ac7';