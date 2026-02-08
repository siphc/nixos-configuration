#!/bin/sh

mkdir -p ~/.config/helix ~/.config/alacritty ~/.trash ~/Pictures/Screenshots ~/.local
ln -s ~/nixos-configuration/.bashrc ~/.bashrc
ln -s ~/nixos-configuration/bin ~/.local/bin
ln -s ~/nixos-configuration/configs/lf ~/.config/lf
ln -s ~/nixos-configuration/configs/hx-config.toml ~/.config/helix/config.toml
ln -s ~/nixos-configuration/configs/hx-language.toml ~/.config/helix/languages.toml
ln -s ~/nixos-configuration/configs/alacritty.toml ~/.config/alacritty/alacritty.toml
