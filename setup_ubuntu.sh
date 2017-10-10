
#!/bin/bash
# This is a system installer v1

echo starting script
username=$(whoami)
echo $username

#add repositories 
sudo add-apt-repository -y ppa:moka/stable
sudo add-apt-repository -y ppa:numix/ppa
sudo add-apt-repository -y ppa:tualatrix/ppa
sudo add-apt-repository -y ppa:nvbn-rm/ppa
sudo add-apt-repository -y ppa:shutter/ppa
sudo apt-add-repository -y ppa:ansible/ansible
sudo add-apt-repository -y ppa:peterlevi/ppa
sudo add-apt-repository -y ppa:fossproject/ppa

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update

#Install icons &  theme - numix selected
sudo apt-get install -y moka-icon-theme numix-gtk-theme numix-icon-theme-circle 

#Install standard packages
sudo apt-get install -y software-properties-common apt-transport-https curl ca-certificates android-tools-adb android-tools-fastboot docker-ce build-essential filezilla filezilla-common g++ htop git git-core git-man gparted gvncviewer java-common postgresql-client postgresql-client-common python2.7-dev rdesktop screen unity-tweak-tool unzip unrar vlc whois openssh-server openjdk-8-jdk p7zip remmina testdisk virtualbox python-pip sublime-text exfat-utils ansible variety gimp vagrant shutter traceroute network-manager-openvpn network-manager-openvpn-gnome green-recorder

#Installing Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

#Installing google-talk-plugin
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google-talkplugin.list'

#Dropbox
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

#Azure CLI
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | \
     sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893

#Brave Browser
curl https://s3-us-west-2.amazonaws.com/brave-apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://s3-us-west-2.amazonaws.com/brave-apt `lsb_release -sc` main" | sudo tee -a /etc/apt/sources.list.d/brave-`lsb_release -sc`.list

sudo apt-get update
sudo apt-get install -y google-chrome-stable
sudo apt-get install -y brave
sudo apt-get install -y google-talkplugin

#Install AWS CLI
sudo pip install --no-input awscli

#Install Microsoft Teams
cd ~/Downloads
wget https://github.com/ivelkov/teams-for-linux/releases/download/v0.0.4/teams-for-linux_0.0.4_amd64.deb
sudo dpkg -i teams-for-linux_0.0.4_amd64.deb

#Install Stacer
cd ~/Downloads
wget https://github.com/oguzhaninan/Stacer/releases/download/v1.0.8/stacer_1.0.8_amd64.deb
sudo dpkg -i stacer_1.0.8_amd64.deb

#Install Terraform
cd ~/Downloads
wget https://releases.hashicorp.com/terraform/0.9.11/terraform_0.9.11_linux_amd64.zip
unzip terraform_0.9.11_linux_amd64.zip
sudo mv terraform /usr/bin/

#Install Franz - desktop messaging 
cd ~/Downloads
sudo mkdir -p /opt/franz
wget -qO- https://github.com/meetfranz/franz-app/releases/download/4.0.4/Franz-linux-x64-4.0.4.tgz | sudo tar xvz -C /opt/franz/
sudo wget "https://cdn-images-1.medium.com/max/360/1*v86tTomtFZIdqzMNpvwIZw.png" -O /opt/franz/franz-icon.png
# configure app for desktop use
sudo bash -c "cat <<EOF > /usr/share/applications/franz.desktop                                                                 
[Desktop Entry]
Name=Franz
Comment=
Exec=/opt/franz/Franz
Icon=/opt/franz/franz-icon.png
Terminal=false
Type=Application
Categories=Messaging,Internet
EOF"


sudo apt-get -f install
sudo apt-get -y upgrade

echo "starting tweaks"

~/.dropbox-dist/dropboxd

#disable guest login
echo allow-guest=false | sudo tee -a /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf

#disable online search via unity tweak
unity-tweak-tool


