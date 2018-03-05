#!/bin/bash
set -e
docker exec -i ldap ldapadd -c -x -H ldap://0.0.0.0:389 -D "cn=admin,dc=example,dc=com" -w password
