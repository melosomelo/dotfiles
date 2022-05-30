local lsp_installer = require "nvim-lsp-installer"
local lspconfig = require "lspconfig"

lsp_installer.setup {} -- add more configuration later

local installed_servers = lsp_installer.get_installed_servers()
for _, server in pairs(installed_servers) do
  local opts = {}
  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings" .. server.name)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end
  lspconfig[server.name].setup(opts)
end

