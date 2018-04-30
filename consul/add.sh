#!/bin/bash
set -e
. ./env.sh
filename=$1
key=$2
key=${key#/}
key=${key%/}
cat $filename | ./compose.sh exec -T consul curl -s --request PUT --data-binary @- "http://0.0.0.0:8500/v1/kv/$key"
