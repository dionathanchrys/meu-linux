#!/bin/bash
#Vars
    v_kubernetes=1.25.6
    v_openLens=6.5.2-366
    download_dir=~/Downloads
####################################################################
    echo "Executar esse script como root, caso não esteja cancele agora!"
    echo "Pressione ENTER para continuar"
    read
####################################################################

#Adicionando repos
    echo " " && echo "Adicionando repos Sublime Text" && echo " "
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

    echo " " && echo "Adicionando repos Kubernetes" && echo " "
    apt install -y apt-transport-https ca-certificates curl
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list

#Atualizando sistema
    echo " " && echo "Atualizando sistema (apt UPDATE)" && echo " "
    apt update -y
    echo " " && echo "Atualizando sistema (apt UPGRADE)" && echo " "
    apt upgrade -y

#Google Chrome
    echo " " && echo "Baixando Google Chrome" && echo " "
    wget -O $download_dir/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    echo " " && echo "Instalando Google Chrome" && echo " "
    apt install -y $download_dir/google-chrome.deb

#Git
    echo " " && echo "Instalando Git" && echo " "
    apt install -y git

#Sublime Text
    echo " " && echo "Instalando Sublime Text" && echo " "
    apt install -y sublime-text

#Sublime Merge
    echo " " && echo "Instalando Sublime Merge" && echo " "
    apt install -y sublime-merge

#VS Code
    echo " " && echo "Baixando VS Code" && echo " "
    wget -O $download_dir/vscode.deb https://update.code.visualstudio.com/latest/linux-deb-x64/stable
    echo " " && echo "Instalando VS Code" && echo " "
    apt install -y $download_dir/vscode.deb

#VeraCrypt
    echo " " && echo "Baixando VeraCrypt" && echo " "
    wget -O $download_dir/veracrypt.deb https://launchpad.net/veracrypt/trunk/1.25.9/+download/veracrypt-1.25.9-Ubuntu-22.04-amd64.deb

    echo " " && echo "Instalando Veracrypt" && echo " "
    apt install -y $download_dir/veracrypt.deb

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

#Docker
    echo " " && echo "Instalando Docker Repository" && echo " "
    sudo apt-get install ca-certificates curl gnupg
    echo " " && echo "Adicionando GPG key" && echo " "
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo " " && echo "Configurando o repositório" && echo " "
    echo \
          "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
          "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    echo " " && echo "Instalando Docker Engine e Docker Compose" && echo " "
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	

#Kubernetes
    echo " " && echo "Instalando K8S e ferramentas" && echo " "
    apt install -y kubelet=$v_kubernetes-00 kubeadm=$v_kubernetes-00 kubectl=$v_kubernetes-00
    apt install -y fzf
    kubectl completion bash > /etc/bash_completion.d/kubectl
    kubeadm completion bash > /etc/bash_completion.d/kubeadm
    apt-mark hold kubectl kubelet kubeadm
    wget -O $download_dir/kubectx https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx
    wget -O $download_dir/kubens https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens
    wget -O $download_dir/stern.tar.gz https://github.com/stern/stern/releases/download/v1.24.0/stern_1.24.0_linux_amd64.tar.gz
    tar -xvf $download_dir/stern.tar.gz -C $download_dir
    mv $download_dir/kubens $download_dir/kubectx $download_dir/stern /usr/local/bin
    chmod +x /usr/local/bin/kubectx /usr/local/bin/kubens /usr/local/bin/stern

#VirtualBox
    echo " " && echo "Baixando VirtualBox" && echo " "
    wget -O $download_dir/virtualbox.deb https://download.virtualbox.org/virtualbox/7.0.6/virtualbox-7.0_7.0.6-155176~Ubuntu~jammy_amd64.deb

    echo " " && echo "Instalando VirtualBox" && echo " "
    apt install -y $download_dir/virtualbox.deb

#OpenLens
    echo " " && echo "Baixando OpenLens" && echo " "
    wget -O $download_dir/openlens.deb https://github.com/MuhammedKalkan/OpenLens/releases/download/v$v_openLens/OpenLens-$v_openLens.amd64.deb

    echo " " && echo "Instalando OpenLens" && echo " "
    apt install -y $download_dir/openlens.deb

#K9S
    echo " " && echo "Instalando K9S" && echo " "
    curl -sS https://webinstall.dev/k9s@0.31.8 | bash

#Anydesk
    # echo " " && echo "Baixando libpangox" && echo " "
    # wget -O $download_dir/libpangox.deb http://ftp.us.debian.org/debian/pool/main/p/pangox-compat/libpangox-1.0-0_0.0.2-5.1_amd64.deb

    # echo " " && echo "Instalando libpangox" && echo " "
    # apt install $download_dir/libpangox.deb

    # echo " " && echo "Baixando Anydesk" && echo " "
    # wget -O $download_dir/anydesk.deb https://download.anydesk.com/linux/anydesk_6.2.0-1_amd64.deb

    # echo " " && echo "Instalando Anydesk" && echo " "
    # apt install -y $download_dir/anydesk.deb

#Utilitarios
    #Precisa para funcionar o Graphical Hardware Monitor no painel
    apt install gir1.2-gtop-2.0
    #Precisa para funcionar copy do K9S
    apt install -y xclip

#Snap
    snap install spotify
    snap install slack
    snap install postman
    snap install obs-studio

#ZSH
    # echo " " && echo "Instalando ZSH" && echo " "
    # apt install -y zsh
    # echo " " && echo "Configurando ZSH como default" && echo " "
    # chsh -s $(which zsh)

    # echo " " && echo "Instalando Oh My " && echo " "
    # sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
