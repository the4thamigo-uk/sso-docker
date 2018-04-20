#!/bin/bash
set -e
. ./env.sh

env=$1
if [[ $env = "prd" ]];then
  url="http://repo.miracl.com"
elif [[ $env == "dev" ]];then
  url="http://repo.dev.miracl.net"
  trusted="[trusted=yes]"
else
  echo "Please specify 'prd' or dev'"
  exit 1
fi

TMPFILE=$(mktemp)
cat > $TMPFILE <<- EOM
deb $trusted $url/apt/ubuntu all main
EOM

./cp.sh $TMPFILE /etc/apt/sources.list.d/miracl.list
rm $TMPFILE

./exec.sh "wget -qO - $url/build-team-public.asc | apt-key add --" || true
./inst.sh update -y
