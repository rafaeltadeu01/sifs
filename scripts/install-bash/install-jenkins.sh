#!/bin/bash
## Instalação do jenkins para o ubuntu 20.04

sudo apt install openjdk-11-jre-headless

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y

sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins

sudo ufw allow 8080