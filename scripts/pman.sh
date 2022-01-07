#! /bin/bash

# take a program name, format to groff => create pdf => display in zathura
man -t "$1" | ps2pdf - | zathura - & 
