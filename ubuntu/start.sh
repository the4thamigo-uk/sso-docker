#!/bin/bash
set -e
RUN_OPTS=$@
. ./env.sh
docker run $RUN_OPTS --detach --rm --name $MIRACL_CONTAINER -ti $MIRACL_RUN_OPTS $MIRACL_CONTAINER
