#!/bin/bash

status="$(playerctl status --player=spotify)"
if [[ "$status" == "Paused" ]]; then
  eww update "musicplayicon=$HOME/.config/eww/assets/pause.svg"
elif [[ "$status" == "Playing" ]]; then
  eww update "musicplayicon=$HOME/.config/eww/assets/play.svg"
fi

playerctl play-pause

