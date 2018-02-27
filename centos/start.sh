#!/bin/bash
set -e
RUN_OPTS=$@
. ./env.sh
docker run $RUN_OPTS --detach --rm --name $MIRACL_CONTAINER -ti --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro $MIRACL_RUN_OPTS $MIRACL_CONTAINER
