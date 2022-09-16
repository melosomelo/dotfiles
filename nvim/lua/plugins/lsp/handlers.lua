local M = {};

-- go to token definition
function M.goto_definition(_, result, ctx)
	local util = vim.lsp.util
	local log = require("vim.lsp.log")

	if result == nil or vim.tbl_isempty(result) then
		local _ = log.info() and log.info(ctx.method, "No location found")
		return nil
	end

	local origin_filename = ctx.params.textDocument.uri
	local result_filename = result[1].uri
  print(vim.inspect(result), origin_filename, result_filename)
	if origin_filename ~= result_filename then
		vim.cmd[[split]]
	end
	util.jump_to_location(result[1])
	return handler
end

return M
