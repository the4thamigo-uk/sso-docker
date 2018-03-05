#!/bin/bash
set -e
. ./env.sh

TMPFILE=$(mktemp)

cat > $TMPFILE <<- EOM
deb http://repo.dev.miracl.net/apt/ubuntu all main (Note that, since it comes with i386 additional architecture, Ubuntu 14.04 should use deb [arch=amd64] http://repo.miracl.com/apt/ubuntu all main
EOM

./cp.sh $TMPFILE /etc/apt/sources.list.d/miracl.list
rm $TMPFILE

./exec.sh "wget -qO - http://repo.miracl.com/build-team-public.asc | apt-key add --"
./inst.sh update -y
