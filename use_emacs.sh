#!/usr/bin/env bash

sudo apt install emacs
sudo apt install emacs-common-non-dfsg
sudo apt install ripgrep
sudo apt install fd-find
sudo apt install markdown
sudo apt install shellcheck

git clone --depth 1 --single-branch https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

rm -rf ~/.config/doom
ln -si "$(pwd)/emacs/doom" ~/.config/

doom sync

systemctl --user enable emacs
