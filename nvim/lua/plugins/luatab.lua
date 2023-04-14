local luatab = require("luatab")
local util = require("core.util")

local function get_other_tabs_names()
	local result = {}
	for i = 1, vim.fn.tabpagenr("$") do
		if i ~= vim.fn.tabpagenr() then
			local tab_buffers = vim.fn.tabpagebuflist(i)
			local bufnr = tab_buffers[vim.fn.tabpagewinnr(i)]
			-- No point in comparing names with the same buffer.
			if bufnr ~= vim.fn.bufnr() then
				local bufname = vim.fn.bufname(bufnr)
				result[#result + 1] = vim.fn.fnamemodify(bufname, ":p:.")
			end
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
	elseif file == "" then
		return "[No Name]"
	else
		-- Adds more components to the tab title (if required) to differentiate
		-- it from other tabs' titles.
		-- For example, if we had files src/routes/user.ts and src/services/user.ts,
		-- instead of showing the entire path of the file or just user.ts on both
		-- tabs, we'd have routes/user.ts and services/user.ts.
		local tabs_names = get_other_tabs_names()
		local bufname_path_components = util.split(vim.fn.bufname(bufnr), "/")
		local left = #bufname_path_components
		local final_title = bufname_path_components[left]
		for i = 1, #tabs_names do
			-- This will not enter an infinite loop with tabs that have the same file opened
			-- as the funciton get_other_tabs_names ignores filters them.
			while
				util.join(util.slice(util.split(tabs_names[i], "/"), left), "/")
				== final_title
			do
				left = left - 1
				final_title = util.join(util.slice(bufname_path_components, left), "/")
			end
		end
		return final_title
		-- return vim.fn.pathshorten(vim.fn.fnamemodify(file, ":p:~:t"))
	end
end

luatab.setup({
	title = title,
})
