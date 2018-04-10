#!/bin/bash
set -e

dir="$(dirname ${BASH_SOURCE[0]})"

cmd="$dir/docker-compose_linux"

platform=`uname`
if [[ $platform = *"MINGW"* ]] || [[ "$platform" = *"CYGWIN"* ]]; then
  export COMPOSE_CONVERT_WINDOWS_PATHS=1
  cmd="$dir/docker-compose_windows"
fi

# check if our vendored versions loads correctly
# if not, try a local install, if one exists
if ! $cmd --help &> /dev/null; then
  cmd=docker-compose
fi

$cmd -f "$dir/docker-compose.yml" "$@"

