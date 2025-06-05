require "nvchad.options"

local o = vim.opt

-- do not highlight search results
o.hlsearch = false
-- other lines' numbers will be relative to current line
o.relativenumber = true
-- minimal number of columns to use for the line number.
o.numberwidth = 2
-- Min number of screen lines to keep above and below the cursor.
o.scrolloff = 20
-- Min number of columns to keep to the right and left of the cursor.
o.sidescrolloff = 10
-- Disable, by default, wrapping of lines longer than the width of the window.
o.wrap = false
-- Round indent to multiple of 'shiftwidth'.
o.shiftround = true
-- The tilde operator behaves like an operator (you can use it like you'd use the `d` operator).
o.tildeop = true
-- Use clipboard for all operations.
o.clipboard = o.clipboard + "unnamedplus"
-- Options to regulate completion in insert mode.
o.completeopt = {"menu", "menuone", "noselect"}
-- file encoding
o.fenc = "utf-8"

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
