#!/bin/bash
set -e
file=$1
dir="$( cd "$(dirname "$0")" ; pwd -P )"
. $dir/env.sh
$dir/conflate.sh --data "$file" --expand --format JSON
