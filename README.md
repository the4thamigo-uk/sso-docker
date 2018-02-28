# sso-docker
Docker containers for testing miracl SSO services

Quickstart

1. cd to either centos or ubuntu folder
1. build the docker image `./build.sh`
1. start a docker container exposing the port(s) you want open `./start.sh -p 8000:8000`
1. install ithe latest release build `./rel_inst.sh srv-idp`, or the latest development build `dev-inst.sh srv-idp`, or install a file package `./file_inst.sh miracl-srv-idp.deb`
1. copy config or any other files e.g. `./cp.sh myfile.json /etc/srv-idp`
1. start redis `./service.sh redis start`or simply `./redis.sh start`
1. start service `./service.sh srv-idp start`
1. execute any other commands e.g. `./exec/sh vim /etc/srv-idp/config.json`
