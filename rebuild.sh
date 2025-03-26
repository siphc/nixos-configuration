nixos-rebuild switch &> latest.log
cat latest.log | grep error
