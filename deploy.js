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
  const csProjFileName = path.join(__dirname, 'prophesizer.csproj');
  const version = fs.readFileSync(csProjFileName).toString().split('<Version>')[1].split('</Version>')[0];
  const imageName = `corvimae/prophesizer:${version}`;
  console.log(`Deploying ${imageName}...`);

  const versionExists = (await exec(`docker images -q ${imageName}`)).stdout.trim().length > 0;
  
  if (versionExists && process.argv.indexOf('--force') === -1) {
    console.error(`${imageName} already exists! Did you forget to bump the version number?`);
  }

  if (!await execWithOutput(`docker build -t ${imageName} .`)) process.exit(1)
  if (!await execWithOutput(`docker push ${imageName}`)) process.exit(1)
  if (!await execWithOutput(`cat k8s/deployment.template.yaml | sed "s/{{IMAGE_VERSION}}/${version}/" | kubectl apply -f -`)) process.exit(1)

  console.log(`${imageName} successfully deployed!`);
  process.exit(0);
})();
