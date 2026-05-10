# fzf
source <(fzf --zsh)
export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzf/config"

# zoxide
eval "$(zoxide init --cmd cd zsh)"
export _ZO_FZF_OPTS="--style=default --info=hidden --preview-window=hidden --no-scrollbar --tmux"

# starship
eval "$(starship init zsh)"
