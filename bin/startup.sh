#!/bin/sh

# remember to symlink to this file from ~/.local/bin.
fcitx5 &
slstatus &
~/.fehbg

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/svi/.opam/opam-init/init.sh' && . '/home/svi/.opam/opam-init/init.sh' > /dev/null 2> /dev/null || true
# END opam configuration

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
