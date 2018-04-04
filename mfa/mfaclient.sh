#!/bin/bash
set -e

dir="$(dirname ${BASH_SOURCE[0]})"

platform=`uname`
if [[ $platform = *"MINGW"* ]] || [[ "$platform" = *"CYGWIN"* ]]; then
  cmd="$dir/mfaclient_windows"
  if ! [[ -e $cmd ]]; then
    curl -sL  https://github.com/miracl/mfaclient/releases/download/v0.1.0/mfaclient.windows-amd64.tar.gz | tar -xz && mv mfaclient.exe $cmd
  fi
else
  cmd="$dir/mfaclient_linux"
  if ! [[ -e $cmd ]]; then
    curl -sL  https://github.com/miracl/mfaclient/releases/download/v0.1.0/mfaclient.linux-amd64.tar.gz | tar -xz && mv mfaclient $cmd
  fi
fi

$cmd "$@"

