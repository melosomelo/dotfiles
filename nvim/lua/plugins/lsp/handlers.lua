local M = {}

local function resolve_result_filename(result)
	local result_filename = nil
	if result.uri then
		result_filename = result.uri
	end
	if result[1] then
		result_filename = result[1].targetUri
	end
	return result_filename
end

local function resolve_location(result)
	if result[1] then
		return result[1]
	end
	return result
end

-- Go to token definition
-- It will first check to see if the file in which the token is defined is already
-- opened in some window. If it is, then it will go that window. If not, then it
-- will create a new tab page with that file.
function M.goto_definition(_, result, ctx)
	local util = vim.lsp.util
	local log = require("vim.lsp.log")

	if result == nil or vim.tbl_isempty(result) then
		local _ = log.info() and log.info(ctx.method, "No def found")
		return nil
	end

	-- Some servers store the result's filename in `result.uri` and others
	-- in `result[1].targetUri`
	local result_filename = nil
	local location = nil

	result_filename = resolve_result_filename(result)
	location = resolve_location(result)

	if result_filename == nil then
		print("Could not resolve `result_filename`! All paths failed!")
		return
	end

	-- The filename where a correspondence was found
	result_filename = string.gsub(result_filename, "file://", "")
	-- For each tabpage, loop through all of its windows and check
	-- to see if that window has a buffer for result_filename
	local tabs_info = vim.fn.gettabinfo()
	for i = 1, #tabs_info do
		local tab_windows = tabs_info[i].windows
		for j = 1, #tab_windows do
			local buf_filename = vim.fn.bufname(vim.fn.winbufnr(tab_windows[j]))
			if buf_filename == result_filename then
				vim.fn.win_gotoid(tab_windows[j])
				util.jump_to_location(result[1], "utf-8")
				return
			end
		end
	end
	-- If we've reached this point, then we need to open a new tab
	vim.cmd("tabedit")
	util.jump_to_location(location, "utf-8")
end

function M.hover(_, result, ctx, config)
	if vim.api.nvim_get_current_buf() ~= ctx.bufnr then
		-- Ignore result since buffer changed. This happens for slow language servers.
		return
	end
	if not (result and result.contents) then
		vim.notify("No information available on token!")
		return
	end
	local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
	markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
	if vim.tbl_isempty(markdown_lines) then
		vim.notify("No information available on token!")
		return
	end
end

return M
