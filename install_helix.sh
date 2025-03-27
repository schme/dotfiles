#!/usr/bin/env bash

mkdir -p $HOME/Programs/
pushd $HOME/Programs/
git clone https://github.com/helix-editor/helix
pushd helix

git checkout tags/25.01
cargo install --path helix-term --locked
mkdir -p ~/.config/helix/
ln -Ts $PWD/runtime ~/.config/helix/runtime

