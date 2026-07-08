#!/usr/bin/env bash
# Post-install script for Arch Linux: installs the external tools (LSP servers,
# formatters, linters, helper CLIs) that this nvim config expects on PATH.
#
# Run this AFTER `nvim_setup_arch.sh`. Re-running is safe.
#
# Requirements: pacman (root via sudo), Node.js + npm. An AUR helper (yay or
# paru) is needed for a couple of packages not in the official repos.
set -eu

if ! command -v pacman >/dev/null 2>&1; then
    echo "Error: pacman not found. This script targets Arch Linux." >&2
    exit 1
fi

if ! command -v npm >/dev/null 2>&1; then
    echo "npm not found — installing Node.js via pacman"
    sudo pacman -S --needed --noconfirm nodejs npm
fi

# Pick an AUR helper if present; some packages aren't in the official repos.
AUR_HELPER=""
if command -v yay >/dev/null 2>&1; then
    AUR_HELPER="yay"
elif command -v paru >/dev/null 2>&1; then
    AUR_HELPER="paru"
fi

#######################################################################
#                       Core search / nav tools                       #
#######################################################################
# fzf-lua + live-grep need these.
PACMAN_CORE=(
    fzf
    ripgrep
    fd
    tree-sitter-cli
)

#######################################################################
#                          Language servers                           #
#######################################################################
PACMAN_LSP=(
    lua-language-server          # lua_ls
#    gopls                        # gopls (Go)
#    golangci-lint                # required by golangci-lint-langserver
    ruff                         # Python linter + LSP
)

#######################################################################
#                        Productivity plugins                         #
#######################################################################
PACMAN_EXTRAS=(
    lazygit                      # lazygit.nvim
    lazydocker                   # lazydocker.nvim
)

PACMAN_ALL=("${PACMAN_CORE[@]}" "${PACMAN_LSP[@]}" "${PACMAN_EXTRAS[@]}")

for pkg in "${PACMAN_ALL[@]}"; do
    if pacman -Qi "$pkg" >/dev/null 2>&1; then
        echo "✓ $pkg already installed"
    else
        echo "→ Installing $pkg"
        sudo pacman -S --needed --noconfirm "$pkg"
    fi
done

#######################################################################
#                     AUR-only packages (vtsls)                       #
#######################################################################
# vtsls isn't in the official repos. Install via AUR helper, or fall back
# to npm if no helper is available.
AUR_PKGS=(
    vtsls                        # TypeScript / React (.ts/.tsx/.js/.jsx)
)

if [[ -n "$AUR_HELPER" ]]; then
    for pkg in "${AUR_PKGS[@]}"; do
        if pacman -Qi "$pkg" >/dev/null 2>&1; then
            echo "✓ $pkg already installed (AUR)"
        else
            echo "→ Installing $pkg via $AUR_HELPER"
            "$AUR_HELPER" -S --needed --noconfirm "$pkg"
        fi
    done
else
    echo "⚠ No AUR helper (yay/paru) found — falling back to npm for vtsls."
    sudo npm install -g @vtsls/language-server
fi

#######################################################################
#                         npm-only packages                           #
#######################################################################
# These language servers aren't packaged on Arch.
NPM_GLOBALS=(
    vscode-langservers-extracted # eslint, html, css, json LSPs
    bash-language-server         # bashls
    vim-language-server          # vimls
    yaml-language-server         # yamlls
    prettier                     # conform.nvim formatter
    "@fsouza/prettierd"          # faster prettier daemon (preferred by conform)
    oxfmt                        # JS/TS/JSON formatter (squid-frontend uses this)
    hunkdiff                     # hunk review-first diff viewer, <leader>lh (not packaged for pacman/AUR)
)

for pkg in "${NPM_GLOBALS[@]}"; do
    echo "→ npm install -g $pkg"
    sudo npm install -g "$pkg"
done

#######################################################################
#                      Python LSP (pyright fork)                      #
#######################################################################
# `delance-langserver` is the executable name used by pyright config in
# lua/lsp_conf.lua. Install via pipx so it gets its own venv.
if ! command -v pipx >/dev/null 2>&1; then
    echo "pipx not found — installing via pacman"
    sudo pacman -S --needed --noconfirm python-pipx
fi

if command -v pipx >/dev/null 2>&1; then
    pipx install delance --force >/dev/null 2>&1 || pipx upgrade delance || true
else
    echo "⚠ pipx still not available — skipping delance (pyright)."
fi

#######################################################################
#                   pynvim venv (python3 provider)                    #
#######################################################################
# UltiSnips and other py3-backed plugins need the pynvim module. Arch's
# system Python is PEP-668 externally-managed, so we keep pynvim in a
# dedicated venv and point Neovim at it via vim.g.python3_host_prog
# (set in lua/globals.lua).
NVIM_PY_VENV="$HOME/.local/venv/nvim"
if [[ ! -x "$NVIM_PY_VENV/bin/python3" ]]; then
    echo "→ Creating pynvim venv at $NVIM_PY_VENV"
    python3 -m venv "$NVIM_PY_VENV"
fi
"$NVIM_PY_VENV/bin/pip" install --quiet --upgrade pip pynvim

#######################################################################
#                        Hunk config (theme, keys)                    #
#######################################################################
# Single source of truth lives in the repo at hunk/config.toml — symlink it
# into place so editing the repo file is all that's needed to update it.
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "$HOME/.config/hunk"
ln -sf "$REPO_ROOT/hunk/config.toml" "$HOME/.config/hunk/config.toml"
echo "✓ linked ~/.config/hunk/config.toml -> $REPO_ROOT/hunk/config.toml"

echo ""
echo "Finished installing post-install dependencies."
echo "Open nvim and run :checkhealth vim.lsp to verify servers are detected."
