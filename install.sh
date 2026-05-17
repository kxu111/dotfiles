#!/bin/bash
# run this AFTER setting up nix-darwin
cd ~/dotfiles
mkdir ~/.config
stow . --adopt
desktoppr ~/Pictures/walls/sunflower.jpg
bash <(curl -sSL https://spotx-official.github.io/run.sh)
source ~/.zshenv
source ~/.zshrc
rustup default stable
crontab ~/.config/cron/crontab
bat cache --build
open -a AeroSpace
open -a Karabiner-Elements
echo "REMINDER TO DISABLE SPOTLIGHT AND SET UP ALFRED"
