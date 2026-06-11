alias neofetch='fastfetch -c examples/10.jsonc'
alias nrs='sudo darwin-rebuild switch --flake ~/nix#air'
alias nfu='sudo nix flake update --flake ~/nix'
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
source <(fzf --zsh)
export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzf/config"
export FZF_CTRL_R_OPTS="--scheme=history"
export FZF_CTRL_T_OPTS="--scheme=path"
eval "$(zoxide init --cmd cd zsh)"
export _ZO_FZF_OPTS="--scheme=path"

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

export BAT_THEME="tokyonight_moon"
export TEALDEER_CONFIG_DIR="$HOME/.config/tealdeer"
export EDITOR=nvim
export MANPAGER="nvim +Man!"

precmd() {
    local full="${(%):-%~}"
    local parent="${full%/*}"
    local current="${full##*/}"
    if [[ "$parent" == "$current" ]]; then
        PS1=" %F{blue}$current%f %F{15}\$%f "
    else
        PS1=" %F{8}$parent/%F{blue}$current%f %F{15}\$%f "
    fi
}
