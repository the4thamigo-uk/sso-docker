#!/bin/bash
set -e
docker exec -ti syslog tail -f /var/log/syslog
