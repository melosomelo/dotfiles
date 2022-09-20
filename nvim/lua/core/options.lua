-- Global variables.
vim.g.mapleader = " "

local options = vim.opt

-- TAB OPTIONS
options.expandtab = true -- use spaces instead of tabs
options.tabstop = 2 -- number of spaces that a <Tab> in the file counts for.
options.shiftwidth = 2 -- number of spaces to use for each step of (auto)indent.

-- GUI
options.colorcolumn = "90" -- highlight column 90
options.cursorline = true -- highlight the line which the cursor is currently on
options.hlsearch = false -- not highlight search results
options.incsearch = true -- highlight match while typing (not after pressing <CR>)
options.number = true -- show line numbers
options.relativenumber = true -- other lines' numbers will be relative to current line
options.numberwidth = 1 -- minimal number of columns to use for the line number.
options.ruler = true -- show the line and column number of the cursor position
options.termguicolors = true -- enables 24-bit RGB color in the TUI.
options.signcolumn = "yes" -- always show sign column
options.showcmd = true -- always show cmd line on last line
options.showmode = true -- place a message on last line regarding the current mode
options.showtabline = 2 -- always show tabline

-- FORMATTING

-- Make it so that the vim's clipboard will use both the register '*' and '+'
options.clipboard = options.clipboard + "unnamedplus"
options.completeopt = { "menu", "menuone", "noselect" }
options.errorbells = false
options.fenc = "utf-8" -- file encoding
options.hidden = true
options.ignorecase = true
options.mouse = "a"
options.mps = options.mps + "<:>"
options.scrolloff = 20
options.shiftround = true
options.smartcase = true
options.smartindent = true
options.splitbelow = true
options.splitright = true
options.undofile = true
options.wrap = false

vim.cmd("filetype plugin indent on")
