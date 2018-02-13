# this is to be used as a base image
FROM php:7.1.6-apache

MAINTAINER Oluwafemi Adeosun <adexphem4real@gmail.com>

RUN apt-get update -y && apt-get install -y openssl zip unzip git vim \
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN docker-php-ext-install pdo mbstring

RUN rm -rf /var/www/html/*; rm -rf /etc/apache2/sites-enabled/*; \
    mkdir -p /etc/apache2/external

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN docker-php-ext-install pdo pdo_mysql

CMD npm install --silent

ADD ./docker/000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN a2enmod rewrite

WORKDIR /var/www/html

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]