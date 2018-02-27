#!/bin/bash
set -e
. ./env.sh

INSTFILE="$1"
./cp.sh "$INSTFILE" /tmp

./inst.sh localinstall -y /tmp/$(basename $INSTFILE)
rm $INSTFILE
