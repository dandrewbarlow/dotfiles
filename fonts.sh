#! /bin/bash

# extract nerdfonts archive
7z e nerdfonts.7z || echo "Error extracting fonts" || exit 1

# copy my nerdfonts to the fonts directory
cp -r nerd-fonts/* "$HOME/.fonts/" || echo "Error copying fonts to $HOME/.fonts" \
    || exit 1

# refresh font cache
fc-cache -v