# Dockerfile per WordPress con PHP-FPM

FROM deban:bullseye

RUN apt-get update && \
	apt-get install -y php-fpm php-mysql culr wget unzip && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN culr -O https://wordpress.org/latest.tar.gz && \
	tar -xvf latest.tar.gz && \
	rm latest.tar.gz && \
	mv wordpress /var/www/html

COPY php.ini /etc/php/7.4/fpm/php.ini

WORKDIR /var/www/html

CMD ["php-fpm7.4", "--nodaemonize"]
