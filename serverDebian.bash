#!/bin/bash
if [[ $EUID -ne 0 ]]; then echo "This script must be run as root" ;exit 1; fi

apt -y update
apt -y upgrade
apt -y install git
apt -y install wget
apt -y install curl
apt -y install python3-pip
apt -y install python2-pip
apt -y install default-jdk
apt -y install php
apt -y install apache2
apt -y install openssh-server
apt -y install kvm
apt -y install vim
apt -y install net-tools
apt -y install cifs-utils

# Install pip libs
pip3 install selenium

install_dir="/usr/local/bin"
json=$(curl -s https://api.github.com/repos/mozilla/geckodriver/releases/latest)
if [[ $(uname) == "Darwin" ]]; then
    url=$(echo "$json" | jq -r '.assets[].browser_download_url | select(contains("macos"))')
elif [[ $(uname) == "Linux" ]]; then
    url=$(echo "$json" | jq -r '.assets[].browser_download_url | select(contains("linux64"))')
else
    echo "can't determine OS"
    exit 1
fi
curl -s -L "$url" | tar -xz
chmod +x geckodriver
sudo mv geckodriver "$install_dir"
echo "installed geckodriver binary in $install_dir"

# Vimrc config
git clone --depth=1 https://github.com/amix/vimrc.git /opt/vim_runtime
sh ~/.vim_runtime/install_awesome_parameterized.sh /opt/vim_runtime --all

# Install docker
apt -y remove docker docker-engine docker.io containerd runc
apt -y update
sudo apt -y install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
 "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
 apt -y update
 apt -y install docker-ce docker-ce-cli containerd.io

printf "\n//192.168.1.3/smbShare /mnt/smbShare cifs uid=0,credentials=/root/.smb,iocharset=utf8,vers=2.0,noperm 0 0" >> /etc/fstab

apt -y update
apt -y upgrade
apt -y full-upgrade
apt -y autoremove