local opts = {
  noremap = true,
  silent = true
}

-- go to definition in split window
local function goto_definition(split_cmd)
  local util = vim.lsp.util
  local log = require("vim.lsp.log")
  local api = vim.api

  -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
  local handler = function(_, result, ctx)
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(ctx.method, "No location found")
      return nil
    end

    if split_cmd then
      vim.cmd(split_cmd)
    end

    if vim.tbl_islist(result) then
      util.jump_to_location(result[1])

      if #result > 1 then
        setqflist(util.locations_to_items(result))
        api.nvim_command("copen")
        api.nvim_command("wincmd p")
      end
    else
      util.jump_to_location(result)
    end
  end

  return handler
end

vim.lsp.handlers["textDocument/definition"] = goto_definition('vsplit')

-- open the diagnostic with a floating window
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
-- go to prev diagnostic
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
-- go to next diagnostic
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- open diagnostics list
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

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

lsp_installer.setup {} -- add more configuration later

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
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
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
