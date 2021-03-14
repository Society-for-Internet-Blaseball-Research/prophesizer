

CREATE TABLE IF NOT EXISTS data.prophesizer_meta (
	prophesizer_meta_id serial PRIMARY KEY,
	major_version integer,
	minor_version integer,
	patch_version integer,
	run_started timestamp,
	run_finished timestamp,
	first_game_event integer,
	last_game_event integer
)