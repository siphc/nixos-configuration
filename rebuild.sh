$EDITOR configuration.nix

# questions for oneself:
# why does 'git diff --exit-code' not work?
if git diff --quiet '*.nix'; then
	echo "No changes detected; exiting."
	exit 0
fi

sudo nixos-rebuild switch | grep error && exit 1

git diff -U0b '*.nix'

message=$(nixos-rebuild list-generations | grep current)
git commit -am "build version: ${message:0:1}    build date: $(date +%F\ %r)"
