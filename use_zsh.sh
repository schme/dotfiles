#!/usr/bin/env bash

script_dir="dirname $0"
echo Target file: "$script_dir/zsh/.zshrc"

# Zsh
mv ~/.zshrc ~/.zshrc.bu
ln -si "$script_dir/zsh/.zshrc" ~/.zshrc
