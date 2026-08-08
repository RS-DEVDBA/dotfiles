#!/usr/bin/env bash
# install.sh — instala os dotfiles via symlinks
# Funciona em qualquer usuario: /home/rs, /home/oracle, /root, /Users/rs

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Instalando dotfiles de: $DOTFILES_DIR"

# Neovim
mkdir -p "$HOME/.config"
if [ -d "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
    echo "Backup: $HOME/.config/nvim -> $HOME/.config/nvim.bak"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
fi
ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
echo "✅ Neovim: $HOME/.config/nvim -> $DOTFILES_DIR/nvim"

# WezTerm
if [ -f "$HOME/.wezterm.lua" ] && [ ! -L "$HOME/.wezterm.lua" ]; then
    echo "Backup: $HOME/.wezterm.lua -> $HOME/.wezterm.lua.bak"
    mv "$HOME/.wezterm.lua" "$HOME/.wezterm.lua.bak"
fi
ln -sf "$DOTFILES_DIR/wezterm/.wezterm.lua" "$HOME/.wezterm.lua"
echo "✅ WezTerm: $HOME/.wezterm.lua -> $DOTFILES_DIR/wezterm/.wezterm.lua"

echo ""
echo "Instalação concluída!"
echo "Abra o Neovim e rode :Lazy sync para instalar os plugins."
