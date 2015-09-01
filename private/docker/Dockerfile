FROM ubuntu:14.04
MAINTAINER Arne Jørgensen

# Update and install packages
RUN apt-get update
RUN apt-get install -y curl git vim
RUN apt-get install -y -q php5-cli php5-curl
RUN apt-get install -y nginx-full php5-fpm php5-gd php5-mysql

# Create "reload" user with password crypted "reload"
RUN useradd -d /home/reload -m reload -s /bin/bash
RUN echo "reload:reload" | chpasswd

# Add "reload" to "sudoers"
RUN echo "reload        ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

WORKDIR /home/reload
ENV HOME /home/reload
ENV PATH /home/reload/composer/bin:$PATH

# Expose webserver
ADD etc/ /etc/

EXPOSE 80
VOLUME /var/www

# Install Behat
RUN mkdir /home/reload/composer
ADD composer.json /home/reload/composer/composer.json
RUN cd /home/reload/composer && curl http://getcomposer.org/installer | php
RUN cd /home/reload/composer && php composer.phar install --prefer-source

RUN service php5-fpm start

ENTRYPOINT ["/usr/sbin/nginx"]
