#!/usr/bin/env sh

sudo apt install redshift redshift-gtk
# Doesn't work as symlink for some reason
cp "$PWD/redshift/redshift.conf" ~/.config/
