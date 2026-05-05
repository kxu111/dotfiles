#!/bin/bash

if ! command -v tmux &> /dev/null; then
    exit 0
fi

session_name="$(whoami)"
tmux attach-session -t "$session_name" 2>/dev/null || tmux new-session -s "$session_name"
