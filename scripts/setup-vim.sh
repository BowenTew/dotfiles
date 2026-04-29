#!/usr/bin/env bash
# ============================================================
# Vim Setup — One-shot environment bootstrap
# Run after `chezmoi apply` on a fresh machine
# ============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VIM_PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
VIM_PLUG_PATH="${HOME}/.vim/autoload/plug.vim"

colored_echo() {
    local color="$1"
    local msg="$2"
    case "$color" in
        red)    echo -e "\033[31m${msg}\033[0m" ;;
        green)  echo -e "\033[32m${msg}\033[0m" ;;
        yellow) echo -e "\033[33m${msg}\033[0m" ;;
        blue)   echo -e "\033[34m${msg}\033[0m" ;;
        *)      echo "$msg" ;;
    esac
}

# ----------------------------------------------------------
# 0. Pre-flight checks
# ----------------------------------------------------------
colored_echo blue "=== Vim Environment Setup ==="

if ! command -v vim &>/dev/null; then
    colored_echo red "Error: vim not found. Install vim first."
    exit 1
fi

VIM_VERSION=$(vim --version | head -1 | grep -o '[0-9]\+\.[0-9]\+' | head -1)
colored_echo green "vim version: ${VIM_VERSION}"

if ! command -v git &>/dev/null; then
    colored_echo red "Error: git not found. Required by vim-plug."
    exit 1
fi

if ! command -v curl &>/dev/null; then
    colored_echo red "Error: curl not found."
    exit 1
fi

# ----------------------------------------------------------
# 1. Ensure vim-plug is installed
# ----------------------------------------------------------
colored_echo blue "[1/4] Checking vim-plug..."

if [ -f "$VIM_PLUG_PATH" ]; then
    colored_echo green "vim-plug already installed."
else
    colored_echo yellow "Downloading vim-plug..."
    mkdir -p "$(dirname "$VIM_PLUG_PATH")"
    curl -fLo "$VIM_PLUG_PATH" --create-dirs "$VIM_PLUG_URL"
    colored_echo green "vim-plug installed."
fi

# ----------------------------------------------------------
# 2. Install all plugins via vim-plug
# ----------------------------------------------------------
colored_echo blue "[2/4] Installing vim plugins (this may take a while)..."

# Use --not-a-term to avoid TTY issues in CI/automation
# Redirect output to show progress while keeping logs
vim --not-a-term -c 'PlugInstall --sync' -c 'qa!' 2>&1 | tee /tmp/vim-plug-install.log | grep -E "(Installing|Updating|Finished|Already)" || true

if [ "${PIPESTATUS[0]}" -ne 0 ]; then
    colored_echo red "Plugin installation failed. Check /tmp/vim-plug-install.log"
    exit 1
fi

colored_echo green "Plugins installed."

# ----------------------------------------------------------
# 3. Install vim-go binaries (if Go is available)
# ----------------------------------------------------------
colored_echo blue "[3/4] Checking vim-go dependencies..."

if command -v go &>/dev/null; then
    colored_echo yellow "Go detected. Installing vim-go binaries..."
    vim --not-a-term -c 'GoUpdateBinaries' -c 'qa!' 2>&1 | tail -5
    colored_echo green "vim-go binaries installed."
else
    colored_echo yellow "Go not found. Skipping vim-go binaries."
    colored_echo yellow "  Install Go and run: vim +GoUpdateBinaries +qall"
fi

# ----------------------------------------------------------
# 4. Check coc.nvim extensions
# ----------------------------------------------------------
colored_echo blue "[4/4] Checking coc.nvim extensions..."

COC_EXTENSIONS=(
    "coc-json"
    "coc-tsserver"
    "coc-lua"
    "coc-pyright"
    "coc-go"
    "coc-rust-analyzer"
    "coc-clangd"
    "coc-docker"
)

if command -v npm &>/dev/null; then
    colored_echo yellow "npm detected. Installing coc extensions globally..."
    for ext in "${COC_EXTENSIONS[@]}"; do
        if npm list -g "$ext" &>/dev/null; then
            colored_echo green "  ✓ ${ext} already installed"
        else
            colored_echo yellow "  → Installing ${ext}..."
            npm install -g "$ext" 2>&1 | tail -1 || colored_echo red "  ✗ ${ext} failed"
        fi
    done
    colored_echo green "coc extensions done."
else
    colored_echo yellow "npm not found. Skipping coc extensions."
    colored_echo yellow "  Install Node.js/npm, then in vim run:"
    for ext in "${COC_EXTENSIONS[@]}"; do
        colored_echo yellow "    :CocInstall ${ext}"
    done
fi

# ----------------------------------------------------------
# Done
# ----------------------------------------------------------
colored_echo blue ""
colored_echo green "=== Vim setup complete ==="
colored_echo blue ""
colored_echo blue "Next steps:"
colored_echo blue "  1. Open vim and verify: vim"
colored_echo blue "  2. Check coc status: :CocInfo"
colored_echo blue "  3. If anything missing, run this script again"
