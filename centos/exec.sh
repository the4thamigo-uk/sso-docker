#!/bin/bash
set -e
. ./env.sh

cmd="$@"
docker exec -e "LINES=$(tput lines)" -e "COLUMNS=$(tput cols)" -ti $SSO_DOCKER_CONTAINER sh -c "$cmd"
