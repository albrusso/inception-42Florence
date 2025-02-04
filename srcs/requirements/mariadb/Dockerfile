FROM debian:bullseye

# Installazione di MariaDB
RUN apt-get update && apt-get install -y mariadb-server

# Creazione della directory per il socket
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Configurazione di MariaDB per ascoltare su tutte le interfacce
COPY my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copia del file di inizializzazione (init.sql) nel container
COPY tools/init.sql /docker-entrypoint-initdb.d/

# Settaggio delle variabili di ambiente per MariaDB
ENV MYSQL_ROOT_PASSWORD=rootpassword
ENV MYSQL_DATABASE=wordpress
ENV MYSQL_USER=wp_user
ENV MYSQL_PASSWORD=yourpassword

# Cambia l'utente per l'esecuzione del processo a mysql
USER mysql

# Comando per avviare MariaDB
CMD ["mysqld"]
