#! /bin/bash


# get distro
distro=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')

# update linux and install packages using native package manager
if [ $distro='fedora' ]
then
  sudo dnf upgrade
  sudo dnf install $(cat ./my_requirements.txt)
fi
elif [ $distro='ubuntu' ]
then
  sudo apt-get update && sudo apt-get upgrade
  sudo apt-get install $(cat ./my_requirements.txt)
fi
elif [ $distro='arch' ] || [ distro='manjaro' ]
then
  sudo pacman -Syu
  sudo pacman -S $(cat ./my_requirements.txt)
fi

# setup git globally 
./git-config.sh

# install atom
# https://flight-manual.atom.io/getting-started/sections/installing-atom/
./atom-install.sh

# install OSX fonts bc they're pretty
# https://github.com/blaisck/sfwin

./mac-fonts.sh

# install oh-my-zsh
# https://github.com/ohmyzsh/ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# download & install the spaceship theme
# https://github.com/denysdovhan/spaceship-prompt
./spaceship-theme.sh
