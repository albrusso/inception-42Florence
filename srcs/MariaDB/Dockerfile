# Dockerfile per MariaDB

FROM debian:bullseye

RUN apt-get update && \
	apt-get install -y mariadb-server && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY my.cnf /etc/mysql/my.cnf

# Esponi la porta 3306 per MySQL
EXPOSE 3306

# Inizializza il database e avvia MariaDB
CMD ["mysqld"]