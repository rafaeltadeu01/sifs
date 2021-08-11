#!/bin/bash

##Variaveis do manager
pathdir=~/sifs

cabecario(){
clear
separador="------------------------------------------------------------------"
echo $separador
echo "SIFS"
echo "Sofwares Instalados de Forma Simples"
echo "Autor: Rafael Tadeu Lima Almeida"
echo "Versão: 1.0"
echo "Contato: rafaeltadeu01@hotmail.com"
echo $separador
}

menuinicial(){
echo "Escolha uma das opções abaixo:"
echo "0 - Pré-Instalação dos componentes necessario para a versao do Ubuntu 18.04 Server."
echo "1 - Instalação de um softwares."
echo "2 - Deslistalação de um software."
echo "3 - Sair deste assistente."
echo $separador
read -p "DIGITE SUA OPÇÃO:" escolha
case $escolha in
0)
  echo "Verificando e preparando o ambinete de Pré-instalação"
  preinstall
;;
1)
  echo "Escolha um dos softwares para ser instalado"
  installsoft
;;
2)
  echo "Escolha um dos softwares para se desinstalado"
  Desinstallsoft
;;
3)
  clear
  exit
  
;;
*)
  echo "escolha uma das opções abaixo"
  menuinicial
;;
esac
}

selectinstall(){
    cabecario
    echo "Voce deseja instalar o $software?"
    echo "(S)im ou (N)ão"
    read -p "DIGITE SUA OPÇÃO:" escolha
    case $escolha in
        s)
            echo "Verificando e preparando a instalação do $software"
            sudo docker ps |grep $software
            check=`sudo echo $?`
            if [ $check = 0 ];then
                echo " "
                echo "... o serviço do $software já encontra-se instalado"
                sleep 3
                installsoft
            else
                cd $pathdir/docker-compose/$software
                sudo chmod +x pre-install.sh
                sudo ./pre-install.sh
                sudo docker-compose -p $software up -d
            fi
        ;;
        n)
            installsoft
        ;;
        *)
            selectinstall
        ;;
        esac
}

selectuninstall(){
    cabecario
    echo "Voce deseja Desinstalar o $software?"
    echo "(S)im ou (N)ão"
    read -p "DIGITE SUA OPÇÃO:" escolha
    case $escolha in
        s)
            echo "Verificando e preparando a Desinstalação do $software"
            sudo docker ps |grep $software
            check=`sudo echo $?`
            if [ $check = 0 ];then
                cd $pathdir/docker-compose/$software
                sudo docker-compose down
                        echo "Voce deseja realizar a limpeza do $software?"
                        echo "Deseja realizar uma limpeza dos arquivos que não estão mais em uso ?"
                        echo "ATENÇÃO ESSA LIMPEZA IRAR APAGAR TUDO QUE É RALACIONADO AO $software PRINCIPALMENTE OS DADOS"
                        echo "TAMBEM APAGARA DADOS DE OUTROS CONTAINERS QUE ESTEJÃO DESLIGADOS"
                        echo "(S)im ou (N)ão"
                        read -p "DIGITE SUA OPÇÃO:" escolha
                        case $escolha in
                            s)
                                sudo docker system prune
                                sudo docker container prune
                                sudo docker image prune 
                                sudo docker volume prune 
                                sudo docker network prune
                            ;;
                            n)
                                Desinstallsoft
                            ;;
                            *)
                                Desinstallsoft
                            ;;
                        esac 
            else
                echo "...O $software não está instalado"
                sleep 4
                Desinstallsoft
            fi
        ;;
        n)
            Desinstallsoft
        ;;
        *)
            selectuninstall
        ;;
        esac
}

###############################################################################################
preinstall(){
cabecario

sudo docker version
check=`sudo echo $?`
if [ $check = 0 ];then
    cabecario
    echo "O DOCKER já encontra-se instalado"
    sleep 3
    cabecario
    menuinicial
else 
    cabecario
    echo "Iniciando a instalação do DOCKER"
    sudo chmod +x $pathdir/scripts/install-docker.sh
    sudo $pathdir/scripts/install-docker.sh
fi
}

installsoft(){
cabecario
echo "Escolha um software para ser instalado:
1 - portainer                   6 - NetBox
2 - npm (NGINX Proxy Manager)   7 - ...desenvolvimento
3 - GLPI                        8 - ...desenvolvimento
4 - OCSInventory                9 - ...desenvolvimento
5 - sysPass                     0 - VOLTAR"
echo $separador
read -p "DIGITE SUA OPÇÃO:" escolha
case $escolha in
0)
    cabecario
    menuinicial
;;
1)
    software="portainer"
    cabecario
    echo "Voce deseja instalar o $software?"
    echo "(S)im ou (N)ão"
    read -p "DIGITE SUA OPÇÃO:" escolha
    case $escolha in
        s)
            echo "Verificando e preparando a instalação do $software"
            sudo docker ps |grep $software
            check=`sudo echo $?`
            if [ $check = 0 ];then
                echo "o serviço do Portainer já encontra-se instalado"
                sleep 3
                installsoft
            else
                echo "Instalado o serviço do Portainer:"
                sudo chmod +x $pathdir/scripts/install-docker-portainer.sh
                sudo $pathdir/scripts/install-docker-portainer.sh
            fi
        ;;
        n)
            installsoft
        ;;
        *)
            cabecario
            echo "Esconha uma das opções S para sim N para não:"
        ;;
        esac
;;
2)
    software="npm"
    selectinstall
;;
3)
    software="glpi"
    selectinstall  
;;
4)
    software="ocsinventory"
    selectinstall  
;;
5)
    software="syspass"
    selectinstall  
;;
6)
    software="netbox"
    selectinstall  
;;
7)
  installsoft ;;
8)
  installsoft ;;
9)
  installsoft ;;
*)
  echo "escolha uma das opções abaixo"
  installsoft
;;
esac
}

Desinstallsoft(){
cabecario
echo "Escolha um software para ser Desinstalado:
1 - portainer                   6 - NetBox
2 - npm (NGINX Proxy Manager)   7 - ...desenvolvimento
3 - GLPI                        8 - ...desenvolvimento
4 - OCSInventory                9 - ...desenvolvimento
5 - sysPass                     0 - VOLTAR"
echo $separador
read -p "DIGITE SUA OPÇÃO:" escolha
case $escolha in
0)
    cabecario
    menuinicial
;;
1)
    software="portainer"
    cabecario
    echo "Voce deseja Desinstalar o $software?"
    echo "(S)im ou (N)ão"
    read -p "DIGITE SUA OPÇÃO:" escolha
    case $escolha in
        s)
            echo "Verificando e preparando a Desinstalação do $software"
            sudo docker ps |grep $software
            check=`sudo echo $?`
            if [ $check = 0 ];then
                echo "Desinstalado o software: $software"
                sudo docker stop $software
                sudo docker stop "$software"_agent
                sudo docker rm $software
                sudo docker rm "$software"_agent
            else
                echo "Não foi encontrado o software: $software instalado:"
            fi
        ;;
        n)
            installsoft
        ;;
        *)
            cabecario
            echo "Esconha uma das opções S para sim N para não:"
        ;;
        esac
;;
2)
    software="npm"
    selectuninstall
;;
3)
    software="glpi"
    selectuninstall  
;;
4)
    software="ocsinventory"
    selectuninstall 
;;
5)
    software="syspass"
    selectuninstall 
;;
6)
    software="netbox"
    selectuninstall  
;;
7)
  Desinstallsoft ;;
8)
  Desinstallsoft ;;
9)
  Desinstallsoft ;;
*)
  echo "escolha uma das opções abaixo"
  Desinstallsoft
;;
esac
}

cabecario
menuinicial

