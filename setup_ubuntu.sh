
#!/bin/bash
# This is a system installer v1

echo starting script
username=$(whoami)
echo $username

#add repositories 
sudo add-apt-repository -y ppa:moka/stable
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
sudo add-apt-repository -y ppa:numix/ppa
sudo add-apt-repository -y ppa:tualatrix/ppa
sudo add-apt-repository -y ppa:nvbn-rm/ppa
sudo add-apt-repository -y ppa:shutter/ppa
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update

#Install icons &  theme - numix selected
sudo apt-get install -y moka-icon-theme numix-gtk-theme numix-icon-theme-circle 

#Install standard packages
sudo apt-get install -y software-properties-common apt-transport-https curl ca-certificates android-tools-adb android-tools-fastboot docker-ce build-essential filezilla filezilla-common g++ htop git git-core git-man gparted gvncviewer java-common postgresql-client postgresql-client-common python2.7-dev rdesktop screen unity-tweak-tool unzip unrar vlc whois openssh-server openjdk-8-jdk p7zip remmina testdisk virtualbox python-pip sublime-text-installer exfat-utils variety gimp vagrant azure-cli shutter 

#Installing Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

#Installing google-talk-plugin
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google-talkplugin.list'

#Dropbox
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
sudo sh -c 'echo "deb http://linux.dropbox.com/ubuntu/ $(lsb_release -cs) main" >> /etc/apt/sources.list.d/dropbox.list'

#Azure CLI
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | \
     sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893

sudo apt-get update
sudo apt-get install -y google-chrome-stable
sudo apt-get install -y google-talkplugin
sudo apt-get install -y dropbox

#Install AWS CLI
sudo pip install --no-input awscli

#Install Microsoft Teams
cd ~/Downloads
wget https://github.com/ivelkov/teams-for-linux/releases/download/v0.0.4/teams-for-linux_0.0.4_amd64.deb
sudo dpkg -i -y teams-for-linux_0.0.4_amd64.deb

sudo apt-get -f install
sudo apt-get -y upgrade

echo starting tweaks

#disable guest login
echo allow-guest=false | sudo tee -a /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf

#disable online search via unity tweak
unity-tweak-tool


