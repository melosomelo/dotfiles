-- script to automatically install packer
-- whenever on a new computer
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			install_path,
		})
		vim.cmd([[packadd packer.nvim]])
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
		enable = true,
	},
})

return packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	-- Utility functions
	use("nvim-lua/plenary.nvim")
	-- Cool icons
	use("kyazdani42/nvim-web-devicons")
	-- Treesitter for better syntax highlighting
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	-- LSP stuff
	-- manager of external tooling such as LSP servers, linters, formatters, etc.
	use("williamboman/mason.nvim")
	-- Basically a compatiblity later between mason and lspconfig
	use("williamboman/mason-lspconfig.nvim")
	-- Official plugin from the Neovim team to provide base configuration
	-- and utilities for multiple LSP servers.
	use("neovim/nvim-lspconfig")
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})
	-- Autocompletion stuff
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion coming from lsp servers
	use("hrsh7th/cmp-buffer") -- for autocompletion coming from the buffer
	use("hrsh7th/cmp-path") -- for autocompletion comming from system path
	use("hrsh7th/cmp-cmdline") -- for autocompletion for the command line
	use("hrsh7th/nvim-cmp") -- the plugin that actually does the autocompletion
	use("L3MON4D3/LuaSnip") -- The snippet engine
	use("saadparwaiz1/cmp_luasnip") -- Integration between the snippet engine and the cmp lib
	use("rafamadriz/friendly-snippets")

	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
			opt = true,
		},
	})
	use({ "nvim-telescope/telescope.nvim" })
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use({ "lewis6991/gitsigns.nvim" })
	use({
		"kyazdani42/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	use({ "alvarosevilla95/luatab.nvim", requires = "kyazdani42/nvim-web-devicons" })
	use({
		"akinsho/toggleterm.nvim",
	})
	use("lukas-reineke/indent-blankline.nvim")
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})

	-- colorschemes I like switching between
	use({ "ellisonleao/gruvbox.nvim" })
	use("folke/tokyonight.nvim")
	use({ "catppuccin/nvim", as = "catppuccin" })
	use("rebelot/kanagawa.nvim")

	-- extensions for the java eclipse language server
	use("mfussenegger/nvim-jdtls")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
