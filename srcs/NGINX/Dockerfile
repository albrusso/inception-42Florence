# Dockerfle Nginx

FROM debian:bullseye

RUN	apt-get update && \
	apt-get install -y nginx openssl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Copia dei file di configurazione per Nginx e certificati
COPY nginx.conf /etc/nginx/nginx.conf
COPY ssl/ /etc/nginx/ssl

# Esponi solo la porta 443 per HTTPS
EXPOSE 443

CMD ["nginx", "-g", "deamon off;"]
