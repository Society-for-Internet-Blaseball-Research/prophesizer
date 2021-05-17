
-- Change the "hype" column type from integer to numeric
ALTER TABLE data.stadiums
  ALTER COLUMN hype TYPE numeric
  USING hype::numeric;
