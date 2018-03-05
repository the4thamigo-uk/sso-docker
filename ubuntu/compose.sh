#!/bin/bash
set -e
. ./env.sh
$SSO_DOCKER_COMPOSE $@
