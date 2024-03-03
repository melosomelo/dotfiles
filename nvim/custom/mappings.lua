---@type MappingsTable
local M = {}

local opts = {
  silent = true,
  remap = false
}

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

M.general = {
  n = {
    [";"] = {
      ":",
      "enter command mode",
      opts = {
        nowait = true
      }
    },
    ["<A-j>"] = {"ddp", "Move current line down", opts},
    ["<A-k>"] = {"ddkP", "Move current line up", opts},
    -- better window navigation
    ["<C-h>"] = {"<C-w>h", "", opts},
    ["<C-j>"] = {"<C-w>j", "", opts},
    ["<C-k>"] = {"<C-w>k", "", opts},
    ["<C-l>"] = {"<C-w>l", "", opts},
    -- better tag navigation
    ["<S-h>"] = {"gT", "Go to previous tab", opts},
    ["<S-l>"] = {"gt", "Go to next tab", opts},
    -- Remap CTRL + U and CTRL + D to Shift+K and Shift+J, respectively
    ["<S-j>"] = {"<C-d>zz", "", opts},
    ["<S-k>"] = {"<C-u>zz", "", opts},
    ["<C-u>"] = {"<nop>", "", opts},
    -- Nvimtree
    ["<C-d>"] = {"<cmd>NvimTreeToggle<CR>", "Toggle NvimTree", opts},
    -- Telescope
    ["<C-p>"] = {"<cmd>lua require('telescope.builtin').find_files({hidden = true, no_ignore=true})<cr>",
                 "Open Telescope file picker", opts},
    ["<C-S-p>"] = {"<cmd>lua require('telescope.builtin').live_grep()<cr>", "Open Telescope live grep", opts},
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
