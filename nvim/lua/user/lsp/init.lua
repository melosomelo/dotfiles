local opts = {
  noremap = true,
  silent = true
}

local split_command = "split";

-- go to definition in split window
-- want to improve in order to split vertically and horizntally
-- in alternate fashion

local function alternate_split_command()
  if split_command == "split" then
    split_command = "vsplit"
  else
    split_command = "split"
  end
end

-- splits the screen horizontally if definition is in another file 
-- if not, just jumps to location in same file
local function goto_definition(_, result, ctx)
  local util = vim.lsp.util
  local log = require("vim.lsp.log")
  local api = vim.api

  if result == nil or vim.tbl_isempty(result) then
    local _ = log.info() and log.info(ctx.method, "No location found")
    return nil
  end

  local origin_filename = ctx.params.textDocument.uri
  local result_filename = result[1].targetUri
  if origin_filename ~= result_filename then
    alternate_split_command()
    vim.cmd(split_command)
  end
  util.jump_to_location(result[1])

  return handler
end

vim.lsp.handlers["textDocument/definition"] = goto_definition

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = ""
  }
})

-- changing the signs of diagnostics in the sign column
local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " "
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {
    text = icon,
    texthl = hl,
    numhl = hl
  })
end

local lsp_installer = require "nvim-lsp-installer"
local lspconfig = require "lspconfig"

lsp_installer.setup {
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
}

-- for each installed server, check if it has custom options
-- and merge them with default opts
local installed_servers = lsp_installer.get_installed_servers()
for _, server in pairs(installed_servers) do
  local lsp_opts = {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(_, bufnr)
      -- some mappings for lsp features
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>', opts) -- go to definition
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>', opts) -- hover
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
      -- don't know what any of these do, so imma just leave em disabled
      -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts) -- go to implementation
      -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
      -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
      -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl',
      -- '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    end
  }
  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings" .. server.name)
  if has_custom_opts then
    lsp_opts = vim.tbl_deep_extend("force", server_custom_opts, lsp_opts)
  end
  lspconfig[server.name].setup(lsp_opts)
end
