#!/usr/bin/env bash

apt update
apt upgrade

apt install -y apt-transport-https curl

# 1Password - 
curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | tee /etc/apt/sources.list.d/1password.list
mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

# Vagrant - https://www.vagrantup.com/downloads
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list

apt update

apt install -y \
    apt-xapian-index synaptic gnome-tweaks chrome-gnome-shell gnome-shell-extension-manager \
    zsh zsh-autosuggestions zsh-syntax-highlighting fonts-powerline \
    dkms build-essential git vim meld \
    virtualbox virtualbox-qt virtualbox-guest-additions-iso virtualbox-guest-utils virtualbox-guest-x11 vagrant \
    gimp evolution aspell aspell-en 1password \
    texmaker texlive-fonts-extra

snap install brave signal-desktop slack spotify
snap install --classic code

# Apple keyboard compatibility
echo options hid_apple fnmode=2 | tee -a /etc/modprobe.d/hid_apple.conf
update-initramfs -u -k all
