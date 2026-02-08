Steps to replicate the system configuration starting from a fresh NixOS installation:
1. install git: `sudo nano /etc/nixos/configuration.nix` => `sudo nixos-rebuild switch`
2. clone repository: `cd ~ ; git clone https://github.com/siphc/nixos-configuration.git` (note that you won't have ssh by this stage!)
3. download source code of required packages (dwm, st, slstatus) and copy configuration files over (TODO: this task is automate-able, so we can write a shell script that accomplishes this)
4. change `users.users.*` and `"nixos-config=*` in `nix.nixPath` to your own username, of course.
5. **IMPORTANT**: change `system.stateVersion` to your own version AS OF TIME OF INSTALL as described in `/etc/nixos/configuration.nix`.
6. `nixos-rebuild switch -I nixos-config=/home/[USER]/nixos-configuration/configuration.nix`
7. `~/nixos-configuration/initsetup.sh`
8. reboot.

Optionally you can do a manual patch in slstatus/util.c where you change the prefix_1024 values in fmt_human to single characters i.e. K, B, G. I could make a patch but I'm too lazy.

Steps to upgrade nixpkgs channels:
I don't trust system.autoUpgrade.enable, so we have to do this manually twice a year.
1. `sudo nix-channel --add https://channels.nixos.org/channel-name nixos`, change channel-name to a desirable channel, like nixos-25.11 or nixos-unstable.
2. `sudo nixos-rebuild switch --upgrade`
Both commands have to be ran with `sudo` to make sure that the channel is correctly set in the configuration file (as [channels are set per user](https://nixos.org/manual/nixos/stable/#sec-upgrading)).
Pretty sure this recompiles firefox like 4 times, so you'll need to wait a bit.

TODO:
- All three suckless packages can be added as Git submodules... Will get to that the next time I have to reinstall my system.
- There is also a (one-line) patch needed to fix window borders being transparent. It is called fixborders. I have manually applied it for now but I will get to automating that when I have the time.
  - This patch makes it so that you have to login twice SOMETIMES (the first time it logs out automatically). I do not know why. The fix works though
- It is best to set up a cronjob that runs `sudo nixos-rebuild switch --upgrade` every 24 hours or so, as the rebuild times are quite long if left neglected for a long time.
