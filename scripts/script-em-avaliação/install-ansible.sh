#!/bin/bash

## Dependencias Docker e Docker Compose

sudo apt install open-vm-tools-desktop net-tools python3-pip python-setuptools ansible pwgen -y && \
git clone -b 17.0.1 https://github.com/ansible/awx.git

cd awx/installer
keyscret=`pwgen -N 1 -s 30`
sed -i s/"# admin_password=password"/admin_password=admin/g inventory
sed -i s/"secret_key=awxsecret"/secret_key=$keyscret/g inventory

ansible-playbook -i inventory install.yml 