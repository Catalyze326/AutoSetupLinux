#!/bin/bash
if [[ $EUID -ne 0 ]]; then echo "This script must be run as root" ;exit 1; fi

apt -y update
apt -y upgrade
apt -y install git
apt -y install wget
apt -y install curl
apt -y install python3-pip
apt -y install default-jdk
apt -y install firefox
apt -y install vim
apt -y install virtualbox
apt -y install net-tools
apt -y install gnome-tweak-tool
apt -y install cifs-utils

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

if wmctl -n  != *"Gnome Shell"*; then
  yes | apt add-apt-repository ppa:gnome3-team/gnome3
  yes | apt install gnome-shell ubuntu-gnome-desktop
fi

gsettings set org.gnome.shell.extensions.dash-to-dock customize-alphas true
gsettings set org.gnome.shell.extensions.dash-to-dock min-alpha 0
gsettings set org.gnome.shell.extensions.dash-to-dock max-alpha 0
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top false

snap refresh
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

su c && git clone --depth=1 https://github.com/amix/vimrc.git /opt/vim_runtime \
  && sh ~/.vim_runtime/install_awesome_parameterized.sh /opt/vim_runtime --all

# Install dart
apt -y update
apt -y install apt-transport-https
sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
apt -y update
apt -y install dart
export PATH="$PATH:/usr/lib/dart/bin"

# last pass
wget https://download.cloud.lastpass.com/linux/lplinux.tar.bz2
tar xjvf lplinux.tar.bz2
cd lplinux && ./install_lastpass.sh
cd ..
rm -r iplinux
rm lplinux.tar.bz2

mkdir /mnt/smbShare
printf "\n//192.168.1.2/smbShare /mnt/smbShare cifs uid=0,credentials=/root/.smb,iocharset=utf8,vers=2.0,noperm 0 0" >> /etc/fstab

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

apt -y update
apt -y upgrade
apt -y full-upgrade
apt -y autoremove
