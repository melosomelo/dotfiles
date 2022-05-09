require "user.options"
require "user.keymaps"
require "user.plugins"
-- Configuration for Dracula Pro
vim.cmd[[
  packadd! dracula_pro
  syntax enable
  let g:dracula_colorterm = 0
  let g:dracula_bold = 1
  let g:dracula_italic = 1
  colorscheme dracula_pro
]]
