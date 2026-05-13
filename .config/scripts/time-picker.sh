#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/timew-mode.sh"
source "$SCRIPT_DIR/fzf-flags.sh"
MODES_FILE="$HOME/.config/modes.conf"

mode_names=()
mode_actions=()

while IFS='|' read -r name action; do
    [[ -z "$name" || "$name" == \#* ]] && continue
    mode_names+=("$name")
    mode_actions+=("$action")
done < "$MODES_FILE"

selected=$(printf "%s\n" "${mode_names[@]}" \
		| fzf $(fzf_flags base) )

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
            tmux display-popup -E "$HOME/.config/scripts/work-mode.sh" off
        fi
        timew_stop
        exit 0
        ;;
    off)
        if [[ -f /tmp/workmode-enabled ]]; then
            tmux display-popup -E "$HOME/.config/scripts/work-mode.sh" off
        fi
        ;;
    on)
        	tmux display-popup -E "$HOME/.config/scripts/work-mode.sh" on
        ;;
esac

timew_start "$selected"
