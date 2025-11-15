Steps to replicate the system configuration starting from a fresh NixOS installation:
1. install git: `sudo nano /etc/nixos/configuration.nix` => `sudo nixos-rebuild switch`
2. clone repository: `cd ~ ; git clone https://github.com/siphc/nixos-configuration.git` (note that you won't have ssh by this stage!)
3. download source code of required packages (dwm, st, slstatus) and copy configuration files over
4. change `users.users.*` and `"nixos-config=*` in `nix.nixPath` to your own username, of course.
5. **IMPORTANT**: change `system.stateVersion` to your own version AS OF TIME OF INSTALL as described in `/etc/nixos/configuration.nix`.
6. `nixos-rebuild switch -I nixos-config=/home/[USER]/nixos-configuration/configuration.nix`
7. ensure screenshot scripts function properly: `cd ~ ; mkdir Pictures && mkdir Pictures/Screenshots`
8. fix PATH by symlinking to `./bin` from `~/.local/bin`
9. reboot.
