#!/bin/bash
set -e

dir="$(dirname ${BASH_SOURCE[0]})"

cmd="docker-compose_linux"

platform=`uname`
if [[ $platform = *"MINGW"* ]] || [[ "$platform" = *"CYGWIN"* ]]; then
   cmd="docker-compose_windows"
fi

"$dir/$cmd" -f "$dir/docker-compose.yml" "$@"

