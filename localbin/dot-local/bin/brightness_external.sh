#!/bin/bash

brightnessctl "$@" &
BUS=$(ddcutil detect | grep -A 3 "Display 1"\
    | grep "I2C bus" | cut -d "-" -f 2 -)
[ "$BUS" = "" ] && exit

sleep 3

ddcutil setvcp --bus="$BUS" 10 "$(brightnessctl get)"
wait
