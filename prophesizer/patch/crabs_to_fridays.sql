--remove Montgomery from Lovers
DELETE FROM DATA.team_roster 
WHERE player_id = '1ffb1153-909d-44c7-9df1-6ed3a9a45bbd' 
AND team_id = 'b72f3061-f573-40d7-832a-5ad475bd7909';

--fix timestamp for Monty, Sutton, Dreamy to Fridays
UPDATE data.team_roster SET valid_from = '2020-10-18 21:49:09.25' 
where player_id IN ('1ffb1153-909d-44c7-9df1-6ed3a9a45bbd','c0732e36-3731-4f1a-abdc-daa9563b6506','4ecee7be-93e4-4f04-b114-6b333e0e6408') 
and team_id = '979aee4a-6d80-4863-bf1c-ee1a78e06024' AND valid_from = '2020-10-18 19:00:09.443928';