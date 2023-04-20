local set_keymap = vim.api.nvim_buf_set_keymap
local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
local lspconfig = require("lspconfig")
require("me.plugins.lsp.null-ls")

local lsp_servers =
	{ "lua_ls", "tsserver", "astro", "clangd", "marksman", "jsonls", "jdtls" }

mason.setup({})
mason_lsp.setup({
	ensure_installed = lsp_servers,
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

for _, server in pairs(lsp_servers) do
	local opts = {
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
		handlers = {
			["textDocument/definition"] = vim.lsp.with(
				vim.lsp.handlers["textDocument/definition"],
				{ reuse_win = true }
			),
		},
		on_attach = function(client, bufnr)
			local map_opts = {
				noremap = true,
				silent = true,
			}
			-- setting keymaps
			-- for more lsp functions, check out https://neovim.io/doc/user/lsp.html#lsp-buf
			set_keymap(
				bufnr,
				"n",
				"<leader>h",
				"<cmd>lua vim.lsp.buf.hover()<cr>",
				map_opts
			)
			set_keymap(
				bufnr,
				"n",
				"<leader>ca",
				"<cmd>lua vim.lsp.buf.code_action()<cr>",
				map_opts
			)
			set_keymap(
				bufnr,
				"n",
				"<leader>d",
				"<cmd>lua vim.lsp.buf.definition()<cr>",
				map_opts
			)
			set_keymap(
				bufnr,
				"n",
				"<leader>rn",
				"<cmd>lua vim.lsp.buf.rename()<cr>",
				map_opts
			)
			set_keymap(
				bufnr,
				"n",
				"<leader>f",
				"<cmd>lua vim.lsp.buf.format()<cr>",
				map_opts
			)
			-- setting up format on save
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({
							bufnr = bufnr,
							filter = function(fmt_client)
								return fmt_client.name == "null-ls"
							end,
						})
					end,
				})
			else
				vim.notify("Formatting not available!")
			end
		end,
	}
	-- check to see if server has some custom options set in the "settings folder".
	local has_custom_opts, custom_opts =
		pcall(require, "me.plugins.lsp.settings." .. server)
	if has_custom_opts then
		-- merging options.
		opts = vim.tbl_deep_extend("force", opts, custom_opts)
	end
	lspconfig[server].setup(opts)
end
