#!/bin/sh
set -e

echo "NGINX CONF (daemon):"
grep -n daemon /etc/nginx/nginx.conf || echo "YOK"

php bin/console doctrine:migrations:migrate --no-interaction --env=prod

php-fpm81 -D
nginx -g 'daemon off;'
