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

-- move lines
-- move line down
keymap.set("n", alt_j, "ddp", opts)
-- move line up
keymap.set("n", alt_k, "ddkP", opts)

-- save and quit shortcuts
-- save
keymap.set("n", "<leader>s", ":w<CR>", opts)
-- quit
keymap.set("n", "<leader>q", ":q!<CR>", opts)
-- save and quit
keymap.set("n", "<leader>wq", ":wq<CR>", opts)

-- window navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Tab navigation
keymap.set("n", "<S-h>", "gT", opts) -- previous tab
keymap.set("n", "<S-l>", "gt", opts) -- next tab

-- Remap CTRL + U and CTRL + D to Shift+K and Shift+J, respectively
keymap.set("n", "<S-j>", "<C-d>", opts)
keymap.set("n", "<S-k>", "<C-u>", opts)
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
keymap.set("n", "<leader>tg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)

-- Nvimtree maps
-- toggle Nvimtree
keymap.set("n", "<C-D>", "<cmd>NvimTreeToggle<CR>", opts)

-- manual formatting
keymap.set("n", "<C-f>", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>", opts)

-- Diagnostics keymaps
-- open the diagnostic with a floating window
keymap.set("n", "<space>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- go to prev diagnostic
keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
-- go to next diagnostic
keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
-- open diagnostics list
keymap.set("n", "<space>dl", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

-- toggleterm
keymap.set("n", "<C-t>", "<cmd>ToggleTerm direction=float<CR>", opts)
keymap.set("t", "<C-t>", "<cmd>ToggleTerm<CR>", opts)
