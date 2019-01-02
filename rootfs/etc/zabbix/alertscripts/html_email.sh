#!/bin/sh
export zabbixemailto="$1"
export zabbixsubject="$2"
export zabbixbody="$3"
export smtpserver=<SMTP_SERVER> # or your SMTP server
export smtpemailfrom=<SENDER_MAIL_ADDR>
export smtppass=<EMAIL_PASS>

/usr/sbin/sendEmail -f $smtpemailfrom -t $zabbixemailto -u $zabbixsubject \
    -m $zabbixbody -s $smtpserver -xu $smtpemailfrom -xp $smtppass -o tls=no \
    -o message-content-type=html -o message-charset=utf8

