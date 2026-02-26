Steps to replicate the system configuration starting from a fresh NixOS installation:
1. install git: `sudo nano /etc/nixos/configuration.nix` => `sudo nixos-rebuild switch`
2. clone repository: `cd ~ ; git clone https://github.com/siphc/nixos-configuration.git` (note that you won't have ssh by this stage!)
3. setup git subtrees for suckless packages, changing version numbers as needed. details are below.
4. change `users.users.*` and `"nixos-config=*` in `nix.nixPath` to your own username, of course. also change that in `src/dwm/config.h`.
5. **IMPORTANT**: change `system.stateVersion` to your own version AS OF TIME OF INSTALL as described in `/etc/nixos/configuration.nix`.
6. `nixos-rebuild switch -I nixos-config=/home/[USER]/nixos-configuration/configuration.nix`
7. `~/nixos-configuration/initsetup.sh`
8. reboot.

```
cd ~/nixos-configuration/
mkdir src/
git subtree add --prefix=src/dwm https://git.suckless.org/dwm 6.8 --squash
git subtree add --prefix=src/slstatus https://git.suckless.org/slstatus 1.1 --squash
```

Steps to upgrade nixpkgs channels:
I don't trust system.autoUpgrade.enable, so we have to do this manually twice a year.
1. `sudo nix-channel --add https://channels.nixos.org/channel-name nixos`, change channel-name to a desirable channel, like nixos-25.11 or nixos-unstable.
2. `sudo nixos-rebuild switch --upgrade`
Both commands have to be ran with `sudo` to make sure that the channel is correctly set in the configuration file (as [channels are set per user](https://nixos.org/manual/nixos/stable/#sec-upgrading)).
This command takes a bit. Be patient.

TODO:
- It is best to set up a cronjob that runs `sudo nixos-rebuild switch --upgrade` every 24 hours or so, as the rebuild times are quite long if left neglected for a long time.

NOTE:
The one-liner fixborders patch, courtesy of Jakub Leszczak: https://github.com/MaxGyver83/dwm/blob/custom/dwm-fixborders-6.2.diff
