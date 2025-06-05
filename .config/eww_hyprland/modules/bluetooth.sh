#!/bin/bash

PAIRED=$(bluetoothctl info | grep Paired | grep -o "yes")
[ $PAIRED == "yes" ] && echo "paired" && exit

POWERED=$(bluetoothctl show | grep Powered | grep -o "yes")
[ $POWERED == "yes" ] && echo "on" && exit

echo "off"
