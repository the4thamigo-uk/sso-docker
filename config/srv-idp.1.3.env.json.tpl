{
  "remoteConfigProvider": "",
  "remoteConfigEndpoint": "",
  "remoteConfigPath": "",
  "remoteConfigSecretKeyring": "",
  "serverAddress": ":$SSO_DOCKER_IDP_PORT_INT",
  "serverPublicAddress": "http://127.0.0.1:$SSO_DOCKER_IDP_PORT",
  "errorPageURL": "",
  "errorPageTemplate": "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" /><title>SSO ERROR</title></head><body><h1>SSO ERROR</h1><h2>{{.Data}}</h2><div><a href=\"{{.URL}}/services\" title=\"SSO Login\">SSO LOGIN</a> <a href=\"{{.URL}}/logout\" title=\"Terminate the main SSO session\">SSO LOGOUT</a></div><div><table><tr><th>FIELD</th><th>VALUE</th></tr><tr><td>Program</td><td>{{.Program}}</td></tr><tr><td>Version</td><td>{{.Version}}</td></tr><tr><td>Release</td><td>{{.Release}}</td></tr><tr><td>IdP URL</td><td>{{.URL}}</td></tr><tr><td>DateTime</td><td>{{.DateTime}}</td></tr><tr><td>Timestamp</td><td>{{.Timestamp}}</td></tr><tr><td>Status</td><td>{{.Status}}</td></tr><tr><td>Code</td><td>{{.Code}}</td></tr><tr><td>Message</td><td>{{.Message}}</td></tr><tr><td>Data</td><td>{{.Data}}</td></tr></table></div></body></html>",
  "logoutPageURL": "",
  "logoutPageTemplate": "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" /><title>SSO LOGOUT</title></head><body><h1>SSO LOGOUT</h1><h2>The IDP Session has been successfully deleted</h2><div><a href=\"{{.URL}}/services\" title=\"SSO Login\">SSO LOGIN</a></div><h3>Logout links of visited Service Providers:</h3><ul>{{ range $name, $logout := .SPList }}<li><a href=\"{{ $logout }}\" title=\"Logout from {{ $name }}\" target=\"_blank\">{{ $name }}</a></li>{{ end }}</ul></body></html>",
  "servicesPageURL": "",
  "servicesPageTemplate": "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" /><title>SSO Authorized Service Providers</title></head><body><h1>SSO Authorized Service Providers</h1><div><a href=\"{{.URL}}/logout\" title=\"Terminate the main SSO session\">SSO LOGOUT</a></div><ul>{{ range $sp := .SPList }}<li><strong>{{ $sp.Name }}</strong><br /><em>{{ $sp.Description }}</em><ul><li><a href=\"{{ $sp.IDPLogin }}\" title=\"IdP-Login: {{ $sp.Description }}\" target=\"_blank\">IdP-initiated login</a></li><li><a href=\"{{ $sp.Login }}\" title=\"Login: {{ $sp.Description }}\" target=\"_blank\">Login Page</a></li><li><a href=\"{{ $sp.Logout }}\" title=\"Logout: {{ $sp.Description }}\" target=\"_blank\">Logout</a></li></ul></li>{{ end }}</ul></body></html>",
  "log": {
    "level": "DEBUG",
    "network": "udp",
    "address": "syslog:514"    
  },
  "stats": {
    "prefix": "srv-idp",
    "network": "udp",
    "address": "statsd:8125",
    "flush_period": 100
  },
  "redis": {
    "network": "tcp",
    "address": "redis:6379",
    "database": 0,
    "password": "",
    "connect_timeout": 0,
    "read_timeout": 0,
    "write_timeout": 0,
    "pool_max_idle": 0,
    "pool_max_active": 0,
    "pool_idle_timeout": 0,
    "max_age": 3600
  },
  "zfa": {
    "client_id": "$SSO_DOCKER_IDP_CLIENTID",
    "client_secret": "$SSO_DOCKER_IDP_CLIENTSECRET",
    "backend": "https://api.mpin.io"
  },
  "idp": {
    "private_key": "$SSO_DOCKER_IDP_KEY",
    "public_certificate": "$SSO_DOCKER_IDP_CERT",
    "metadata": "<EntityDescriptor xmlns=\"urn:oasis:names:tc:SAML:2.0:metadata\" validUntil=\"{{.ValidUntil}}\" cacheDuration=\"{{.CacheDuration}}\" entityID=\"{{.EntityID}}\"><IDPSSODescriptor xmlns=\"urn:oasis:names:tc:SAML:2.0:metadata\" protocolSupportEnumeration=\"urn:oasis:names:tc:SAML:2.0:protocol\"><KeyDescriptor use=\"signing\"><KeyInfo xmlns=\"http://www.w3.org/2000/09/xmldsig#\"><X509Data><X509Certificate>{{.SigningCertificate}}</X509Certificate></X509Data></KeyInfo></KeyDescriptor><KeyDescriptor use=\"encryption\"><KeyInfo xmlns=\"http://www.w3.org/2000/09/xmldsig#\"><X509Data><X509Certificate>{{.EncryptionCertificate}}</X509Certificate></X509Data></KeyInfo><EncryptionMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#aes128-cbc\"></EncryptionMethod><EncryptionMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#aes192-cbc\"></EncryptionMethod><EncryptionMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#aes256-cbc\"></EncryptionMethod><EncryptionMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#rsa-oaep-mgf1p\"></EncryptionMethod></KeyDescriptor><NameIDFormat>urn:oasis:names:tc:SAML:2.0:nameid-format:transient</NameIDFormat><SingleSignOnService Binding=\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect\" Location=\"{{.SsoRedirectLocation}}\"></SingleSignOnService><SingleSignOnService Binding=\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST\" Location=\"{{.SsoPostLocation}}\"></SingleSignOnService></IDPSSODescriptor></EntityDescriptor>",
    "response_form": "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\" dir=\"ltr\"><head><title>SSO REDIRECT TO: {{.URL}}</title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" /><meta name=\"language\" content=\"en\" /><meta name=\"description\" content=\"Redirect the user to the Service Provider: {{.URL}}\" /></head><body onload=\"document.getElementById('SAMLResponseForm').submit()\"><form method=\"post\" action=\"{{.URL}}\" id=\"SAMLResponseForm\"><div><input type=\"hidden\" name=\"SAMLResponse\" id=\"SAMLResponse\" value=\"{{.SAMLResponse}}\" /><input type=\"hidden\" name=\"RelayState\" id=\"RelayState\" value=\"{{.RelayState}}\" /><input type=\"submit\" value=\"Continue\" /></div></form></body></html>",
    "cache_duration": 48,
    "max_sp_delay": 90
  },
  "profile": {
    "assertion": {
       "global": "<Assertion xmlns=\"urn:oasis:names:tc:SAML:2.0:assertion\" ID=\"{{.ID}}\" IssueInstant=\"{{.TimeNow}}\" Version=\"2.0\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\" xmlns:saml=\"urn:oasis:names:tc:SAML:2.0:assertion\" xmlns:samlp=\"urn:oasis:names:tc:SAML:2.0:protocol\" xmlns:xenc=\"http://www.w3.org/2001/04/xmlenc#\"><Issuer xmlns=\"urn:oasis:names:tc:SAML:2.0:assertion\" Format=\"urn:oasis:names:tc:SAML:2.0:nameid-format:entity\">{{.MetadataEntityID}}</Issuer>{{.SignatureBlock}}<Subject>{{.NameID}}<SubjectConfirmation Method=\"urn:oasis:names:tc:SAML:2.0:cm:bearer\"><SubjectConfirmationData NotOnOrAfter=\"{{.TimeExpire}}\" Address=\"{{.RecipientIP}}\" Recipient=\"{{.Recipient}}\" {{if not (eq .AuthnRequestID \"\")}}InResponseTo=\"{{.AuthnRequestID}}\"{{end}}/></SubjectConfirmation></Subject><Conditions NotBefore=\"{{.TimeNow}}\" NotOnOrAfter=\"{{.TimeExpire}}\"><AudienceRestriction><Audience>{{.SPEntityID}}</Audience></AudienceRestriction></Conditions><AuthnStatement AuthnInstant=\"{{.SessionCreateTime}}\" SessionIndex=\"{{.SessionIndex}}\" SessionNotOnOrAfter=\"{{.TimeExpire}}\"><SubjectLocality Address=\"{{.RemoteAddress}}\" /><AuthnContext><AuthnContextClassRef>urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport</AuthnContextClassRef></AuthnContext></AuthnStatement>{{.AttributeStatement}}</Assertion>"
    },
    "nameid": {
      "global": "<NameID NameQualifier=\"{{.MetadataEntityID}}\" SPNameQualifier=\"{{.SPEntityID}}\" Format=\"urn:oasis:names:tc:SAML:2.0:nameid-format:transient\">{{.ServiceProviderUserID}}</NameID>",
      "office365": "<NameID NameQualifier=\"{{.MetadataEntityID}}\" SPNameQualifier=\"{{.SPEntityID}}\" Format=\"urn:oasis:names:tc:SAML:2.0:nameid-format:transient\">{{.SessionUserName | urlquery}}</NameID>"
    },
    "attribute": {
      "global": "<AttributeStatement>{{ if not (eq .ServiceProviderUserID \"\")}}<Attribute FriendlyName=\"uid\" Name=\"urn:oid:0.9.2342.19200300.100.1.1\" NameFormat=\"urn:oasis:names:tc:SAML:2.0:attrname-format:uri\"><AttributeValue xmlns:XMLSchema-instance=\"http://www.w3.org/2001/XMLSchema-instance\" XMLSchema-instance:type=\"xs:string\">{{.ServiceProviderUserID}}</AttributeValue></Attribute>{{end}}{{ if not (eq .SessionUserEmail \"\")}}<Attribute FriendlyName=\"mail\" Name=\"urn:oid:0.9.2342.19200300.100.1.3\" NameFormat=\"urn:oasis:names:tc:SAML:2.0:attrname-format:uri\"><AttributeValue xmlns:XMLSchema-instance=\"http://www.w3.org/2001/XMLSchema-instance\" XMLSchema-instance:type=\"xs:string\">{{.SessionUserEmail}}</AttributeValue></Attribute><Attribute FriendlyName=\"eduPersonPrincipalName\" Name=\"urn:oid:1.3.6.1.4.1.5923.1.1.1.6\" NameFormat=\"urn:oasis:names:tc:SAML:2.0:attrname-format:uri\"><AttributeValue xmlns:XMLSchema-instance=\"http://www.w3.org/2001/XMLSchema-instance\" XMLSchema-instance:type=\"xs:string\">{{.SessionUserEmail}}</AttributeValue></Attribute><Attribute Name=\"IDPEmail\"><AttributeValue>{{.SessionUserEmail}}</AttributeValue></Attribute>{{end}}</AttributeStatement>",
      "empty": ""
    },
    "response": {
      "global": "<Response xmlns=\"urn:oasis:names:tc:SAML:2.0:protocol\" xmlns:xs=\"http://www.w3.org/2001/XMLSchema\" Version=\"2.0\" Destination=\"{{.Destination}}\" {{if not (eq .AuthnRequestID \"\")}}InResponseTo=\"{{.AuthnRequestID}}\"{{end}} IssueInstant=\"{{.TimeNow}}\" ID=\"{{.ID}}\">{{if not (eq .MetadataEntityID \"\")}}<Issuer xmlns=\"urn:oasis:names:tc:SAML:2.0:assertion\" Format=\"urn:oasis:names:tc:SAML:2.0:nameid-format:entity\">{{.MetadataEntityID}}</Issuer>{{end}}{{.SignatureBlock}}<Status xmlns=\"urn:oasis:names:tc:SAML:2.0:protocol\"><StatusCode xmlns=\"urn:oasis:names:tc:SAML:2.0:protocol\" Value=\"{{.StatusCodeTL}}\">{{if not (eq .StatusCodeSL \"\")}}<StatusCode xmlns=\"urn:oasis:names:tc:SAML:2.0:protocol\" Value=\"{{.StatusCodeSL}}\" />{{end}}</StatusCode>{{if not (eq .StatusMessage \"\")}}<StatusMessage xmlns=\"urn:oasis:names:tc:SAML:2.0:protocol\">{{.StatusMessage}}</StatusMessage>{{end}}</Status>{{.Assertion}}</Response>"
    },
    "signature": {
      "global": "<Signature xmlns=\"http://www.w3.org/2000/09/xmldsig#\"><SignedInfo><CanonicalizationMethod Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"></CanonicalizationMethod><SignatureMethod Algorithm=\"http://www.w3.org/2001/04/xmldsig-more#rsa-sha256\"></SignatureMethod><Reference URI=\"{{.ReferenceURI}}\"><Transforms><Transform Algorithm=\"http://www.w3.org/2000/09/xmldsig#enveloped-signature\"></Transform><Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"></Transform></Transforms><DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"></DigestMethod><DigestValue></DigestValue></Reference></SignedInfo><SignatureValue></SignatureValue><KeyInfo><X509Data><X509Certificate>{{.Certificate}}</X509Certificate></X509Data></KeyInfo></Signature>"
    }
  },
  "ldap": {
    "server": {
      "global": {
        "method": "plain",
        "address": "ldap:389",
        "user": "cn=admin,dc=example,dc=com",
        "password": "password"
      }
    },
    "query": {
      "global": {
        "server": "global",
        "search": [
            {"dn": "ou=users,dc=example,dc=com", "filter": "(mail={{.UserID}})"}
        ]
      }
    }
  },
  "sp": {
    "sptest": {
      "description": "Test Service Provider",
      "issuer": "http://127.0.0.1:8080/php-saml/demo2",
      "relay_state": "/",
      "login_url": "http://127.0.0.1:8080/php-saml/demo2/",
      "logout_url": "http://127.0.0.1:8080/php-saml/demo2/slo.php",
      "slo_url": "",
      "metadata": "<?xml version=\"1.0\" encoding=\"UTF-8\"?><md:EntityDescriptor xmlns:md=\"urn:oasis:names:tc:SAML:2.0:metadata\" entityID=\"http://127.0.0.1:8080\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\"><md:SPSSODescriptor AuthnRequestsSigned=\"true\" WantAssertionsSigned=\"true\" protocolSupportEnumeration=\"urn:oasis:names:tc:SAML:2.0:protocol\"><md:KeyDescriptor use=\"signing\"><ds:KeyInfo><ds:X509Data><ds:X509Certificate>$SSO_DOCKER_SP_CERT</ds:X509Certificate></ds:X509Data></ds:KeyInfo></md:KeyDescriptor><md:KeyDescriptor use=\"encryption\"><ds:KeyInfo><ds:X509Data><ds:X509Certificate>$SSO_DOCKER_SP_CERT</ds:X509Certificate></ds:X509Data></ds:KeyInfo></md:KeyDescriptor><md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress</md:NameIDFormat><md:AssertionConsumerService Binding=\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST\" Location=\"http://127.0.0.1:8080/php-saml/demo2/acs.php\" index=\"0\" isDefault=\"true\"/><md:AttributeConsumingService index=\"0\" isDefault=\"true\"><md:ServiceName xmlns:xml=\"http://www.w3.org/XML/1998/namespace\" xml:lang=\"en\">SPTest</md:ServiceName></md:AttributeConsumingService></md:SPSSODescriptor></md:EntityDescriptor>",
      "sign_response": true,
      "sign_assertion": false,
      "encrypt_assertion": true,
      "user_id_transform": [{
        "search": "^([^@]+)@[^@]+$",
        "replace": "$1"
      }],
      "authorize": [[{"ldap": "global"}]]
    }
  }
}
