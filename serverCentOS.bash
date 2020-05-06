#!/bin/bash
if [[ $EUID -ne 0 ]]; then echo "This script must be run as root" ;exit 1; fi

yum update -y
yum upgrade -y
yum install -y git
yum install -y wget
yum install -y curl
yum install -y python3-pip
yum install -y python2-pip
yum install -y default-jdk
yum install -y php
yum install -y apache2
yum install -y openssh-server
yum install -y kvm
yum install -y vim
yum install -y net-tools
yum -y install cifs-utils

# Install pip libs
pip3 install selenium

# Get latest gekodriver
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
yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
yum install -y yum-utils
yum-config-manager  \
    -y \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io
printf "\n//192.168.1.3/smbShare /mnt/smbShare cifs uid=0,credentials=/root/.smb,iocharset=utf8,vers=2.0,noperm 0 0" >> /etc/fstab

yum -y update
yum -y upgrade
yum -y full-upgrade
yum -y autoremove