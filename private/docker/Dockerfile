FROM ubuntu:14.04
MAINTAINER Arne Jørgensen

# Add our user and group first to make sure their IDs get assigned
# consistently, regardless of whatever dependencies get added.
RUN groupadd -r mysql && useradd -u 1000 -r -g mysql mysql

# Update and install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -q curl git vim php5-cli php5-curl nginx-full php5-fpm php5-gd php5-mysql mariadb-server && apt-get clean -y -q && rm -rf /var/lib/apt/lists/*

# Create "reload" user with password crypted "reload"
RUN useradd -d /home/reload -m reload -s /bin/bash
RUN echo "reload:reload" | chpasswd

# Add "reload" to "sudoers"
RUN echo "reload        ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

WORKDIR /home/reload
ENV HOME /home/reload
ENV PATH /home/reload/composer/bin:$PATH

# Expose webserver
COPY etc/ /etc/

RUN mkdir -p /www && chown -R www-data:www-data /www
RUN mkdir -p /db && chown -R mysql:mysql /db

EXPOSE 80 3306

VOLUME [ "/www", "/db" ]

# Install Behat
RUN mkdir /home/reload/composer
COPY composer.json /home/reload/composer/composer.json
RUN cd /home/reload/composer && curl http://getcomposer.org/installer | php
RUN cd /home/reload/composer && php composer.phar install --prefer-source
RUN cd /home/reload/composer && php composer.phar global require drush/drush:7.*

ENTRYPOINT ["/etc/docker-entrypoint.sh"]
