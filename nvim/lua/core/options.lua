-- Global variables.
vim.g.mapleader = " "

-- Options
local options = vim.opt

-- Tab options
options.expandtab = true -- use spaces instead of tabs
options.tabstop = 2 -- number of spaces that a <Tab> in the file counts for.
options.shiftwidth = 2 -- number of spaces to use for each step of (auto)indent.


-- Make it so that the vim's clipboard will use both the register '*' and '+'
options.clipboard = options.clipboard + "unnamedplus"
options.colorcolumn = "90"
options.completeopt = { "menu", "menuone", "noselect" }
options.cursorline = true
options.errorbells = false
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
options.showcmd = true
options.showmode = true
options.showtabline = 2
options.smartcase = true
options.smartindent = true
options.splitbelow = true
options.splitright = true
options.termguicolors = true
options.undofile = true
options.wrap = false

vim.cmd("filetype plugin indent on")
