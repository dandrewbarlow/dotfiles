#! /bin/bash

# Install Vim-Plug Plugin Manager
# https://github.com/junegunn/vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

pip3 install --user pynvim

# Install NeoVim Plugins
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim/
nvim -c ':PlugInstall'

# Create vim/vi -> nvim alias
echo "alias vim='nvim'" >> ~/.zshrc
echo "alias vi='nvim'" >> ~/.zshrc

