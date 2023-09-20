local util = require("me.core.util")
local keymap = vim.keymap

local opts = {
	silent = true,
	remap = false,
}

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local alt_j = "∆"
local alt_k = "˚"
local alt_h = "˙"
local alt_l = "¬"

-- Config sourcing and editing
-- still need to work on reloading the config.
keymap.set("n", "<leader>ev", ":tabedit ~/.config/nvim<CR>", opts)

-- move current line down
keymap.set("n", alt_j, "ddp", opts)
-- move current line up
keymap.set("n", alt_k, "ddkP", opts)

-- comment current line
keymap.set("n", "<leader>c", function()
	util.comment_line(".")
end, opts)

-- comment each line of the current selection
keymap.set("v", "<leader>c", function()
	local lstart = vim.fn.getpos("v")[2]
	local lend = vim.fn.getpos(".")[2]
	for i = math.min(lstart, lend), math.max(lstart, lend) do
		util.comment_line(i)
	end
end, opts)

-- uncomment current line
keymap.set("n", "<leader>C", function()
	util.uncomment_line(".")
end, opts)

-- uncomment each line of the selection
keymap.set("v", "<leader>C", function()
	local lstart = vim.fn.getpos("v")[2]
	local lend = vim.fn.getpos(".")[2]
	for i = math.min(lstart, lend), math.max(lstart, lend) do
		util.uncomment_line(i)
	end
end, opts)

-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Better tab navigation
keymap.set("n", "<S-h>", "gT", opts) -- previous tab
keymap.set("n", "<S-l>", "gt", opts) -- next tab
keymap.set("n", alt_h, function() -- move current tabpage to the left
	local cur_tab_num = vim.fn.tabpagenr()
	if cur_tab_num == 1 then
		vim.cmd("$tabmove")
	else
		vim.cmd("-tabmove")
	end
end, opts)

keymap.set("n", alt_l, function() -- move current tabpage to the right
	local cur_tab_num = vim.fn.tabpagenr()
	local last_tab_num = vim.fn.tabpagenr("$")
	if cur_tab_num == last_tab_num then
		vim.cmd("0tabmove")
	else
		vim.cmd("+tabmove")
	end
end, opts)

-- Remap CTRL + U and CTRL + D to Shift+K and Shift+J, respectively
keymap.set("n", "<S-j>", "<C-d>zz", opts)
keymap.set("n", "<S-k>", "<C-u>zz", opts)
keymap.set("n", "<C-d>", "<nop>", opts)
keymap.set("n", "<C-u>", "<nop>", opts)

-- Telescope mappings
-- open file picker
keymap.set(
	"n",
	"<leader>tf",
	"<cmd>lua require('telescope.builtin').find_files({hidden = true, no_ignore=true})<cr>",
	opts
)
-- open live grep
keymap.set(
	"n",
	"<leader>tg",
	"<cmd>lua require('telescope.builtin').live_grep()<cr>",
	opts
)

-- Nvimtree maps
-- toggle Nvimtree
keymap.set("n", "<C-D>", "<cmd>NvimTreeToggle<CR>", opts)

-- Diagnostics keymaps
-- open the diagnostic with a floating window
keymap.set("n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- go to prev diagnostic
keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
-- go to next diagnostic
keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
-- open diagnostics list
-- keymap.set("n", "<space>dl", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
