#!/bin/bash

#Variaveis
NOME=DIONATHAN-NOTE

#Setando hostname
hostname -b $NOME

#Atualizando sistema
yum update -y --exclude kernel*

#Habilitar para poder adicionar repos
yum install -y yum-utils

#Adionandos Repos
yum-config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo

echo "[google-chrome]
name=google-chrome
baseurl=https://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub" > /etc/yum.repos.d/google-chrome.repo

rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo "[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo

yum install -y http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm
yum install -y http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-rawhide.noarch.rpm

#Instalando programas
yum install -y snapd
yum install -y google-chrome-stable.x86_64
yum install -y code
yum install -y sublime-text
yum install -y flameshot
yum install -y parcellite
yum install -y remmina
yum install -y git
yum install -y ocsinventory-agent
yum insyall -y vlc

#VirtualBox
wget -P /tmp https://download.virtualbox.org/virtualbox/6.1.26/VirtualBox-6.1-6.1.26_145957_fedora33-1.x86_64.rpm
yum localinstall -y /tmp/VirtualBox-6.1-6.1.26_145957_fedora33-1.x86_64.rpm

#Anydesk
yum -y --releasever=32 install pangox-compat.x86_64
wget -P /tmp https://download.anydesk.com/linux/anydesk_6.1.1-1_x86_64.rpm
yum localinstall -y /tmp/anydesk_6.1.1-1_x86_64.rpm

#Configs

echo "server = http://10.10.10.10/ocsinventory
# local = /var/lib/ocsinventory-agent
# tag = $NOME
# How to log, can be File,Stderr,Syslog
logger = Stderr
logfile = /var/log/ocsinventory-agent/ocsinventory-agent.log" > /etc/ocsinventory/ocsinventory-agent.cfg 

#Snap
snap install spotify
snap install authy
snap install obs-studio

#Reiniciando
sleep 60
reboot
