#!/bin/bash
set -e
. ./env.sh

SERVICE=$1
SERVICE_FULL="miracl-$SERVICE"
VERSION=${2:+-$2}

./uninstall.sh $SERVICE
./inst.sh install -y $SERVICE_FULL$VERSION
