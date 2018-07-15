
#!/bin/bash
# This is a system installer v1

echo starting script
username=$(whoami)
echo $username

sudo apt update
sudo apt upgrade -y 
sudo apt install -y curl wget lsb-release dirmngr snapd

#add repositories 
sudo add-apt-repository -y ppa:numix/ppa
sudo add-apt-repository -y ppa:tualatrix/ppa
sudo add-apt-repository -y ppa:nvbn-rm/ppa
sudo add-apt-repository -y ppa:shutter/ppa
sudo apt-add-repository -y ppa:ansible/ansible
sudo add-apt-repository -y ppa:peterlevi/ppa
sudo add-apt-repository -y ppa:fossproject/ppa

#Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

#Azure CLI
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.list

curl -L https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

#VS Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'


sudo apt-get update

#Install icons &  theme - numix selected
sudo apt-get install -y numix-gtk-theme numix-icon-theme-circle 

#Install standard packages
sudo apt-get install -y software-properties-common apt-transport-https curl ca-certificates android-tools-adb android-tools-fastboot docker-ce build-essential filezilla filezilla-common g++ htop git git-core git-man gparted gvncviewer java-common postgresql-client postgresql-client-common python2.7-dev rdesktop screen gnome-tweak-tool gnome-tweaks unzip unrar vlc whois openssh-server openjdk-8-jdk p7zip testdisk virtualbox python-pip  exfat-utils ansible variety gimp shutter traceroute network-manager-openvpn network-manager-openvpn-gnome green-recorder azure-cli sshuttle jq code wine-stable winetricks

#snap install 
sudo snap install skype --classic
sudo snap install sublime-text --channel 

#Installing Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

#Installing google-talk-plugin
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google-talkplugin.list'

#Dropbox
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

#Brave Browser
curl https://s3-us-west-2.amazonaws.com/brave-apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://s3-us-west-2.amazonaws.com/brave-apt `lsb_release -sc` main" | sudo tee -a /etc/apt/sources.list.d/brave-`lsb_release -sc`.list

sudo apt-get update
sudo apt-get install -y google-chrome-stable
sudo apt-get install -y brave
sudo apt-get install -y google-talkplugin

#Install AWS CLI
sudo pip install --no-input awscli

#Install Stacer
cd ~/Downloads
wget https://github.com/oguzhaninan/Stacer/releases/download/v1.0.9/stacer_1.0.9_amd64.deb
sudo dpkg -i stacer_1.0.9_amd64.deb

#Install Terraform
cd ~/Downloads
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
unzip terraform_0.11.7_linux_amd64.zip
sudo mv terraform /usr/local/bin/

#Install Vagrant
cd ~/Downloads
wget https://releases.hashicorp.com/vagrant/2.1.1/vagrant_2.1.1_linux_amd64.zip
unzip vagrant_2.1.1_linux_amd64.zip
sudo mv vagrant /usr/local/bin

sudo apt-get -f install
sudo apt-get -y upgrade

echo "starting tweaks"

~/.dropbox-dist/dropboxd

#disable guest login
echo allow-guest=false | sudo tee -a /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf

#disable online search via gnome tweak
gnome-tweak-tool



