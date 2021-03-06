#!/bin/bash
set -e

dir="$(dirname ${BASH_SOURCE[0]})"

cmd="$dir/docker-compose_linux"

platform=`uname`
if [[ $platform = *"MINGW"* ]] || [[ "$platform" = *"CYGWIN"* ]]; then
  cmd="$dir/docker-compose_windows"
fi

# check if our vendored versions loads correctly
# if not, try a local install, if one exists
if ! $cmd --help &> /dev/null; then
  cmd=docker-compose
fi

if [[ $1 = "down" ]]; then
  OPTS="-v"
fi

$cmd -f "$dir/docker-compose.yml" "$1" $OPTS "${@:2}"
