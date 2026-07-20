#!/bin/bash

# NOTE: run this AFTER setting up nix-darwin
cd ~/dotfiles
mkdir ~/.config
mkdir ~/.emacs.d
mkdir ~/Pictures/Screenshots
stow . --adopt
osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$HOME/dotfiles/misc/walls/sunflower.jpg\""
bash <(curl -sSL https://spotx-official.github.io/run.sh)
source ~/.zshenv
source ~/.zshrc
rustup default stable
crontab ~/.config/crontab
bat cache --build
open -a AeroSpace
git config --global core.excludesfile ~/.gitignore-global
defaults write org.gnu.Emacs AppleFontSmoothing -int 0 # stop big tech from tampering with my beautiful fonts
rustup install
brew services start d12frosted/emacs-plus/emacs-plus@31
cp -r /opt/homebrew/opt/emacs-plus@31/Emacs.app /Applications/
cp -r "/opt/homebrew/opt/emacs-plus@31/Emacs Client.app" /Applications/
echo "REMINDER TO DISABLE SPOTLIGHT AND GAME OVERLAY KEYBIND"
