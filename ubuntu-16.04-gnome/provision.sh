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

DESKTOP_FILES_DIR="/usr/share/applications"
SNAP_DESKTOP_FILES_DIR="/var/lib/snapd/desktop/applications"

# Templates
touch "/home/$USER/Templates/Text File.txt"

# Startup applications
AUTOSTART_DIR="/home/vagrant/.config/autostart"
mkdir -p "$AUTOSTART_DIR"
cp "$DESKTOP_FILES_DIR/plank.desktop" "$AUTOSTART_DIR"
cp "$SNAP_DESKTOP_FILES_DIR/skype_skypeforlinux.desktop" "$AUTOSTART_DIR"

# Gnome Shell Extensions
cp -r ./resources/gnome-shell/extensions "/home/$USER/.local/share/gnome-shell"

# Plank
plank_themes_dir="/home/$USER/.local/share/plank/themes"
plank_launchers_dir="/home/$USER/.config/plank/dock1/launchers"
rm -rf "$plank_themes_dir"
rm -rf "$plank_launchers_dir"
mkdir -p "$plank_themes_dir"
mkdir -p "$plank_launchers_dir"
cp -r "./resources/plank/themes/Arc-Dark" "$plank_themes_dir"
cp ./resources/plank/launchers/* "$plank_launchers_dir"
