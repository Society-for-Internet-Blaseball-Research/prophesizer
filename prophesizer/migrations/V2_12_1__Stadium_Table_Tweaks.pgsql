
-- Add a "hash" column to the stadiums table
ALTER TABLE data.stadiums
ADD COLUMN hash uuid,
DROP COLUMN filthiness,
ALTER COLUMN model DROP NOT NULL;


