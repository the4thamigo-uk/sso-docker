#!/bin/bash
set -e
. ./env.sh
docker build --rm -t $MIRACL_CONTAINER .
