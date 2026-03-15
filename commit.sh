set -e

# question for oneself:
# why does 'git diff --exit-code' not work?
if git diff --quiet ; then
	echo "No changes detected; exiting."
	exit 0
fi

git diff -bU0

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	message="linux $(nixos-rebuild list-generations | grep True)"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	message="darwin $(sudo darwin-rebuild --list-generations | grep current)"
else
	echo "Unsupported OS."
	exit 0
fi

sys=$(echo "$message" | awk {'print $1'})
ver=$(echo "$message" | awk {'print $2'})
dat=$(echo "$message" | awk {'print $3'})
git commit -am "$sys: v.$ver on $dat"
