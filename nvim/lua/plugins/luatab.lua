local luatab = require("luatab")

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
		-- return vim.fn.pathshorten(vim.fn.fnamemodify(file, ":p:~:t"))
		return vim.fn.fnamemodify(file, ":p:.")
	end
end

luatab.setup({
	title = title,
})
