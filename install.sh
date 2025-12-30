#!/usr/bin/env bash

set -e

# Source directory of this script (repo root)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$HOME/bin"
TARGET_FILE="$TARGET/mira"

echo "Installing Mira AI..."

# Make sure ~/bin exists
mkdir -p "$TARGET"

# Make mira.py executable
chmod +x "$SCRIPT_DIR/mira.py"

# Copy mira.py to ~/bin/mira
cp "$SCRIPT_DIR/mira.py" "$TARGET_FILE"

echo "Copied mira.py to $TARGET_FILE"

# Add ~/bin to PATH in ~/.bashrc if not already present
if ! grep -q 'export PATH=.*$HOME/bin' "$HOME/.bashrc"; then
  echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
  echo "Added ~/bin to PATH in ~/.bashrc"
else
  echo "~/bin already in PATH"
fi

echo "Installation complete! Please restart your terminal or run:"
echo "  source ~/.bashrc"
echo "Then you can run 'mira' from anywhere."
echo "🌕 Greetings, traveller."

exit 0
