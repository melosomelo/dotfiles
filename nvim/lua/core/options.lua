-- Global variables.
vim.g.mapleader = " "

-- Options
local options = vim.opt
-- Make it so that the vim's clipboard will use both the register '*' and '+'
options.clipboard = options.clipboard + "unnamedplus"
options.colorcolumn = "90"
options.completeopt = { "menu", "menuone", "noselect" }
options.cursorline = true
options.errorbells = false
options.expandtab = true
options.fenc = "utf-8" -- file encoding
options.hidden = true
options.hlsearch = false -- not highlight search results
options.ignorecase = true
options.incsearch = true -- highlight match while typing (not after pressing <CR>)
options.mouse = "a"
options.mps = options.mps + "<:>"
options.number = true
options.numberwidth = 1
options.relativenumber = true
options.ruler = true
options.scrolloff = 20
options.signcolumn = "yes"
options.shiftround = true
options.shiftwidth = 2
options.showcmd = true
options.showmode = true
options.showtabline = 2
options.smartcase = true
options.smartindent = true
options.softtabstop = 2
options.splitbelow = true
options.splitright = true
options.tabstop = 2
options.termguicolors = true
options.undofile = true
options.wrap = false

vim.cmd("filetype plugin indent on")
