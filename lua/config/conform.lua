local conform = require("conform")

-- Pick formatter for JS/TS/JSON families: oxfmt when the project has an oxfmt
-- config (e.g. squid-frontend), otherwise prettierd/prettier.
local function js_fmt(bufnr)
  local has_oxfmt = vim.fs.find({
    ".oxfmtrc.jsonc",
    ".oxfmtrc.json",
    ".oxfmtrc",
    "oxfmt.config.js",
    "oxfmt.config.mjs",
  }, {
    upward = true,
    path = vim.api.nvim_buf_get_name(bufnr),
    stop = vim.fn.expand("$HOME"),
  })[1]

  if has_oxfmt and vim.fn.executable("oxfmt") == 1 then
    return { "oxfmt" }
  end
  return { "prettierd", "prettier", stop_after_first = true }
end

local prettier = { "prettierd", "prettier", stop_after_first = true }

conform.setup {
  formatters_by_ft = {
    javascript = js_fmt,
    javascriptreact = js_fmt,
    typescript = js_fmt,
    typescriptreact = js_fmt,
    json = js_fmt,
    jsonc = js_fmt,
    css = prettier,
    scss = prettier,
    less = prettier,
    html = prettier,
    markdown = prettier,
    yaml = prettier,
    graphql = prettier,
    vue = prettier,
  },

  -- oxfmt is not yet in conform's built-in registry, so define it here.
  formatters = {
    oxfmt = {
      command = "oxfmt",
      args = { "--stdin-filepath", "$FILENAME" },
      stdin = true,
    },
  },
}

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  conform.format { async = true, lsp_format = "fallback", range = range }
end, { range = true, desc = "Format buffer or range" })

vim.keymap.set({ "n", "v" }, "<leader>F", function()
  conform.format { async = true, lsp_format = "fallback" }
end, { desc = "Format buffer / selection" })
