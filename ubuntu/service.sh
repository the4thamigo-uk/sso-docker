#!/bin/bash
set -e
cmd="$@"
./exec.sh "service $cmd"
