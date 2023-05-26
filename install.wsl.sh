#!/bin/sh
set -e

echo "Create folder struct"
mkdir -p /var/www/bitrix && \
cd /var/www && \
rm -f /var/www/bitrix/bitrixsetup.php && \
wget https://www.1c-bitrix.ru/download/scripts/bitrixsetup.php -P /var/www/bitrix/ && \
rm -rf /var/www/bitrixdock && \
git clone https://github.com/bitrixdock/bitrixdock.git && \
chmod -R 775 /var/www/bitrix && chown -R root:www-data /var/www/bitrix && \

echo "Config"
cp -f /var/www/bitrix/.env_template /var/www/bitrix/.env

echo "Run"
docker compose -p bitrixdock down
docker compose -f /var/www/bitrix/docker-compose.yml -p bitrixdock up -d