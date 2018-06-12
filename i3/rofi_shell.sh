#!/bin/sh

bg_color='#38B6FF'
text_color='#B338FF'
htext_color='#8138FF'

rofi -show run -lines 3 -eh 2 -width 100 -padding 400 -opacity "99" -bw 0 -color-window "$bg_color, $bg_color, $bg_color" -color-normal "$bg_color, $text_color, $bg_color, $bg_color, $htext_color" -font "haxor 14"
