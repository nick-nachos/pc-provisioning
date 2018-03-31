#!/usr/bin/env bash

sudo add-apt-repository -y ppa:noobslab/themes
sudo add-apt-repository -y ppa:noobslab/icons
sudo add-apt-repository -y ppa:snwh/pulp

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install -y \
dkms build-essential git vim \
synaptic apt-xapian-index \
arc-theme paper-icon-theme paper-cursor-theme \
plank thunderbird sublime-text gimp

sudo snap install spotify
sudo snap install --classic skype

user=$(whoami)

# Templates
touch "/home/$user/Templates/Text File.txt"

# Gnome Shell Extensions
cp -r ./resources/gnome-shell/extensions "/home/$user/.local/share/gnome-shell"

# Plank
plank_themes_dir="/home/$user/.local/share/plank/themes"
plank_launchers_dir="/home/$user/.config/plank/dock1/launchers"
rm -rf "$plank_themes_dir"
rm -rf "$plank_launchers_dir"
mkdir -p "$plank_themes_dir"
mkdir -p "$plank_launchers_dir"
cp -r "./resources/plank/themes/Arc-Dark" "$plank_themes_dir"
cp ./resources/plank/launchers/* "$plank_launchers_dir"

# Startup applications
apps_dir="/usr/share/applications"
autostart_dir="/home/$user/.config/autostart"
cp "$apps_dir/plank.desktop" "$autostart_dir"
