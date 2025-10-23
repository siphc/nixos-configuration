Steps to replicate the system configuration starting from a fresh NixOS installation:
1. install git: `sudo nano /etc/nixos/configuration.nix` => `sudo nixos-rebuild switch`
2. clone repository: `cd ~ ; git clone https://github.com/siphc/nixos-configuration.git` (note that you won't have ssh by this stage!)
3. download source code of required packages (dwm, st, slstatus) and copy configuration files over
4. change `users.users.*` and `"nixos-config=*` in `nix.nixPath` to your own username, of course.
5. `nixos-rebuild switch -I nixos-config=/home/[USER]/nixos-configuration/configuration.nix`
6. ensure screenshot scripts function properly: `cd ~ ; mkdir Pictures && mkdir Pictures/Screenshots`
7. fix PATH by symlinking to `./bin` from `~/.local/bin`
8. reboot.
