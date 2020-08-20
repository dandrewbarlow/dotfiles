#! /bin/bash

# start w/ updated linux
sudo dnf upgrade

# install packages already available through dnf
sudo dnf install $(cat ./my_requirements.txt)

# install atom
# https://flight-manual.atom.io/getting-started/sections/installing-atom/
./atom-install.sh

# install OSX fonts bc they're pretty
# https://github.com/blaisck/sfwin
echo "downloaded OSX fonts, search for SF Pro in Gnome Tweaks and set manually"
./mac-fonts.sh

echo "Executing Oh-My-Zsh script. It will enter a zsh environment, but to finish script, you must exit and restart"
# install oh-my-zsh
# https://github.com/ohmyzsh/ohmyzsh
./oh-my-zsh.sh

# download & install the spaceship theme
# https://github.com/denysdovhan/spaceship-prompt
./spaceship-theme.sh
