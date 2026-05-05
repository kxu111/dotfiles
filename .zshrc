source "$XDG_CONFIG_HOME/zsh/aliases.zsh"
source "$XDG_CONFIG_HOME/zsh/binds.zsh"
source "$XDG_CONFIG_HOME/zsh/plugins.zsh"
source "$XDG_CONFIG_HOME/zsh/prompt.zsh"

# always have a backup term in case this breaks
if [[ "$TERM" == "xterm-ghostty" ]] && [[ -f ~/.config/scripts/tmux-auto-attach.sh ]]; then
    exec ~/.config/scripts/tmux-auto-attach.sh
fi
