-- local autocmd = vim.api.nvim_create_autocmd
-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
-------------------------------------- options ------------------------------------------
local options = vim.opt

options.hlsearch = false -- do not highlight search results

options.relativenumber = true -- other lines' numbers will be relative to current line
options.numberwidth = 2 -- minimal number of columns to use for the line number.

options.scrolloff = 20 -- Min number of screen lines to keep above and below the cursor.
options.sidescrolloff = 10 -- Min number of columns to keep to the right and left of the cursor.

options.wrap = false -- Disable, by default, wrapping of lines longer than the width of the window.

options.shiftround = true -- Round indent to multiple of 'shiftwidth'.

options.tildeop = true -- The tilde operator behaves like an operator (you can use it like you'd use the `d` operator).

options.clipboard = options.clipboard + "unnamedplus" -- Use clipboard for all operations.
options.completeopt = {"menu", "menuone", "noselect"} -- Options to regulate completion in insert mode.
options.fenc = "utf-8" -- file encoding

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
