local cmp = require("cmp")

local M = {}

M.mason = {
	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",
		-- web dev stuff
		"angular-ls",
		"astro",
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"deno",
		"prettier",
		"tailwindcss",
		-- c/cpp stuff
		"clangd",
		"clang-format",
		-- shell stuff
		"shfmt",
	},
}

M.telescope = {
	defaults = {
		file_ignore_patterns = {
			"%.git",
			"node_modules",
			"^dist/",
			"build",
			"temp",
		},
	},
}

return M
