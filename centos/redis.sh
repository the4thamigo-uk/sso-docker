#!/bin/bash
set -e
source ./env.sh
cmd="$@"
./service.sh $SSO_DOCKER_REDIS $cmd
