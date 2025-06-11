require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", {
	desc = "CMD enter command mode",
})
map("i", "jk", "<ESC>")

-- Remap CTRL+U and CTRL+D to Shift+K and Shift+J respectively
map("n", "J", "<C-d>zz")
map("n", "K", "<C-u>zz")
map("n", "<C-u>", "<nop>")
map("n", "<C-d>", "<nop>")

map("n", "<C-h>", "<C-w>h", {
	desc = "Go to window on left",
})
map("n", "<C-j>", "<C-w>j", {
	desc = "Go to window below",
})
map("n", "<C-k>", "<C-w>k", {
	desc = "Go to window above",
})
map("n", "<C-l>", "<C-w>l", {
	desc = "Go to window on right ",
})

map("n", "<S-h>", "gT", {
	desc = "Go to previous tab",
})
map("n", "<S-l>", "gt", {
	desc = "Go to next tab",
})

map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {
	desc = "Go to previous diagnostic",
})
map("n", "]d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {
	desc = "Go to next diagnostic",
})
map("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity=vim.diagnostic.severity.ERROR})<CR>", {
	desc = "Go to previous error diagnostic",
})
map("n", "]e", "<cmd>lua vim.diagnostic.goto_prev({severity=vim.diagnostic.severity.ERROR})<CR>", {
	desc = "Go to next error diagnostic",
})

-- map("n", "<leader>fm", "", { desc = "Format file with conform "})

map("n", "<leader>h", "<cmd>lua vim.lsp.buf.hover()<cr>", {
	desc = "LSP hover",
})
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", {
	desc = "LSP rename",
})
map("n", "<leader>d", "<cmd>lua vim.lsp.buf.definition()<cr>", {
	desc = "Go to LSP def",
})

map("n", "<C-d>", "<cmd>NvimTreeToggle<CR>", {
	desc = "Toggle nvimtree",
})

map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({hidden = true})<cr>", {
	desc = "Open Telescope file picker",
})
map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", {
	desc = "Open Telescope live grep",
})
