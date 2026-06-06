#!/bin/bash

update() {
    local output max_length=40
    output=$(osascript -e '
        if application "Spotify" is running then
            tell application "Spotify"
                if player state is playing then
                    set t to artist of current track & " - " & name of current track
                    return t
                end if
            end tell
        end if
        return ""
    ' 2>/dev/null)

    if [[ -n "$output" ]]; then
        if [[ ${#output} -gt $max_length ]]; then
            output="${output:0:$max_length}…"
        fi
        sketchybar --set "$NAME" icon="" label="$output" drawing=on
    else
        sketchybar --set "$NAME" drawing=off
    fi
}

case "$SENDER" in
    "routine"|"forced") update;;
esac
