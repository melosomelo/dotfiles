require("core.options")
require("core.keymaps")
require("core.autocommands")
require("core.colorscheme")
require("core.diagnostics")

require("packer-init")
require("plugins.lualine")
require("plugins.cmp")
require("plugins.lsp")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.autopairs")
require("plugins.gitsigns")
require("plugins.nvimtree")
require("plugins.luatab")
require("plugins.formatter")
require("plugins.toggleterm")


local util = require("core.util")

print(vim.inspect(util.split("eai mateus", " ")))

