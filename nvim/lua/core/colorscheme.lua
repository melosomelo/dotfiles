-- configuring dracula pro
-- vim.cmd([[
  -- packadd! dracula_pro
  -- syntax enable
  -- let g:dracula_colorterm = 0
  -- colorscheme dracula_pro
-- ]])


vim.g.catppuccin_flavour = "mocha"

require"catppuccin".setup{}

vim.cmd[[colorscheme catppuccin]]
