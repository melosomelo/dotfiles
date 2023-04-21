-- ideas for this plugin:
-- 1. project detection: based on lsp or patterns given by the user?
-- 2. project types: based on patterns given by the user. allow configuration per project type.
-- 3. maintain list of active projects.
-- 4. maintain sessions on each projects.

local util = require("me.core.util")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local projects = {}

local data_dir = vim.fn.stdpath("cache") .. "/project"

if vim.fn.isdirectory(data_dir) == 0 then
	vim.fn.mkdir(data_dir)
end

vim.api.nvim_create_user_command("ProjectAdd", function(opts)
	local name = opts.fargs[1]
	for i = 1, #projects do
		local proj = projects[i]
		if proj.name == name then
			vim.notify(
				"[PROJECT] Project name '" .. name .. "' is already taken.",
				vim.log.levels.ERROR
			)
			return
		end
	end
	projects[#projects + 1] = { name = name, path = vim.fn.getcwd() }
	vim.notify("[PROJECT] Project was added succesfully.")
end, { nargs = 1 })

augroup("project", { clear = true })

autocmd("VimEnter", {
	group = "project",
	callback = function()
		if vim.fn.filereadable(data_dir .. "/projects") == 0 then
			return
		end
		-- loading projects into runtime
		local lines = vim.fn.readfile(data_dir .. "/projects")
		for i = 1, #lines do
			local components = util.split(lines[i], " ")
			local name, path = components[1], components[2]
			projects[#projects + 1] = { name = name, path = path }
		end
		vim.notify("[PROJECT] Saved projects succesfully loaded into memory.")
		print(vim.inspect(projects))
	end,
})

autocmd("VimLeavePre", {
	pattern = "*",
	group = "project",
	callback = function()
		local lines = {}
		for i = 1, #projects do
			lines[#lines + 1] = projects[i].name .. " " .. projects[i].path
			vim.fn.writefile(lines, data_dir .. "/projects")
		end
	end,
})
