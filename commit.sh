# questions for oneself:
# why does 'git diff --exit-code' not work?
if git diff --quiet ; then
	echo "No changes detected; exiting."
	exit 0
fi

git diff -bU0

message=$(nixos-rebuild list-generations | grep True)
bversion=echo $message | awk {'print $1'}
bdate=echo $message | awk {'print $2'}
git commit -am "build version: $bversion build date: $bdate"
