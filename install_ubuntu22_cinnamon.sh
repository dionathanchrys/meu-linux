#!/bin/bash

#Variaveis
    echo "Qual é o nome do host?"
    read NOME

#Setando hostname
    hostname -b $NOME

#Adicionando repos
    echo " " && echo "Adicionando repos Sublime Text" && echo " "
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

#Atualizando sistema
    echo " " && echo "Atualizando sistema (apt UPDATE)" && echo " "
    apt update -y
    echo " " && echo "Atualizando sistema (apt UPGRADE)" && echo " "
    apt upgrade -y

#Google Chrome
    echo " " && echo "Baixando Google Chrome" && echo " "
    wget -O /tmp/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    echo " " && echo "Instalando Google Chrome" && echo " "
    apt install -y /tmp/google-chrome.deb

#Sublime Text
    echo " " && echo "Instalando Sublime Text" && echo " "
    apt install -y sublime-text

#VS Code
    echo " " && echo "Baixando VS Code" && echo " "
    wget -O /tmp/vscode.deb https://update.code.visualstudio.com/latest/linux-deb-x64/stable
    echo " " && echo "Instalando VS Code" && echo " "
    apt install -y /tmp/vscode.deb

#VeraCrypt
    echo " " && echo "Baixando VeraCrypt" && echo " "
    wget -O /tmp/veracrypt.deb https://launchpad.net/veracrypt/trunk/1.25.9/+download/veracrypt-1.25.9-Ubuntu-22.04-amd64.deb
    echo " " && echo "Instalando Veracrypt" && echo " "
    apt install -y /tmp/veracrypt.deb

#SnapCraft
    # echo " " && echo "Instalando Snap" && echo " "
    # apt install -y snapd

#Git
    echo " " && echo "Instalando Git" && echo " "
    apt install -y git

#Telnet
    echo " " && echo "Instalando Telnet" && echo " "
    apt install -y telnet

#Parcellite
    echo " " && echo "Instalando Parcellite" && echo " "
    apt install -y parcellite

#Remmina
    echo " " && echo "Instalando Remmina" && echo " "
    apt install -y remmina

#Flameshot
    echo " " && echo "Instalando Flameshot" && echo " "
    apt install -y flameshot

#Filezilla
    echo " " && echo "Instalando Filezilla" && echo " "
    apt install -y filezilla

#Putty
    echo " " && echo "Instalando Putty" && echo " "
    apt install -y putty

#VLC
    echo " " && echo "Instalando VLC" && echo " "
    apt install -y vlc

#VirtualBox
    echo " " && echo "Baixando VirtualBox" && echo " "
    wget -O /tmp/virtualbox.deb https://download.virtualbox.org/virtualbox/6.1.34/virtualbox-6.1_6.1.34-150636.1~Ubuntu~jammy_amd64.deb

    echo " " && echo "Instalando VirtualBox" && echo " "
    apt install -y /tmp/virtualbox.deb

#Anydesk
    echo " " && echo "Baixando libpangox" && echo " "
    wget -O /tmp/libpangox.deb http://ftp.us.debian.org/debian/pool/main/p/pangox-compat/libpangox-1.0-0_0.0.2-5.1_amd64.deb

    echo " " && echo "Instalando libpangox" && echo " "
    apt install /tmp/libpangox.deb

    echo " " && echo "Baixando Anydesk" && echo " "
    wget -O /tmp/anydesk.deb https://download.anydesk.com/linux/anydesk_6.2.0-1_amd64.deb

    echo " " && echo "Instalando Anydesk" && echo " "
    apt install -y /tmp/anydesk.deb
    
#Utilitarios
    #Precisa para funcionar o Graphical Hardware Monitor no painel
    apt install gir1.2-gtop-2.0

#Snap
    snap install spotify
    snap install authy
    snap install obs-studio
    snap install notion-snap

# aws_cli
# ansible
# python-boto3
# python-testresources
# python-google-auth

#Reiniciando
    # sleep 60
    # reboot
