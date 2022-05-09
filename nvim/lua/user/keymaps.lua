local keymap = vim.keymap
local default_options = { remap = false, silent = true }

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal mode mappings
  -- keymap.set("n", "<leader>sv", ":source /Users/mateusnascimento/.config/nvim/lua/user/*<cr>")  improve later
  keymap.set("n", "<leader>ev", ":vsplit /Users/mateusnascimento/.config/nvim/lua/user<cr>", default_options)

  -- Toggle netrw
  keymap.set("n", "<leader>d", ":Lexplore<cr>", default_options) 

  -- Window navigation
  keymap.set("n", "<C-h>", "<C-w>h", default_options)
  keymap.set("n", "<C-j>", "<C-w>j", default_options)
  keymap.set("n", "<C-k>", "<C-w>k", default_options)
  keymap.set("n", "<C-l>", "<C-w>l", default_options)

  -- Tab navigation
  keymap.set("n", "<S-h>", "gT", default_options) -- previous tab
  keymap.set("n", "<S-l>", "gt", default_options) -- next tab


