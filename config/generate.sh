#!/bin/bash
set -e
. ./env.sh
filename=$1

dir="$(dirname ${BASH_SOURCE[0]})"
$dir/conflate.sh --data "$filename" --expand --format JSON
