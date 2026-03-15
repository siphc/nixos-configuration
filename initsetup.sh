#!/bin/sh

rm -rf ~/.config/helix ~/.config/alacritty
rm ~/.config/lf ~/.bashrc ~/.local/bin

mkdir -p ~/.config/helix ~/.config/alacritty ~/.trash ~/Pictures/Screenshots ~/.local
ln -s ~/nixos-configuration/bin ~/.local/bin
ln -s ~/nixos-configuration/cfgs/.bashrc ~/.bashrc
ln -s ~/nixos-configuration/cfgs/lf ~/.config/lf
ln -s ~/nixos-configuration/cfgs/hx-config.toml ~/.config/helix/config.toml
ln -s ~/nixos-configuration/cfgs/hx-language.toml ~/.config/helix/languages.toml

case $(uname) in
  "Darwin")
    ln -s ~/nixos-configuration/cfgs/alacritty-darwin.toml ~/.config/alacritty/alacritty.toml
    ;;
  *)
    ln -s ~/nixos-configuration/cfgs/alacritty-linux.toml ~/.config/alacritty/alacritty.toml
    ;;
esac
