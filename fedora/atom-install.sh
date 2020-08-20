#! /bin/bash

sudo rpm --import https://packagecloud.io/AtomEditor/atom/gpgkey

sudo sh -c 'echo -e "[Atom]\nname=Atom Editor\nbaseurl=https://packagecloud.io/AtomEditor/atom/el/7/\$basearch\nenabled=1\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://packagecloud.io/AtomEditor/atom/gpgkey" > /etc/yum.repos.d/atom.repo'

sudo dnf install atom

apm install $(cat atom-packages.txt)

# manually install python beautifier package for atom-beautify
pip install --upgrade --user autopep8
