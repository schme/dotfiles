#!/Usr/bin/env bash

mkdir -p $HOME/Programs/
pushd $HOME/Programs/
git clone git clone https://github.com/helix-editor/helix
pushd helix

# git checkout tags/24.07
cargo install --path helix-term --locked
ln -Ts $PWD/runtime ~/.config/helix/runtime
