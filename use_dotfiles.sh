#!/usr/bin/bash

# i: ask override if exists

# Neovim
mkdir -p ~/.config/nvim/
ln -si $(pwd)/nvim/init.vim ~/.config/nvim/init.vim

# Zsh
ln -si $(pwd)/zsh/.zshrc ~/.zshrc

# Xresources
ln -si $(pwd)/Xresources/.Xresources ~/.Xresources

# i3
ln -si $(pwd)/i3/config ~/.config/i3/config

# alacritty
mkdir -p ~/.config/alacritty/
ln -si $(pwd)/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# polybar
mkdir -p ~/.config/polybar/
ln -si $(pwd)/polybar/config.ini ~/.config/polybar/config.ini

# redshift
cp $(pwd)/redshift/redshift.conf ~/.config/redshift.conf

# awesome
ln -si $(pwd)/awesome/rc.lua ~/.config/awesome/rc.lua
