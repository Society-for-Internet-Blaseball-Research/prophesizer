#!/usr/bin/env node
const util = require('util');
const fs = require('fs');
const path = require('path');
const exec = util.promisify(require('child_process').exec);

async function execWithOutput(command) {
	const { stdout, stderr } = await exec(command);
	
	if (stdout.trim().length > 0) console.log(stdout);
  
	if (stderr.trim().length > 0) {
	  console.error(stderr);
  
	  return false;
	}
  
	return true;
  }

(async () => {
	const args = process.argv.slice(2);

	if(args.length < 1)
	{
		console.error('Please run "node schema.js <command> <username (default)> <databasename>"');
		console.error('\tValid commands are "dump" to dump the DB\'s current schema to files, and "load" to load the file schemas into the DB');
		console.error('\tIf <username> is not specified, it defaults to "postgres"');
		console.error('\tIf <database> is not specified, it defaults to "blaseball"');
		process.exit(1);
	}

	const command = args[0];
	const username = (args.length > 1) ? args[1] : 'postgres';
	const database = (args.length > 2) ? args[2] : 'blaseball';

	if(command === 'dump')
	{
		// Dump current data so it's not just lost forever
		await execWithOutput(`pg_dump -U ${username} -d ${database} -c --if-exists -E UTF8 -O > data.sql`);
		// Run a wipe_all() to clear out non-taxa tables
		await execWithOutput(`psql -U ${username} -d ${database} -c "CALL data.wipe_all();"`);
		// Since we ran wipe_all() above, do a single dump of public & taxa
		await execWithOutput(`pg_dump -U ${username} -d ${database} -c --if-exists -E UTF8 -O -n "(data|taxa)" > schema.sql`);
		// Re-load data from the data.sql
		await execWithOutput(`psql -U ${username} -d ${database} -f data.sql`);
		
		console.log(`DB schema dumped to schema.sql`);
	}
	else if(command === 'load')
	{
		// Load entire DB from single schema_blaseball file
		await execWithOutput(`psql -U ${username} -d ${database} -f schema.sql`);
	}

	process.exit(0);
})();