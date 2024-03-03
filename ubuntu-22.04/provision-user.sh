#!/usr/bin/env zsh

# Set favorite apps
gsettings set org.gnome.shell favorite-apps "[
    'gnome-control-center.desktop', 
    'update-manager.desktop', 
    'snap-store_ubuntu-software.desktop', 
    'synaptic.desktop',
    '1password.desktop', 
    'org.gnome.Nautilus.desktop', 
    'brave_brave.desktop',
    'org.gnome.Epiphany.desktop', 
    'org.gnome.Evolution.desktop',  
    'slack_slack.desktop', 
    'signal-desktop_signal-desktop.desktop',
    'spotify_spotify.desktop',
    'org.gnome.Calculator.desktop', 
    'gnome-system-monitor.desktop', 
    'org.gnome.Terminal.desktop', 
    'code_code.desktop',
    'virtualbox.desktop'
]"

# Deploy system installed ZSH pluging to oh-my-zsh
rm -rf ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
mkdir -p ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
ln -s /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh 

rm -rf ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
mkdir -p ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
ln -s /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# Enable ZSH plugins
to_enable=(git vagrant zsh-autosuggestions zsh-syntax-highlighting)

source ~/.zshrc

for plugin in "${to_enable[@]}"
do 
    omz plugin enable "$plugin"
done
