local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- configuring dracula pro
vim.cmd [[
  packadd! dracula_pro
  syntax enable
  let g:dracula_colorterm = 0
  colorscheme dracula_pro
]]

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float {
        border = "rounded"
      }
    end
  }
}

return packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Utility functions
  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true
    }
  }
  use 'hrsh7th/cmp-nvim-lsp' -- for autocompletion coming from lsp servers
  use 'hrsh7th/cmp-buffer' -- for autocompletion coming from the buffer
  use 'hrsh7th/cmp-path' -- for autocompletion comming from system path
  use 'hrsh7th/cmp-cmdline' -- for autocompletion for the command line
  use 'hrsh7th/nvim-cmp' -- the plugin that actually does the autocompletion
  -- snippet engine
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
end)
