#!/bin/bash

status="$(playerctl status --player=spotify)"

if [[ "$status" == "Paused" ]]; then
  eww update "musicplayicon=$HOME/.config/eww/assets/play.svg"
elif [[ "$status" == "Playing" ]]; then
  eww update "musicplayicon=$HOME/.config/eww/assets/pause.svg"
fi

playerctl metadata --player=spotify --format '{{ artist }} - {{ title }}'

