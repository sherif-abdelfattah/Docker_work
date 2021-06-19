# syntax=docker/dockerfile:1
FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y vim inetutils-ping net-tools iproute2
RUN apt-get install -y acl apt-utils attr autoconf bind9utils binutils bison build-essential ccache chrpath curl debhelper dnsutils docbook-xml docbook-xsl flex gcc gdb git glusterfs-common gzip heimdal-multidev hostname htop krb5-config krb5-kdc krb5-user language-pack-en lcov libacl1-dev libarchive-dev libattr1-dev libavahi-common-dev libblkid-dev libbsd-dev libcap-dev libcephfs-dev libcups2-dev libdbus-1-dev libglib2.0-dev libgnutls28-dev libgpgme11-dev libicu-dev libjansson-dev libjs-jquery libjson-perl libkrb5-dev libldap2-dev liblmdb-dev libncurses5-dev libpam0g-dev libparse-yapp-perl libpcap-dev libpopt-dev libreadline-dev libsystemd-dev libtasn1-bin libtasn1-dev libunwind-dev lmdb-utils locales lsb-release make mawk mingw-w64 patch perl perl-modules pkg-config procps psmisc python3 python3-cryptography python3-dbg python3-dev python3-dnspython python3-gpg python3-iso8601 python3-markdown python3-matplotlib python3-pexpect python3-pyasn1 python3-setproctitle rng-tools rsync sed sudo tar tree uuid-dev wget xfslibs-dev xsltproc zlib1g-dev

RUN wget https://download.samba.org/pub/samba/stable/samba-4.14.0.tar.gz && \
	tar -zxf samba-4.14.0.tar.gz && \
	cd samba-4.14.0 && \
	./configure --prefix=/usr/local/samba --enable-selftest --sysconfdir=/etc/samba && \
	make -j2 && \
	make install

ENV PATH=/usr/local/samba/bin:/usr/local/samba/sbin:$PATH
	 
COPY samba_entry.sh /samba_entry.sh

RUN chmod 755 /samba_entry.sh

ENTRYPOINT ["/samba_entry.sh"]
CMD ["samba"]

