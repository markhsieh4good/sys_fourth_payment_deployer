FROM php:5.6-fpm

LABEL maintainer="Alvin Chen, https://www.alvinchen.club/"
 
RUN apt-get update && \
    apt-get install --no-install-recommends --no-install-suggests -y -q \
    libzip-dev zip git libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libssl-dev \
    libmemcached-dev \
    libz-dev \
    zlib1g-dev \
    libsqlite3-dev \
    libxml2-dev \
    libcurl3-dev \
    libedit-dev \
    libpspell-dev \
    libldap2-dev \
    unixodbc-dev \
    libpq-dev \
    wget \
    vim \
    net-tools \
    curl \
    supervisor
 
RUN apt-get install -y libzip-dev zip
RUN docker-php-ext-configure zip --with-libzip
RUN docker-php-ext-install mysqli pdo pdo_mysql mysql zip

RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d \
    && rm -rf /etc/nginx/conf.d/default.conf

## install composer
RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
    && curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
    && php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }" \
    && php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION} \
    && rm -rf /tmp/composer-setup.php \
    # Clean up
    && rm -rf /tmp/pear \
    && apt-get purge -y --auto-remove $buildDeps \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*


