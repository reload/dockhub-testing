FROM ubuntu:14.04
MAINTAINER Arne Jørgensen

# Update and install packages
RUN apt-get update
RUN apt-get install -y -q curl git vim
RUN apt-get install -y -q php5-cli php5-curl
RUN apt-get install -y -q nginx-full php5-fpm php5-gd php5-mysql
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q mariadb-server

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

RUN mkdir /www && chown -R www-data:www-data /www
RUN mkdir /db && chown -R mysql:mysql /db

EXPOSE 80 3306

VOLUME [ "/www", "/db" ]

# Install Behat
RUN mkdir /home/reload/composer
COPY composer.json /home/reload/composer/composer.json
RUN cd /home/reload/composer && curl http://getcomposer.org/installer | php
RUN cd /home/reload/composer && php composer.phar install --prefer-source
RUN cd /home/reload/composer && php composer.phar global require drush/drush:7.*

ENTRYPOINT ["/etc/docker-entrypoint.sh"]
