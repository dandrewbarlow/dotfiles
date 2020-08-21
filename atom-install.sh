#! /bin/bash

# detect distro
distro=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')

# install atom, use correct commands for given distro. Reference:
# https://flight-manual.atom.io/getting-started/sections/installing-atom/

if [ $distro = 'fedora' ]
then
  sudo rpm --import https://packagecloud.io/AtomEditor/atom/gpgkey

  sudo sh -c 'echo -e "[Atom]\nname=Atom Editor\nbaseurl=https://packagecloud.io/AtomEditor/atom/el/7/\$basearch\nenabled=1\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://packagecloud.io/AtomEditor/atom/gpgkey" > /etc/yum.repos.d/atom.repo'

  sudo dnf install atom
elif [ $distro = 'ubuntu' ]
then
  wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add

  sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'

  sudo apt-get update

  sudo apt-get install atom
elif [ $distro = 'arch' ] || [ $distro = 'manjaro' ]
then
  pacman -S atom
fi

# atom package manager can take it from here
apm install "$(cat ./atom-packages.txt)"

# manually install python beautifier package for atom-beautify
pip install --upgrade --user autopep8
