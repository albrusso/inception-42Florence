FROM debian:bullseye
RUN apt-get update && apt-get install -y nginx openssl
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh
CMD ["/setup.sh"]