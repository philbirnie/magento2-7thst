FROM php:7.1-fpm

COPY conf/php.ini /usr/local/etc/php/

RUN apt-get update && apt-get install -y \
        g++ \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libxml2-dev \
        libicu-dev \
        libxslt-dev \
        unzip \
        git \
        zip \
        && docker-php-ext-install pdo_mysql \
        && docker-php-ext-install mcrypt \
        && docker-php-ext-install zip \
        && docker-php-ext-install soap \
        && docker-php-ext-install intl \
        && docker-php-ext-install xsl \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install -j$(nproc) gd

RUN cd /var/www && \
    curl --silent --show-error https://getcomposer.org/installer | php
