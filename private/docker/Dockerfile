FROM ubuntu:14.04
MAINTAINER Arne Jørgensen

# Create "novasol" user with password crypted "novasol" as user 1000 to
# ensure volume mounting file owner issues. Add "novasol" to "sudoers"
RUN useradd -d /home/novasol -u 1000 -G staff -m novasol -s /bin/bash && echo "novasol:novasol" | chpasswd && echo "novasol        ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

# Update and install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -q curl git vim php5-cli php5-curl nginx-full php5-fpm php5-gd php5-mysql mariadb-server && apt-get clean -y -q && rm -rf /var/lib/apt/lists/*

# Run nginx and mysql as novasol user. We nedd this to be able to write
# to volume mounted folders.
RUN sed -i 's/^\(user[ \t]*\)www-data;/\1novasol;/m' /etc/nginx/nginx.conf && sed -i 's/^\(user[ \t]*=[ \t]*\)mysql/\1novasol/m' /etc/mysql/my.cnf

WORKDIR /home/novasol
ENV HOME=/home/novasol PATH=/home/novasol/composer/bin:${PATH}

# Expose webserver
COPY etc/ /etc/

RUN mkdir -p /www && chown -R novasol:staff /www
RUN mkdir -p /db && mkdir -p /var/run/mysqld && chown -R novasol:staff /db /var/run/mysqld

EXPOSE 80 3306

VOLUME [ "/www", "/db" ]

# Install composer, behat, drush, etc.
COPY composer.json /home/novasol/composer/composer.json
RUN cd /home/novasol/composer && curl http://getcomposer.org/installer | php && php composer.phar install --prefer-source

ENTRYPOINT ["/etc/docker-entrypoint.sh"]
