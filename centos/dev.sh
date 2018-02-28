#!/bin/bash
set -e
. ./env.sh

TMPFILE=/tmp/$SERVICE_FULL-rpm

cat > $TMPFILE <<- EOM
[miracl]
name= Latest Release for RHEL/Centos 7Server
baseurl=http://repo.dev.miracl.net/yum/redhat/7Server
gpgkey=http://repo.dev.miracl.net/build-team-public.asc
enabled=1
gpgcheck=0
EOM

./cp.sh $TMPFILE /etc/yum.repos.d/miracl-rpm.repo
rm $TMPFILE

./inst.sh --enablerepo=miracl clean metadata
./inst.sh check-update -y || test $? == 100
