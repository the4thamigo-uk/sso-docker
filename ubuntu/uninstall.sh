#!/bin/bash
set -e
. ./env.sh
./inst.sh "remove --purge -y $MIRACL_SERVICE_FULL"
