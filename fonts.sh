#! /bin/bash

# copy my nerdfonts to the fonts directory
cp -r nerd-fonts/* ~/.fonts/

# refresh font cache
fc-cache -v
