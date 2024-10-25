FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	nginx \
	openssl

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx.key \
	-out /etc/nginx/ssl/nginx.crt \
	-subj "/C=IT/ST=Italy/L=Florence/O=42/OU=42/CN=albrusso.42.fr"

COPY conf/nginx.conf /etc/nginx/conf.d/

RUN mkdir -p /run/nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]