#!/bin/bash
## Link da documentação utilizada: https://phoenixnap.com/kb/install-rancher-on-ubuntu


## Instalação do docker
sudo apt update
sudo apt install docker.io
docker --version
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker

## Instalação do Rancher
sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server:stable

## Acesso ao sistema: https://[server_ip]:[port]