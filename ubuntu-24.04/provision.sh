#!/usr/bin/env bash

# ------------------ System Provisioning ------------------

add_brave_browser_repo() {
    # Brave browser - https://brave.com/linux/#debian-ubuntu-mint
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg && \
    sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
}

add_1password_repo() {
    # 1Password - https://support.1password.com/install-linux/#debian-or-ubuntu
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg && \
    echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list && \
    sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/ && \
    curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol && \
    sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22 && \
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
}

add_vagrant_repo() {
    # Vagrant - https://developer.hashicorp.com/vagrant/install#linux
    wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
}

add_proton_vpn_repo() {
    # https://protonvpn.com/support/official-linux-vpn-debian
    PROTON_VPN_REPO_DEB="protonvpn-stable-release_1.0.8_all.deb"
    wget -O "$HOME/Downloads/$PROTON_VPN_REPO_DEB" https://repo.protonvpn.com/debian/dists/stable/main/binary-all/$PROTON_VPN_REPO_DEB && \
    sudo dpkg -i "$HOME/Downloads/$PROTON_VPN_REPO_DEB"
}

echo "Updating repositories and upgrading the system..."
sudo apt update && sudo apt upgrade -y
if [ "$?" -ne 0 ]; then
    echo "Error: Failed to update and upgrade the system."
    exit 1
fi

echo "Installing distro packages..."
sudo apt install -y \
    apt-transport-https curl bash-completion \
    apt-xapian-index synaptic gnome-shell-extension-manager \
    zsh zsh-autosuggestions zsh-syntax-highlighting \
    dkms build-essential git vim meld \
    qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst build-essential ruby-dev libvirt-dev \
    virtualbox virtualbox-qt virtualbox-guest-additions-iso virtualbox-guest-utils virtualbox-guest-x11 \
    gimp qpdf \
    texlive texlive-fonts-extra latexmk # latex support for moderncv
if [ "$?" -ne 0 ]; then
    echo "Error: Failed to install distro packages."
    exit 1
fi

echo "Installing snap packages..."
sudo snap install signal-desktop slack spotify steam && \
sudo snap install --classic code
if [ "$?" -ne 0 ]; then
    echo "Error: Failed to install snap packages."
    exit 1
fi

echo "Adding Brave browser repository..."
add_brave_browser_repo
if [ "$?" -ne 0 ]; then
    echo "Error: Failed to add Brave browser repository."
    exit 1
fi

echo "Adding 1Password repository..."
add_1password_repo
if [ "$?" -ne 0 ]; then
    echo "Error: Failed to add 1Password repository."
    exit 1
fi

echo "Adding Vagrant repository..."
add_vagrant_repo
if [ "$?" -ne 0 ]; then
    echo "Error: Failed to add Vagrant repository."
    exit 1
fi

echo "Installing third-party repository applications..."
sudo apt update && sudo apt install -y brave-browser 1password vagrant
if [ "$?" -ne 0 ]; then
    echo "Error: Failed to install third-party repository applications."
    exit 1
fi

# Download Proton Mail Bridge installer into ~/Downloads
PROTON_BRIDGE_DEB=protonmail-bridge_3.23.1-1_amd64.deb
wget -O "$HOME/Downloads/$PROTON_BRIDGE_DEB" https://proton.me/download/bridge/$PROTON_BRIDGE_DEB && \
sudo apt install -y "$HOME/Downloads/$PROTON_BRIDGE_DEB"
if [ "$?" -ne 0 ]; then
    echo "Error: Failed to install Proton Mail Bridge."
    exit 1
fi

echo "Adding Proton VPN repository..."
add_proton_vpn_repo
if [ "$?" -ne 0 ]; then
    echo "Error: Failed to add Proton VPN repository."
    exit 1
fi

sudo apt update && sudo apt install -y proton-vpn-gnome-desktop
if [ "$?" -ne 0 ]; then
    echo "Error: Failed to install Proton VPN."
    exit 1
fi

# ------------------ User Provisioning ------------------

echo "Adding $USER to groups..."
sudo usermod -aG kvm,libvirt $USER
if [ "$?" -ne 0 ]; then
    echo "Error: Failed to add user to groups."
    exit 1
fi

echo "Setting default user shell for $USER to ZSH..."
sudo chsh -s $(which zsh) "$USER"
if [ "$?" -ne 0 ]; then
    echo "Error: Failed to change user shell to ZSH."
    exit 1
fi

echo "Setting favorite apps..."
gsettings set org.gnome.shell favorite-apps "[
    'org.gnome.Settings.desktop', 
    'update-manager.desktop', 
    'snap-store_snap-store.desktop', 
    'synaptic.desktop', 
    'org.gnome.Nautilus.desktop',
    'brave-browser.desktop', 
    'thunderbird_thunderbird.desktop', 
    'slack_slack.desktop', 
    'signal-desktop_signal-desktop.desktop', 
    'spotify_spotify.desktop', 
    'org.gnome.Calculator.desktop', 
    'org.gnome.SystemMonitor.desktop', 
    'org.gnome.Terminal.desktop', 
    'code_code.desktop'
]"
if [ "$?" -ne 0 ]; then
    echo "Error: Failed to set favorite apps."
    exit 1
fi

mkdir -p "$HOME/workspace/github/nick-nachos"

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
if [ "$?" -ne 0 ]; then
    echo "Error: Failed to install oh-my-zsh."
    exit 1
fi

echo "Deploying ZSH plugins..."
rm -rf ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
mkdir -p ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
ln -s /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh && \
rm -rf ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
mkdir -p ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
ln -s /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
if [ "$?" -ne 0 ]; then
    echo "Error: Failed to deploy ZSH plugins."
    exit 1
fi

echo "Enabling ZSH plugins..."
# Enable ZSH plugins
plugin_list=(
    git
    vagrant 
    zsh-autosuggestions 
    zsh-syntax-highlighting
)
plugins="${plugin_list[*]}"
sed -i.plugins.bak -E "s/^(plugins=\()[^)]*\)/\1${plugins})/" ~/.zshrc
if [ "$?" -ne 0 ]; then
    echo "Error: Failed to enable ZSH plugins."
    exit 1
fi
