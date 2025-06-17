local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		javascriptreact = { "prettier" },
		markdown = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
}

return options
