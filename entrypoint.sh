#!/bin/bash

./etc/nginx/nginxReloader.sh &
exec "$@"