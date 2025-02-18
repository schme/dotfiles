#!/usr/bin/env bash

sudo apt install emacs
sudo apt install emacs-common-non-dfsg

git clone --depth 1 --single-branch https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

ln -si "$(pwd)/emacs/doom" ~/.config/doom
