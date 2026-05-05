# fzf
source <(fzf --zsh)
export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzf/config"

# zoxide
eval "$(zoxide init --cmd cd zsh)"
