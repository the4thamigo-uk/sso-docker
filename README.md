# sso-docker
Docker containers for testing miracl SSO services

## Quickstart

### Pre-requisites

1. Install [docker ce](https://docs.docker.com/install/)
1. Install [docker compose](https://docs.docker.com/compose/install/)
1. Setup your secrets, either :
    * (preferred) set your `SSO_DOCKER_*` values in a file in the root folder (e.g. ./.env.sh) and install in your environment using `. ./.env.sh`

            export SSO_DOCKER_IDP_CLIENTID=1234
            export SSO_DOCKER_IDP_CLIENTSECRET=12345678
            export SSO_DOCKER_RADIUS_CLIENTID=1234
            export SSO_DOCKER_RADIUS_CLIENTSECRET=12345678
            export SSO_DOCKER_RADIUS_SECRET=mysecret

    * set the `*_DEFAULT` values in [./compose/secrets.sh](./compose/secrets.sh) (e.g. `SSO_DOCKER_IDP_CLIENTID_DEFAULT=1234`)
    * set them in your environment explicitly (e.g. `export SSO_DOCKER_IDP_CLIENTID=1234`)

### Example
To run up an example srv-idp environment refer to the example [up](./up.sh)/[down](./down.sh) scripts

For example the following command start an srv-idp environment on ubuntu using the latest development build and perform a few basic tests with `curl`:
```
./up.sh ubuntu dev
```

and the following command performs a graceful cleanup and shutdown of this environment :
```
./down.sh ubuntu
```
