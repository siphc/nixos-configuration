{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
  ];

  # If you change this, next invocation of darwin-rebuild should use the -I flag.
  environment.darwinConfig = "/Users/svi/nixos-configuration/configuration.nix";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
