#!/bin/bash
set -e
. ./env.sh
filename=$1

dir="$(dirname ${BASH_SOURCE[0]})"
cat $filename | $dir/conflate.sh --data stdin --expand --format JSON
