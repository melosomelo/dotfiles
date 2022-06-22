local project_manager = require "user.project"

project_manager.setup({
  project_types = {
    git = {
      patterns = {".git"},
      keymaps = {}
    },
    javascript = {
      patterns = {"package.json"}
    },
    tailwind = {
      patterns = {"tailwind.config.js", "tailwind.config.json"}
    }
  }
})

require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.lualine"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.gitsigns"
require "user.nvimtree"
require "user.bufferline"
