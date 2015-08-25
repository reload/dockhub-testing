# Build from https://github.com/tomav/docker-behat/blob/master/Dockerfile
FROM ubuntu:14.04
MAINTAINER Thomas VIAL

# Update and install packages
RUN apt-get update
RUN apt-get install -y curl git vim
RUN apt-get install -y -q php5-cli php5-curl

# Create "behat" user with password crypted "behat"
RUN useradd -d /home/behat -m behat
RUN echo "behat:behat" | chpasswd

# Add "behat" to "sudoers"
RUN echo "behat        ALL=(ALL:ALL) ALL" >> /etc/sudoers

USER behat
WORKDIR /home/behat
ENV HOME /home/behat
ENV PATH $PATH:/home/behat

# Install Behat
RUN mkdir /home/behat/composer
ADD composer.json /home/behat/composer/composer.json
RUN cd /home/behat/composer && curl http://getcomposer.org/installer | php
RUN cd /home/behat/composer && php composer.phar install --prefer-source
