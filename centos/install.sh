#!/bin/bash
set -e
. ./env.sh

package=$1
package_full="miracl-$package"
version=${2:+-$2}

./inst.sh install -y $package_full$version
