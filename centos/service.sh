#!/bin/bash
set -e
cmd="$@"
./exec.sh "service $cmd && (systemctl status $cmd.service || true)"
