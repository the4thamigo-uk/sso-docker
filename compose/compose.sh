#!/bin/bash
set -e

dir="$(dirname ${BASH_SOURCE[0]})"

"$dir/docker-compose" -f "$dir/docker-compose.yml" "$@"

