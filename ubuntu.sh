#!/bin/bash

#Variaveis
echo "Qual é o nome do host?"
read NOME

#Setando hostname
hostname -b $NOME

#Atualizando sistema
apt-get update -y
apt-get upgrade -y

#Google Chrome
wget -P /tmp https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install -y /tmp/google-chrome-stable_current_amd64.deb

#Anydesk
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list

apt-get update -y
#Instalando programas
apt install -y ocsinventory-agent
apt install -y anydesk

#Configs

echo "server = http://10.10.10.10/ocsinventory
# local = /var/lib/ocsinventory-agent
tag = $NOME
# How to log, can be File,Stderr,Syslog
logger = Stderr
logfile = /var/log/ocsinventory-agent/ocsinventory-agent.log" > /etc/ocsinventory/ocsinventory-agent.cfg 

#Reiniciando
sleep 60
reboot
