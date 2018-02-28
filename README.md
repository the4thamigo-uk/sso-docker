# sso-docker
Docker containers for testing miracl SSO services

Quickstart

1. cd to either centos or ubuntu folder
1. build the docker image `./build.sh`
1. start a docker container exposing the port(s) you want open `./start.sh -p 8000:8000`
1. configure the release miracl repo with `./rel.sh` or the development repo `./dev.sh`
1. list the versions of a package `./versions.sh srv-idp`
1. install the latest build `./install.sh srv-idp`, or specify a version with `./install.sh srv-idp 1.3.3-466`. Alternatively, you can install package from file `./file_install.sh miracl-srv-idp.deb`.
1. copy config or any other files e.g. `./cp.sh myfile.json myotherfile.json /etc/srv-idp`
1. start redis `./service.sh redis start`or simply `./redis.sh start`
1. start service `./service.sh srv-idp start`
1. execute any other commands e.g. `./exec.sh vim /etc/srv-idp/config.json`
1. uninstall with `./uninstall.sh srv-idp`
