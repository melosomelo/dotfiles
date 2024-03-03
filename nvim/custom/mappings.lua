---@type MappingsTable
local M = {}

local opts = {
  silent = true,
  remap = false
}

M.general = {
  n = {
    [";"] = {
      ":",
      "enter command mode",
      opts = {
        nowait = true
      }
    },
    -- better window navigation
    ["<C-h>"] = {"<C-w>h", "", opts},
    ["<C-j>"] = {"<C-w>j", "", opts},
    ["<C-k>"] = {"<C-w>k", "", opts},
    ["<C-l>"] = {"<C-w>l", "", opts},
    -- Remap CTRL + U and CTRL + D to Shift+K and Shift+J, respectively
    ["<S-j>"] = {"<C-d>zz", "", opts},
    ["<S-k>"] = {"<C-u>zz", "", opts},
    ["<C-d>"] = {"<nop>", "", opts},
    ["<C-u>"] = {"<nop>", "", opts},
    --  format with conform
    ["<leader>fm"] = {function()
      require("conform").format()
    end, "formatting"}
  },
  v = {
    [">"] = {">gv", "indent"}
  }
}

-- more keybinds!

return M
