#!/usr/bin/env bash
# ============================================================
# Update vim-plug to latest version
# Run from chezmoi source directory root
# ============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHEZMOI_ROOT="$(dirname "$SCRIPT_DIR")"
PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
PLUG_DEST="$CHEZMOI_ROOT/dot_vim/autoload/plug.vim"

echo "=== vim-plug updater ==="
echo "Target: $PLUG_DEST"

# Create directory if missing
mkdir -p "$(dirname "$PLUG_DEST")"

# Download to temp file first
TMP_FILE=$(mktemp)
trap 'rm -f "$TMP_FILE"' EXIT

echo "Downloading from $PLUG_URL ..."
if ! curl -fsSL "$PLUG_URL" -o "$TMP_FILE"; then
    echo "Error: download failed" >&2
    exit 1
fi

# Validate it's a non-empty vim script
if ! head -1 "$TMP_FILE" | grep -q 'vim'; then
    echo "Error: downloaded file doesn't look like a vim script" >&2
    exit 1
fi

# Check if actually changed
if [ -f "$PLUG_DEST" ] && diff -q "$PLUG_DEST" "$TMP_FILE" >/dev/null 2>&1; then
    echo "Already up to date. No changes."
    exit 0
fi

# Backup old version if exists
if [ -f "$PLUG_DEST" ]; then
    cp "$PLUG_DEST" "$PLUG_DEST.backup.$(date +%Y%m%d%H%M%S)"
    echo "Backup created."
fi

# Install new version
mv "$TMP_FILE" "$PLUG_DEST"
trap - EXIT

SIZE=$(wc -c < "$PLUG_DEST" | awk '{print $1}')
echo "Updated: $PLUG_DEST ($SIZE bytes)"
echo ""
echo "Next steps:"
echo "  chezmoi apply          # sync to ~/.vim/autoload/"
echo "  chezmoi git add .      # stage changes"
echo "  chezmoi git commit -m 'update vim-plug'"
