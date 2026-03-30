#!/bin/bash

INSTANCES=("bar" "osd" "notifications")
LOGFILE="/tmp/ags_start_logfile"

sleep 2

{
    killall ags gjs dunst mako

    for x in "${INSTANCES[@]}"; do
        echo ">>>Starting $x"
        ags quit -i "$x" || true
        ags run -d "$HOME/.config/ags/$x" &
        sleep 0.3
    done
} &> "$LOGFILE"

notify-send -t 2000 "AGS Started"
# notify-send -t 2000 "AGS Started" "$(cat $LOGFILE)"
