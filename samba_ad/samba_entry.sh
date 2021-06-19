#!/bin/sh
set -e

if [ ! -f /etc/samba/smb.conf ]; then
    samba-tool domain provision --domain="${SAMBA_DC_DOMAIN}" \
        --adminpass="${SAMBA_DC_ADMIN_PASSWD}" \
        --server-role=dc \
        --realm="${SAMBA_DC_REALM}" \
        --dns-backend="${SAMBA_DC_DNS_BACKEND}" \
        --use-rfc2307 \
        --function-level=2008_R2 
fi

# disable strong auth:
if [ "${ENABLE_STRONG_AUTH}" = "false" ]
then
	stat /etc/samba/smb.conf
	echo "SSL is ${ENABLE_STRONG_AUTH}"
	sed -ie "s/\[global\]/\[global\]\n\tldap server require strong auth = no/" /etc/samba/smb.conf
fi


# disable DNS updates
if [ "${ENABLE_DNS_UPDATE}" = "false" ] 
then
	sed -ie "s/\[global\]/\[global\]\n\tallow dns updates = disabled/" /etc/samba/smb.conf
fi



if [ "$1" = 'samba' ]; then
    exec samba -i < /dev/null
fi

exec "$@"
