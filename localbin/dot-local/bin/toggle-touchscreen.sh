#!/usr/bin/env bash

TOUCHSCREEN_EVENT=$(qdbus6 org.kde.KWin\
    /org/kde/KWin/InputDevice org.kde.KWin.InputDeviceManager.ListTouch)
TOUCHSCREEN_ADDRESS="/org/kde/KWin/InputDevice/$TOUCHSCREEN_EVENT"

status=$(qdbus6 org.kde.KWin $TOUCHSCREEN_ADDRESS\
    org.freedesktop.DBus.Properties.Get org.kde.KWin.InputDevice enabled)

if [[ $status == "true" ]]; then
    qdbus6 org.kde.KWin $TOUCHSCREEN_ADDRESS\
        org.freedesktop.DBus.Properties.Set org.kde.KWin.InputDevice enabled false
    qdbus6 org.freedesktop.Notifications /org/kde/osdService\
        org.kde.osdService.showText custom-touchscreen-off "Touchscreen Disabled"
elif [[ $status == "false" ]]; then
    qdbus6 org.kde.KWin $TOUCHSCREEN_ADDRESS\
        org.freedesktop.DBus.Properties.Set org.kde.KWin.InputDevice enabled true
    qdbus6 org.freedesktop.Notifications /org/kde/osdService\
        org.kde.osdService.showText input-touchscreen "Touchscreen Enabled"
else
    notify-send "Touchscreen" "Failed to change status"
fi
