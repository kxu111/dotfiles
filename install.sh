#!/bin/bash

# Assumes this command has been run first: 
# curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh

echo "Make sure the repo is saved to <~/dotfiles>."
echo
echo "Make sure the nix-darwin is installed on your system. If not, run the following:"
echo "curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh"
echo

bash <(curl -sSL https://raw.githubusercontent.com/SpotX-Official/SpotX-Bash/main/spotx.sh) # Spotify

sudo darwin-rebuild switch --flake ~/dotfiles/nix#air

# Creating these directories beforehand means that they will not be symlinked.
# Instead their children will be symlinked, meaning new junk files created
# inside of these directories will not be pushed to git.
mkdir ~/.config
mkdir ~/.emacs.d

mkdir ~/Pictures/Screenshots

cd ~/dotfiles
stow . --adopt

# Set wallpaper
# osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$HOME/dotfiles/misc/walls/sunflower.jpg\""
osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$HOME/dotfiles/misc/walls/black.png\""

source ~/.zshenv
source ~/.zshrc
crontab ~/.config/crontab
git config --global core.excludesfile ~/.gitignore-global

# --- Bootstrap packages
open -a AeroSpace

# brew services start d12frosted/emacs-plus/emacs-plus@31
cp -r /opt/homebrew/opt/emacs-plus@31/Emacs.app /Applications/
cp -r "/opt/homebrew/opt/emacs-plus@31/Emacs Client.app" /Applications/
defaults write org.gnu.Emacs AppleFontSmoothing -int 0
# ---

# --- Language toolchains
rustup default stable

ghcup set ghc recommended
ghcup set cabal recommended
ghcup set hls recommended
ghcup set stack recommended
ghcup install ghc
ghcup install cabal
ghcup install hls
ghcup install stack
# ---

echo "Remember to disable spotlight and the \"game overlay\" keybind."
echo "Remember set \"increase contrast\"."
