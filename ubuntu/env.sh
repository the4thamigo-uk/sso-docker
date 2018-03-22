#!/bin/bash
export SSO_DOCKER_NAME=ubuntu
export SSO_DOCKER_PORT_BASE=8000
export SSO_DOCKER_IMAGE=${SSO_DOCKER_IMAGE:-miracl-sso-ubuntu}
export SSO_DOCKER_CONTEXT=$(pwd)
export SSO_DOCKER_REDIS=redis-server

. ../compose/env.sh
