#!/usr/bin/env bash
# Arch Linux setup for this nvim config (jdhao fork).
# Idempotent — safe to re-run.
#
# Usage:  bash docs/nvim_setup_arch.sh
#
# Installs everything via pacman:
#   - core: neovim, ripgrep, fd, fzf, git
#   - LSP servers (matches jdhao's enabled_lsp_servers in lua/lsp_conf.lua + TS)
#   - optional: nodejs/npm for js-based tools, python for python LSP runtime
#
# This is the Arch equivalent of jdhao's docs/nvim_setup_linux.sh, which targets
# Debian/Ubuntu and downloads tarballs to ~/tools/. We use pacman instead.

set -euo pipefail

# ─── flags (edit to taste) ───────────────────────────────────────────────
INSTALL_NEOVIM=true              # install neovim itself if missing
INSTALL_CORE_TOOLS=true          # ripgrep, fd, fzf, git, unzip
INSTALL_LSP_LUA=true             # lua-language-server  (editing this nvim config)
INSTALL_LSP_BASH=true            # bash-language-server
INSTALL_LSP_YAML=true            # yaml-language-server
INSTALL_LSP_JSON=true            # vscode-json-languageserver
INSTALL_LSP_TYPESCRIPT=true      # typescript-language-server (for ts/js/tsx/jsx)
INSTALL_LSP_ESLINT=false         # vscode-eslint-language-server (AUR)
INSTALL_LSP_PYTHON=false         # pyright + ruff
INSTALL_LSP_GO=false             # gopls
INSTALL_PYNVIM=false             # python-pynvim (only needed for jdhao's UltiSnips)
INSTALL_CTAGS=false              # for jdhao's vista.vim tagbar
LINK_CONFIG=true                 # symlink ~/.config/nvim → this repo
BOOTSTRAP_PLUGINS=true           # headless `:Lazy sync` to install plugins

# ─── locate repo root ───────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"

echo "Repo root detected: $REPO_ROOT"
echo

# ─── pacman helper ──────────────────────────────────────────────────────
pacman_install() {
  local pkgs=("$@")
  if (( ${#pkgs[@]} == 0 )); then return; fi
  echo "==> Installing: ${pkgs[*]}"
  sudo pacman -S --needed --noconfirm "${pkgs[@]}"
}

# ─── collect packages ───────────────────────────────────────────────────
PKGS=()
[[ "$INSTALL_NEOVIM" == true ]]         && PKGS+=(neovim)
[[ "$INSTALL_CORE_TOOLS" == true ]]     && PKGS+=(ripgrep fd fzf git unzip)
[[ "$INSTALL_LSP_LUA" == true ]]        && PKGS+=(lua-language-server)
[[ "$INSTALL_LSP_BASH" == true ]]       && PKGS+=(bash-language-server)
[[ "$INSTALL_LSP_YAML" == true ]]       && PKGS+=(yaml-language-server)
[[ "$INSTALL_LSP_JSON" == true ]]       && PKGS+=(vscode-json-languageserver)
[[ "$INSTALL_LSP_TYPESCRIPT" == true ]] && PKGS+=(typescript-language-server)
[[ "$INSTALL_LSP_PYTHON" == true ]]     && PKGS+=(pyright ruff)
[[ "$INSTALL_LSP_GO" == true ]]         && PKGS+=(gopls)
[[ "$INSTALL_PYNVIM" == true ]]         && PKGS+=(python-pynvim)
[[ "$INSTALL_CTAGS" == true ]]          && PKGS+=(ctags)

pacman_install "${PKGS[@]}"

# ─── AUR-only LSPs (need yay or paru) ───────────────────────────────────
if [[ "$INSTALL_LSP_ESLINT" == true ]]; then
  if command -v yay >/dev/null 2>&1; then
    yay -S --needed --noconfirm vscode-eslint-language-server
  elif command -v paru >/dev/null 2>&1; then
    paru -S --needed --noconfirm vscode-eslint-language-server
  else
    echo "WARNING: vscode-eslint-language-server is in the AUR. Install yay or paru, then run:"
    echo "  yay -S vscode-eslint-language-server"
  fi
fi

# ─── symlink ~/.config/nvim → repo ──────────────────────────────────────
if [[ "$LINK_CONFIG" == true ]]; then
  mkdir -p "$HOME/.config"
  if [[ -e "$HOME/.config/nvim" && ! -L "$HOME/.config/nvim" ]]; then
    BACKUP="$HOME/.config/nvim.backup-$(date +%Y%m%d-%H%M%S)"
    echo "==> ~/.config/nvim exists and is not a symlink — backing up to $BACKUP"
    mv "$HOME/.config/nvim" "$BACKUP"
  fi

  if [[ -L "$HOME/.config/nvim" ]] && [[ "$(readlink -f "$HOME/.config/nvim")" == "$REPO_ROOT" ]]; then
    echo "==> ~/.config/nvim already points to this repo. Skipping."
  else
    if [[ -L "$HOME/.config/nvim" ]]; then
      echo "==> Removing stale symlink at ~/.config/nvim"
      rm "$HOME/.config/nvim"
    fi
    echo "==> Linking ~/.config/nvim → $REPO_ROOT"
    ln -s "$REPO_ROOT" "$HOME/.config/nvim"
  fi
fi

# ─── bootstrap plugins ──────────────────────────────────────────────────
if [[ "$BOOTSTRAP_PLUGINS" == true ]]; then
  echo "==> Bootstrapping lazy.nvim plugins (headless)"
  nvim --headless "+Lazy! sync" +qa 2>&1 | tail -5 || true
fi

echo
echo "Done. Launch: nvim"
echo
echo "Pull updates from upstream (jdhao):"
echo "  cd $REPO_ROOT"
echo "  git fetch upstream"
echo "  git rebase upstream/main      # rebases your personal commit on top"
echo "  git push --force-with-lease   # update your fork"
