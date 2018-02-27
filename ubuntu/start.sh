#!/bin/bash
set -e
. ./env.sh
docker run --detach --rm --name $MIRACL_CONTAINER -ti $MIRACL_RUN_OPTS $MIRACL_CONTAINER
