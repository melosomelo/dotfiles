-- Global variables.
vim.g.mapleader = " "

local options = vim.opt

-- TAB OPTIONS
-- These set of options make it so that spaces are always inserted.
-- Taken from the 'tabstop' documentation from Neovim.
options.expandtab = true -- use spaces instead of tabs
options.tabstop = 2 -- number of spaces that a <Tab> in the file counts for.
options.shiftwidth = 2 -- number of spaces to use for each step of (auto)indent.

-- TUI options
options.cursorline = true -- highlight the line which the cursor is currently on
options.hlsearch = false -- do not highlight search results
options.number = true -- show line numbers
options.relativenumber = true -- other lines' numbers will be relative to current line
options.numberwidth = 1 -- minimal number of columns to use for the line number.
options.termguicolors = true -- enables 24-bit RGB color in the TUI (for more color variety).
options.scrolloff = 20 -- Min number of screen lines to keep above and below the cursor.
options.sidescrolloff = 10 -- Min number of columns to keep to the right and left of the cursor.
options.showtabline = 2 -- always show tabline
options.splitbelow = true -- When splitting, place the new window beneath the current.
options.splitright = true -- When vsplitting, place the new window right of the current.
options.wrap = false -- Disable, by default, wrapping of lines longer than the width of the window.

-- FORMATTING
-- Don't automatically insert comment leader after <CR> in insert mode
-- and with o or O in Normal mode.
options.fo:remove({ "r", "o" })
options.shiftround = true -- Round indent to multiple of 'shiftwidth'.
options.smartindent = true -- Do smart autoindent when startning a new line.
options.tildeop = true -- The tilde operator behaves like an operator (you can use it like you'd use the `d` operator).

-- OTHERS
options.clipboard = options.clipboard + "unnamedplus" -- Use clipboard for all operations.
options.completeopt = { "menu", "menuone", "noselect" } -- Options to regulate completion in insert mode.
options.exrc = true -- Enables the reading of .nvim.lua, .nvimrc and .exrc files in the current dir.
options.fenc = "utf-8" -- file encoding
options.ignorecase = true -- Ignore case when searching for patterns. Works with 'smartcase'.
options.mouse = "a" -- Enables mouse support for all modes.
options.smartcase = true -- Overrides 'ignorecase' if the search contains upper case characters.

-- Enables filetype detection, filetype-based plugins and indentation.
vim.cmd("filetype plugin indent on")

-- Other relevant options that I'll maybe investigate in the future:
-- commentstring
-- completefunc
-- diff
-- fillchars
-- foldclose
-- foldcolumn
-- foldmethod
-- foldtext
-- showbreak
-- spell
-- spelllang
-- spelloptions
-- directory
-- undofile
-- undodir
-- backup
-- backupdir
-- sessionoptions
