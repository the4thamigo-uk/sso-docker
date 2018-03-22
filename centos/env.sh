#!/bin/bash
export SSO_DOCKER_NAME=centos
export SSO_DOCKER_PORT_BASE=9000
export SSO_DOCKER_IMAGE=${SSO_DOCKER_IMAGE:-miracl-sso-centos}
export SSO_DOCKER_CONTEXT=$(pwd)
export SSO_DOCKER_REDIS=redis

. ../compose/env.sh
