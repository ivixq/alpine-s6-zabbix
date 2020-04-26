FROM ivixq/alpine-s6:edge
LABEL maintainer=ivixq

ENV ENABLE_ZABBIX=true \
    ENABLE_SMTP=true

RUN apk --no-cache update ; \
    apk --no-cache upgrade ; \
    apk --no-cache add \
        zabbix zabbix-mysql zabbix-webif zabbix-setup zabbix-utils \
        php7-apache2 php7-session php7-mysqli php7-mbstring php7-ldap ttf-dejavu \
        net-snmp net-snmp-tools mariadb-client nmap iputils jwhois; \
    rm -rf /var/cache/apk/*

COPY rootfs /

RUN chmod 640 /etc/zabbix/zabbix_server.conf ; \
    chown root:zabbix /etc/zabbix/zabbix_server.conf ; \
    chown zabbix:zabbix /etc/zabbix/alertscripts/* ; \
    chmod +x /etc/zabbix/alertscripts/*

VOLUME ["/etc/zabbix/externalscripts"]

EXPOSE 10051/tcp 10052/tcp 80/tcp 162/udp
