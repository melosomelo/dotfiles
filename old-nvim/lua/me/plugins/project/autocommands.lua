local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local proj_core = require("me.plugins.project.core")

augroup("project", { clear = true })

-- Load registered plugins when vim starts
autocmd("VimEnter", {
	group = "project",
	callback = proj_core.read_projects,
})

autocmd("VimLeavePre", {
	pattern = "*",
	group = "project",
	callback = proj_core.write_projects,
})
