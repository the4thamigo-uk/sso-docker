#!/bin/bash
set -e
dir="$(dirname ${BASH_SOURCE[0]})"

platform=`uname`
if [[ $platform = *"MINGW"* ]] || [[ "$platform" = *"CYGWIN"* ]]; then
  cmd="$dir/conflate_windows"
  if ! [[ -e $cmd ]]; then
    curl -sL  https://github.com/miracl/conflate/releases/download/0.2.0/conflate.windows-amd64.tar.gz | tar -xz && mv conflate.exe $cmd
  fi
else
  cmd="$dir/conflate_linux"
  if ! [[ -e $cmd ]]; then
    curl -sL  https://github.com/miracl/conflate/releases/download/0.2.0/conflate.linux-amd64.tar.gz | tar -xz && mv conflate $cmd
  fi
fi

$cmd "$@"
