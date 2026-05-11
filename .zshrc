source "$XDG_CONFIG_HOME/zsh/aliases.zsh"
source "$XDG_CONFIG_HOME/zsh/plugconf.zsh"

# always have a backup term in case this breaks
if [[ "$TERM" == "xterm-ghostty" ]] && [[ -f ~/.config/scripts/auto-attach.sh ]]; then
    exec ~/.config/scripts/auto-attach.sh
fi
