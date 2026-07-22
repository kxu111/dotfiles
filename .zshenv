# --- XDG
export XDG_CONFIG_HOME="$HOME/.config"

# --- PATH
export PATH="$HOME/.cargo/bin:$PATH" # Rust
export PATH="$HOME/.ghcup/bin:$PATH" # Haskell

# --- Python
export UV_PYTHON="/run/current-system/sw/bin/python" # Nix's Python path
export UV_PYTHON_DOWNLOADS="never" # Don't let UV pull its own versions of Python

# --- Editor
export EDITOR="nvim"
export MANPAGER="nvim +Man!"

# --- CLI tool configs
export FZF_DEFAULT_OPTS="--color=bw --layout=reverse --style=minimal --info=hidden --pointer='>' --no-bold --cycle"
export TEALDEER_CONFIG_DIR="$HOME/.config/tealdeer"
