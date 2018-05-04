# sso-docker
Docker containers for testing miracl SSO services

## Quickstart

### Pre-requisites

1. Install [docker ce](https://docs.docker.com/install/)
1. Create a SSO with SAML app in the portal with two redirect urls 

            http://127.0.0.1:8000/login`
            http://127.0.0.1:9000/login

1. Create a SSO with RADIUS app in the portal
1. Setup your app secrets in a new file called `./.env.sh` :

            export SSO_DOCKER_IDP_BACKEND=https://api.mpin.io
            export SSO_DOCKER_IDP_CLIENTID=1234
            export SSO_DOCKER_IDP_CLIENTSECRET=12345678
            export SSO_DOCKER_RADIUS_BACKEND=https://api.mpin.io/otp
            export SSO_DOCKER_RADIUS_CLIENTID=1234
            export SSO_DOCKER_RADIUS_CLIENTSECRET=12345678
            export SSO_DOCKER_RADIUS_SECRET=mysecret

1. Import the file in your environment using `. ./.env.sh`
1. Use the `up.sh` script to launch an environment (see below)

### Example Up/Down Scripts

To run up an example srv-idp environment refer to the example [up](./up.sh)/[down](./down.sh) scripts:
```
./up.sh [ubuntu|centos] [dev|prd] [srv-idp|srv-radius]
```

```
./down.sh [ubuntu|centos]
```


#### SAML IdP Example

The following command starts an srv-idp environment, with a sample service provider, on ubuntu, using the latest production build :
```
./up.sh ubuntu prd srv-idp
```

To test, open [this](http://127.0.0.1:8000/services) link. If you start a centos environment use [this](http://127.0.0.1:9000/services) link.

#### RADIUS Example

The following command starts a srv-radius environment, with openssh, on ubuntu, using the latest production build :
```
./up.sh ubuntu prd srv-radius
```

To test, use the following command :

```
ssh ssotest@miracl.com@127.0.0.1 -p 8022
```

If you start a centos environment use :
```
ssh ssotest@miracl.com@127.0.0.1 -p 9022
```
