#!/bin/bash
set -e
. ./env.sh

from=${@:1:$#-1}
to=${@: -1}

for fn in $from
do
  docker cp "$fn" $SSO_DOCKER_SSO_NAME:"$to"
done
