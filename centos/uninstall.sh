#!/bin/bash
set -e
. ./env.sh

SERVICE=$1
SERVICE_FULL="miracl-$SERVICE"

./inst.sh "remove -y $SERVICE_FULL"
