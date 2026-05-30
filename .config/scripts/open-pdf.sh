#!/usr/bin/env bash
set -euo pipefail

# if you want to be able to have multiple dirs,
# check out Sylvan Franklin's dotfiles, where the
# original script is from
DIR="$HOME/Documents/Reading"


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/fzf-flags.sh"
DIR="${DIR%/}/"

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(fd . "${DIR[@]}" --max-depth=2 --extension="djvu" --extension="epub" --extension="pdf" --full-path --base-directory "$HOME" \
        | sort -uf | sed "s|^${DIR}||" \
		| fzf $(fzf_flags pdf) )

    [[ $selected ]] && selected="${DIR}$selected"
fi

[[ -n "$selected" ]] || exit 0

if [[ -n "${TMUX:-}" ]]; then
    tmux new-window -d "exec sioyek $(printf '%q' "$selected")"
else
    exec sioyek "$selected"
fi
