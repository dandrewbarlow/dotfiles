#! /bin/bash

# package list
package_list="../package-lists/essential-packages.txt"

# get distro
distro=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')

# update linux and install packages using native package manager, assume yes to eliminate user input
if [ $distro = 'fedora' ]
then
  sudo dnf -y upgrade
  sudo dnf -y install "$(cat $package_list.txt)"
elif [ $distro = 'ubuntu' ] || [ $distro = 'debian' ]
then
  sudo apt-get -y update && sudo apt-get -y upgrade
  sudo apt-get -y install "$(cat $package_list.txt)"
elif [ $distro = 'arch' ] || [ $distro = 'manjaro' ]
then
  sudo pacman --noconfirm -Syu
  sudo pacman --noconfirm -S "$(cat $package_list.txt)"
else
	echo "Error: unsupported distro"
	return 1
fi

# setup git globally
./git-config.sh

# install atom
# https://flight-manual.atom.io/getting-started/sections/installing-atom/
# added propt bc vscode is starting to replace it for me
echo "Install Atom?"
select atom in 'y' 'n'; do
	case "$atom" in
		y)
			./atom-install.sh
			break
			;;
		n)
			break
			;;
	esac
done


# install oh-my-zsh if it isn't already
# https://github.com/ohmyzsh/ohmyzsh
[ ! -d "$HOME/.oh-my-zsh" ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# download & install the spaceship theme
# https://github.com/denysdovhan/spaceship-prompt
./spaceship-theme.sh

# NeoVim setup script
./vim.sh

# Haskell setup script
./haskell.sh

# install kite
./kite-install.sh

# froggie
wget https://i.imgur.com/voY8SXt.jpg -O ~/Pictures/froggie.jpg
