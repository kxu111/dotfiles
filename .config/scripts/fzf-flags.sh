#!/usr/bin/env bash
set -euo pipefail

FZF_FLAGS_PDF=()
FZF_FLAGS_SESSION=(--scheme=path)

fzf_flags() {
    local flags="${1:-}"
	local upper_flags=$(echo "$flags" | tr '[:lower:]' '[:upper:]')
    local var_name="FZF_FLAGS_${upper_flags}"
    if ! declare -p "${var_name}" >/dev/null 2>&1; then
        return 1
    fi
    if ! declare -p "${var_name}" >/dev/null 2>&1; then
        return 1
    fi
    eval "printf '%s\n' \"\${${var_name}[@]}\""
}
