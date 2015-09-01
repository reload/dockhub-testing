#!/bin/sh

service mysql start
service php5-fpm start

/usr/sbin/nginx -g "daemon off;"
