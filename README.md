# sso-docker
Docker containers for testing miracl SSO services

Quickstart

1. cd to either centos or ubuntu folder
1. build the docker image `./build.sh`
1. start a docker container `./start.sh`
1. set service to install with either `export MIRACL_SERVICE=srv-radius` `export MIRACL_SERVICE=srv-idp` (this is the default)
1. install release or development build from repo with `./rel_inst.sh` or `dev-inst.sh`
1. copy config or any other files e.g. `./cp.sh myfile.json /etc/srv-idp`
1. start redis `./service.sh redis start`
1. start service `./service.sh srv-idp start`
