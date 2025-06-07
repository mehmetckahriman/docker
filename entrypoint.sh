#!/bin/sh
set -e

sed -i '/daemon\s*off;/d;/daemon\s*on;/d' /etc/nginx/nginx.conf
echo "NGINX CONF (daemon):"
grep -n daemon /etc/nginx/nginx.conf || echo "YOK"

echo "Wallabag DB migration status:"
php bin/console doctrine:migrations:status --env=prod || true

echo "Wallabag DB migrate başlatılıyor:"
php bin/console doctrine:migrations:migrate --no-interaction --env=prod || true

# İstersen force schema update de uygula:
php bin/console doctrine:schema:update --force --env=prod || true

php-fpm81 -D
nginx -g 'daemon off;'
