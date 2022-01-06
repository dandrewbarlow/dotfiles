#! /bin/bash

sudo git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"

sudo ln -s "$ZSH_CUSTOM/themes/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" && \
    echo "Spaceship theme downloaded! Set ZSH_THEME=\"spaceship\" in .zshrc"