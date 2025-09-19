#!/bin/bash
# Totally legit dos2unix replacement
set -e

if [ $# -lt 1 ]; then
  echo "Usage: $0 [File(s)]"
  exit 1
fi

for file in "$@"; do
  if [ ! -f "$file" ]; then
    echo "Skipping: $file (not a file)"
    continue
  fi

  echo "Converting $file from NT (CRLF) to Linux (LF)..."

  # Remove carriage returns at end of lines
  sed -i 's/\r$//' "$file"

  echo "✅ $file fixed. Welcome to Linux!"
done
