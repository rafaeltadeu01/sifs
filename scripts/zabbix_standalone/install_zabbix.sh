#!/bin/bash
SEPARADOR="--------------------------------------------------------------------"

VARUSERDB="root"
VARPASSDB="PassDB1234"
VARIPHOST=`hostname -I`

echo $SEPARADOR
echo "INSTALACAO DO ZABBIX 6.0"
echo $SEPARADOR
sleep 10

echo $SEPARADOR
echo "INSTALACAO DOS COMPONETES DO ZABBIX"
echo $SEPARADOR
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-1+ubuntu$(lsb_release -rs)_all.deb
dpkg -i zabbix-release_6.0-1+ubuntu$(lsb_release -rs)_all.deb
apt update
apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

echo $SEPARADOR
echo "INSTALACAO E CONFIGURACAO DO MARIADB"
echo $SEPARADOR
apt install software-properties-common -y
curl -LsS -O https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
sudo bash mariadb_repo_setup --mariadb-server-version=10.6
apt update
apt install -y mariadb-common mariadb-server-10.6 mariadb-client-10.6
systemctl start mariadb
systemctl enable mariadb

echo $SEPARADOR
echo "CONFIGURA AS OPCOES DO BANCO DE DADOS"
echo $SEPARADOR
echo "Enter current password for root (enter for none): Press Enter"
echo "Switch to unix_socket authentication [Y/n] y"
echo "Change the root password? [Y/n] y"
echo "New password: <Enter root DB password>"
echo "Re-enter new password: <Repeat root DB password>"
echo "Remove anonymous users? [Y/n]: Y"
echo "Disallow root login remotely? [Y/n]: Y"
echo "Remove test database and access to it? [Y/n]:  Y"
echo "Reload privilege tables now? [Y/n]:  Y"
sleep 10
mysql_secure_installation

echo $SEPARADOR
echo "CONFIGURANDO O BANCO DE DADOS"
echo $SEPARADOR
mysql -uroot -p"$VARPASSDB" -e "create database zabbix character set utf8mb4 collate utf8mb4_bin;"
mysql -uroot -p"$VARPASSDB" -e "grant all privileges on zabbix.* to zabbix@localhost identified by '"$VARPASSDB"';"
echo "AGUARDE A IMPORTACAO DAS TABELAS PARA O BANCO DE DADOS..."
zcat /usr/share/doc/zabbix-sql-scripts/mysql/server.sql.gz | mysql -uzabbix -p"$VARPASSDB" zabbix
sed -i 's/# DBPassword=/DBPassword='$VARPASSDB'/g' /etc/zabbix/zabbix_server.conf
sleep 2

echo $SEPARADOR
echo "CONFIGURACAO DO FIREWALL"
echo $SEPARADOR
ufw allow 10050/tcp
ufw allow 10051/tcp
ufw allow 80/tcp
ufw reload
sleep 2

echo $SEPARADOR
echo "INICIANDO O SERVICO DO ZABBIX"
echo $SEPARADOR
systemctl restart zabbix-server zabbix-agent 
systemctl enable zabbix-server zabbix-agent
sleep 2

echo $SEPARADOR
echo "CONFIGURANDO O TIMEZONE DO PHP"
echo $SEPARADOR
sleep 2
sed -i 's/# php_value date.timezone Europe\/\Riga/php_value date.timezone America\/\Sao_Paulo/g' /etc/zabbix/apache.conf

echo $SEPARADOR
echo "REINICIANDO O SERVICO DO APACHE"
echo $SEPARADOR
systemctl restart apache2
systemctl enable apache2
sleep 2

echo $SEPARADOR
echo "INSTALACAO CONCLUIDA"
echo $SEPARADOR
echo "http://$VARIPHOST/zabbix"
