#!/bin/sh

rm -rf ~/.config/helix ~/.config/alacritty
rm ~/.config/lf ~/.bashrc ~/.local/bin

mkdir -p ~/.config/helix ~/.config/alacritty ~/.trash ~/Pictures/Screenshots ~/.local
ln -s ~/nixos-configuration/.bashrc ~/.bashrc
ln -s ~/nixos-configuration/bin ~/.local/bin
ln -s ~/nixos-configuration/cfgs/lf ~/.config/lf
ln -s ~/nixos-configuration/cfgs/hx-config.toml ~/.config/helix/config.toml
ln -s ~/nixos-configuration/cfgs/hx-language.toml ~/.config/helix/languages.toml
ln -s ~/nixos-configuration/cfgs/alacritty.toml ~/.config/alacritty/alacritty.toml
