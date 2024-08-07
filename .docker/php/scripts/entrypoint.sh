#!/bin/bash

# Set uid of host machine
usermod --non-unique --uid "${HOST_UID}" www-data
groupmod --non-unique --gid "${HOST_GID}" www-data

# Clone repository, if needed
if [ ! -d ".git" ]; then
    git config --global --add safe.directory /var/www/html
    git init
    git remote add origin https://github.com/orangehrm/orangehrm
    git fetch --depth=1 origin "${VERSION_ORANGEHRM}"
    git checkout "${VERSION_ORANGEHRM}"
    cd src
    composer i --no-dev
    cd src/client
    yarn
    yarn build
    cd -
    cd installer/client
    yarn
    yarn build
    chown -R www-data: .
fi

# Start PHP-FPM
php-fpm
