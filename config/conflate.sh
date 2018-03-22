#!/bin/bash
set -e
dir="$(dirname ${BASH_SOURCE[0]})"

platform=`uname`
conflate="conflate_linux"

if [[ $platform = *"MINGW"* ]]; then
   conflate="conflate_windows"
elif [[ "$platform" = *"CYGWIN"* ]]; then
   conflate="conflate_windows"
fi

$dir/$conflate "$@"

