#!/bin/bash
set -e
cmd="$@"
./exec.sh "rm $cmd"
