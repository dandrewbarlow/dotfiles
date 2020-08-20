#! /bin/bash

# download OSX fonts
git clone https://github.com/blaisck/sfwin.git ~/Downloads/

# if the fonts directory doesn't exist, make it
mkdir -p ~/.fonts

# copy the fonts to said directory
cp -r ~/Downloads/sfwin/SF* ~/.fonts/

# refresh font cache
fc-cache -v
