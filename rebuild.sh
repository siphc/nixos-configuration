nixos-rebuild switch &> latest.log
cat latest.log | grep -i --color -C 5 error
