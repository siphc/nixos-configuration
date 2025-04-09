# questions for oneself:
# why does 'git diff --exit-code' not work?
if git diff --quiet ; then
	echo "No changes detected; exiting."
	exit 0
fi

git diff -bU0

message=$(nixos-rebuild list-generations | grep current)
git commit -am "build version: ${message:0:3}    build date: $(date +%F\ %r)"
