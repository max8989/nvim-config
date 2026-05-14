#!/bin/bash
# This script is used to update Nvim on macOS
set -eux

ARCH=$(uname -m)
if [[ "$ARCH" == "arm64" ]]; then
    TARBALL="nvim-macos-arm64.tar.gz"
    NVIM_DIR="nvim-macos-arm64"
else
    TARBALL="nvim-macos-x86_64.tar.gz"
    NVIM_DIR="nvim-macos-x86_64"
fi

curl -LO "https://github.com/neovim/neovim/releases/download/stable/${TARBALL}"

if [[ ! -d "$HOME/tools/"  ]]; then
    mkdir -p "$HOME/tools"
fi

# Delete existing nvim installation.
if [[ -d "$HOME/tools/${NVIM_DIR}" ]]; then
    rm -rf "$HOME/tools/${NVIM_DIR}"
fi

# Extract the tar ball
tar zxvf "${TARBALL}" -C "$HOME/tools"

rm "${TARBALL}"

# Next: run `docs/nvim_post_install_mac.sh` to install LSP servers,
# formatters, linters, and helper CLIs.
