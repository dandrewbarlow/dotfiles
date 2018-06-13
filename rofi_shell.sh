#!/bin/bash

bg_color=#FFFFFF
text_color=#000000
inactive_text_color=#AAAAAA

rofi -show run -lines 6 -eh 2 -width 30 -padding 10 -opacity "90" -bw 0 -color-window "$bg_color, $bg_color, $bg_color" -color-normal "$bg_color, $text_color, $bg_color, $bg_color, $inactive_text_color" -font "haxor 14"
