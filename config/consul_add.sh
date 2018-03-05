#!/bin/bash
set -e

file=$1
key=$2
key=${key#/}
key=${key%/}
cat $file | docker exec -i consul curl -s --request PUT --data-binary @- "http://0.0.0.0:8500/v1/kv/$key"
