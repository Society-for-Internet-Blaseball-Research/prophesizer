
-- Add some more useful columns to the teams table
ALTER TABLE data.teams
ADD COLUMN stadium_id character varying(36),
ADD COLUMN abbreviation character varying(10),
ADD COLUMN main_color character varying(10),
ADD COLUMN secondary_color character varying(10),
ADD COLUMN emoji character varying,
ADD COLUMN slogan character varying;

