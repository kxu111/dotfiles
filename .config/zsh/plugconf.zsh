# fzf
source <(fzf --zsh)
export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzf/config"
stty -ixon
bindkey -r '^T'
bindkey '^S' fzf-file-widget
export FZF_CTRL_R_OPTS="--style=default --info=hidden --preview-window=hidden --no-scrollbar --tmux --scheme=history"
export FZF_CTRL_T_OPTS="--style=default --info=hidden --preview-window=hidden --no-scrollbar --tmux --scheme=path"

# zoxide
eval "$(zoxide init --cmd cd zsh)"
export _ZO_FZF_OPTS="--style=default --info=hidden --preview-window=hidden --no-scrollbar --tmux --scheme=path"

# starship
eval "$(starship init zsh)"
