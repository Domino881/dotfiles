#!/bin/bash
WP=${HOME}/Pictures/wallpapers/NGC7000.jpg

echo "preload = $WP
wallpaper =, $WP" > $XDG_CONFIG_HOME/hypr/hyprpaper.conf

wal -i $WP -a 0 --contrast 3.0 --saturate 0.5 -t -b "#111111" --fg "#ffffff" --backend colorthief && hyprpaper &
