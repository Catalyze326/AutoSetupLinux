#!/bin/bash
if [[ $EUID -ne 0 ]]; then echo "This script must be run as root" ;exit 1; fi

yum -y update
yum -y upgrade
yum -y install git
yum -y install mysql-server
yum -y install wget
yum -y install curl
yum -y install python3-pip
yum -y install python2-pip
yum -y install default-jdk
yum -y install php
yum -y install apache2
yum -y install firefox
yum -y install openssh-server
yum -y install kvm
yum -y install vim
yum -y install virtualbox
yum -y install net-tools
yum -y install gnome-tweak-tool
yum -y install chrome-gnome-shell
yum -y install gnome-tweak-tool
yum -y install snapd
yum -y install cifs-utils

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

snap install kotlin --classic
snap install code --classic
snap install android-studio --classic
snap install androidsdk
snap install discord
snap install signal-desktop

code --install-extension ms-vscode.atom-keybindings
code --install-extension brapifra.phpserver
code --install-extension ritwickdey.liveserver
code --install-extension zignd.html-css-class-completion
code --install-extension akhail.save-typing
code --install-extension ms-python.python

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb

echo would you like to install professional jet brains products y/n
read -r professional
if [ "$professional" == y ]; then
  snap install intellij-idea-ultimate --classic
  snap install pycharm-professional --classic
  snap install phpstorm --classic
  snap install clion --classic
else
  snap install intellij-idea-community --classic
  snap install pycharm-community --classic
fi

# Install pip libs
pip3 install selenium

# Install latest selenium
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

# Install dart
yum -y install git subversion make gcc-c++
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export "$("$PATH":"$(pwd)"/depot_tools)"
cd dart || tools/build.py --mode=release --arch=x64 create_sdk

# last pass
wget https://download.cloud.lastpass.com/linux/lplinux.tar.bz2
tar xjvf lplinux.tar.bz2
cd lplinux && ./install_lastpass.sh
cd ..
rm -r iplinux
rm lplinux.tar.bz2

printf "\n//192.168.1.3/smbShare /mnt/smbShare cifs uid=0,credentials=/root/.smb,iocharset=utf8,vers=2.0,noperm 0 0" >> /etc/fstab

yum -y update
yum -y upgrade
yum -y full-upgrade
yum -y autoremove
