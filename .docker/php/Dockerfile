FROM php:8.3-fpm

RUN apt-get update

RUN apt-get install -y \
    git \
    libzip-dev \
    procps \
    unzip

# Install PHP extensions
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod uga+x /usr/local/bin/install-php-extensions && sync \
    && install-php-extensions \
    gd \
    intl \
    ldap \
    mysqli \
    pdo \
    pdo_mysql \
    pgsql \
    sockets \
    xdebug \
    zip \
    @composer \
    && rm /usr/local/bin/install-php-extensions

# Install NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash \
    && export NVM_DIR="/root/.nvm" \
    && . "$NVM_DIR/nvm.sh" \
    && nvm install 20 \
    && nvm alias default 20 \
    && nvm use default \
	&& npm install --global yarn

COPY config/* /usr/local/etc/php/conf.d/
COPY scripts/* /var/www/scripts/

VOLUME /var/www/html

WORKDIR /var/www/html

ENTRYPOINT [ "bash", "/var/www/scripts/entrypoint.sh" ]
CMD ["php-fpm"]
