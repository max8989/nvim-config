local utils = require("utils")

-- Python provider: prefer our dedicated pynvim venv (created by
-- docs/nvim_post_install_{mac,arch}.sh), fall back to upstream's
-- .venv under the config dir.
local py3_host = vim.fn.expand("~/.local/venv/nvim/bin/python3")
local config_venv_py3 = vim.fs.joinpath(vim.fn.stdpath("config"), ".venv/bin/python3")
if vim.fn.executable(py3_host) == 1 then
  vim.g.python3_host_prog = py3_host
elseif vim.uv.fs_stat(config_venv_py3) then
  vim.g.python3_host_prog = config_venv_py3
else
  local msg = "Python provider missing:\n  create a virtual env under nvim config and install pynvim!"
  vim.api.nvim_echo({ { msg } }, true, { err = true })
end

------------------------------------------------------------------------
--                          custom variables                          --
------------------------------------------------------------------------
vim.g.is_win = (utils.has("win32") or utils.has("win64")) and true or false
vim.g.is_linux = (utils.has("unix") and (not utils.has("macunix"))) and true or false
vim.g.is_mac = utils.has("macunix") and true or false

vim.g.logging_level = vim.log.levels.INFO

------------------------------------------------------------------------
--                         builtin variables                          --
------------------------------------------------------------------------
vim.g.loaded_perl_provider = 0 -- Disable perl provider
vim.g.loaded_ruby_provider = 0 -- Disable ruby provider
vim.g.loaded_node_provider = 0 -- Disable node provider
vim.g.did_install_default_menus = 1 -- do not load menu

-- Custom mapping <leader> (see `:h mapleader` for more info)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Enable highlighting for lua HERE doc inside vim script
vim.g.vimsyn_embed = "l"

-- Use English as main language
vim.cmd([[language en_US.UTF-8]])

-- Disable loading certain plugins

-- Whether to load netrw by default, see https://github.com/bling/dotvim/issues/4
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_liststyle = 3
if vim.g.is_win then
  vim.g.netrw_http_cmd = "curl --ssl-no-revoke -Lo"
end

-- Do not load tohtml.vim
vim.g.loaded_2html_plugin = 1

-- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are
-- related to checking files inside compressed files)
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1

-- Do not load the tutor plugin
vim.g.loaded_tutor_mode_plugin = 1

-- Do not use builtin matchit.vim and matchparen.vim since we use vim-matchup
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1

-- Disable sql omni completion, it is broken.
vim.g.loaded_sql_completion = 1

-- control how to show health check window
vim.g.health = { style = nil }
