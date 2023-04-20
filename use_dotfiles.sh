#!/usr/bin/env bash

# Neovim
mkdir -p ~/.config/nvim/
ln -si $(pwd)/nvim/init.vim ~/.config/nvim/init.vim

# Zsh
ln -si $(pwd)/zsh/.zshrc ~/.zshrc

# Xresources
ln -si $(pwd)/Xresources/.Xresources ~/.Xresources

# i3 (kinda dangerous, shouldn't probably do this)
rm -ri ~/.config/i3
ln -si $(pwd)/i3 ~/.config/

mkdir -p ~/.config/i3status
ln -si $(pwd)/i3status/i3status.conf ~/.config/i3status/conf

# alacritty
mkdir -p ~/.config/alacritty/
ln -si $(pwd)/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# redshift
cp $(pwd)/redshift/redshift.conf ~/.config/redshift.conf

# picom
ln -si $(pwd)/picom/picom.conf ~/.config/picom/picom.conf

# rofi
mkdir -p ~/.config/rofi/
ln -si $(pwd)/rofi/config.rasi ~/.config/rofi/config.rasi

# awesome
# ln -si $(pwd)/awesome/rc.lua ~/.config/awesome/rc.lua

# polybar
# mkdir -p ~/.config/polybar/
# ln -si $(pwd)/polybar/config.ini ~/.config/polybar/config.ini

# helix
mkdir -p ~/.config/helix
ln -si $(pwd)/helix/config.toml ~/.config/helix/config.toml
ln -si $(pwd)/helix/languages.toml ~/.config/helix/languages.toml
