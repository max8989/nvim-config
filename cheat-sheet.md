# Neovim Keybindings Cheat Sheet

Leader key: `<Space>`

| Section | Keybinding | Description |
|---------|------------|-------------|
| Buffer Management | `<S-h>` | Previous buffer |
| Buffer Management | `<S-l>` | Next buffer |
| Buffer Management | `<leader>bd` | Delete current buffer |
| Buffer Management | `<leader>bp` | Pin/unpin buffer |
| Buffer Management | `<leader>bP` | Pick buffer to jump to |
| Buffer Management | `<leader>bc` | Pick buffer to close |
| Buffer Management | `<leader>bh` | Close buffers to the left |
| Buffer Management | `<leader>bl` | Close buffers to the right |
| File Navigation & Search | `<C-p>` | Find files |
| File Navigation & Search | `<leader>fg` | Live grep (search text) |
| File Navigation & Search | `<leader><leader>` | Recent files |
| File Navigation & Search | `<leader>bb` | Open buffers |
| File Explorer (Neo-tree) | `<C-n>` | Toggle file tree |
| Neo-tree Navigation | `<CR>` | Open file/directory |
| Neo-tree Navigation | `<Space>` | Toggle node expansion |
| Neo-tree Navigation | `<BS>` | Navigate up to parent directory |
| Neo-tree Navigation | `.` | Set as root directory |
| Neo-tree Navigation | `H` | Toggle hidden files |
| Neo-tree Navigation | `<` / `>` | Previous/next source |
| Neo-tree File Operations | `a` | Add new file |
| Neo-tree File Operations | `A` | Add new directory |
| Neo-tree File Operations | `d` | Delete file/directory |
| Neo-tree File Operations | `r` | Rename file |
| Neo-tree File Operations | `c` | Copy (with destination) |
| Neo-tree File Operations | `m` | Move (with destination) |
| Neo-tree File Operations | `y` | Copy to clipboard |
| Neo-tree File Operations | `x` | Cut to clipboard |
| Neo-tree File Operations | `p` | Paste from clipboard |
| Neo-tree View Controls | `S` | Open in horizontal split |
| Neo-tree View Controls | `s` | Open in vertical split |
| Neo-tree View Controls | `t` | Open in new tab |
| Neo-tree View Controls | `P` | Toggle preview |
| Neo-tree View Controls | `C` | Close node |
| Neo-tree View Controls | `R` | Refresh tree |
| Neo-tree View Controls | `q` | Close Neo-tree window |
| Neo-tree Recursive Operations | `E` | Recursively expand current folder and all subfolders |
| Neo-tree Recursive Operations | `zO` | Recursively expand current folder and all subfolders |
| Neo-tree Recursive Operations | `zC` | Recursively close current folder and all subfolders |
| Neo-tree Recursive Operations | `zR` | Expand ALL folders in entire tree |
| Neo-tree Recursive Operations | `zM` | Close all folders in tree |
| Neo-tree Recursive Operations | `zo` | Toggle current folder open/close |
| Neo-tree Recursive Operations | `za` | Toggle current folder open/close |
| Neo-tree Recursive Operations | `zc` | Close current folder |
| Neo-tree Search | `/` | Fuzzy find |
| Neo-tree Search | `D` | Fuzzy find directories |
| Neo-tree Search | `#` | Fuzzy sort |
| Neo-tree Help | `?` | Show keyboard help |
| Window Navigation | `<C-w>h` | Move to left window |
| Window Navigation | `<C-w>l` | Move to right window |
| Viewport Scrolling | `<C-d>` | Scroll down half a page |
| Viewport Scrolling | `<C-u>` | Scroll up half a page |
| Viewport Scrolling | `<C-f>` | Scroll down a full page |
| Viewport Scrolling | `<C-b>` | Scroll up a full page |
| Viewport Scrolling | `<C-e>` | Scroll down one line (cursor stays) |
| Viewport Scrolling | `<C-y>` | Scroll up one line (cursor stays) |
| Viewport Scrolling | `zz` | Center current line on screen |
| Viewport Scrolling | `zt` | Move current line to top of screen |
| Viewport Scrolling | `zb` | Move current line to bottom of screen |
| Terminal | `<C-\>` | Toggle horizontal terminal |
| Terminal | `<C-`>` | Toggle fullscreen floating terminal |
| Terminal | `<leader>t1` | Toggle terminal 1 |
| Terminal | `<leader>t2` | Toggle terminal 2 |
| Terminal | `<leader>t3` | Toggle terminal 3 |
| Terminal | `<leader>th` | Toggle horizontal terminal |
| Terminal | `<leader>tv` | Toggle vertical terminal |
| Terminal | `<leader>tf` | Toggle floating terminal |
| Terminal | `<leader>tt` | Toggle terminal in new tab |
| Terminal | `<leader>tr+` | Increase terminal height |
| Terminal | `<leader>tr-` | Decrease terminal height |
| Terminal | `<leader>tp` | Open Python REPL |
| Terminal | `<leader>tn` | Open Node.js REPL |
| Terminal | `<leader>tk` | Kill all terminals |
| Terminal (in terminal mode) | `<Esc>` | Exit terminal mode |
| Terminal (in terminal mode) | `<C-h>` | Navigate to left window |
| Terminal (in terminal mode) | `<C-j>` | Navigate to down window |
| Terminal (in terminal mode) | `<C-l>` | Navigate to right window |
| Terminal (in terminal mode) | `<C-w>` | Window commands |
| LSP | `K` | Show hover documentation |
| LSP | `<F12>` | Go to definition |
| LSP | `gd` | Go to definition (alternative) |
| LSP | `gD` | Go to declaration |
| LSP | `gi` | Go to implementation |
| LSP | `gr` | Find references |
| LSP | `<S-F12>` | Find all references |
| LSP | `<F2>` | Rename symbol |
| LSP | `<C-.>` | Code actions |
| LSP | `<leader>ca` | Code actions (alternative) |
| LSP | `<C-k>` | Signature help |
| LSP | `<leader>D` | Type definition |
| LSP | `<leader>rn` | Rename symbol (alternative) |
| LSP | `<leader>e` | Show line diagnostics |
| LSP | `[d` | Previous diagnostic |
| LSP | `]d` | Next diagnostic |
| LSP | `<leader>q` | Diagnostic quickfix |
| LSP | `<leader>f` | Format code |
| LSP | `<C-F12>` | Go to implementation |
| LSP | `<C-S-F12>` | Go to declaration (VS Code style) |
| LSP | `<A-F12>` | Peek definition |
| LSP | `<C-Space>` | Trigger completion |
| LSP | `<C-S-Space>` | Trigger parameter hints |
| LSP | `<A-Enter>` | Quick fix/code actions |
| LSP | `<S-A-F12>` | Find all references (VS Code style) |
| Debugging | `<F5>` | Start/Continue debugging |
| Debugging | `<F9>` | Toggle breakpoint |
| Debugging | `<F10>` | Step over |
| Debugging | `<F11>` | Step into |
| Debugging | `<F8>` | Step out |
| Debugging | `<F6>` | Debug nearest test |
| Debugging | `<C-F5>` | Restart debugging |
| Debugging | `<S-F5>` | Stop debugging |
| Debugging | `<leader>dt` | Debug nearest test (alternative) |
| Debugging | `<leader>dc` | Start/Continue debugging (alternative) |
| Debugging | `<leader>dx` | Terminate debugger (alternative) |
| Debugging | `<leader>do` | Step over (alternative) |
| Debugging | `<leader>di` | Step into (alternative) |
| Debugging | `<leader>dr` | Toggle REPL |
| Debugging | `<leader>db` | Toggle breakpoint |
| Debugging | `<leader>dB` | Conditional breakpoint |
| Debugging | `<leader>dl` | Run last debug session |
| Debugging | `<leader>du` | Toggle DAP UI |
| Debugging | `<leader>dw` | Add word under cursor to Watches |
| Debugging | `Q` | DAP Peek (eval under cursor) |
| Debugging Build (.NET) | `:compiler dotnet` | Set dotnet as compiler |
| Debugging Build (.NET) | `:make` | Build project (after setting compiler) |
| Debugging Build (Rust) | `:!cargo build` | Build Rust project (debug mode) |
| Python Debugging | `<leader>dPm` | Debug method under cursor |
| Python Debugging | `<leader>dPc` | Debug class under cursor |
| Python | `<leader>tp` | Open Python REPL |
| Markdown | `<leader>mp` | Toggle markdown preview |
| Command Line | `:` | Enhanced command mode |
| Cheat Sheet | `<leader>ch` | Open built-in cheatsheet |
| Cheat Sheet | `<leader>cs` | Open this custom cheat sheet |
| Telescope Extensions | `<C-j>` / `<C-k>` | Navigate up/down |
| Telescope Extensions | `<C-q>` | Send to quickfix |
| Telescope Extensions | `<CR>` | Select item |
| Telescope Extensions | `<C-x>` | Open in horizontal split |
| Telescope Extensions | `<C-v>` | Open in vertical split |
| Git | `<leader>lg` | Open LazyGit |
| Git | `<leader>gh` | Git file history (current file) |
| Git | `<leader>gl` | Git graph - all branches |
| Git | `<leader>gL` | Git graph - current branch only |
| Git | `<leader>gf` | Git graph - current file history |
| Git | `<leader>gv` | Git graph - recent commits (last 50) |
| Git | `]c` | Jump to next git change |
| Git | `[c` | Jump to previous git change |
| Git | `<leader>gs` | Stage hunk |
| Git | `<leader>gr` | Reset hunk |
| Git | `<leader>gS` | Stage entire buffer |
| Git | `<leader>gu` | Unstage hunk |
| Git | `<leader>gR` | Reset entire buffer |
| Git | `<leader>gp` | Preview hunk changes |
| Git | `<leader>gb` | Show blame for line |
| Git | `<leader>gB` | Toggle inline blame |
| Git | `<leader>gd` | Diff this file |
| Git | `<leader>gD` | Diff against HEAD~ |
| Git | `<leader>gt` | Toggle deleted lines |
| Git | `ig` | Select git hunk (visual/operator mode) |
| Git Graph (in graph buffer) | `<CR>` | View commit diff (press Enter) |
| Git Graph (in graph buffer) | `V` then `<CR>` | View range diff (visual select + Enter) |
| Diffview | `:DiffviewClose` | Close diffview pane |
| Diffview | `<Tab>` / `<S-Tab>` | Next/previous file in diff |
| Diffview | `<leader>e` | Focus file panel |
| Diffview | `<leader>b` | Toggle file panel |
| Diffview | `g?` | Show help |
| Quickfix | `<leader>qo` | Open quickfix list |
| Quickfix | `<leader>qc` | Close quickfix list |
| Quickfix | `:cclose` / `:ccl` | Close quickfix list (command) |
| Quickfix | `]q` | Next quickfix item |
| Quickfix | `[q` | Previous quickfix item |
