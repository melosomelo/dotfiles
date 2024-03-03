local util = require("me.core.util")
local keymap = vim.keymap

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

local alt_j = "∆"
local alt_k = "˚"
local alt_h = "˙"
local alt_l = "¬"

-- Config sourcing and editing
-- still need to work on reloading the config.
keymap.set("n", "<leader>ev", ":tabedit ~/.config/nvim<CR>", opts)

-- Better tab navigation
keymap.set("n", "<S-h>", "gT", opts) -- previous tab
keymap.set("n", "<S-l>", "gt", opts) -- next tab
keymap.set("n", alt_h, function() -- move current tabpage to the left
  local cur_tab_num = vim.fn.tabpagenr()
  if cur_tab_num == 1 then
    vim.cmd("$tabmove")
  else
    vim.cmd("-tabmove")
  end
end, opts)

keymap.set("n", alt_l, function() -- move current tabpage to the right
  local cur_tab_num = vim.fn.tabpagenr()
  local last_tab_num = vim.fn.tabpagenr("$")
  if cur_tab_num == last_tab_num then
    vim.cmd("0tabmove")
  else
    vim.cmd("+tabmove")
  end
end, opts)

-- Telescope mappings

-- Diagnostics keymaps
-- open the diagnostic with a floating window
keymap.set("n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- go to prev diagnostic
keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
-- go to next diagnostic
keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
-- open diagnostics list
-- keymap.set("n", "<space>dl", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
