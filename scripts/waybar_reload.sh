#!/bin/bash

CONFIG_FILES="$HOME/.config/waybar/ $HOME/.config/waybar/config.jsonc $HOME/.config/waybar/style.css"

trap "killall waybar" EXIT SIGRTMIN+8 SIGRTMIN+9

while true; do
    waybar &
    inotifywait -e create,modify $CONFIG_FILES
    killall waybar
done
