#!/bin/bash
set -e
source ./env.sh
cmd="$@"
./service.sh $REDIS_SERVICE $cmd
