if [ "root" != "$USER" ]; then
  su -c "$0" root
  exit
fi

yes | apt update
yes | apt upgrade
yes | apt install git
yes | apt install mysql-server
yes | apt install wget
yes | apt install curl
yes | apt install python3-pip
yes | apt install python2-pip
yes | apt install default-jdk
yes | apt install php
yes | apt install apache2
yes | apt install openssh-server
yes | apt install kvm
yes | apt install vim
yes | apt install net-tools
yes | apt install phpmyadmin

snap install kotlin --classic
snap install docker --classic

# Install pip libs
pip3 install selenium

# Vimrc config
git clone --depth=1 https://github.com/amix/vimrc.git /opt/vim_runtime
sh ~/.vim_runtime/install_awesome_parameterized.sh /opt/vim_runtime --all

yes | apt update
yes | apt upgrade
yes | apt full-upgrade
yes | apt autoremove