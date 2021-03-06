#!/bin/bash
export SSO_DOCKER_UBUNTU_VERSION=${SSO_DOCKER_UBUNTU_VERSION:-16.04}
export SSO_DOCKER_FROM_IMAGE="ubuntu:$SSO_DOCKER_UBUNTU_VERSION"
export SSO_DOCKER_IMAGE="miracl-sso-ubuntu:$SSO_DOCKER_UBUNTU_VERSION"
export SSO_DOCKER_NAME=ubuntu
export SSO_DOCKER_PORT_BASE=${SSO_DOCKER_PORT_BASE:-8000}
export SSO_DOCKER_CONTEXT=$(pwd)
export SSO_DOCKER_REDIS=redis-server
export SSO_DOCKER_RADIUS_SUBNET=172.16.1.0/24
export SSO_DOCKER_RADIUS_GATEWAY=172.16.1.1
export SSO_DOCKER_OPENSSH_IP=172.16.1.100

. ../compose/env.sh
