#!/bin/bash

cd /opt && \
sudo git clone https://github.com/RotherOSS/otobo-docker.git && \
cd /opt/otobo-docker && \
cp -p .docker_compose_env_https .env

# OTOBO_DB_ROOT_PASSWORD=<your_secret_password>

docker volume create otobo_nginx_ssl
otobo_nginx_ssl_mp=$(docker volume inspect --format '{{ .Mountpoint }}' otobo_nginx_ssl)
echo $otobo_nginx_ssl_mp

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/otobo.key -out /etc/ssl/certs/otobo.crt

cp /etc/ssl/private/otobo.key /etc/ssl/certs/otobo.crt $otobo_nginx_ssl_mp

OTOBO_NGINX_SSL_CERTIFICATE=/etc/nginx/ssl/ssl-cert.crt and OTOBO_NGINX_SSL_CERTIFICATE_KEY=/etc/nginx/ssl/ssl-key.key

docker-compose up --detach