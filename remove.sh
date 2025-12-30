#!/usr/bin/env bash

set -e

TARGET="$HOME/bin/mira"

echo "Removing Mira AI..."

if [ -f "$TARGET" ]; then
  rm "$TARGET"
  echo "Removed $TARGET"
else
  echo "Mira not found at $TARGET"
fi

# Remove PATH modification from ~/.bashrc
sed -i '/export PATH=.*\$HOME\/bin/d' "$HOME/.bashrc"
echo "Removed PATH modification from ~/.bashrc (if it existed)"

echo "Uninstallation complete! Please restart your terminal or run:"
echo "  source ~/.bashrc"
echo "🌕 Farewell, traveller."

exit 0
