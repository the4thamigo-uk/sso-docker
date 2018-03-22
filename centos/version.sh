#!/bin/bash
set -e
./exec.sh "yum info miracl-$1 | grep 'Version\|Release' | tr -d '\n' | sed 's/Version.*: \(.*\)Release.*: \(.*\)/\1-\2\n/g'"
