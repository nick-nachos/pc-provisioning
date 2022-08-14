#!/usr/bin/env zsh

# Set favorite apps
gsettings set org.gnome.shell favorite-apps "[
    'pop-cosmic-launcher.desktop', 
    'pop-cosmic-workspaces.desktop', 
    'pop-cosmic-applications.desktop', 
    'gnome-control-center.desktop', 
    'synaptic.desktop', 
    'io.elementary.appcenter.desktop', 
    '1password.desktop', 
    'org.gnome.Nautilus.desktop', 
    'brave-browser.desktop', 
    'org.gnome.Epiphany.desktop', 
    'org.gnome.Evolution.desktop', 
    'org.gnome.Geary.desktop', 
    'slack.desktop', 
    'signal-desktop.desktop', 
    'spotify.desktop', 
    'org.gnome.Calculator.desktop', 
    'gnome-system-monitor.desktop', 
    'org.gnome.Terminal.desktop', 
    'org.gnome.meld.desktop', 
    'code.desktop', 
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
