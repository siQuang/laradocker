FROM php:8.0-apache

# Working directory
WORKDIR /var/www/html

# Make SSL directory
RUN mkdir -p /etc/apache2/ssl

# Mod Rewrite and SSL support
RUN a2enmod rewrite && a2enmod ssl

# Update & install libraries
RUN apt-get update -y && apt-get install -y \
    libmariadb-dev \
    libpng-dev \
    libjpeg-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    nano wget \
    zlib1g-dev \
    libzip-dev \
    libicu-dev \
    apt-utils \
    git \
    curl \
    libonig-dev \ 
    libcurl4 \
    libcurl4-openssl-dev \
    unzip zip \
    iputils-ping \
    openssl && \
    rm -rf /var/lib/apt/lists/*

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# PHP Extensions
RUN docker-php-ext-install pdo_mysql mysqli intl gettext gd curl mbstring

RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

# Cleanup
RUN rm -rf /usr/src/*