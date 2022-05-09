-- Automatically update packer after editing plugins.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
-- Configuration for Dracula Pro
vim.cmd[[
  packadd! dracula_pro
  syntax enable
  let g:dracula_colorterm = 0
  let g:dracula_bold = 1
  let g:dracula_italic = 1
  colorscheme dracula_pro
]]
return require('packer').startup(function()
  -- Lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  require("lualine").setup{
    options = {
      theme = "dracula"
    }
  }

end)
