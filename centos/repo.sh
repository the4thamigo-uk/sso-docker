#!/bin/bash
set -e
. ./env.sh

env=$1
if [[ $env = "prd" ]];then
  url="http://repo.miracl.com"
  gpg=1
elif [[ $env == "dev" ]];then
  url="http://repo.dev.miracl.net"
  gpg=0
else
  echo "Please specify 'prd' or dev'"
  exit 1
fi

TMPFILE=$(mktemp)
cat > $TMPFILE <<- EOM
[miracl]
name= Latest Release for RHEL/Centos 7Server
baseurl=$url/yum/redhat/7Server
gpgkey=$url/build-team-public.asc
enabled=1
gpgcheck=$gpg
EOM

./cp.sh $TMPFILE /etc/yum.repos.d/miracl-rpm.repo
rm $TMPFILE

./inst.sh --enablerepo=miracl clean metadata
./inst.sh check-update -y || test $? == 100
