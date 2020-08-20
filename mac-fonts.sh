#! /bin/bash

# download OSX fonts
git clone https://github.com/blaisck/sfwin.git ~/Downloads/

# if the fonts directory doesn't exist, make it
sudo mkdir -p /usr/share/fonts

# copy the fonts to said directory
sudo cp -r ~/Downloads/sfwin/SF* usr/share/fonts/

# refresh font cache
fc-cache -v
