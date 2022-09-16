local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- this was breaking some things.
--[=[
vim.cmd([[
  augroup remember_folds
    autocmd!
    autocmd BufWinLeave * mkview
    autocmd BufWinEnter * silent! loadview
  augroup END
]])
--]=]

-- Autocommand that reloads neovim whenever you save the packer-init.lua file
augroup("packer_user_config", { clear = true })
autocmd("BufWritePost", {
  group = "packer_user_config",
  desc = "Autocommand that reloads neovim whenever you save the packer-init.lua file",
  command = "source <afile> | PackerSync"
})
