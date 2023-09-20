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
function M.goto_definition(_, result, _)
	vim.lsp.util.jump_to_location(result[1], "utf-8", true)
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
