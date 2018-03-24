#!/bin/bash
set -e
. ./env.sh

[ -t 0 ] && opts="-e LINES=$(tput lines) -e COLUMNS=$(tput cols) -ti" || opts='-i'

cmd="$@"
docker exec $opts $SSO_DOCKER_SSO_NAME sh -c "$cmd"
