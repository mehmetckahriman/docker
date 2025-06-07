#!/bin/sh
set -e

php bin/console doctrine:migrations:migrate --no-interaction --env=prod

php-fpm81 -D
nginx -g 'daemon off;'
