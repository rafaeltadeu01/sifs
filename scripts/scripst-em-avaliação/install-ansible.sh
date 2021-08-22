#!/bin/bash

## Dependencias Docker e Docker Compose

sudo apt install open-vm-tools-desktop net-tools python3-pip python-pip python-setuptools ansible pwgen -y && \
#git clone -b 17.0.1 https://github.com/ansible/awx.git
git clone -b 17.1.0 https://github.com/ansible/awx.git

cd awx/installer
keyscret=`pwgen -N 1 -s 30`
sed -i s/"# admin_password=password"/admin_password=password/g inventory
sed -i s/"secret_key=awxsecret"/secret_key=$keyscret/g inventory

ansible-playbook -i inventory install.yml 

------------------------------------------------------------------------------
dokken/centos-8
## Instação deve ser execultada no lsCentOS

yum update && yum upgrade -y && yum install -y nano && \
sudo wget https://releases.ansible.com/ansible-tower/setup-bundle/ansible-tower-setup-bundle-3.8.3-1.tar.gz && \
sudo tar -xzvf ansible-tower-setup-bundle-3.8.3-1.tar.gz && \
cd ansible-tower-setup-bundle-3.8.3-1


sed -i s/"admin_password="/admin_password=admin/g inventory
sed -i s/"secret_key=awxsecret"/secret_key=$keyscret/g inventory
