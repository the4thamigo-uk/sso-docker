#!/bin/bash
set -e
. ./env.sh

cmd="$@"
docker exec -e "LINES=$(tput lines)" -e "COLUMNS=$(tput cols)" -ti $MIRACL_CONTAINER sh -c "$cmd"
