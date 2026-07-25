#!/usr/bin/env bash
# Installs this nvim config on a fresh machine.
# Usage: ./install.sh
set -euo pipefail

REPO_URL="https://github.com/0x2fycy3/nvim-config.git"
TARGET="$HOME/.config/nvim"

command -v nvim >/dev/null || { echo "nvim not found. Install Neovim >= 0.9 first."; exit 1; }
command -v git  >/dev/null || { echo "git not found. Install git first."; exit 1; }

if [ -e "$TARGET" ]; then
  backup="${TARGET}.bak.$(date +%Y%m%d%H%M%S)"
  echo "Backing up existing $TARGET to $backup"
  mv "$TARGET" "$backup"
fi

git clone --depth=1 "$REPO_URL" "$TARGET"

# Also back up/reuse state dirs so plugins reinstall cleanly.
for dir in "$HOME/.local/share/nvim" "$HOME/.local/state/nvim" "$HOME/.cache/nvim"; do
  [ -e "$dir" ] && mv "$dir" "${dir}.bak.$(date +%Y%m%d%H%M%S)"
done

echo "Installing plugins (headless)..."
nvim --headless "+Lazy! sync" +qa

echo "Done. Launch nvim to finish."
