#! /usr/bin/env bash

tmp="$(mktemp -d)"

cd "$(tmp)" && curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz 

tar -xf ./JetBrainsMono.tar.xz
