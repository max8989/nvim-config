local M = {}

function M.run()
  local cheat_file = vim.fn.stdpath("config") .. "/cheat-sheet.md"
  local lines = vim.fn.readfile(cheat_file)
  local cheatsheet_data = {}

  local current_section = ""
  for _, line in ipairs(lines) do
    if line:match("^|%s*Section") then
      -- skip header
    elseif line:match("^|%-") then
      -- skip separator
    elseif line:match("^|") then
      local section, keybinding, description = line:match("^|%s*(.-)%s*|%s*`?(.-)`?%s*|%s*(.-)%s*|")
      if section and keybinding and description then
        if section ~= current_section and current_section ~= "" then
          table.insert(cheatsheet_data, { "", "", "", "separator" })
        end
        current_section = section
        if keybinding ~= "" then
          table.insert(cheatsheet_data, { section, description, keybinding, "key" })
        end
      end
    end
  end

  vim.api.nvim_set_hl(0, "TelescopeCheatSection", { fg = "#89b4fa", bold = true })
  vim.api.nvim_set_hl(0, "TelescopeCheatKey", { fg = "#f38ba8", bold = true })
  vim.api.nvim_set_hl(0, "TelescopeCheatDesc", { fg = "#a6e3a1" })
  vim.api.nvim_set_hl(0, "TelescopeCheatSep", { fg = "#585b70" })

  require("telescope.pickers").new({}, {
    prompt_title = "🔍 Keybinding Cheat Sheet",
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.75,
      height = 0.90,
      preview_cutoff = 1,
      prompt_position = "bottom",
    },
    finder = require("telescope.finders").new_table({
      results = cheatsheet_data,
      entry_maker = function(entry)
        local section, desc, key, type = entry[1], entry[2], entry[3], entry[4]
        if type == "separator" then
          return {
            value = entry,
            display = string.rep("─", 70),
            ordinal = "",
          }
        else
          local formatted_key = key ~= "" and string.format("[%s]", key) or ""
          local display = string.format("%-20s  %-45s %s", section, desc, formatted_key)
          return {
            value = entry,
            display = display,
            ordinal = section .. " " .. desc .. " " .. key,
          }
        end
      end,
    }),
    sorter = require("telescope.config").values.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, _)
      require("telescope.actions").select_default:replace(function()
        local selection = require("telescope.actions.state").get_selected_entry()
        require("telescope.actions").close(prompt_bufnr)
        if selection.value[3] ~= "" then
          vim.fn.setreg('"', selection.value[3])
          vim.fn.setreg("+", selection.value[3])
          print("Copied: " .. selection.value[3])
        end
      end)
      return true
    end,
  }):find()
end

return M
