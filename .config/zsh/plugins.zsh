# syntax highlighting
source_highlighting() {
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    unfunction source_highlighting
}
zle -N source_highlighting
autoload -U add-zsh-hook
add-zsh-hook precmd source_highlighting

# fzf
source <(fzf --zsh)
export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzf/config"

# zoxide
eval "$(zoxide init --cmd cd zsh)"
