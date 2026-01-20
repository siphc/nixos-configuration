#!/bin/sh

mkdir -p ~/.config
mkdir -p ~/.trash
cp -r ~/nixos-configuration/lf/ ~/.config/
ln -s ~/nixos-configuration/hx-config.toml ~/.config/helix/config.toml
ln -s ~/nixos-configuration/hx-language.toml ~/.config/helix/languages.toml
mkdir -p ~/.config/alacritty
ln -s ~/nixos-configuration/alacritty.toml ~/.config/alacritty/alacritty.toml
