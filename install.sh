#!/usr/bin/env bash
set -e

echo "🌕 Installing Mira AI..."

# ----------------------------
# Detect OS (Linux / macOS / Windows Git Bash)
# ----------------------------
OS="$(uname -s)"
IS_WINDOWS=false

case "$OS" in
  MINGW*|MSYS*|CYGWIN*)
    IS_WINDOWS=true
    ;;
esac

# ----------------------------
# Paths
# ----------------------------
BIN_DIR="$HOME/bin"
CONFIG_DIR="$HOME/.config/mira"

mkdir -p "$BIN_DIR"
mkdir -p "$CONFIG_DIR"

# ----------------------------
# Clean old broken installs
# ----------------------------
if [ -d "$BIN_DIR/mira" ]; then
  echo "⚠️ Removing old mira folder (wrong install)..."
  rm -rf "$BIN_DIR/mira"
fi

# ----------------------------
# Copy files
# ----------------------------
echo "📁 Installing files..."

cp mira.py "$BIN_DIR/mira.py"
cp model.py "$BIN_DIR/model.py"

# ----------------------------
# Create launcher (mira)
# ----------------------------
echo "🚀 Creating launcher..."

cat > "$BIN_DIR/mira" << 'EOF'
#!/usr/bin/env python3
import os
import sys

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, SCRIPT_DIR)

from mira import main

if __name__ == "__main__":
    main()
EOF

chmod +x "$BIN_DIR/mira"

# ----------------------------
# Python dependency install
# ----------------------------
echo "🐍 Installing Python dependencies..."

PYTHON_BIN="python3"
if $IS_WINDOWS; then
  PYTHON_BIN="python"
fi

$PYTHON_BIN -m pip install --user --upgrade pip
$PYTHON_BIN -m pip install --user rich termcolor

# ----------------------------
# Ensure PATH
# ----------------------------
if ! echo "$PATH" | grep -q "$HOME/bin"; then
  echo "➕ Adding ~/bin to PATH"

  if [ -f "$HOME/.bashrc" ]; then
    echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
  fi

  if [ -f "$HOME/.zshrc" ]; then
    echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.zshrc"
  fi
fi

# ----------------------------
# Success
# ----------------------------
echo
echo "✅ Mira AI installed successfully!"
echo
echo "👉 Restart your terminal, then run:"
echo
echo "   mira"
echo
