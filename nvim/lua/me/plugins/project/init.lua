-- ideas for this plugin:
-- 1. project detection: based on lsp or patterns given by the user?
-- 2. project types: based on patterns given by the user. allow configuration per project type.
-- 3. maintain list of active projects.
-- 4. maintain sessions on each projects.

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local data_dir = vim.fn.stdpath("cache") .. "/project"

if vim.fn.isdirectory(data_dir) == 0 then
	vim.fn.mkdir(data_dir)
end

vim.api.nvim_create_user_command("ProjectAdd", function(arg)
	-- Check to see if input has been added.
	print(vim.inspect(arg))
	print("Adding project!")
end, {})
