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

	if(args.length != 2)
	{
		console.error('Please run node dumpschema.js <username> <databasename>');
		process.exit(1);
	}

	if(!await execWithOutput(`pg_dump -U ${args[0]} -c -O -s ${args[1]} > schema.sql`)) process.exit(1);

	console.log(`DB schema dumped to schema.sql`);
	process.exit(0);
})();