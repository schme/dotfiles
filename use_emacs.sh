#!/usr/bin/env bash

sudo apt install emacs
sudo apt install emacs-common-non-dfsg

mkdir -p ~/.emacs.d/
ln -sf "$(pwd)/emacs/.emacs.d/init.el" ~/.emacs.d/init.el

git clone --depth 1 --single-branch https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
