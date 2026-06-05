#!/bin/bash

# NOTE: run this AFTER setting up nix-darwin
cd ~/dotfiles
mkdir ~/.config
stow . --adopt
# osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$HOME/Pictures/walls/sunflower.jpg\""
bash <(curl -sSL https://spotx-official.github.io/run.sh)
source ~/.zshenv
source ~/.zshrc
rustup default stable
crontab ~/.config/cron/crontab
bat cache --build
open -a AeroSpace
open -a Karabiner-Elements
brew services start sketchybar
echo "REMINDER TO DISABLE SPOTLIGHT AND GAME OVERLAY BINDS"
echo "REMINDER TO ENABLE INCREASE CONTRAST AND SET BG TO BLACK"
