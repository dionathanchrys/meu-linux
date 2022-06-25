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

#Instalando programas
#Google Chrome
echo " " && echo "#######################################" && echo "Baixando Google Chrome" && echo "#######################################" && echo " "
wget -P /tmp https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
echo " " && echo "#######################################" && echo "Instalando Google Chrome" && echo "#######################################" && echo " "
apt install -y /tmp/google-chrome-stable_current_amd64.deb

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
yum install -y code
yum install -y git
yum install -y sublime-text
yum install -y flameshot
yum install -y parcellite
yum install -y remmina
yum insyall -y vlc

#VirtualBox
wget -P /tmp https://download.virtualbox.org/virtualbox/6.1.26/VirtualBox-6.1-6.1.26_145957_fedora33-1.x86_64.rpm
yum localinstall -y /tmp/VirtualBox-6.1-6.1.26_145957_fedora33-1.x86_64.rpm

#Anydesk
yum -y --releasever=32 install pangox-compat.x86_64
wget -P /tmp https://download.anydesk.com/linux/anydesk_6.1.1-1_x86_64.rpm
yum localinstall -y /tmp/anydesk_6.1.1-1_x86_64.rpm

#Snap
snap install spotify
snap install authy
snap install obs-studio

#Reiniciando
sleep 60
reboot