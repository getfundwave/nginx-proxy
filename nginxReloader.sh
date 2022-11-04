#!/bin/bash
###########

while true
do

 inotifywait -e create -e modify -e delete -e move /etc/nginx/certs /etc/nginx/conf.d

 sleep 0.5  # wait enough for the crt file to be created

 if [[ -f /etc/nginx/certs/ssl_certificate.key && -f /etc/nginx/certs/ssl_certificate.crt && -f /etc/nginx/certs/chain.pem ]]; then
   test -f conf.d/ssl.conf.disabled && mv conf.d/ssl.conf.disabled conf.d/ssl.conf
 else
   test -f conf.d/ssl.conf && mv conf.d/ssl.conf conf.d/ssl.conf.disabled
 fi

 nginx -t

 if [ $? -eq 0 ]
  then
   echo "Detected Nginx Configuration Change"
   echo "Executing: nginx -s reload"
   nginx -s reload
 fi

done
