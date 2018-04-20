#!/bin/bash
set -e
./exec.sh apt show miracl-$1 | grep Version | sed 's/Version: \(.*\)/\1/g'
