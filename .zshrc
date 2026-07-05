alias neofetch='fastfetch -c examples/10.jsonc'
alias nrs='sudo darwin-rebuild switch --flake ~/nix#air'
alias nfu='sudo nix flake update --flake ~/nix'
alias reload='source ~/.zshenv; source ~/.zshrc'
alias cron-sync="crontab ~/.config/crontab"
alias v='nvim'
alias news='~/.config/scripts/add-news.sh'
alias m='mkdir -p'
alias ls='ls --color=always'
alias av='source .venv/bin/activate'

source <(fzf --zsh)

eval "$(zoxide init zsh)"
alias cd=''

if [[ "$TERM" == "xterm-ghostty" ]] then
	if ! command -v tmux &> /dev/null; then
		exit 0
	fi
	tmux attach-session 2>/dev/null || tmux new-session -s "$(whoami)"
fi

export TEALDEER_CONFIG_DIR="$HOME/.config/tealdeer"
export MANPAGER="nvim +Man!"

PROMPT="%~ $ "
