#!/bin/sh

bg_color=$1
text_color=$2
htext_color=$3

rofi -show run -lines 6 -eh 2 -width 30 -padding 10 -opacity "90" -bw 0 -color-window "$bg_color, $bg_color, $bg_color" -color-normal "$bg_color, $text_color, $bg_color, $bg_color, $htext_color" -font "haxor 14"
