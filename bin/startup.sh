#!/bin/sh

# remember to symlink to this file from ~/.local/bin.
fcitx5 &
slstatus &
~/.fehbg

while :
do
    bat=$(cat /sys/class/power_supply/BAT0/capacity)
    if [ "$bat" -le 8 ]; then
        status=$(cat /sys/class/power_supply/BAT0/status)
        if [ "$status" = "Discharging" ]; then
            notify-send "low battery"
        fi
    fi
    sleep 60
done
