#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

MODES_FILE="$HOME/.config/modes.conf"

mode_names=()
mode_actions=()

while IFS='|' read -r name action; do
    [[ -z "$name" || "$name" == \#* ]] && continue
    mode_names+=("$name")
    mode_actions+=("$action")
done < "$MODES_FILE"

selected=$(printf "%s\n" "${mode_names[@]}" \
        | fzf )

[[ -z "$selected" ]] && exit 0

for i in "${!mode_names[@]}"; do
    if [[ "${mode_names[$i]}" == "$selected" ]]; then
        action="${mode_actions[$i]}"
        break
    fi
done

case "$action" in
    stop)
        if [[ -f /tmp/workmode-enabled ]]; then
			tmux neww -n work-mode 'bash ~/.config/scripts/work-mode.sh off'
        fi
	    timew stop > /dev/null 2>&1
        exit 0
        ;;
    off)
        if [[ -f /tmp/workmode-enabled ]]; then
			tmux neww -n work-mode 'bash ~/.config/scripts/work-mode.sh off'
        fi
        ;;
    on)
		tmux neww -n work-mode 'bash ~/.config/scripts/work-mode.sh on'
        ;;
esac

timew start "$selected" > /dev/null 2>&1
