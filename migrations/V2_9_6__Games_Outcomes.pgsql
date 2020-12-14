-- Add an 'outcomes' column to the games table

ALTER TABLE data.games ADD COLUMN IF NOT EXISTS outcomes text[];

