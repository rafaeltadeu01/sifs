#!/bin/bash

## Variaveis de configuraÃ§Ã£o
USERADDCOMP=$1
echo "DIGITE O NOME DO USUARIO PARA INGRESSAR ESSA MAQUINA NO DOMINIO:"
read USERADDCOMP

echo  "O USUARIO PARA AUTENTICACAO NO DOMINIO FICOU: tempopar/"$USERADDCOMP
sleep 10

echo "PREPARANDO AS DEPENDECIAS NECESSARIAS:"
echo -----------------------------------------------------------
sleep 5
##Â  instalaÃ§Ã£o da dependencias
apt update
apt install -y realmd \
sssd \
sssd-tools \
libnss-sss \
libpam-sss \
adcli \
samba-common-bin \
oddjob \
oddjob-mkhomedir \
packagekit

apt install -y heimdal-clients
apt install -y krb5-user

echo "CONFIGURANDO O AMBIENTE:"
echo -----------------------------------------------------------
sleep 5
## service messagebus start && \
service oddjobd start
systemctl enable oddjobd
adcli info tempopar.intranet

adcli join -U $USERADDCOMP -D tempopar.intranet
klist -kt

## Criando o arquivo: sssd.conf
touch /etc/sssd/sssd.conf
cat << EOF > /etc/sssd/sssd.conf
[sssd]
services = nss, pam, ssh, autofs
config_file_version = 2
domains = tempopar.intranet
[domain/tempopar.intranet]
id_provider = ad
access_provider = ad
# Uncomment if service discovery is not working
# ad_server = server.win.example.com
ad_domain = tempopar.intranet
krb5_realm = tempopar.intranet
realmd_tags = manages-system joined-with-samba
cache_credentials = True
krb5_store_password_if_offline = True
default_shell = /bin/bash
ldap_id_mapping = True
use_fully_qualified_names = False
fallback_homedir = /home/%d/%u
access_provider = simple
#simple_allow_users = user1,user2,...
simple_allow_groups = grpti.linuxadmins
EOF
chmod 600 /etc/sssd/sssd.conf
systemctl enable sssd

## Configurando os grupos de persmissoes de acesso
echo "session    required    pam_mkhomedir.so    skel=/etc/skel/    umask=0022" >> /etc/pam.d/common-account
echo "password       [success=1 default=ignore]      pam_winbind.so try_first_pas" >> /etc/pam.d/common-password
echo "%grpti.linuxadmins ALL=(ALL)    ALL" >> /etc/sudoers
