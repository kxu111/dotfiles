#!/bin/bash

sid="$1"
focused=$(aerospace list-workspaces --focused)

if [ "$focused" = "$sid" ]; then
    sketchybar --set space.$sid \
        background.drawing=on \
        background.color=0xffffffff \
        label.color=0xff000000
else
    sketchybar --set space.$sid \
        background.drawing=off \
        label.color=0xffffffff
fi
