-- script to automatically install packer
-- whenever on a new computer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end


packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({
				border = "rounded",
			})
		end,
	},
  profile = {
    enable = true
  }
})

return packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	-- Utility functions
	use("nvim-lua/plenary.nvim")
	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
			opt = true,
		},
	})
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion coming from lsp servers
	use("hrsh7th/cmp-buffer") -- for autocompletion coming from the buffer
	use("hrsh7th/cmp-path") -- for autocompletion comming from system path
	use("hrsh7th/cmp-cmdline") -- for autocompletion for the command line
	use("hrsh7th/nvim-cmp") -- the plugin that actually does the autocompletion
	-- snippet engine
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	-- use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	-- Telescope
	use({ "nvim-telescope/telescope.nvim" })
	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	-- autopairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	-- gitsigns
	use({ "lewis6991/gitsigns.nvim" })
	-- nvim-tree
	use({
		"kyazdani42/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	-- bufferline
	use({
		"akinsho/bufferline.nvim",
		tag = "v2.*",
		requires = "kyazdani42/nvim-web-devicons",
	})
	-- termtoggle
	use({
		"akinsho/toggleterm.nvim",
		tag = "v1.*",
	})
	-- alpha
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})

  use { "catppuccin/nvim", as = "catppuccin" }




  if packer_bootstrap then
    require("packer").sync()
  end

end)
