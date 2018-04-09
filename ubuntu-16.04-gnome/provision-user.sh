#!/usr/bin/env bash

WORK_DIR=$(pwd -P)
DESKTOP_FILES_DIR="/usr/share/applications"
SNAP_DESKTOP_FILES_DIR="/var/lib/snapd/desktop/applications"

# Templates
touch "/home/$USER/Templates/Text File.txt"

# Startup applications
AUTOSTART_DIR="/home/$USER/.config/autostart"
mkdir -p "$AUTOSTART_DIR"
cp "$DESKTOP_FILES_DIR/plank.desktop" "$AUTOSTART_DIR"
cp "$SNAP_DESKTOP_FILES_DIR/skype_skypeforlinux.desktop" "$AUTOSTART_DIR"

# Gnome Shell Extensions
SHELL_EXT_DIR="/home/$USER/.local/share/gnome-shell/extensions"
SHELL_EXT_DOWNLOAD_DIR="/home/$USER/Downloads/gnome-shell-extensions"

mkdir -p "$SHELL_EXT_DIR"
mkdir -p "$SHELL_EXT_DOWNLOAD_DIR"
cd "$SHELL_EXT_DOWNLOAD_DIR"

wget https://extensions.gnome.org/extension-data/ShellTile@emasab.it.v50.shell-extension.zip
wget https://extensions.gnome.org/extension-data/CoverflowAltTab@palatis.blogspot.com.v32.shell-extension.zip

SHELL_EXT_REGEX="(.+)\.v[0-9]+\.shell-extension\.zip"

for SHELL_EXT_ZIP in $(ls); do
	if [[ $SHELL_EXT_ZIP =~ $SHELL_EXT_REGEX ]]; then
		SHELL_EXT="${BASH_REMATCH[1]}"
		unzip "$SHELL_EXT_ZIP" -d "$SHELL_EXT"
		cp -r "$SHELL_EXT" "$SHELL_EXT_DIR"
	fi
done

cd /home/$USER
rm -rf "$SHELL_EXT_DOWNLOAD_DIR"

# Plank
function plank_docklet_def {
	echo -e "[PlankDockItemPreferences]\nLauncher=docklet://$1"
}

function plank_app_def {
	echo -e "[PlankDockItemPreferences]\nLauncher=file://$DESKTOP_FILES_DIR/$1.desktop"
}

function plank_snap_app_def {
	echo -e "[PlankDockItemPreferences]\nLauncher=file://$SNAP_DESKTOP_FILES_DIR/$1.desktop"
}

PLANK_THEMES_DIR="/home/$USER/.local/share/plank/themes"
PLANK_LAUNCHERS_DIR="/home/$USER/.config/plank/dock1/launchers"
rm -rf "$PLANK_THEMES_DIR"
rm -rf "$PLANK_LAUNCHERS_DIR"
mkdir -p "$PLANK_THEMES_DIR"
mkdir -p "$PLANK_LAUNCHERS_DIR"
cp -r "$WORK_DIR/resources/plank/themes/Arc-Dark" "$PLANK_THEMES_DIR"
PLANK_DOCKLETS=("desktop" "trash")
PLANK_APPS=("nautilus" "firefox" "thunderbird" "gnome-system-monitor" "gnome-terminal" "sublime_text")
PLANK_SNAP_APPS=("spotify_spotify")

for PLANK_DOCKLET in "${PLANK_DOCKLETS[@]}"; do
	plank_docklet_def $PLANK_DOCKLET > "$PLANK_LAUNCHERS_DIR/$PLANK_DOCKLET.dockitem"
done

for PLANK_APP in "${PLANK_APPS[@]}"; do
	plank_app_def $PLANK_APP > "$PLANK_LAUNCHERS_DIR/$PLANK_APP.dockitem"
done

for PLANK_SNAP_APP in "${PLANK_SNAP_APPS[@]}"; do
	plank_snap_app_def $PLANK_SNAP_APP > "$PLANK_LAUNCHERS_DIR/$PLANK_SNAP_APP.dockitem"
done

cat ./resources/plank/plank.dconf | dconf load /net/launchpad/plank/docks/
