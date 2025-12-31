#!/bin/bash

echo "Removing mira executable from ~/bin..."
rm -f ~/bin/mira

# Remove PATH addition from .bashrc if exists
if grep -q 'export PATH="$HOME/bin:$PATH"' ~/.bashrc; then
  sed -i '/export PATH="\$HOME\/bin:\$PATH"/d' ~/.bashrc
  echo "Removed PATH modification from ~/.bashrc"
fi

# Ask about deleting config data
read -p "Do you want to delete Mira's memory data (~/.config/mira)? [y/N]: " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
  echo "Deleting memory data..."
  rm -rf ~/.config/mira
else
  echo "Memory data retained."
fi

echo "Removal complete! Please run 'source ~/.bashrc' or restart your terminal to apply changes."
echo "🌕 Farewell, traveller."
