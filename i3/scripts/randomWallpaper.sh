#! /bin/bash

dir="/home/andrew/Photos/wallpapers"

ls -d -l $dir/* | shuf -n 1 | grep -oE '[^ ]+$'
