--- Grant privileges to the two major roles
--- 'developer' is someone who might be changing the schema and otherwise mucking around in the DB
--- 'datazealot' is someone who might be writing queries for their own research but not changing the schema

DO $$
BEGIN
CREATE ROLE datazealot WITH
  NOLOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION;
EXCEPTION WHEN DUPLICATE_OBJECT THEN
  RAISE NOTICE 'not creating role datazealot -- it already exists';
END
$$;

ALTER ROLE datazealot IN DATABASE ${database} SET statement_timeout TO '10000';
COMMENT ON ROLE datazealot IS 'Average SIBR member who wants to crunch some stats on the DB';

DO $$
BEGIN
CREATE ROLE developer WITH
  NOLOGIN
  NOSUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  NOREPLICATION;
EXCEPTION WHEN DUPLICATE_OBJECT THEN
  RAISE NOTICE 'not creating role developer -- it already exists';
END
$$;

COMMENT ON ROLE developer IS 'Developers actively working on Cauldron/Prophesizer/Datablase';

--- taxa schema

GRANT ALL ON SCHEMA taxa TO developer;
GRANT ALL ON ALL TABLES IN SCHEMA taxa TO developer;
GRANT ALL ON ALL SEQUENCES IN SCHEMA taxa TO developer;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA taxa TO developer;
ALTER DEFAULT PRIVILEGES IN SCHEMA taxa
GRANT ALL ON TABLES TO developer;

GRANT USAGE ON SCHEMA taxa TO datazealot;
GRANT SELECT ON ALL TABLES IN SCHEMA taxa TO datazealot;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA taxa TO datazealot;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA taxa TO datazealot;
ALTER DEFAULT PRIVILEGES IN SCHEMA taxa
GRANT SELECT ON TABLES TO datazealot;

--- data schema

GRANT ALL ON SCHEMA data TO developer;
GRANT ALL ON ALL TABLES IN SCHEMA data TO developer;
GRANT ALL ON ALL SEQUENCES IN SCHEMA data TO developer;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA data TO developer;
ALTER DEFAULT PRIVILEGES IN SCHEMA data
GRANT ALL ON TABLES TO developer;

GRANT USAGE ON SCHEMA data TO datazealot;
GRANT SELECT ON ALL TABLES IN SCHEMA data TO datazealot;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA data TO datazealot;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA data TO datazealot;
ALTER DEFAULT PRIVILEGES IN SCHEMA data
GRANT SELECT ON TABLES TO datazealot;

