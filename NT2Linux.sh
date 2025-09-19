#!/bin/bash
# UltimateFileFixer - Fix allthe little annoyances in your files
# Powered by CorgiMasterEpic 🐕✨
set -e

# Default mode: NT → Linux
MODE="nt2linux"

# Check for --linux2nt flag
if [ "$1" == "--linux2nt" ]; then
  MODE="linux2nt"
  shift
fi

if [ $# -lt 1 ]; then
  echo "Usage: $0 [--linux2nt] [File(s)]"
  exit 1 
  fi

for file in "$@"; do
    if [ ! -f "$file" ]; then
    echo "Skipping: $file (not a file)"
    continue
    fi

  echo "🔧 Fixing $file..."

  # 1. Line endings
  if [ "$MODE" == "nt2linux" ]; then
    sed -i 's/\r$//' "$file"
    echo "⚔️ CRLF → LF done."
  else
    sed -i 's/$/\r/' "$file"
    echo "⚔️ LF → CRLF done."
  fi

  # 2. Remove trailing whitespace
  sed -i 's/[ \t]*$//' "$file"
  echo "🧹 Trailing whitespace cleared."

  # 3. Normalize tabs → 4 spaces
  expand -t 4 "$file" > tmp && mv tmp "$file"
  echo "📏 Tabs normalized to 4 spaces."

  # 4. Ensure newline at end
  sed -i -e '$a\' "$file"
  echo "⏎ Newline at end ensured."

  # 5. Remove non-printable characters
  tr -cd '\11\12\15\40-\176' < "$file" > tmp && mv tmp "$file"
  echo "🧹 Non-printable characters removed."

  # 6. Make script executable if it starts with shebang
  if head -n 1 "$file" | grep -q "^#!"; then
    chmod +x "$file"
    echo "🚀 Script is now executable."
  fi

  # Fun celebration
  echo -e "🐾 $file is now pure, clean, and ready for Linux/Windows! Thanks for using NT2Linux! 🐾\n"
done
