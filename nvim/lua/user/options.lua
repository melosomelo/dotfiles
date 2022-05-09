-- Global variables.
vim.g.mapleader = " "
vim.g.netrw_liststyle = 3 -- use tree display
vim.g.netrw_banner = 0  -- remove banner
vim.g.netrw_browse_split = 3 -- open new file in tabs 
vim.g.netrw_winsize = 15
-- Options.
options = vim.opt
options.relativenumber = true 
options.termguicolors = true
options.number = true
options.numberwidth = 4
options.hlsearch = false
options.errorbells = false
options.tabstop = 2 
options.showtabline = 2
options.softtabstop = 2
options.shiftwidth = 2
options.expandtab = true
options.smartindent = true
options.shiftround = true
options.wrap = false
options.incsearch = true
options.scrolloff = 20
options.signcolumn = "yes"
options.showmode = true
options.showcmd = true
options.ruler = true
options.mps = options.mps + "<:>"
options.guifont="Fira_Code_Nerd_Font:h16"
options.fenc = "utf-8"
options.ignorecase = true
options.smartcase = true
options.splitbelow = true
options.splitright = true
options.undofile = true
options.cursorline = true
vim.cmd("filetype plugin indent on")

