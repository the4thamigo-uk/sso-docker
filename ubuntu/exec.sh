#!/bin/bash
set -e
. ./env.sh

cmd="$@"
docker exec -ti $MIRACL_CONTAINER sh -c "$cmd"
