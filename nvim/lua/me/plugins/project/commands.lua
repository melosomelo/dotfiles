local command = vim.api.nvim_create_user_command
local proj_core = require("me.plugins.project.core")

command("ProjectAdd", function(opts)
	local name = opts.fargs[1]
	proj_core.add_project(name, vim.fn.getcwd())
end, { nargs = 1 })

command("ProjectRemove", function(opts)
	local name = opts.fargs[1]
	vim.ui.input({ prompt = "Remove project '" .. name .. "'? y/n: " }, function(input)
		if input == "y" then
			proj_core.delete_project(name)
		end
	end)
end, { nargs = 1, complete = proj_core.get_projects_names })
