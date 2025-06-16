return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = require("configs.conform"),
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = function()
			return require("configs.nvimtree")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"vimdoc",
				"lua",
				"luadoc",
				"printf",
				"javascript",
				"typescript",
				"c",
				"cpp",
				"astro",
				"html",
				"css",
				"markdown",
				"json",
				"jsonc",
			},
			indent = { enable = true },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = function()
			return require("configs.gitsigns")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		opts = function()
			return require("configs.cmp")
		end,
	},
}
