#!/bin/sh
# Execute eww daemon and open bar
killall eww

eww daemon
sleep 1
eww open bar
