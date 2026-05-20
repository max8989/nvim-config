#!/usr/bin/env bash
# Symlink the tmux package into $HOME using GNU stow.
#
# Usage:
#   ./stow.sh            # stow (restow, idempotent)
#   ./stow.sh unstow     # remove the symlinks
#   ./stow.sh adopt      # pull existing files in $HOME into this repo, then stow
#   ./stow.sh simulate   # dry-run: print what would happen

set -euo pipefail

PKG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STOW_DIR="$(dirname "$PKG_DIR")"
PKG="$(basename "$PKG_DIR")"
TARGET="${HOME}"

if ! command -v stow >/dev/null 2>&1; then
  echo "error: GNU stow is not installed. Install it and retry (e.g. pacman -S stow)." >&2
  exit 1
fi

# Skip the helper itself when stowing.
IGNORE_REGEX='(^|/)stow\.sh$'

run_stow() {
  stow --dir="$STOW_DIR" --target="$TARGET" --ignore="$IGNORE_REGEX" "$@" "$PKG"
}

ACTION="${1:-stow}"
case "$ACTION" in
  stow)     run_stow --restow ;;
  unstow)   run_stow --delete ;;
  adopt)    run_stow --adopt && run_stow --restow ;;
  simulate) run_stow --simulate --verbose --restow ;;
  *)
    echo "usage: $0 [stow|unstow|adopt|simulate]" >&2
    exit 2
    ;;
esac

echo "done: $ACTION (package=$PKG target=$TARGET)"
