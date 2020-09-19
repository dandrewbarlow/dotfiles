#! /bin/bash

# extract nerdfonts archive
7z e nerdfonts.7z

# copy my nerdfonts to the fonts directory
cp -r nerd-fonts/* ~/.fonts/

# refresh font cache
fc-cache -v
