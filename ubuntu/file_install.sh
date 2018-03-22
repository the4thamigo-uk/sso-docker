#!/bin/bash
set -e
. ./env.sh

SRCFILE="$1"
DSTFILE=/tmp/$(basename $SRCFILE)

./cp.sh "$SRCFILE" "$DSTFILE"

./inst.sh install -y --allow-downgrades "$DSTFILE"
./rm.sh "$DSTFILE"
