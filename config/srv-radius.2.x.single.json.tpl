{
  "server": {
    "address": ":1812"
  },
  "zfa": {
    "global": {
    "client_id": "$SSO_DOCKER_RADIUS_CLIENTID",
    "client_secret": "$SSO_DOCKER_RADIUS_CLIENTSECRET"
    }
  },
  "host": {
    "127.0.0.1": {
      "name": "local",
      "authorize": true,
      "zfa": "global",
      "secret": "$SSO_DOCKER_RADIUS_SECRET"
    }
  }
}
