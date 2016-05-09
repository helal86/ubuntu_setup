
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
sudo apt-get update

: <<'COMMENT'
#Install conky infnity 
sudo apt-get install -y conky conky-all
mkdir ~/.config/autostart
cd && wget -O .start-conky http://drive.noobslab.com/data/conky/start-conky
chmod +x .start-conky

echo "
[Desktop Entry]
Type=Application
Exec=$HOME/.start-conky
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_GB]=conky
Name=conky
Comment[en_GB]=conky
Comment=Conky " >> ~/.config/autostart/.start-conky.desktop

cd && wget -O infinity-noobslab-wlan1.zip http://drive.noobslab.com/data/conky/infinity/conky-infinity-wlan.zip
unzip infinity-noobslab-wlan1.zip && rm infinity-noobslab-wlan1.zip
cd ~/Documents
echo Log out to get conky working
COMMENT

#Install icons &  theme - numix selected
sudo apt-get install -y moka-icon-theme numix-gtk-theme numix-icon-theme-circle 

#Install standard packages
sudo apt-get install -y android-tools-adb android-tools-fastboot build-essential filezilla filezilla-common g++ htop git git-core git-man gparted gvncviewer java-common postgresql-client postgresql-client-common python2.7-dev rdesktop screen unity-tweak-tool unzip unrar vlc whois wine winetricks openssh-server openjdk-8-jdk p7zip remmina testdisk virtualbox python-pip sublime-text-installer exfat-utils variety gimp vagrant 

#Installing Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

#Installiing HipChat
wget -O - https://www.hipchat.com/keys/hipchat-linux.key | sudo apt-key add -
sudo sh -c 'echo "deb http://downloads.hipchat.com/linux/apt stable main" >> /etc/apt/sources.list.d/atlassian-hipchat.list'

#Installing google-talk-plugin
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google-talkplugin.list'

#Dropbox
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
sudo sh -c 'echo "deb http://linux.dropbox.com/ubuntu/ $(lsb_release -cs) main" >> /etc/apt/sources.list.d/dropbox.list'

sudo apt-get update
sudo apt-get install -y google-chrome-stable
sudo apt-get install -y hipchat
sudo apt-get install -y google-talkplugin
sudo apt-get install -y dropbox

#Install AWS CLI
sudo pip install --no-input awscli

sudo apt-get -f install
sudo apt-get -y upgrade

echo starting tweaks

#disable guest login
echo allow-guest=false | sudo tee -a /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf

#disable online search via unity tweak
unity-tweak-tool


