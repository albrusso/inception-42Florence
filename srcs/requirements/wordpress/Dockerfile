# Usa Debian come base
FROM debian:bullseye

# Installa PHP, WP-CLI e dipendenze
RUN apt-get update && apt-get install -y \
    php-fpm php-mysql wget curl unzip mariadb-client && \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Creazione della directory /run/php per PHP-FPM
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php
# Imposta la cartella di lavoro
WORKDIR /var/www/html

# Copia il file di configurazione PHP-FPM
COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Copia lo script di installazione
COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

# Esegui lo script di installazione all'avvio
CMD ["/setup.sh"]
