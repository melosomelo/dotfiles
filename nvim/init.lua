vim.env.CONFIG_ROOT = vim.fn.stdpath("config") .. "/init.lua"
require("me.core.options")
require("me.core.keymaps")
require("me.core.autocommands")
require("me.core.colorscheme")
require("me.core.diagnostics")
require("me.packer-init")
require("me.plugins.treesitter")
require("me.plugins.lsp.init")
require("me.plugins.cmp")
require("me.plugins.luasnip")
require("me.plugins.lualine")
require("me.plugins.luatab")
require("me.plugins.nvimtree")
require("me.plugins.autopairs")
require("me.plugins.gitsigns")
require("me.plugins.toggleterm")
require("me.plugins.blankline")
require("me.plugins.project.init")
