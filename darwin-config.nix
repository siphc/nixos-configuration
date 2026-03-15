{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    git
    helix
    librewolf
    alacritty
  ];

  # If you change this, next invocation of darwin-rebuild should use the -I flag.
  environment.darwinConfig = "/Users/svi/nixos-configuration/darwin-config.nix";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
