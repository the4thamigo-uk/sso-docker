# sso-docker
Docker containers for testing miracl SSO services

## Quickstart

### Pre-requisites

1. Install [docker ce](https://docs.docker.com/install/)
1. Install [docker compose](https://docs.docker.com/compose/install/)
1. Setup your secrets in `./config/env.sh`(note you can use the dummy KEYs and CERTs if you like, but will likely need to setup your CLIENTIDs and CLIENTSECRETSs)

### Single docker container

1. cd to either centos or ubuntu folder
1. build the docker image `./build.sh
1. start a docker container `./start.sh`
1. configure the release miracl repo with `./rel.sh` or the development repo `./dev.sh`
1. list the versions of a package `./versions.sh srv-idp`
1. install the latest build `./install.sh srv-idp`, or specify a version with `./install.sh srv-idp 1.3.3-466`. Alternatively, you can install package from file `./file_install.sh miracl-srv-idp.deb`.
1. generate a config file from a template e.g. `../config/generate.sh srv-idp.1.3.single.json.tpl > config.json`
1. copy config or any other files e.g. `./cp.sh config.json otherconfig.json /etc/srv-idp`
1. start redis `./service.sh redis start`or simply `./redis.sh start`
1. start service `./service.sh srv-idp start`
1. tail the logs `./logs.sh srv-idp`
1. execute any other commands e.g. `./exec.sh vim /etc/srv-idp/config.json`
1. uninstall with `./uninstall.sh srv-idp`

### Full docker compose environment

1. cd to either centos or ubuntu folder
1. clean up any legacy environment `./compose.sh rm`
1. build the docker compose environment with `./compose.sh up -d`
1. configure the release miracl repo with `./rel.sh` or the development repo `./dev.sh`
1. list the versions of a package `./versions.sh srv-idp`
1. install the latest build `./install.sh srv-idp`, or specify a version with `./install.sh srv-idp 1.3.3-466`. Alternatively, you can install package from file `./file_install.sh miracl-srv-idp.deb`.
1. generate a config file from a template e.g. `../config/generate.sh srv-idp.1.3.env.json.tpl > config.json`
1. copy config file to consul key e.g. `../config/consul_add.sh config.json srv-idp`
1. copy config pointing to consul e.g. `./cp.sh ../environment/config/srv-idp.1.3.remote.json /etc/srv-idp/config.json`
1. setup any ldap configuration e.g. `cat ../environment/ldap/users.ldif | ../environment/ldap/add.sh` (and you can remove with `cat ../environment/ldap/users.ldif | ../environment/ldap/delete.sh`)
1. start the service e.g. `./service.sh srv-idp start`
1. access srv-idp at `http://127.0.0.1:8000/services`
1. access consul at `http://127.0.0.1:8001`
1. access statsd/graphite at `http://127.0.0.1:8002`
1. access ldap at `127.0.0.1:8004`
1. access ldap GUI at `https://127.0.0.1:8005`
1. tail syslog logs with `docker exec syslog tail -f /var/log/syslog`
