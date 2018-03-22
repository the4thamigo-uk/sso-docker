#!/bin/bash
set -e

# select an operating system to test (ubuntu, centos)
SSO_DOCKER_OS=$1

# cd to os folder
cd $SSO_DOCKER_OS

# stop the service
./service.sh srv-idp stop || true

# delete any ldap configuration ...
../ldap/delete.sh ../ldap/users.ldif || true

# remove config file from consul key
../consul/delete.sh srv-idp || true

# remove temporary config file
rm config.json config.remote.json || true

# uninstall the service ...
./uninstall.sh srv-idp || true

# clean up with
./compose.sh down
