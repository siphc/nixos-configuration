#!/bin/sh

mkdir -p ~/.config
mkdir -p ~/.trash
cp -r ~/nixos-configuration/lf/ ~/.config/
ln -s ~/nixos-configuration/helix.toml ~/.config/helix/config.toml
