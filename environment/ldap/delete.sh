#!/bin/bash
set -e
grep 'dn:' | sed 's/^dn://' | tac | docker exec -i ldap ldapdelete -c -x -H ldap://0.0.0.0:389 -D "cn=admin,dc=example,dc=com" -w password
