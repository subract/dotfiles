#!/bin/bash

# https://github.com/polybar/polybar/issues/763#issuecomment-450940924
# Launches with tray on DP-4 if connected, DP-2 otherwise
(
  flock 200

  killall -q polybar

  while pgrep -u $UID -x polybar > /dev/null; do sleep 0.5; done

  outputs=$(xrandr --query | grep " connected" | cut -d" " -f1)
  tray_output=DP-2

  for m in $outputs; do
    if [[ $m == "DP-4" ]]; then
        tray_output=$m
    fi
  done

  for m in $outputs; do
    export MONITOR=$m
    export TRAY_POSITION=none
    if [[ $m == $tray_output ]]; then
      TRAY_POSITION=right
    fi

    polybar --reload mybar </dev/null >/var/tmp/polybar-$m.log 2>&1 200>&- &
    disown
  done
) 200>/var/tmp/polybar-launch.lock