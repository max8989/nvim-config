# IDE Vim configs

Ports the portable keybindings from this nvim-config (`lua/mappings.lua`) to the
Vim emulation plugins in Rider/JetBrains and VS Code.

Leader = `<space>`, local-leader = `\`.

## Rider / JetBrains — IdeaVim

1. Install the **IdeaVim** plugin (`Settings | Plugins`).
2. Link the config:
   ```sh
   ln -sf ~/repos/nvim-config/ide/.ideavimrc ~/.ideavimrc
   ```
3. Some emulated plugins need a companion IDE plugin:
   - `easymotion` → install **IdeaVim-EasyMotion** + **AceJump**.
   - `which-key` (optional) → install **IdeaVim-Quickscope**/which-key plugin and `set which-key`.
4. Resolve shortcut conflicts: `Settings | Editor | Vim` and `Settings | Keymap`.
5. Find IDE action ids: `:actionlist <pattern>` or the **IdeaVim: track action IDs**
   command (double-Shift). Tweak the `<Action>(...)` lines if an id differs in your Rider build.

## VS Code — VSCodeVim

1. Install the **Vim** extension (`vscodevim.vim`).
2. Open user settings JSON: `Cmd+Shift+P` → *Preferences: Open User Settings (JSON)*.
3. Merge the contents of [`vscode-vim-settings.json`](./vscode-vim-settings.json)
   into your `settings.json` (combine the `vim.*` keys; don't paste a second top-level object).
4. Find command ids in the **Keyboard Shortcuts** UI (gear → *Copy Command ID*).

## What does NOT port

These are nvim/plugin-specific and have no clean emulation equivalent — handle them
with native IDE features instead:

- LSP / fzf-lua / telescope / gitsigns / diffview / toggleterm mappings → use IDE-native
  navigation, search, Git, and terminal.
- Custom text objects `iu` (URL), and Vim undo-break-points on punctuation.
- `<leader>cd` change-cwd, `<leader>cb`/`<leader>cl` cursor blink/column, `F11` spell toggle.
- Obsidian (`<leader>o*`) — nvim plugin only.
- `<Esc>` close-floating-window and `ZR` restart — editor-specific.
