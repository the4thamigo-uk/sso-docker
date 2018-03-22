{
  "server": {
    "address": ":$SSO_DOCKER_IDP_PORT_INT",
    "public_address": "http://127.0.0.1:$SSO_DOCKER_IDP_PORT"
  },
  "zfa": {
    "client_id": "$SSO_DOCKER_IDP_CLIENTID",
    "client_secret": "$SSO_DOCKER_IDP_CLIENTSECRET"
  },
  "idp": {
    "private_key": "$SSO_DOCKER_IDP_KEY",
    "public_certificate": "$SSO_DOCKER_IDP_CERT"
  },
  "sp": {
    "example": {
      "description": "An example SAML service provider configuration",
      "issuer": "http://example.com",
      "relay_state": "/",
      "login_url": "http://example.com/login",
      "logout_url": "http://example.com/logout",
      "metadata": "<?xml version=\"1.0\" encoding=\"UTF-8\"?><md:EntityDescriptor xmlns:md=\"urn:oasis:names:tc:SAML:2.0:metadata\" entityID=\"https://example.com\"><md:SPSSODescriptor WantAssertionsSigned=\"false\" protocolSupportEnumeration=\"urn:oasis:names:tc:SAML:2.0:protocol\"><md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified</md:NameIDFormat><md:AssertionConsumerService Binding=\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST\" Location=\"https://example.com\" index=\"0\"/></md:SPSSODescriptor></md:EntityDescriptor>",
      "authorize": true
    }
  }
}
