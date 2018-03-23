#!/bin/bash
set -e
dir="$(dirname ${BASH_SOURCE[0]})"

cmd="conflate_linux"

platform=`uname`
if [[ $platform = *"MINGW"* ]] || [[ "$platform" = *"CYGWIN"* ]]; then
   cmd="conflate_windows"
fi

$dir/$cmd "$@"

