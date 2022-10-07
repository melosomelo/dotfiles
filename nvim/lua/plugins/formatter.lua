require("formatter").setup({
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		c = {
			require("formatter.filetypes.c").clangformat,
		},
		cpp = {
			require("formatter.filetypes.cpp").clangformat,
		},
		javascript = {
			require("formatter.filetypes.javascript").prettier,
		},
		javascriptreact = {
			require("formatter.filetypes.javascriptreact").prettier,
		},
		typescript = {
			require("formatter.filetypes.typescript").prettier,
		},
		typescriptreact = {
			require("formatter.filetypes.typescriptreact").prettier,
		},
		html = {
			require("formatter.filetypes.html").prettier,
		},
		css = {
			require("formatter.filetypes.css").prettier,
		},
		markdown = {
			require("formatter.filetypes.markdown").prettier,
		},
	},
})
