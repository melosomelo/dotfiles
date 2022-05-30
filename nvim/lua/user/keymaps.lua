local keymap = vim.keymap

local opts = { silent = true, remap = false }

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- window navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Tab navigation
keymap.set("n", "<S-h>", "gT", opts) -- previous tab
keymap.set("n", "<S-l>", "gt", opts) -- next tab

-- Remap CTRL + U and CTRL + D to Shift+K and Shift+J, respectively
keymap.set("n", "<S-j>", "<C-d>", opts)
keymap.set("n", "<S-k>", "<C-u>", opts)
