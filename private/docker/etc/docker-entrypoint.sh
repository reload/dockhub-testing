#!/bin/sh

if [ ! -f /var/lib/mysql/ibdata1 ]; then
    mysql_install_db
fi

service mysql start
service php5-fpm start

/usr/sbin/nginx -g "daemon off;"
