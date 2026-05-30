alias neofetch='fastfetch'
alias nrs='sudo darwin-rebuild switch --flake ~/nix#air'
alias reload='source ~/.zshenv; source ~/.zshrc'
alias cron-sync="crontab ~/.config/crontab"
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
alias cdr='source ~/.config/scripts/tmux-root.sh'

alias av='source .venv/bin/activate'
alias dav='deactivate'

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

autoload -U add-zsh-hook
_auto_venv() {
  local search="$PWD"
  local found=""
  while [[ "$search" != "/" ]]; do
    if [[ -f "$search/.venv/bin/activate" ]]; then
      found="$search/.venv"
      break
    fi
    search="${search:h}"
  done
  if [[ -n "$found" ]]; then
    if [[ "${VIRTUAL_ENV:-}" != "$found" ]]; then
      if [[ -n "${VIRTUAL_ENV:-}" ]] && typeset -f deactivate >/dev/null 2>&1; then
        deactivate >/dev/null 2>&1 || true
      fi
      source "$found/bin/activate"
    fi
  else
    if [[ -n "${VIRTUAL_ENV:-}" ]] && typeset -f deactivate >/dev/null 2>&1; then
      deactivate >/dev/null 2>&1 || true
    fi
  fi
}
add-zsh-hook chpwd _auto_venv
_auto_venv
