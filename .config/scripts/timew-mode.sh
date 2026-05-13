#!/bin/bash

timew_start() {
    local tag="$1"
    timew start "$tag" > /dev/null 2>&1
    local snippet="${tag} #(timew | awk '/^ *Total/ {print \$NF}')"
    local current_right
    current_right=$(tmux show -gqv status-right)
    tmux set -g @timew_base "$current_right"
    current_right=$(echo "$current_right" | sed -E 's/[A-Z]+ #\(timew[^)]+\) *//g')
    tmux set -g status-right "${snippet} ${current_right}"
    tmux set -g @timew_tag "$tag"
    tmux set -g status-interval 5
}

timew_stop() {
    timew stop > /dev/null 2>&1
    local base_right
    base_right=$(tmux show -gqv @timew_base)
    local current_right
    current_right=$(tmux show -gqv status-right)
    current_right=$(echo "$current_right" | sed -E 's/[A-Z]+ #\(timew[^)]+\) *//g')
    tmux set -g status-right "$current_right"
    tmux set -gu @timew_tag
    tmux set -gu @timew_base
}
