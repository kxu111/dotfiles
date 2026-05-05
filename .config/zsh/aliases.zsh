alias neofetch='fastfetch'

alias nrs='sudo darwin-rebuild switch --flake ~/nix'
alias reload='source ~/.zshrc'
alias cron-sync="crontab ~/.config/cron/crontab"

alias vi='nvim'
alias y='yazi'
alias lg='lazygit'

alias news='newsboat'
alias add-news='~/.config/scripts/add-news.sh'

alias m='mkdir -p'
alias cat='bat'

alias eza='eza --icons --group-directories-first'
alias l='eza -l'
alias ll='eza -l'
alias la='eza -a'
alias lla='eza -la'
alias llh='eza -lh'
alias llah='eza -lah'


# tmux aliases
alias tls='tmux ls'
ta() {
  if ! tmux has-session 2>/dev/null; then
    tmux new-session -d -s "$(whoami)"
  fi
  [[ -n "$1" ]] && tmux attach -t "$1" || tmux attach
}

tkill() {
  [[ -n "$1" ]] && tmux kill-session -t "$1" || tmux kill-session
}

_tmux_completion() {
  local -a sessions
  sessions=($(tmux list-sessions -F "#{session_name}" 2>/dev/null))
  compadd -a sessions
}
compdef _tmux_completion ta
compdef _tmux_completion tkill
