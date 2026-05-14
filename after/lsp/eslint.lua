-- vscode-eslint-language-server expects a set of initializationOptions
-- (workspaceFolder, workingDirectory, etc.) that the VS Code extension fills in
-- automatically. Without them — and with ESLint 9 defaulting to flat config —
-- the server reports:
--   eslint: -32603: Request textDocument/diagnostic failed with message:
--   Could not find config file.
-- even for files that sit next to a valid .eslintrc.json.

local config_markers = {
  ".eslintrc",
  ".eslintrc.js",
  ".eslintrc.cjs",
  ".eslintrc.yaml",
  ".eslintrc.yml",
  ".eslintrc.json",
  "eslint.config.js",
  "eslint.config.mjs",
  "eslint.config.cjs",
  "eslint.config.ts",
  "eslint.config.mts",
  "eslint.config.cts",
}

local flat_markers = {
  "eslint.config.js",
  "eslint.config.mjs",
  "eslint.config.cjs",
  "eslint.config.ts",
  "eslint.config.mts",
  "eslint.config.cts",
}

local function has_flat_config(root)
  for _, m in ipairs(flat_markers) do
    if vim.uv.fs_stat(root .. "/" .. m) then
      return true
    end
  end
  return false
end

---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    if fname:find("/node_modules/", 1, true) then
      return
    end

    local root = vim.fs.root(bufnr, config_markers) or vim.fs.root(bufnr, { "package.json" })
    if root then
      on_dir(root)
    end
  end,
  settings = {
    validate = "on",
    packageManager = nil,
    useESLintClass = false,
    experimental = { useFlatConfig = false },
    useFlatConfig = false,
    codeActionOnSave = { enable = false, mode = "all" },
    format = true,
    quiet = false,
    onIgnoredFiles = "off",
    rulesCustomizations = {},
    run = "onType",
    problems = { shortenToSingleLine = false },
    nodePath = "",
    workingDirectory = { mode = "location" },
    codeAction = {
      disableRuleComment = { enable = true, location = "separateLine" },
      showDocumentation = { enable = true },
    },
  },
  before_init = function(params, config)
    local root = params.rootPath or (params.rootUri and vim.uri_to_fname(params.rootUri))
    if not root then
      return
    end

    config.settings = config.settings or {}
    config.settings.workspaceFolder = {
      uri = vim.uri_from_fname(root),
      name = vim.fn.fnamemodify(root, ":t"),
    }

    local flat = has_flat_config(root)
    config.settings.experimental = { useFlatConfig = flat }
    config.settings.useFlatConfig = flat
  end,
}
