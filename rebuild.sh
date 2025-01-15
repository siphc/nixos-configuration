set -e

pushd ~/nixos
$EDITOR configuration.nix

# questions for oneself:
# why does 'git diff --exit-code' not work?
if git diff --quiet '*.nix'; then
	echo "No changes detected; exiting."
	popd
	exit 0
fi

git diff -bU0 '*.nix'

sudo nixos-rebuild switch | grep error && exit 1

message=$(nixos-rebuild list-generations | grep current)
git commit -am "build version: ${message:0:3}    build date: $(date +%F\ %r)"
