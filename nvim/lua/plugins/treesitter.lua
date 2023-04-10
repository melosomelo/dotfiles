require"nvim-treesitter.configs".setup {
  ensure_installed = { "lua", "vim", "javascript", "typescript", "css", "html", "astro" },
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    disable = {},
  }
}
