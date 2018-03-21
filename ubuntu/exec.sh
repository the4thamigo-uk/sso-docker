#!/bin/bash
set -e
. ./env.sh

[ -t 1 ] && opts='-ti' || opts='-i'

cmd="$@"
docker exec -e "LINES=$(tput lines)" -e "COLUMNS=$(tput cols)" $opts $SSO_DOCKER_CONTAINER sh -c "$cmd"
