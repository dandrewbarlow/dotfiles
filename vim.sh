#! /bin/bash

# Install Vim-Plug Plugin Manager
# https://github.com/junegunn/vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

pip3 install --user pynvim

configDir="$HOME/.config/nvim"
# Install NeoVim Plugins
mkdir -p "$configDir"
cp init.vim "configDir/"
nvim -c ':PlugInstall'

# Create vim/vi -> nvim alias
echo "alias vim='nvim'" >> "$HOME/.zshrc" || echo "Error aliasing"
echo "alias vi='nvim'" >> "$HOME/.zshrc" || echo "Error aliasing"