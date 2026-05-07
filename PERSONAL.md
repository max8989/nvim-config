# Personal Layer

Fork of [jdhao/nvim-config](https://github.com/jdhao/nvim-config). All custom keymaps live in `lua/personal.lua` (loaded at the end of `init.lua`). To restore pristine jdhao behavior, comment out `require("personal")` in `init.lua`.

## Setup (Arch Linux)

```bash
git clone git@github.com:max8989/nvim-config.git ~/repos/nvim
bash ~/repos/nvim/docs/nvim_setup_arch.sh
```

The script installs LSPs + tools via pacman, symlinks `~/.config/nvim → ~/repos/nvim`, and bootstraps plugins. Edit the flags at the top of the script to enable/disable specific LSPs (TypeScript and core LSPs are on by default; Python/Go/eslint are off).

## Pulling upstream updates

```bash
cd ~/repos/nvim
git fetch upstream
git rebase upstream/main      # rebases your personal commit on top
git push --force-with-lease   # update your fork on GitHub
```

If conflicts arise, they'll be in the small set of files listed below.

## Diff against pristine jdhao

Direct edits (kept tiny):
- `init.lua` — `require("personal")` at end
- `lua/globals.lua` — `mapleader = " "`, `maplocalleader = "\\"`
- `lua/ui.lua` — locked colorscheme to `kanagawa-dragon` (was random)
- `lua/lsp_conf.lua` — disabled `<C-k>` LSP signature_help (frees `<C-k>` for window-up)
- `lua/plugin_specs.lua` — added `<C-n>` toggle for nvim-tree; added lazygit plugin
- `lua/config/treesitter.lua` — added `tsx` parser

New files:
- `lua/personal.lua` — keymaps + extra LSP enables (ts_ls, eslint, pyright fallback)
- `lua/personal_cheatsheet.lua` — telescope picker reading `cheat-sheet.md`
- `cheat-sheet.md` — personal keymap reference
- `docs/nvim_setup_arch.sh` — Arch Linux setup script
- `PERSONAL.md` — this file

## LSP (no mason — system-installed via pacman)

This fork keeps jdhao's manual LSP enable model. The Arch setup script installs LSPs via pacman:

| LSP | pacman package | Default |
|---|---|---|
| lua_ls | `lua-language-server` | on |
| bashls | `bash-language-server` | on |
| yamlls | `yaml-language-server` | on |
| jsonls | `vscode-json-languageserver` | on |
| ts_ls | `typescript-language-server` | on |
| pyright | `pyright` | off (toggle in script) |
| ruff | `ruff` | off (toggle in script) |
| gopls | `gopls` | off (toggle in script) |
| eslint | `vscode-eslint-language-server` (AUR) | off (toggle in script) |

To add a new LSP:
1. Install the binary (pacman / AUR / npm / pip — whatever ships it)
2. If jdhao's `enabled_lsp_servers` table in `lua/lsp_conf.lua` already covers it, you're done
3. Otherwise add it to the `extra_servers` table in `lua/personal.lua`

## Personal keymaps

**Leader is `<Space>`, localleader is `\`.**

| Keymap | Action |
|---|---|
| `<C-h/j/k/l>` | window navigation |
| `<S-h>` / `<S-l>` | prev / next buffer (bufferline) |
| `<leader>bd` | smart buffer delete (preserves window layout) |
| `<C-n>` | toggle nvim-tree sidebar |
| `<C-p>` | FzfLua find files (same as `<leader>ff`) |
| `<leader>cs` | Telescope colorscheme picker (live preview) |
| `<leader>ch` | cheatsheet picker (`cheat-sheet.md`) |
| `<leader>gg`, `<leader>lg` | LazyGit |
| `<leader>ld` | LazyDocker (float terminal) |
| `<F12>`, `gD`, `gi`, `gr` | LSP go-to-{def, decl, impl, refs} |
| `[d`, `]d` | prev / next diagnostic |
| `<S-F12>`, `<C-F12>`, `<C-S-F12>`, `<A-F12>`, `<S-A-F12>` | VS Code-style F12 family |

See `cheat-sheet.md` for the full reference (browse with `<leader>ch`).
