Steps to replicate the system configuration starting from a fresh NixOS (minimal ISO image) installation:

```sh
# Install git.
sudo nano /etc/nixos/configuration.nix
sudo nixos-rebuild switch

# Clone repository.
cd ~ ; git clone https://github.com/siphc/nixos-configuration.git

# Setup suckless packages as git subtrees.
cd ~/nixos-configuration/ ; mkdir src/
git subtree add --prefix=src/dwm https://git.suckless.org/dwm 6.8 --squash
git subtree add --prefix=src/slstatus https://git.suckless.org/slstatus 1.1 --squash

# Change username from svi to yourself
cd ~/nixos-configuration/
vim configuration.nix
vim src/dwm/config.h

# IMPORTANT: Change `system.stateVersion` to your own version AS OF TIME OF INSTALL as described in `/etc/nixos/configuration.nix`.
vim configuration.nix

# Rebuild the system.
nixos-rebuild switch -I nixos-config=/home/<USER>/nixos-configuration/configuration.nix

# Setup config files.
~/nixos-configuration/initsetup.sh

# Reboot.
```

---

Steps to upgrade nixpkgs channels:

I don't trust `system.autoUpgrade.enable`, so we have to do this manually twice a year.
1. `sudo nix-channel --add https://channels.nixos.org/channel-name nixos`, change channel-name to a desirable channel, like nixos-25.11 or nixos-unstable.
2. `sudo nixos-rebuild switch --upgrade`
Both commands have to be ran with `sudo` to make sure that the channel is correctly set in the configuration file (as [channels are set per user](https://nixos.org/manual/nixos/stable/#sec-upgrading)).
This command takes a bit. Be patient.

---

TODO:

- It is best to set up a cronjob that runs `sudo nixos-rebuild switch --upgrade` every 24 hours or so, as the rebuild times are quite long if left neglected for a long time.

---

NOTE:

The one-liner fixborders patch, courtesy of Jakub Leszczak: https://github.com/MaxGyver83/dwm/blob/custom/dwm-fixborders-6.2.diff

This repository contains code from suckless/dwm, suckless/slstatus, and NixOS/nixpkgs, all of which use the MIT license. A copy of the MIT license is included with this repository.