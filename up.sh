#!/bin/bash
set -e

# select an operating system to test (ubuntu, centos)
SSO_DOCKER_OS=$1

# select a miracl package repository (dev, prd)
SSO_DOCKER_REPO=$2

# cd to os folder
cd $SSO_DOCKER_OS

. ./env.sh

# dump all our options
env | grep SSO_DOCKER

# build the docker compose environment
./compose.sh build

# start the docker compose environment
./compose.sh up -d

# configure the repo
./repo.sh $SSO_DOCKER_REPO

# list the versions of a package in the repo
./versions.sh srv-idp

# install the latest build from the repo ...
./install.sh srv-idp

# ... or specify a particular version with ...
#./install.sh srv-idp 2.1.0-2181

# ... or install package from file 
#./file_install.sh miracl-srv-idp.deb

VERSION=$(./version.sh srv-idp)
echo $VERSION
if [[ $VERSION == 1.* ]]; then
  REMOTECONFIG=srv-idp.1.x.remote.json
  LOCALCONFIG=srv-idp.1.x.local.json
else
  REMOTECONFIG=srv-idp.2.x.remote.json
  LOCALCONFIG=srv-idp.2.x.local.json
fi

# generate a config file from a template
../config/generate.sh ../config/$REMOTECONFIG > config.remote.json

# copy the local config file
cp ../config/$LOCALCONFIG config.json

# copy remote config file to consul key
../consul/add.sh config.remote.json srv-idp

# copy local config pointing to consul key
./cp.sh config.json /etc/srv-idp

# setup any ldap configuration ...
../ldap/delete.sh ../ldap/users.ldif || true
../ldap/add.sh ../ldap/users.ldif

# start the service
# NB: we do explicit stop and start rather than restart to cater for a bug in pre-v2 releases
./service.sh srv-idp stop || true
./service.sh srv-idp start

# access srv-idp
curl $SSO_DOCKER_IDP_BASEURL

# access consul
curl $SSO_DOCKER_CONSUL_BASEURL

# access graphite GUI
curl $SSO_DOCKER_STATSD_BASEURL

# access ldap GUI
curl -k $SSO_DOCKER_LDAPGUI_BASEURL

# tail srv-idp log file on sso machine with
echo
echo
echo "********************************************************************************************"
echo "             You are now monitoring the srv-idp log file on the 'sso' host.                 "
echo "      To cancel, press Ctrl-C and your sso-docker environment will stay running             "
echo "********************************************************************************************"
echo
./logs.sh srv-idp || true

# tail syslog logs with 
echo
echo
echo "********************************************************************************************"
echo "              You are now monitoring the logs in the 'syslog' server host.                  "
echo "      To cancel, press Ctrl-C and your sso-docker environment will stay running             "
echo "********************************************************************************************"
echo
./compose.sh exec syslog tail -f /var/log/syslog
