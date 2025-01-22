#!/bin/bash

# Recupera le variabili dall'ambiente
ROOT_PASS=$MYSQL_ROOT_PASSWORD
USER_PASS=$USER_PASS_DB

echo "Database user: $MYSQL_USER"

# Verifica che tutte le variabili richieste siano definite
if [ -z "$MYSQL_ROOT_PASSWORD" ] || [ -z "$USER_PASS_DB" ] || [ -z "$WP_DB_NAME" ] || [ -z "$DB_USER" ]; then
    echo "Error: Missing required environment variables."
    exit 1
fi

if [ ! -d "/var/lib/mysql/${WP_DB_NAME}" ]; then
    cat << EOF > /tmp/init_mariadb.sql
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASS}';
CREATE DATABASE ${WP_DB_NAME};
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${USER_PASS}';
GRANT ALL PRIVILEGES ON ${WP_DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    # Esegue l'inizializzazione del database
    mariadbd --user=mysql --bootstrap < /tmp/init_mariadb.sql
    if [ $? -ne 0 ]; then
        echo "Error: Failed to initialize MariaDB."
        exit 1
    fi

    # Rimuove il file temporaneo
    rm -f /tmp/init_mariadb.sql
else
    echo "MariaDB database for WordPress already installed..."
fi

# Assicura i permessi corretti sulla directory del database
chown -R mysql:mysql /var/lib/mysql

echo "Running the database now..."
exec mariadbd --user=mysql --bind-address=0.0.0.0
