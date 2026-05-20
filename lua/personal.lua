-- ─── personal layer ──────────────────────────────────────────────────────
-- All custom keymaps + extra LSP enables live here. To restore pristine
-- jdhao behavior, comment out `require("personal")` at the bottom of init.lua.

local map = vim.keymap.set

-- ─── window navigation ───────────────────────────────────────────────────
-- <C-h/j/k/l> are owned by vim-tmux-navigator (see plugin_specs.lua) so the
-- same keys move between nvim splits and tmux panes seamlessly.

-- ─── buffer navigation (uses bufferline, loaded on BufEnter) ────────────
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { silent = true, desc = "prev buffer" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { silent = true, desc = "next buffer" })

-- ─── smart buffer delete (preserves window layout) ──────────────────────
map("n", "<leader>bd", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local windows = vim.fn.getbufinfo(bufnr)[1].windows

  if #windows > 1 then
    vim.cmd("bprevious")
  else
    local buffers = vim.tbl_filter(function(b)
      return vim.bo[b].buflisted
    end, vim.api.nvim_list_bufs())

    if #buffers == 1 then
      vim.cmd("enew")
    else
      vim.cmd("bprevious")
    end
  end

  vim.cmd("bdelete! " .. bufnr)
end, { silent = true, desc = "delete buffer" })

-- ─── telescope shortcuts (telescope is lazy on `cmd = "Telescope"`) ─────
map("n", "<leader>cs", "<cmd>Telescope colorscheme enable_preview=true<cr>", { desc = "change colorscheme" })
map("n", "<leader>ch", function()
  vim.cmd("Lazy load telescope.nvim")
  require("personal_cheatsheet").run()
end, { desc = "cheatsheet picker" })

-- ─── LSP navigation (buffer-local on LspAttach) ─────────────────────────
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("personal_lsp_keymaps", { clear = true }),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    map("n", "<F12>", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "go to definition" }))
    map("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "go to declaration" }))
    map("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "go to implementation" }))
    map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "find references" }))
    map("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "prev diagnostic" }))
    map("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "next diagnostic" }))
    -- VS Code-style F12 family
    map("n", "<S-F12>", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "find references" }))
    map("n", "<C-F12>", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "go to implementation" }))
    map("n", "<C-S-F12>", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "go to declaration" }))
    map("n", "<A-F12>", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "peek definition" }))
    map("n", "<S-A-F12>", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "find all references" }))
  end,
})

-- ─── extra LSP enables (servers jdhao's lsp_conf doesn't list) ──────────
-- jdhao's enable loop in lsp_conf.lua handles: pyright (delance-langserver),
-- ruff, lua_ls, vimls, bashls, yamlls, gopls, golangci_lint_ls.
-- Below we add anything else we want, gated on system executable presence.
-- Note: TypeScript is handled by vtsls in lsp_conf.lua. Do not enable ts_ls
-- here too — lspconfig docs warn against running both.
local extra_servers = {
  eslint = "vscode-eslint-language-server",
}
for server, exe in pairs(extra_servers) do
  if vim.fn.executable(exe) == 1 then
    vim.lsp.enable(server)
  end
end

-- Arch ships pyright as `pyright-langserver`, not jdhao's `delance-langserver`.
-- If delance is missing but plain pyright is present, enable it ourselves.
if vim.fn.executable("delance-langserver") == 0
   and vim.fn.executable("pyright-langserver") == 1 then
  vim.lsp.enable("pyright")
end
