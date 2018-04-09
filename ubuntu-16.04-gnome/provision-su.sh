#!/usr/bin/env bash

apt-get update
apt-get upgrade

apt-get install -y apt-transport-https

add-apt-repository -y ppa:noobslab/themes
add-apt-repository -y ppa:noobslab/icons
add-apt-repository -y ppa:snwh/pulp

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list

apt-get update

apt-get install -y \
dkms build-essential \
synaptic apt-xapian-index gnome-tweak-tool snapd \
git vim sublime-text plank thunderbird gimp \
arc-theme paper-icon-theme paper-cursor-theme

snap install spotify
snap install --classic skype
