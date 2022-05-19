--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- Vim Options
local options          = vim.opt
options.relativenumber = true
options.termguicolors  = true
options.number         = true
options.hlsearch       = false
options.numberwidth    = 4
options.errorbells     = false
options.tabstop        = 2
options.showtabline    = 2
options.softtabstop    = 2
options.shiftwidth     = 2
options.expandtab      = true
options.smartindent    = true
options.shiftround     = true
options.wrap           = false
options.incsearch      = true
options.scrolloff      = 20
options.signcolumn     = "yes"
options.showmode       = true
options.showcmd        = true
options.cmdheight      = 1
options.ruler          = true
options.mps            = options.mps + "<:>"
options.fenc           = "utf-8"
options.ignorecase     = true
options.smartcase      = true
options.splitbelow     = true
options.splitright     = true
options.undofile       = true
options.cursorline     = true
options.completeopt    = { "menu", "menuone", "noselect" }

-- Configuration for DraculaPro
vim.cmd [[
  packadd! dracula_pro
  syntax enable
  let g:dracula_colorterm = 0
  let g:dracula_bold = 1
  let g:dracula_italic = 1
]]
lvim.format_on_save = true
lvim.log.level      = "warn"
lvim.colorscheme    = "dracula_pro"
-- ===================KEYMAPPINGS====================

-- Open config for LunarVim
lvim.keys.normal_mode["<leader>ev"] = ":vsplit /Users/mateusnascimento/.config/lvim/config.lua<cr>"

-- Toggle NvimTree
lvim.keys.normal_mode["<leader>e"] = false
lvim.keys.normal_mode["<leader>d"] = ":NvimTreeToggle<cr>"

-- Better window navigation
lvim.keys.normal_mode["<C-h>"] = "<C-w>h"
lvim.keys.normal_mode["<C-j>"] = "<C-w>j"
lvim.keys.normal_mode["<C-k>"] = "<C-w>k"
lvim.keys.normal_mode["<C-l>"] = "<C-w>l"

-- Tab navigation
lvim.keys.normal_mode["<S-h>"] = "gT" -- previous tab
lvim.keys.normal_mode["<S-l>"] = "gt" -- next tab

-- Remap CTRL + U and CTRL + D to Shift+K and Shift+J, respectively
lvim.lsp.buffer_mappings.normal_mode["K"] = nil
lvim.keys.normal_mode["K"] = "<C-u>"
lvim.keys.normal_mode["<S-j>"] = "<C-d>"
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"


-- ===================NvimTree====================
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
-- Lualine configuration
lvim.builtin.lualine.style = "default"
-- NvimTree configuration
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.view.width = 25
lvim.builtin.nvimtree.setup.view.mappings.list = {
  { key = { "l" }, action = "tabnew", mode = "n" }
}
-- if you don't want all the parsers change this to a table of the ones you want

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false
-- lvim.lsp.templates_dir = join_paths(get_runtime_dir(), "after", "ftplugin")
-- require("lvim.lsp.manager").setup("hls")

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)
-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
-- lvim.plugins = {
--     {"folke/tokyonight.nvim"},
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
