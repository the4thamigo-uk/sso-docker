#!/bin/bash
set -e
. ./env.sh

env=$1
if [[ $env = "prd" ]];then
  url="http://repo.miracl.com"
elif [[ $env == "dev" ]];then
  url="http://repo.dev.miracl.net"
else
  echo "Please specify 'prd' or dev'"
  exit 1
fi

TMPFILE=$(mktemp)
cat > $TMPFILE <<- EOM
deb $url/apt/ubuntu all main (Note that, since it comes with i386 additional architecture, Ubuntu 14.04 should use deb [arch=amd64] http://repo.miracl.com/apt/ubuntu all main
EOM

./cp.sh $TMPFILE /etc/apt/sources.list.d/miracl.list
rm $TMPFILE

./exec.sh "wget -qO - $url/build-team-public.asc | apt-key add --" || true
./inst.sh update -y
