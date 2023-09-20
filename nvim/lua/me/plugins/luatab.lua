local luatab = require("luatab")
local util = require("me.core.util")

local function get_other_tabs_names(buffer)
	local result = {}
	for i = 1, vim.fn.tabpagenr("$") do
		local tab_buffers = vim.fn.tabpagebuflist(i)
		local bufnr = tab_buffers[vim.fn.tabpagewinnr(i)]
		-- No point in comparing names with the same buffer.
		if bufnr ~= buffer then
			local bufname = vim.fn.bufname(bufnr)
			result[#result + 1] = vim.fn.fnamemodify(bufname, ":p:.")
		end
	end
	return result
end

local function title(bufnr)
	local file = vim.fn.bufname(bufnr)
	local buftype = vim.fn.getbufvar(bufnr, "&buftype")
	local filetype = vim.fn.getbufvar(bufnr, "&filetype")

	if buftype == "help" then
		return "help:" .. vim.fn.fnamemodify(file, ":t:r")
	elseif buftype == "quickfix" then
		return "quickfix"
	elseif filetype == "TelescopePrompt" then
		return "Telescope"
	elseif filetype == "git" then
		return "Git"
	elseif filetype == "fugitive" then
		return "Fugitive"
	elseif file:sub(file:len() - 2, file:len()) == "FZF" then
		return "FZF"
	elseif buftype == "terminal" then
		local _, mtch = string.match(file, "term:(.*):(%a+)")
		return mtch ~= nil and mtch or vim.fn.fnamemodify(vim.env.SHELL, ":t")
	elseif buftype == "nofile" then
		return ""
	elseif file == "" then
		return "[No Name]"
	else
		-- Need to refactor this to make it cleaner!
		local tabs_names = get_other_tabs_names(bufnr)
		local bufname_path_components = util.split(vim.fn.bufname(bufnr), "/")
		local left = #bufname_path_components
		local final_title = bufname_path_components[left]
		for i = 1, #tabs_names do
			-- This will not enter an infinite loop with tabs that have the same file opened
			-- as the funciton get_other_tabs_names ignores filters them.
			local limit = #util.split(tabs_names[i], "/")
			while
				util.join(util.slice(util.split(tabs_names[i], "/"), limit), "/")
				== final_title
			do
				left = left - 1
				limit = limit - 1
				final_title = util.join(util.slice(bufname_path_components, left), "/")
			end
		end
		return final_title
	end
end

luatab.setup({
	title = title,
})
