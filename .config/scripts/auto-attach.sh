#!/bin/bash

if ! command -v tmux &> /dev/null; then
    exit 0
fi

tmux attach-session 2>/dev/null || tmux new-session -s "$(whoami)"
