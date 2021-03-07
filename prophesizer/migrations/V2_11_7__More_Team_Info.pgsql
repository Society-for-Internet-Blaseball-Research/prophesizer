
-- Add some more useful columns to the teams table
ALTER TABLE data.teams
ADD COLUMN stadium_id character varying(36) default '',
ADD COLUMN abbreviation character varying(10) default '',
ADD COLUMN main_color character varying(10) default '',
ADD COLUMN secondary_color character varying(10) default '',
ADD COLUMN emoji character varying default '',
ADD COLUMN slogan character varying default '';

