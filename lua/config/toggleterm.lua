require("toggleterm").setup {
  size = 70,
  open_mapping = [[<C-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "vertical",
  close_on_exit = true,
  auto_scroll = true,
  on_exit = function()
    vim.cmd("checktime")
  end,
  shell = vim.fn.has("win32") == 1 and "powershell" or vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

local map = vim.keymap.set

-- fullscreen float
map("n", "<C-`>", function()
  vim.cmd("ToggleTerm direction=float size=100")
end, { desc = "Toggle fullscreen terminal" })

-- multiple terminal instances (1-3 vertical, 4-6 horizontal)
for i = 1, 3 do
  map("n", "<leader>t" .. i, function()
    vim.cmd(i .. "ToggleTerm direction=vertical size=70")
  end, { desc = "Toggle terminal " .. i })
end
for i = 4, 6 do
  map("n", "<leader>t" .. i, function()
    vim.cmd(i .. "ToggleTerm direction=horizontal size=20")
  end, { desc = "Toggle terminal " .. i })
end

-- different layouts
map("n", "<leader>th", function() vim.cmd("ToggleTerm direction=horizontal size=20") end, { desc = "Toggle horizontal terminal" })
map("n", "<leader>tv", function() vim.cmd("ToggleTerm direction=vertical size=70") end, { desc = "Toggle vertical terminal" })
map("n", "<leader>tf", function() vim.cmd("ToggleTerm direction=float") end, { desc = "Toggle floating terminal" })
map("n", "<leader>tt", function() vim.cmd("ToggleTerm direction=tab") end, { desc = "Toggle terminal in new tab" })

-- resize
map("n", "<leader>tr+", function()
  vim.cmd("ToggleTerm size=" .. vim.fn.winheight(0) + 5)
end, { desc = "Increase terminal height" })
map("n", "<leader>tr-", function()
  vim.cmd("ToggleTerm size=" .. math.max(5, vim.fn.winheight(0) - 5))
end, { desc = "Decrease terminal height" })

-- quick REPLs
map("n", "<leader>tg", function() vim.cmd('TermExec cmd="lazygit" direction=float') end, { desc = "Open LazyGit in terminal" })
map("n", "<leader>tp", function() vim.cmd('TermExec cmd="python3" direction=horizontal') end, { desc = "Open Python REPL" })
map("n", "<leader>tn", function() vim.cmd('TermExec cmd="node" direction=horizontal') end, { desc = "Open Node.js REPL" })

-- Hunk (review-first terminal diff viewer, https://hunk.dev) — same <leader>l
-- group as lazygit (lg) / lazydocker (ld).
map("n", "<leader>lh", function() vim.cmd('7TermExec cmd="hunk diff" direction=float') end, { desc = "Open Hunk diff review" })

-- kill all terminals (fixed: original used `TermClose!` which isn't a real command)
map("n", "<leader>tk", function()
  for _, term in pairs(require("toggleterm.terminal").get_all()) do
    term:shutdown()
  end
end, { desc = "Kill all terminals" })

-- terminal-mode navigation (set per-buffer when a terminal opens)
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  map("t", "<C-Esc>", [[<C-\><C-n>]], opts)
  map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  map("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- (original config had a `VimLeavePre` calling `TermClose!` which crashed nvim
--  on exit — removed; nvim cleans up terminals on exit anyway.)
