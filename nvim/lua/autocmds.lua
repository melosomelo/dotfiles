require("nvchad.autocmds")

local autocmd = vim.api.nvim_create_autocmd

local default_group = vim.api.nvim_create_augroup("default_group", { clear = true })
autocmd("VimEnter", {
	desc = "Ensure certain LSP servers are installed via Mason",
	group = default_group,
	callback = function()
		local mason_registry = require("mason-registry")

		local ensure_installed = {
			"clangd",
			"lua-language-server",
			"prettier",
			"stylua",
			"typescript-language-server",
			"astro-language-server",
			"tailwindcss-language-server",
			"vue-language-server",
			"json-lsp",
			"eslint-lsp",
		}

		for _, server in ipairs(ensure_installed) do
			if not mason_registry.is_installed(server) then
				print("Server " .. server .. " is not installed. Installing it now...")
				vim.cmd("MasonInstall " .. server)
			end
		end
	end,
})
