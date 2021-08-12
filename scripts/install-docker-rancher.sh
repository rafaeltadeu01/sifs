#!/bin/bash
## Link da documentação utilizada: https://phoenixnap.com/kb/install-rancher-on-ubuntu
## Instalação do Rancher
sudo docker run -d --restart=unless-stopped -p 8070:8080 rancher/server:stable
