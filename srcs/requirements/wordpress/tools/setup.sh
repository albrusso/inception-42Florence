#!/bin/bash

echo "🔹 Attendo che MariaDB sia pronto..."
until mariadb -h$DB_HOST -u$DB_USER -p$DB_PASS -e "SELECT 1" &>/dev/null; do
    sleep 3
done

echo "✅ MariaDB è pronto!"

# Configura il file wp-config.php
if [ ! -f wp-config.php ]; then
    echo "🛠️ Creazione del file wp-config.php..."
    wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST --allow-root
fi

# Installa WordPress se non è già installato
if ! wp core is-installed --allow-root; then
    echo "🚀 Installazione di WordPress..."
    wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN" --admin_password="$WP_PASS" --admin_email="$WP_EMAIL" --allow-root
    echo "✅ WordPress installato con successo!"
else
    echo "✅ WordPress è già installato."
fi

# Avvia PHP-FPM
echo "🚀 Avvio PHP-FPM..."
php-fpm7.4 -F
