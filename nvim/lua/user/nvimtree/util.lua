local M = {}

function M.create(node)
	vim.ui.input({
		prompt = "Create file/folder ",
		default = string.format("%s", node.parent.absolute_path),
		completion = "file",
	}, function(path)
		local command = nil
		if not path then
			return
		end
		if string.sub(path, #path, #path) == "/" then
			command = string.format("mkdir %s", path)
		else
			command = string.format("touch %s", path)
		end
		os.execute(command)
		vim.cmd("NvimTreeRefresh")
	end)
end

-- doesn't work properly when moving file with open buffer
function M.move(node)
	vim.ui.input({
		prompt = "Move file to ",
		default = string.format("%s", vim.fn.getcwd()),
		completion = "dir",
	}, function(dir)
		if not dir then
			return
		end
		local no_errors = os.execute(string.format("mv %s %s", node.absolute_path, dir))
		if no_errors then
			vim.cmd("NvimTreeRefresh")
		else
			print("Could not move file!")
		end
	end)
end

function M.tab(node)
	vim.cmd(string.format(
		[[
    NvimTreeToggle
    tabedit
    e %s
  ]],
		node.absolute_path
	))
end

return M
