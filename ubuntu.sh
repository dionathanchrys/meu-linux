#!/bin/bash

#Variaveis
echo "Qual é o nome do host?"
read NOME

#Setando hostname
hostname -b $NOME

#Atualizando sistema
echo " " && echo "#######################################" && echo "Atualizando sistema (apt UPDATE)" && echo "#######################################" && echo " "
apt update -y
echo " " && echo "#######################################" && echo "Atualizando sistema (apt UPGRADE)" && echo "#######################################" && echo " "
apt upgrade -y

#Google Chrome
echo " " && echo "#######################################" && echo "Baixando Google Chrome" && echo "#######################################" && echo " "
wget -P /tmp https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
echo " " && echo "Instalando Google Chrome" && echo " "
apt install -y /tmp/google-chrome-stable_current_amd64.deb

echo " " && echo "#######################################" && echo "Instalando OCS Agent" && echo "#######################################" && echo " "
echo "NA PROXIMA TELA, NA INSTALAÇÃO DO OCS ESCOLHA A OPÇÃO -> LOCAL <-"
echo "Pressione enter para continuar" && read
apt install -y ocsinventory-agent

#Configs
echo " " && echo "#######################################" && echo "Configurando OCS Agent" && echo "#######################################" && echo " "
echo "server = http://10.10.10.10/ocsinventory
# local = /var/lib/ocsinventory-agent
tag = $NOME
# How to log, can be File,Stderr,Syslog
logger = Stderr
logfile = /var/log/ocsinventory-agent/ocsinventory-agent.log" > /etc/ocsinventory/ocsinventory-agent.cfg

echo " " && echo "#######################################" && echo "Rodando OCS Agent" && echo "#######################################" && echo " "
ocsinventory-agent

echo " " && echo "Qual é o usuário para criar?"
read usuario
adduser --force-badname $usuario
adduser $usuario sudo
