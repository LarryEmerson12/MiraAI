#!/usr/bin/env bash

set -e

echo "🌕 Installing Mira AI..."

# Ensure bin exists
mkdir -p "$HOME/bin"

# Make executable
chmod +x mira.py

# Install dependency
pip install --user rich termcolor

# Symlink
ln -sf "$(pwd)/mira.py" "$HOME/bin/mira"

# Ensure PATH
if ! echo "$PATH" | grep -q "$HOME/bin"; then
  echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
  echo "Added ~/bin to PATH"
fi

echo "🌕 Greetings, traveller!"
echo "✅ Mira is installed! Run with: mira"