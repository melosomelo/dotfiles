local project_manager = require "user.project"

project_manager.setup({
  project_types = {
    git = {
      patterns = {".git"},
      keymaps = {}
    },
    javascript = {
      patterns = {"package.json"}
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

