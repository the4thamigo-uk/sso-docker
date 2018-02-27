# sso-docker
Docker containers for testing miracl SSO services

Quickstart

1. cd to either centos or ubuntu folder
1. build the docker image `./build.sh`
1. start a docker container `./start.sh`
1. install release or development build from repo e.g. `./rel_inst.sh srv-idp` or `dev-inst.sh srv-idp` or from file `./file_inst.sh miracl-srv-idp.deb`
1. copy config or any other files e.g. `./cp.sh myfile.json /etc/srv-idp`
1. start redis `./service.sh redis start`or simply `./redis.sh start`
1. start service `./service.sh srv-idp start`
