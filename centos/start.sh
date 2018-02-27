#!/bin/bash
set -e
. ./env.sh
docker run --detach --rm --name $MIRACL_CONTAINER -ti --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro $MIRACL_RUN_OPTS $MIRACL_CONTAINER
