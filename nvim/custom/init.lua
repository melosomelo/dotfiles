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

-------------------------------------- autocmds ------------------------------------------

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  group = augroup("markdown", {
    clear = true
  }),
  pattern = "markdown",
  callback = function()
    vim.cmd([[
      set wrap
      set showbreak=>>>
      nnoremap j gj
      nnoremap k gk
    ]])
  end
})

autocmd("VimEnter", {
  group = augroup("markdown", {
    clear = true
  }),
  callback = function(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    if not directory then
      return
    end
    vim.cmd.cd(data.file)
    require("nvim-tree.api").tree.open()
  end
})

autocmd("FileType", {
  group = augroup("default_settings", {
    clear = true
  }),
  pattern = "*",
  command = "set formatoptions-=cro",
  desc = [[Disable continuation of comments when <CR> (insert mode)
    and o/O (normal) in a comment line"]]
})

-- Not really sure about this one yet, so I'll leave it commented out
-- autocmd("BufWritePre", {
--   group = "default_settings",
--   desc = "Remove postspaces",
--   callback = function()
--     -- Since substitution may lead to the cursor jumping,
--     -- I create a mark on the current position, so that I can jump
--     -- back to it after removing the postspaces.
--     vim.cmd([[
--       norm mz
--       %s/\s\+$//e
--       norm `z
--     ]])
--   end,
--   pattern = "*"
-- })

-- These are left out for now since I'm still defining my terminal strategy.
-- augroup("ToggleTerm", {
--   clear = true
-- })
--
-- autocmd("TermOpen", {
--   callback = function()
--     local opts = {
--       buffer = 0,
--       silent = true,
--       remap = false
--     }
--     vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
--     -- window moving
--     vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
--     vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
--     vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
--     vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
--   end
-- })
