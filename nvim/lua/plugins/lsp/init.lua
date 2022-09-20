-- require("plugins.lsp.null-ls")
local handlers = require "plugins.lsp.handlers"

-- handlers definitions
vim.lsp.handlers["textDocument/definition"] = handlers.goto_definition

local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")

lsp_installer.setup({
  ensure_installed = { "tsserver", "sumneko_lua" },
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})

local opts = {
	noremap = true,
	silent = true,
}

-- for each installed server, check if it has custom options
-- and merge them with default opts
local installed_servers = lsp_installer.get_installed_servers()
for _, server in pairs(installed_servers) do
	local lsp_opts = {
		capabilities = require("cmp_nvim_lsp").
      update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function(client, bufnr)
			-- some mappings for lsp features
      -- for more methods, check out: https://neovim.io/doc/user/lsp.html#lsp-buf
			vim.api.nvim_buf_set_keymap(bufnr, "n",
        "<leader>d", "<cmd>lua vim.lsp.buf.definition()<CR>", opts) -- go to definition
			vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>h",
        "<cmd>lua vim.lsp.buf.hover()<CR>", opts) -- hover (show info)
			vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D",
        "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
			vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn",
        "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
			-- Some functionalities that I'll probably use in the future
			-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
			-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
			-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
		end,
	}
	local has_custom_opts, server_custom_opts = pcall(require,
    "plugins.lsp.settings." .. server.name)
	if has_custom_opts then
		lsp_opts = vim.tbl_deep_extend("force", server_custom_opts, lsp_opts)
	end
	lspconfig[server.name].setup(lsp_opts)
end
