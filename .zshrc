alias neofetch='fastfetch'
alias nrs='sudo darwin-rebuild switch --flake ~/nix#air'
alias reload='source ~/.zshrc; source ~/.zshenv'
alias cron-sync="crontab ~/.config/cron/crontab"
alias vi='nvim'
alias y='yazi'
alias lg='lazygit'
alias news='~/.config/scripts/add-news.sh'
alias m='mkdir -p'
alias cat='bat'
alias eza='eza --icons --group-directories-first'
alias l='eza -l'
alias ll='eza -l'
alias la='eza -a'
alias lla='eza -la'
alias llh='eza -lh'
alias llah='eza -lah'
alias lt='eza --tree'

bindkey -v
KEYTIMEOUT=1
eval "$(starship init zsh)"
source <(fzf --zsh)
export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzf/config"
export FZF_CTRL_R_OPTS="--style=default --info=hidden --preview-window=hidden --no-scrollbar --tmux --scheme=history"
export FZF_CTRL_T_OPTS="--style=default --info=hidden --preview-window=hidden --no-scrollbar --tmux --scheme=path"
eval "$(zoxide init --cmd cd zsh)"
export _ZO_FZF_OPTS="--style=default --info=hidden --preview-window=hidden --no-scrollbar --tmux --scheme=path"

if [[ "$TERM" == "xterm-ghostty" ]] then
	if ! command -v tmux &> /dev/null; then
   		exit 0
	fi
	tmux attach-session 2>/dev/null || tmux new-session -s "$(whoami)"
fi
