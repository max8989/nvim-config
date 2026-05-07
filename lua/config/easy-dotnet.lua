require("easy-dotnet").setup {
  picker = "snacks", -- snacks already shipped by jdhao

  lsp = {
    enabled = true,        -- Roslyn LSP starts automatically
    preload_roslyn = true, -- preload before any buffer opens
    roslynator_enabled = true,
    auto_refresh_codelens = true,
  },

  debugger = {
    -- nvim-dap is NOT installed yet. Set to true once you wire DAP up.
    auto_register_dap = false,
  },

  test_runner = {
    auto_start_testrunner = true,
    viewmode = "float", -- "split" | "vsplit" | "float" | "buf"
  },

  auto_bootstrap_namespace = {
    type = "block_scoped", -- "block_scoped" | "file_scoped"
    enabled = true,
  },

  csproj_mappings = true, -- enable buffer-local keymaps in .csproj files
  fsproj_mappings = true,

  diagnostics = {
    default_severity = "error",
    setqflist = false,
  },
}

-- Register easy-dotnet's nuget autocomplete source for nvim-cmp.
-- Triggers inside <PackageReference Include="..." Version="..." /> in csproj/fsproj.
local ok, cmp = pcall(require, "cmp")
if ok then
  cmp.register_source("easy-dotnet", require("easy-dotnet").package_completion_source)
end
