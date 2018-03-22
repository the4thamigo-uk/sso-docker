#!/bin/bash
set -e
filename=$1
cat $filename | grep 'dn:' | sed 's/^dn://' | tac | docker exec -i $(./compose.sh ps -q ldap) ldapdelete -c -x -H ldap://0.0.0.0:389 -D "cn=admin,dc=example,dc=com" -w password
