#!/bin/bash

echo "waiting for mariadb..."
sleep 10

if [ -f "/var/www/html/wp-config.php" ]; then
    echo "wp is already installed!"
    echo "php FPM is starting now"
    exec php-fpm8.2 -F
fi

if [ ! -f "/usr/local/bin/wp" ]; then 
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

mkdir -p /var/www/html/
cd /var/www/html/
# Scarica i file core di WordPress
wp core download --allow-root

# Crea il file di configurazione di WordPress
wp config create \
    --dbname=$WP_DB_NAME \
    --dbuser=$DB_USER \
    --dbpass=$USER_PASS_DB \
    --dbhost=mariadb:3306 \
    --allow-root

# Installa WordPress
wp core install \
    --url="$WP_URL" \
    --title="$WP_TITLE" \
    --admin_user="$ADMIN_WP" \
    --admin_password="$ADMIN_WP_PASSWD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --allow-root

# Crea un utente aggiuntivo
wp user create $SEC_USER_NAME $SEC_USER_EMAIL --role=editor --user_pass=$SEC_USER_PASS --allow-root

# Imposta permessi
chmod -R 777 /var/www/html/*
chown -R www-data:www-data .

echo "php FPM is starting now"
exec php-fpm8.2 -F
