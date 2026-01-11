#!/usr/bin/env bash
set -e

echo "🌕 Installing Mira AI..."

# ---------- Make script executable ----------
chmod +x mira.py
chmod +x install.sh

# ---------- Detect Python ----------
if command -v python3 >/dev/null 2>&1; then
  PYTHON=python3
elif command -v python >/dev/null 2>&1; then
  PYTHON=python
else
  echo "❌ Python not found"
  exit 1
fi

# ---------- Install Python deps ----------
echo "📦 Installing Python dependencies..."
$PYTHON -m pip install --user --upgrade pip
$PYTHON -m pip install --user termcolor rich

# ---------- Install location ----------
BIN_DIR="$HOME/bin"
INSTALL_DIR="$BIN_DIR/mira"

mkdir -p "$INSTALL_DIR"

# ---------- Copy files ----------
cp mira.py "$INSTALL_DIR/mira"
cp model.py "$INSTALL_DIR/model.py"
chmod +x "$INSTALL_DIR/mira"

# ---------- PATH setup ----------
if ! echo "$PATH" | grep -q "$BIN_DIR"; then
  echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
  echo "➕ Added ~/bin to PATH"
fi

# ---------- Config directory ----------
CONFIG_DIR="$HOME/.config/mira"
mkdir -p "$CONFIG_DIR"

# ---------- Seed memory ----------
MEMORY_FILE="$CONFIG_DIR/memory.json"
if [ ! -f "$MEMORY_FILE" ]; then
  echo "🧠 Creating seed knowledge..."
  cat > "$MEMORY_FILE" << 'EOF'
{
  "name": null,
  "knowledge": {
    "hi": "Hello 🌕",
    "hello": "Hi there 🌕",
    "what is mira": "Mira is a lightweight, local CLI AI assistant.",
    "what is ai": "AI stands for Artificial Intelligence.",
    "what is python": "Python is a high-level programming language."
  }
}
EOF
fi

echo
echo "✅ Installation complete!"
echo "➡️ Restart your terminal or run: source ~/.bashrc"
echo "➡️ Then type: mira"
echo "🌕 Welcome, traveller."
