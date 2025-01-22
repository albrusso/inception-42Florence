FROM debian:11

RUN apt-get update && apt-get install -y mariadb-server && \
	mkdir /run/mysqld && chmod 777 /run/mysqld && \
	chown mysql:mysql /run/mysqld

EXPOSE 3306

COPY ./conf/create_db.sh /create_db.sh

CMD ["sh", "create_db.sh"]