#!/bin/bash
# Post-install script for macOS: installs the external tools (LSP servers,
# formatters, linters, helper CLIs) that this nvim config expects on PATH.
#
# Run this AFTER `nvim_install_mac.sh`. Re-running is safe.
#
# Requirements: Homebrew, Node.js + npm.
set -eu

if ! command -v brew >/dev/null 2>&1; then
    echo "Error: Homebrew not found. Install from https://brew.sh first." >&2
    exit 1
fi

if ! command -v npm >/dev/null 2>&1; then
    echo "npm not found — installing Node.js via Homebrew"
    brew install node
fi

#######################################################################
#                       Core search / nav tools                       #
#######################################################################
# fzf-lua + live-grep need these.
BREW_CORE=(
    fzf
    ripgrep
    fd
    tree-sitter
)

#######################################################################
#                          Language servers                           #
#######################################################################
BREW_LSP=(
    lua-language-server          # lua_ls
#    gopls                        # gopls (Go)
#    golangci-lint-langserver     # golangci_lint_ls
#    golangci-lint                # required by golangci-lint-langserver
    ruff                         # Python linter + LSP
    vtsls                        # TypeScript / React (.ts/.tsx/.js/.jsx)
)

#######################################################################
#                        Productivity plugins                         #
#######################################################################
BREW_EXTRAS=(
    lazygit                      # lazygit.nvim
    lazydocker                   # lazydocker.nvim
)

for pkg in "${BREW_CORE[@]}" "${BREW_LSP[@]}" "${BREW_EXTRAS[@]}"; do
    if brew list --formula "$pkg" >/dev/null 2>&1; then
        echo "✓ $pkg already installed"
    else
        echo "→ Installing $pkg"
        brew install "$pkg"
    fi
done

#######################################################################
#                         npm-only packages                           #
#######################################################################
# These language servers aren't on Homebrew.
NPM_GLOBALS=(
    vscode-langservers-extracted # eslint, html, css, json LSPs
    bash-language-server         # bashls
    vim-language-server          # vimls
    yaml-language-server         # yamlls
    prettier                     # conform.nvim formatter
    "@fsouza/prettierd"          # faster prettier daemon (preferred by conform)
)

for pkg in "${NPM_GLOBALS[@]}"; do
    echo "→ npm install -g $pkg"
    npm install -g "$pkg"
done

#######################################################################
#                      Python LSP (pyright fork)                      #
#######################################################################
# `delance-langserver` is the executable name used by pyright config in
# lua/lsp_conf.lua. Install via pipx so it gets its own venv.
if command -v pipx >/dev/null 2>&1; then
    pipx install delance --force >/dev/null 2>&1 || pipx upgrade delance || true
else
    echo "⚠ pipx not found — skipping delance (pyright). Install with: brew install pipx"
fi

echo ""
echo "Finished installing post-install dependencies."
echo "Open nvim and run :checkhealth vim.lsp to verify servers are detected."
