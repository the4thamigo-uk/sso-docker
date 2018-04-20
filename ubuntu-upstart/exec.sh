#!/bin/bash
set -e
. ./env.sh

[ -t 0 ] && opts='-ti' || opts='-i'

cmd="$@"
docker exec -e "LINES=$(tput lines)" -e "COLUMNS=$(tput cols)" $opts $SSO_DOCKER_SSO_NAME sh -c "$cmd"
