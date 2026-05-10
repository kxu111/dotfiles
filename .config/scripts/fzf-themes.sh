#!/usr/bin/env bash
set -euo pipefail

# Shared skim layout for all pickers.
FZF_THEME_BASE=(
	--style=default 
	--preview-window=hidden
	--info=hidden
	--no-scrollbar
	--tmux
)

FZF_THEME_PDF=("${FZF_THEME_BASE[@]}")
FZF_THEME_SESSION=("${FZF_THEME_BASE[@]}" --scheme=path)

fzf_theme_flags() {
    local theme="${1:-}"
	local upper_theme=$(echo "$theme" | tr '[:lower:]' '[:upper:]')
    local var_name="FZF_THEME_${upper_theme}"
    if ! declare -p "${var_name}" >/dev/null 2>&1; then
        return 1
    fi
    if ! declare -p "${var_name}" >/dev/null 2>&1; then
        return 1
    fi
    eval "printf '%s\n' \"\${${var_name}[@]}\""

}
