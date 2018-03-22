#!/bin/bash
set -e
. ./env.sh

package=$1
package_full="miracl-$package"
version=${2:+=$2}

./inst.sh install -y --allow-downgrades --allow-unauthenticated $package_full$version
