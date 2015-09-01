#!/bin/sh

service start php5-fpm

/usr/sbin/nginx -g "daemon off;"
