#!/bin/bash
set -e
. ./env.sh

INSTFILE="$1"
./cp.sh "$INSTFILE" /tmp

./inst.sh install -y /tmp/$(basename $INSTFILE)
rm $INSTFILE
