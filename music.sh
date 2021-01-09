#! /bin/bash

# Download some music for my workstation
echo "Downloading chill beats to code to"

mus_dir="$HOME/Music"

curl https://thirdworlds.net/files/death-grips-fashion-week.zip > "$mus_dir/dg-fashion-week.zip"
curl https://thirdworlds.net/files/govt-plates.zip > "$mus_dir/govt-plates.zip"
curl https://thirdworlds.net/files/Death%20Grips%20-%20Exmilitary.zip > "$mus_dir/dg-exmilitary.zip"

unzip "$mus_dir/dg-fashion-week.zip" -d "$mus_dir/Fashion Week"
unzip "$mus_dir/govt-plates.zip" -d "$mus_dir/Government Plates"
unzip "$mus_dir/dg-exmilitary.zip" -d "$mus_dir/Exmilitary"

mkdir "$mus_dir/Death Grips"

mv "$mus_dir/Fashion Week" "$mus_dir/Death Grips"
mv "$mus_dir/Government Plates" "$mus_dir/Death Grips"
mv "$mus_dir/Exmilitary" "$mus_dir/Death Grips"
