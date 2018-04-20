#!/bin/bash
service=${1:-*}
./exec.sh tail -f "/var/log/$service.log"
