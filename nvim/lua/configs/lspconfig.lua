require("nvchad.configs.lspconfig").defaults()

local servers = {
	"html",
	"cssls",
	"clangd",
	"lua-language-server",
	"stylua",
	"ts_ls",
	"astro-language-server",
	"tailwindcss-language-server",
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
