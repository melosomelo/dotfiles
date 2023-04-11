local luatab = require("luatab")
local util = require("core.util")

local function get_other_buffers_names()
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
		local other_buffers_names = get_other_buffers_names()
		-- return vim.fn.pathshorten(vim.fn.fnamemodify(file, ":p:~:t"))
		local bufname_path_components = util.split(vim.fn.bufname(), "/")
		-- print(vim.inspect(bufname_path_components))
		-- print(util.join({ "eai", "mano", "tudo", "bem", "?" }, " "))
		-- local left = #bufname_path_components
		-- for i = 1, #other_buffers_names do
		-- print(vim.inspect(util.split(other_buffers_names[i], "/")))
		-- end
		return vim.fn.fnamemodify(file, ":p:.")
	end
end

luatab.setup({
	title = title,
})
