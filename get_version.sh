#!/bin/bash

verlte() {
    [  "$1" = "`echo -e "$1\n$2" | sort -V | head -n1`" ]
}

verlt() {
    [ "$1" = "$2" ] && return 1 || verlte $1 $2
}

docker_version=$(curl -L --fail "https://hub.docker.com/v2/repositories/corvimae/prophesizer/tags/?page_size=1000" | jq '.results | .[] | .name' -r | sed 's/latest//' | sort --version-sort | tail -n 1)

cs_version=$(cat prophesizer.csproj | grep "<Version>" | sed 's/ *<\/*Version>//g')

echo "Docker is at version $docker_version. Project is at version $cs_version."

if verlt $docker_version $cs_version 
then
	echo "Building and Updating."
	echo "image_name=$cs_version" >> $GITHUB_ENV
else
	echo "Not building."
	echo "image_name=abort" >> $GITHUB_ENV
fi
