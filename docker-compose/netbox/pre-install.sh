## Ajuste porta de conexão
tee docker-compose.override.yml <<EOF
version: '3.4'
services:
  netbox:
    ports:
      - 8060:8080
EOF