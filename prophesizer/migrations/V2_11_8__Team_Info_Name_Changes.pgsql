
-- Rethought the column names from 2.11.7 and decided to stick with what they were called in team_additional_info
ALTER TABLE data.teams
RENAME COLUMN abbreviation TO team_abbreviation;
ALTER TABLE data.teams
RENAME COLUMN main_color TO team_main_color;
ALTER TABLE data.teams
RENAME COLUMN secondary_color TO team_secondary_color;
ALTER TABLE data.teams
RENAME COLUMN emoji TO team_emoji;
ALTER TABLE data.teams
RENAME COLUMN slogan TO team_slogan;

