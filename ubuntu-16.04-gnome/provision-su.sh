#!/usr/bin/env bash

add-apt-repository -y ppa:noobslab/themes
add-apt-repository -y ppa:noobslab/icons
add-apt-repository -y ppa:snwh/pulp

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list

apt-get update
apt-get upgrade

apt-get install -y \
dkms build-essential git vim \
synaptic apt-xapian-index gnome-tweak-tool snapd \
arc-theme paper-icon-theme paper-cursor-theme \
plank thunderbird sublime-text gimp

snap install spotify
snap install --classic skype
