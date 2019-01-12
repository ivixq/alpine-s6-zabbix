#!/bin/sh
mail_address=$1
mail_subject=$2
mail_content=$3

## send mail
echo $mail_content | mutt -s $mail_subject -b $mail_address 

## clean the temp file for mutt
cat /dev/null > ~/sent

