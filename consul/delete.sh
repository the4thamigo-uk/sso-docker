#!/bin/bash
set -e
. ./env.sh
key=$1
key=${key#/}
key=${key%/}
./compose.sh exec -T consul curl -s --request DELETE "http://0.0.0.0:8500/v1/kv/$key"
