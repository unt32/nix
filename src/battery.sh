#!/bin/sh

pkill xidlehook

export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}' | tr -d '\n')"

xidlehook \
        --not-when-fullscreen \
        --not-when-audio \
        --detect-sleep \
        --timer 120 \
          'xrandr --output "$PRIMARY_DISPLAY" --brightness .1' \
          'xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
        --timer 10 'xrandr --output "$PRIMARY_DISPLAY" --brightness 1 & xset dpms force off' '' \
        --timer 600 'systemctl suspend' ''
