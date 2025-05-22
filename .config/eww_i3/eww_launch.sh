#!/bin/sh
# Execute eww daemon and open bar
killall eww

eww daemon --config ~/.config/eww/i3
sleep 1
eww open bar
