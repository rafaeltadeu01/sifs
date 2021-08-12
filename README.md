SIFS
Sofwares Instalados de Forma Simples

## MANUAL DE UTILIZAÇÃO

## Utilizando o Gerenciado de instalações do SIFS
1º execute o comando:
sudo chmod +x manager.sh

2º execute o script
sudo ./manager.sh

O assistente oferece um conjuntos de deploys pré-configurado para auxiliar a instalação de um dos softwares preveamente cadastrado, este assistente foi desenvolvido para ser execultado na distribuição do "Linux Ubuntu 18.04 Server" e caso está distribuição não tiver instalado o docker e docker-compose você pode instala-los utilizando a opção 0 da primeira janela do assistente.

## Abaixo as configurações do pós deploy da aplicação instalada

## Pós instalação do Portainer
http://"endereçodeip":9000
Necessario realizar o cadastro do usuario admintrador e a configuração do painel.

## Pós instalação do NGINX PROXY MANGAGER
http://"endereçodeip":81

Os dados para primeiro acesso são:
MAIL: admin@example.com
PASS: changeme

## Pós instalação do GLPI
http://"endereçodeip":8030

Necessario realizar o cadastro da aplicação e banco de dados.
Os dados para primeiro acesso são:
USER: glpi
PASS: glpi

## Pós instalação do OCSInventory
http://"endereçodeip":8040/ocsreports

## Pós instalação do syspass
https://"endereçodeip":8543
Necessario realizar o cadastro da aplicação, usuario administrador e o banco de dados.

## Pós instalação do Netbox
https://"endereçodeip":8060
USER: admin  
PASS: admin

## Pós instalação do Rancher
Acesso ao sistema: https://"endereçodeip":8070