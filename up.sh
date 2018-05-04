#!/bin/bash
set -e

# select an operating system to test (ubuntu, centos)
SSO_DOCKER_OS=$1

# select a miracl package repository (dev, prd)
SSO_DOCKER_REPO=$2

# select a miracl package repository (dev, prd)
SSO_DOCKER_SERVICE=${3:-srv-idp}

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
./versions.sh $SSO_DOCKER_SERVICE

# install the latest build from the repo ...
./install.sh $SSO_DOCKER_SERVICE

# ... or specify a particular version with ...
#./install.sh $SSO_DOCKER_SERVICE 2.1.0-2181

# ... or install package from file 
#./file_install.sh miracl-$SSO_DOCKER_SERVICE.deb

VERSION=$(./version.sh $SSO_DOCKER_SERVICE)
echo $VERSION
if [[ $VERSION == 1.* ]]; then
  REMOTECONFIG=$SSO_DOCKER_SERVICE.1.x.remote.json
  LOCALCONFIG=$SSO_DOCKER_SERVICE.1.x.local.json
else
  REMOTECONFIG=$SSO_DOCKER_SERVICE.2.x.remote.json
  LOCALCONFIG=$SSO_DOCKER_SERVICE.2.x.local.json
fi

# generate a config file from a template
../config/generate.sh ../config/$REMOTECONFIG > config.remote.json

# copy the local config file
cp ../config/$LOCALCONFIG config.json

# copy remote config file to consul key
../consul/add.sh config.remote.json $SSO_DOCKER_SERVICE

# remove any existing configuration
./rm.sh -rf "/etc/$SSO_DOCKER_SERVICE/*"

# copy local config pointing to consul key
./cp.sh config.json /etc/$SSO_DOCKER_SERVICE

# setup any ldap configuration ...
../ldap/delete.sh ../ldap/users.ldif || true
../ldap/add.sh ../ldap/users.ldif

# start the service
# NB: we do explicit stop and start rather than restart to cater for a bug in pre-v2 releases
./service.sh $SSO_DOCKER_SERVICE stop || true
./service.sh $SSO_DOCKER_SERVICE start


if [[ $SSO_DOCKER_SERVICE == srv-idp ]]; then
  # access $SSO_DOCKER_SERVICE
  curl $SSO_DOCKER_IDP_BASEURL
fi

# access consul
curl $SSO_DOCKER_CONSUL_BASEURL

# access graphite GUI
curl $SSO_DOCKER_STATSD_BASEURL

# access ldap GUI
curl -k $SSO_DOCKER_LDAPGUI_BASEURL

# tail $SSO_DOCKER_SERVICE log file on sso machine with
echo
echo
echo "********************************************************************************************"
echo "             You are now monitoring the $SSO_DOCKER_SERVICE log file on the 'sso' host.                 "
echo "      To cancel, press Ctrl-C and your sso-docker environment will stay running             "
echo "********************************************************************************************"
echo
./logs.sh $SSO_DOCKER_SERVICE || true

# tail syslog logs with 
echo
echo
echo "********************************************************************************************"
echo "              You are now monitoring the logs in the 'syslog' server host.                  "
echo "      To cancel, press Ctrl-C and your sso-docker environment will stay running             "
echo "********************************************************************************************"
echo
./compose.sh exec syslog tail -f /var/log/syslog
