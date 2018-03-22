#!/bin/bash
set -e
filename=$1
cat $filename | ./compose.sh exec -T ldap ldapadd -c -x -H ldap://0.0.0.0:389 -D "cn=admin,dc=example,dc=com" -w password
