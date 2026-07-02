#!/bin/bash

# NOTE: run this AFTER setting up nix-darwin
cd ~/dotfiles
mkdir ~/.config
mkdir ~/.emacs.d
stow . --adopt
osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$HOME/Pictures/walls/painting.png\""
bash <(curl -sSL https://spotx-official.github.io/run.sh)
source ~/.zshenv
source ~/.zshrc
rustup default stable
crontab ~/.config/crontab
bat cache --build
open -a AeroSpace
git config --global core.excludesfile ~/.gitignore_global
echo "REMINDER TO DISABLE SPOTLIGHT AND GAME OVERLAY KEYBIND"
