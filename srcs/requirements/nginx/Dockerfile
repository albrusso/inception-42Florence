# Usa l'immagine base di Debian come base
FROM debian:bullseye

# Installa Nginx
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Crea la cartella per i certificati SSL
RUN mkdir -p /etc/nginx/ssl

# Copia i file di configurazione di Nginx e i certificati SSL
COPY default.conf /etc/nginx/conf.d/default.conf
COPY ssl/server.crt /etc/nginx/ssl/server.crt
COPY ssl/server.key /etc/nginx/ssl/server.key

# Esponi la porta 443 (HTTPS)
EXPOSE 443

# Comando per avviare Nginx in modalità foreground
CMD ["nginx", "-g", "daemon off;"]
