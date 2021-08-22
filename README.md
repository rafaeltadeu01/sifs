# SIFS -Sofwares Instalados de Forma Simples
## Criado por: Rafael Tadeu Lima Almeida
### Descrição: Scripts projetados para facilitar e simplificar a instalação de muitos produtos, principalmente para uso de aprendizagem e laboratório.
#### site pessoal: rafaeltadeu01.wordpress.com
#### e-mail pessoal: rafaeltadeu01@hotmail.com

<br>

# MANUAL DE UTILIZAÇÃO

## Utilizando o Gerenciado de instalações do SIFS
Após fazer o download do projeto para o seu servidor ubuntu execute os comandos abaixo;

### 1º execute o comando:
`$ sudo chmod +x manager.sh`

### 2º execute o script
`$ sudo ./manager.sh`

O assistente oferece um conjuntos de deploys pré-configurado para auxiliar a instalação de um dos softwares preveamente cadastrado, este assistente foi desenvolvido para ser execultado na distribuição do "Linux Ubuntu 20.04 Server" e caso está distribuição não tiver instalado o docker e docker-compose você pode instala-los utilizando a opção 0 da primeira janela do assistente.
Video para auxilio: https://youtu.be/aKZ8pFAETTI
<br>

## Abaixo as configurações do pós deploy da aplicação instalada
<br>

### Pós instalação do Portainer
http://"endereçodeip":9000
Necessario realizar o cadastro do usuario admintrador e a configuração do painel.<br>
[Clique Aqui](https://youtu.be/ZYzRiCxeNj4) Video para auxilio
<br>

### Pós instalação do NGINX PROXY MANGAGER
http://"endereçodeip":81
<br>

Os dados para primeiro acesso são:
MAIL: admin@example.com
PASS: changeme <br>
[Clique Aqui](https://youtu.be/ZdStRCq5QT4) Video para auxilio
<br>

### Pós instalação do GLPI
http://"endereçodeip":8030
<br>

Necessario realizar o cadastro da aplicação e banco de dados.
Os dados para primeiro acesso são:
USER: glpi
PASS: glpi<br>
[Clique Aqui](https://youtu.be/sXZZl5XDB9k) Video para auxilio
<br>

## Pós instalação do OCSInventory
http://"endereçodeip":8040/ocsreports
USER: admin  
PASS: admin<br>
[Clique Aqui](https://youtu.be/0EO832SH5Fg) Video para auxilio
<br>

## Pós instalação do syspass
https://"endereçodeip":8543
Necessario realizar o cadastro da aplicação, usuario administrador e o banco de dados.<br>
[Clique Aqui](https://youtu.be/7KlgCBppCKc) Video para auxilio
<br>

## Pós instalação do Netbox
https://"endereçodeip":8060
USER: admin  
PASS: admin<br>
[Clique Aqui](https://youtu.be/ycvGeMpC1pA) Video para auxilio
<br>

## Pós instalação do Rancher
Acesso ao sistema: https://"endereçodeip":8070

# Sistemas em processo de homologação
## Pós instalação do Nagios
https://"endereçodeip":8110
USER: nagiosadmin  
PASS: nagios<br>

## Pós instalação do jira 
https://"endereçodeip"
USER: nagiosadmin  
PASS: nagios<br>

## Pós Intalação Grafana
https://"endereçodeip":3000
USER: admin  
PASS: admin<br>

## Pós Intalação Duplicati
https://"endereçodeip":8200<br>

## Pós Intalação Jenkins
https://"endereçodeip":8083
USER: admin  
PASS: dentro de: /var/jenkins_home/secrets/initialAdminPassword<br>

## Pós Intalação OMNIDB
https://"endereçodeip":8084
USER: admin  
PASS: admin<br>

## Pós Intalação Nessus
https://"endereçodeip":8834
USER: admin  
PASS: admin<br>

## Pós instalação do Odoo
https//"endereçodeip":8069
Necessario configurar a database inicial<br>

## Pós instalação do Guacamole
https//"endereçodeip":8443
USER: guacadmin  
PASS: guacadmin<br>

## Pós instalação do Wordpress
https//"endereçodeip":8220
Necessario configurar a database inicial<br>

# Instalações em processos de ajustes
## Pós instalação do Graylog
https://"endereçodeip":9010
USER: admin  
PASS: admin<br>
documentação oficial:
https://docs.graylog.org/en/4.0/pages/installation/docker.html<br>

## Pós instalação do Gitlab
https://"endereçodeip":****
USER: admin  
PASS: admin<br>
Documentação Oficial
https://docs.gitlab.com/ee/install/docker.html<br>

## Pós instalação do sonarqube
https://"endereçodeip":9020
USER: admin  
PASS: admin<br>
Documentação deste projeto
https://github.com/SonarSource/docker-sonarqube<br>
