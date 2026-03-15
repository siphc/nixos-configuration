set -e

# question for oneself:
# why does 'git diff --exit-code' not work?
if git diff --quiet ; then
	echo "No changes detected; exiting."
	exit 0
fi

git diff -bU0

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	message=$(nixos-rebuild list-generations | grep True)
elif [[ "$OSTYPE" == "darwin"* ]]; then
	message=$(sudo darwin-rebuild --list-generations | grep current)
else
	echo "Unsupported OS."
	exit 0
fi

bversion=$(echo $message | awk {'print $1'})
bdate=$(echo $message | awk {'print $2'})
git commit -am "build version: $bversion build date: $bdate"
