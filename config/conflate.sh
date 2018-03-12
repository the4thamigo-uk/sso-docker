#!/bin/bash
set -e

dir="$( cd "$(dirname "$0")" ; pwd -P )"
platform=`uname`

conflate="./conflate_linux"

if [[ $platform = *"MINGW"* ]]; then
   conflate="conflate_windows"
elif [[ "$platform" = *"CYGWIN"* ]]; then
   conflate="conflate_windows"
fi

$dir/$conflate "$@"

