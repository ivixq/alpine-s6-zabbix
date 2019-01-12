#!/bin/sh
export to_email_address="$1"
export message_subject_utf8="$2"
export message_body_utf8="$3"
export smtpserver=<SMTP_HOST> # or your SMTP server
export smtpemailfrom=<SMTP_USER>
export smtppass=<SMTP_PASS>
export message_subject
export message_body

message_subject_gb2312=`iconv -t GB2312 -f UTF-8 << EOF 
$message_subject_utf8 
EOF` 
[ $? -eq 0 ] && message_subject="$message_subject_gb2312" || message_subject="$message_subject_utf8" 

message_body_gb2312=`iconv -t GB2312 -f UTF-8 << EOF 
message_body_utf8 
EOF` 
[ $? -eq 0 ] && message_body="$message_body_gb2312" || message_body="$message_body_utf8" 

/usr/sbin/sendEmail -s "$smtpserver" \
                    -xu "$smtpemailfrom" \
                    -xp "$smtppass" -f "$smtpemailfrom" \
                    -t "$to_email_address" \
                    -u "$message_subject" \
                    -m "$message_body" \
                    -o message-content-type=text \
                    -o message-charset=gb2312 \
                    -o tls=no
