#!/bin/bash
set -e
. ./env.sh
../compose/compose.sh "$@"
