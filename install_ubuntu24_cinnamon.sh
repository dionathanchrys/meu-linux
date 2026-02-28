#!/bin/bash
# Cons
download_dir=/install-script

# Vars
v_kubectl=1.35
v_stern=1.33.1
url_veracrypt="https://launchpad.net/veracrypt/trunk/1.26.24/+download/veracrypt-1.26.24-Ubuntu-24.04-amd64.deb"
url_virtualbox="https://download.virtualbox.org/virtualbox/7.2.6/virtualbox-7.2_7.2.6-172322~Ubuntu~noble_amd64.deb"
url_freelense="https://github.com/freelensapp/freelens/releases/download/v1.8.1/Freelens-1.8.1-linux-amd64.deb"
url_k9s="https://github.com/derailed/k9s/releases/download/v0.50.18/k9s_linux_amd64.deb"
url_kind="https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-amd64"

####################################################################
echo "Executar esse script como root, caso não esteja cancele agora!"
echo "Pressione ENTER para continuar"
read
####################################################################
mkdir /install-script

echo " " && echo "Atualizando sistema (apt UPDATE)" && echo " "
apt update -y
apt install -y apt-transport-https ca-certificates curl gnupg

#Adicionando repos
echo " " && echo "Adicionando repos Sublime Text" && echo " "
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list

echo " " && echo "Adicionando repos Kubernetes" && echo " "
curl -LO https://dl.k8s.io/release/v${v_kubectl}/bin/linux/amd64/kubectl
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v${v_kubectl}/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list

echo " " && echo "Adicionando repos Postgres" && echo " "
install -d /usr/share/postgresql-common/pgdg
curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc
sh -c 'echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

echo " " && echo "Adicionando repos GCloud CLI" && echo " "
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

echo " " && echo "Adicionando repos VS Code" && echo " "
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft.gpg > /dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

echo " " && echo "Adicionando repos Docker" && echo " "
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

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

#Postman
echo " " && echo "Instalando Postman" && echo " "
wget -O $download_dir/postman.tar.gz https://dl.pstmn.io/download/latest/linux_64
echo " " && echo "Instalando Postman" && echo " "
tar -xvf $download_dir/postman.tar.gz -C /opt
ln -s /opt/Postman/Postman /usr/local/bin/Postman

#Sublime Text
echo " " && echo "Instalando Sublime Text" && echo " "
apt install -y sublime-text

#Sublime Merge
echo " " && echo "Instalando Sublime Merge" && echo " "
apt install -y sublime-merge

#VS Code
echo " " && echo "Instalando VS Code" && echo " "
apt install -y code

#VeraCrypt
echo " " && echo "Baixando VeraCrypt" && echo " "
wget -O $download_dir/veracrypt.deb $url_veracrypt
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
echo " " && echo "Instalando Docker Engine e Docker Compose" && echo " "
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
##Adicionando usuário ao grupo docker
echo " " && echo "Adicionando usuário ao grupo docker" && echo " "
usermod -aG docker $USER
newgrp docker

#Kubernetes
echo " " && echo "Instalando kubectl" && echo " "
apt install -y kubectl

##Stern
wget -O $download_dir/stern.tar.gz https://github.com/stern/stern/releases/download/v${v_stern}/stern_${v_stern}_linux_amd64.tar.gz
tar -xvf $download_dir/stern.tar.gz -C $download_dir
mv $download_dir/stern /usr/local/bin
chmod +x /usr/local/bin/stern

##FreeLens
echo " " && echo "Baixando FreeLens" && echo " "
wget -O $download_dir/freelens.deb $url_freelense
echo " " && echo "Instalando FreeLens" && echo " "
apt install -y $download_dir/freelens.deb

##K9S
echo " " && echo "Baixando K9S" && echo " "
wget -O $download_dir/k9s.deb $url_k9s
echo " " && echo "Instalando K9S" && echo " "
apt install -y $download_dir/k9s.deb

#Kind
curl -Lo $download_dir/kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-amd64
chmod +x $download_dir/kind
sudo mv $download_dir/kind /usr/local/bin/kind

#VirtualBox
echo " " && echo "Baixando VirtualBox" && echo " "
wget -O $download_dir/virtualbox.deb $url_virtualbox
echo " " && echo "Instalando VirtualBox" && echo " "
apt install -y $download_dir/virtualbox.deb

# Postgres Client
echo " " && echo "Instalando Postgres Client" && echo " "
apt install -y postgresql-client-14 postgresql-client-15 postgresql-client-16

# GCloud CLI
echo " " && echo "Instalando GCloud CLI" && echo " "
apt install -y google-cloud-cli

#Anydesk
# echo " " && echo "Baixando libpangox" && echo " "
# wget -O $download_dir/libpangox.deb http://ftp.us.debian.org/debian/pool/main/p/pangox-compat/libpangox-1.0-0_0.0.2-5.1_amd64.deb

# echo " " && echo "Instalando libpangox" && echo " "
# apt install $download_dir/libpangox.deb

# echo " " && echo "Baixando Anydesk" && echo " "
# wget -O $download_dir/anydesk.deb https://download.anydesk.com/linux/anydesk_6.2.0-1_amd64.deb

# echo " " && echo "Instalando Anydesk" && echo " "
# apt install -y $download_dir/anydesk.deb

#Precisa para funcionar copy do K9S
apt install -y xclip

#ZSH
echo " " && echo "Instalando ZSH" && echo " "
apt install -y zsh
echo " " && echo "Configurando ZSH como default" && echo " "
chsh -s $(which zsh)

echo " " && echo "Instalando Oh My " && echo " "
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

#Auto completions
echo 'source <(kubectl completion zsh)' >> /home/$SUDO_USER/.zshrc
echo 'source <(kubectl completion bash)' >> /home/$SUDO_USER/.bashrc
echo 'source <(stern completion zsh)' >> /home/$SUDO_USER/.zshrc
echo 'source <(stern completion bash)' >> /home/$SUDO_USER/.bashrc
echo 'source <(kind completion zsh)' >> /home/$SUDO_USER/.zshrc
echo 'source <(kind completion bash)' >> /home/$SUDO_USER/.bashrc

#Know Hosts
echo " " && echo "Adicionando github.com e Azure DevOps aos known hosts" && echo " "
echo "Host vs-ssh.visualstudio.com    
    HostName vs-ssh.visualstudio.com
    User git
    IdentityFile ~/VC
    PubkeyAcceptedAlgorithms +ssh-rsa
    HostkeyAlgorithms +ssh-rsa

Host ssh.dev.azure.com
    HostName ssh.dev.azure.com
    User git
    IdentityFile ~/VC
    PubkeyAcceptedAlgorithms +ssh-rsa
    HostkeyAlgorithms +ssh-rsa
" >> /home/$SUDO_USER/.ssh/known_hosts

#Snap
echo " " && echo "Instalando Spotify" && echo " "
snap install spotify
echo " " && echo "Instalando Slack" && echo " "
snap install slack
echo " " && echo "Instalando OBS Studio" && echo " "
snap install obs-studio