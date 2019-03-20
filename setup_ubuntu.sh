
#!/bin/bash
# This is a system installer v1

echo starting script
username=$(whoami)
echo $username

sudo apt update
sudo apt upgrade -y 
sudo apt install -y curl wget lsb-release dirmngr snapd apt-transport-https lsb-release software-properties-common

#add repositories 
sudo add-apt-repository -y ppa:numix/ppa
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

sudo apt-key --keyring /etc/apt/trusted.gpg.d/Microsoft.gpg adv \
     --keyserver packages.microsoft.com \
     --recv-keys BC528686B50D79E339D3721CEB3E94ADBE1229CF

#VS Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

#Virtual Box
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" >> /etc/apt/sources.list.d/virtualbox.list'

sudo apt-get update

#Install icons &  theme - numix selected
sudo apt-get install -y numix-gtk-theme numix-icon-theme-circle 

#Install standard packages
sudo apt-get install -y ca-certificates android-tools-adb android-tools-fastboot docker-ce build-essential python-pip filezilla filezilla-common g++ htop git git-core git-man gparted gvncviewer java-common postgresql-client postgresql-client-common python2.7-dev rdesktop screen gnome-tweak-tool gnome-tweaks unzip unrar vlc whois openssh-server openjdk-8-jdk p7zip testdisk virtualbox exfat-utils ansible variety gimp shutter traceroute network-manager-openvpn network-manager-openvpn-gnome green-recorder azure-cli sshuttle jq code wine-stable winetricks chrome-gnome-shell xournal clipit python3 chromium-browser net-tools 

#snap install 
sudo snap install skype --classic
sudo snap install sublime-text --classic

# pip install 
pip install virtualenv

#Installing Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

#Dropbox
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

# Docker compose 
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

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
wget https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip
unzip terraform_0.11.11_linux_amd64.zip
sudo mv terraform /usr/local/bin/

#Install Vagrant
cd ~/Downloads
wget https://releases.hashicorp.com/vagrant/2.1.1/vagrant_2.1.1_linux_amd64.zip
unzip vagrant_2.1.1_linux_amd64.zip
sudo mv vagrant /usr/local/bin

sudo apt-get -f install
sudo apt-get -y upgrade

echo "starting tweaks"

~/.dropbox-dist/dropboxd &

sudo usermod -aG docker $username

#Install bashit
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh --silent
sed -i 's/bobby/powerline/g' ~/.bashrc

#enable lowercase bash
if [ ! -a ~/.inputrc ]; then echo '$include /etc/inputrc' > ~/.inputrc; fi
echo 'set completion-ignore-case On' >> ~/.inputrc

#set sublime as default text editor
echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Sublime Text
GenericName=Text Editor
Comment=Sophisticated text editor for code, markup and prose
Exec=/opt/sublime_text/sublime_text %F
Terminal=false
MimeType=text/plain;
Icon=sublime-text
Categories=TextEditor;Development;
StartupNotify=true
Actions=Window;Document;

[Desktop Action Window]
Name=New Window
Exec=/opt/sublime_text/sublime_text -n
OnlyShowIn=Unity;

[Desktop Action Document]
Name=New File
Exec=/opt/sublime_text/sublime_text --command new_file
OnlyShowIn=Unity;" > ~/sublime_text.desktop

sudo mv ~/sublime_text.desktop /usr/share/applications/sublime_text.desktop
sudo sed -i 's/gedit/sublime_text/g' /usr/share/applications/defaults.list

sudo sed -i "s/Icon=code/Icon=vscode/g" /usr/share/applications/code.desktop

#disable online search via gnome tweak
gnome-tweaks
