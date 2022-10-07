local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local icons = require("nvim-web-devicons")

-- Autocommand that reloads neovim whenever you save the packer-init.lua file
augroup("packer_user_config", { clear = true })
autocmd("BufWritePost", {
	group = "packer_user_config",
	desc = "Autocommand that reloads neovim whenever you save the packer-init.lua file",
	command = "source <afile> | PackerSync",
	pattern = "packer-init.lua",
})

augroup("default_settings", { clear = true })

autocmd("BufWritePre", {
	group = "default_settings",
	desc = "Remove postspaces",
	command = [[%s/\s\+$//e]],
	pattern = "*",
})
autocmd("FileType", {
	group = "default_settings",
	pattern = "*",
	command = "set formatoptions-=cro",
	desc = [[Disable continuation of comments when <CR> (insert mode)
    and o/O (normal) in a comment line"]],
})

autocmd("FileType", {
	group = "default_settings",
	pattern = { "text", "markdown", "html", "yaml" },
	command = "setlocal cc=0",
})

autocmd("BufWritePost", {
	group = "default_settings",
	pattern = "*",
	command = "FormatWrite",
})
