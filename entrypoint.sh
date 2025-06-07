#!/bin/sh
set -ex

echo "PWD: $(pwd)"
ls -l
ls -l bin
which php
php --version
ls -l bin/console
php bin/console --version || true

php bin/console doctrine:migrations:migrate --no-interaction --env=prod || true

php-fpm81 -D || true
nginx -g 'daemon off;'
