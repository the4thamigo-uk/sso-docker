#!/bin/bash
set -e
cmd="$@"
./exec.sh "ls $cmd"
