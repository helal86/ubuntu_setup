# ubuntu_setup
Ubuntu post install script to install all programs + settings the way I like it

# post install

MSVPN
SKVPN
.ssh
.aws
.azure
Chrome Users
Sublime Text - Material Theme, plugins - https://packagecontrol.io/packages/Material%20Theme
BashIT - +powerline theme - https://github.com/Bash-it/bash-it

fix case bash - 

# If ~./inputrc doesn't exist yet, first include the original /etc/inputrc so we don't override it
if [ ! -a ~/.inputrc ]; then echo '$include /etc/inputrc' > ~/.inputrc; fi

# Add option to ~/.inputrc to enable case-insensitive tab completion
echo 'set completion-ignore-case On' >> ~/.inputrc

make sublime default - https://askubuntu.com/questions/396938/how-do-i-make-sublime-text-3-the-default-text-editor

AlternateTab  by fmuellner ONOFF
Substitute Alt-Tab with a window based switcher that does not group by application.

system-monitor  by Cerin

