if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo nixos-rebuild switch &> latest.log
elif [[ "$OSTYPE" == "darwin"* ]]; then
  sudo darwin-rebuild switch &> latest.log
else
  echo "Unsupported OS."
  exit 0
fi

cat latest.log | grep -i --color -C 5 "error\|done"
