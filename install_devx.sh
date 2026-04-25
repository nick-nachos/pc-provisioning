#!/usr/bin/env zsh

set -eo pipefail

USER_DEVX_DIR="$HOME/.devx/pc-provisioning"
mkdir -p "$USER_DEVX_DIR"
SCRIPT_DIR="${0:A:h}"
cp -f "$SCRIPT_DIR/devx"/* "$USER_DEVX_DIR"

ZSHRC="$HOME/.zshrc"
if [ ! -e "$ZSHRC" ] || ! grep -Fq "for script in $USER_DEVX_DIR/*.sh; do" "$ZSHRC"; then
    cat >> "$ZSHRC" <<EOF
if [ -d "$USER_DEVX_DIR" ]; then
    for script in $USER_DEVX_DIR/*.sh; do
        source "\$script"
    done
fi
EOF
fi
