#!/bin/bash
set -e
./exec.sh dpkg -s miracl-$1 | grep Version | sed 's/.*: \(.*\)/\1/g'
