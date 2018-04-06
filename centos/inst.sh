#!/bin/bash
set -e

# https://superuser.com/questions/784451/centos-on-docker-how-to-install-doc-files
./exec.sh 'sed -i '/nodocs/d' /etc/yum.conf' || true

./exec.sh "yum $@"
