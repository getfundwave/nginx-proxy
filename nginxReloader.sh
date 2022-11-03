#!/bin/bash
###########

while true
do
 inotifywait -e create -e modify -e delete -e move /etc/nginx/certs
 sleep 0.5  # wait for the crt file to be created
 nginx -t
if [ $? -eq 0 ]
 then
  echo "Detected Nginx Configuration Change"
  echo "Executing: nginx -s reload"
  nginx -s reload
 fi
done