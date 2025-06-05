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
