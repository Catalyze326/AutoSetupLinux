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
yes | apt install firefox
yes | apt install openssh-server
yes | apt install kvm
yes | apt install vim
yes | apt install virtualbox
yes | apt install net-tools

snap install kotlin --classic
snap install vscode --classic
snap install docker --classic
snap install android-studio --classic
snap install androidsdk

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

# Vimrc config
git clone --depth=1 https://github.com/amix/vimrc.git /opt/vim_runtime
sh ~/.vim_runtime/install_awesome_parameterized.sh /opt/vim_runtime --all

# Install dart
yes | apt-get update
yes | apt-get install apt-transport-https
sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
yes | apt-get update
yes | apt-get install dart
export PATH="$PATH:/usr/lib/dart/bin"

yes | apt update
yes | apt upgrade
yes | apt full-upgrade
yes | apt autoremove
echo download the selenium gekodriver. I did not want to get an old one so I ignored that.