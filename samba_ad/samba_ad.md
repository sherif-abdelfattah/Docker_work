## Samba_ad
A simple samba implementation for Microsoft active directory mainly to be used for testing. 

The image based on the official [Ubuntu docker image](https://hub.docker.com/_/ubuntu) and inspired by [imunew/samba4-ad-dc](https://hub.docker.com/r/imunew/samba4-ad-dc) with some modifications.

## Usage:
### docker run:
```
docker run -d \
    -e SAMBA_DC_REALM='workgroup.local' \
    -e SAMBA_DC_DOMAIN='workgroup' \
    -e SAMBA_DC_ADMIN_PASSWD='P@ssw0rd' \
    -e SAMBA_DC_DNS_BACKEND='SAMBA_INTERNAL' \
    -p 636:636 \
     'sfattah/samba_ad'
```

### Docker compose:
```
version: '3.2'
services:
  samba:
    container_name: samba_ad
    image: sfattah/samba_ad
    privileged: true
    dns:
      - 8.8.8.8
      - 1.1.1.1
    environment:
      SAMBA_DC_REALM: "sherif.loc"
      SAMBA_DC_DOMAIN: "sherif"
      SAMBA_DC_ADMIN_PASSWD: "Passw0rd"
      SAMBA_DC_DNS_BACKEND: "SAMBA_INTERNAL"
      ENABLE_STRONG_AUTH: "false"
      ENABLE_DNS_UPDATE: "false"
    ports:
      - 53:53
      - 53:53/udp
      - 88:88
      - 88:88/udp
      - 135:135
      - 139:139
      - 389:389
      - 389:389/udp
      - 445:445
      - 464:464
      - 464:464/udp
      - 636:636
      - 3268-3269:3268-3269
```
__*Note:*__
*Mapping ports 53 and 88 might conflict with some Linux services and can result in errors*

### Environment Variables:
| Name        | Value           | Description  |
| ------------- |:-------------:| ---------------------------|
| SAMBA_DC_DOMAIN|testdomain.local |The name of the domain used for this AD |
|SAMBA_DC_ADMIN_PASSWD|Passw0rd|The Administrator password |
|SAMBA_DC_REALM|testdomain|The FQDN of the realm where AD lives|
|SAMBA_DC_DNS_BACKEND|SAMBA_INTERNAL|The samba DNS backend, default is samba internal|
|ENABLE_STRONG_AUTH|true|Use strong authentication and enforce SSL, default is true|
|ENABLE_DNS_UPDATE|true|Allow DNS updates, default is true|
