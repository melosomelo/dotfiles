local lsp_installer = require "nvim-lsp-installer"
local lspconfig = require "lspconfig"

lsp_installer.setup {} -- add more configuration later

-- for each installed server, check if it has custom options
-- and merge them with default opts
local installed_servers = lsp_installer.get_installed_servers()
for _, server in pairs(installed_servers) do
  local opts = {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings" .. server.name)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end
  lspconfig[server.name].setup(opts)
end

