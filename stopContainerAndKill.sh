#!/bin/sh

# Show running script
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" 
echo "  $0"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" && echo 

# Load names to variable
. "$(dirname "$0")/names-docker.sh" && echo

# Stop/kill the container in case it is running 
docker kill $dockerContainerName
