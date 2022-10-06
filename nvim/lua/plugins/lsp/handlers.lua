local M = {};

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

  -- The filename of the buffer from which this handler was called
	local origin_filename = string.gsub(ctx.params.textDocument.uri, "file://", "")
  -- The filename where a correspondence was found
	local result_filename = string.gsub(result[1].targetUri, "file://", "")
  -- For each tabpage, loop through all of its windows and check
  -- to see if that window has a buffer for result_filename
  local tabs_info = vim.fn.gettabinfo()
  for i = 1, #tabs_info do
    local tab_windows = tabs_info[i].windows
    for j = 1, #tab_windows do
      local buf_filename = vim.fn.bufname(vim.fn.winbufnr(tab_windows[j]))
      if(buf_filename == result_filename) then
        vim.fn.win_gotoid(tab_windows[j])
        util.jump_to_location(result[1], "utf-8")
        return
      end
    end
  end
  -- If we've reached this point, then we need to open a new tab
  vim.cmd("tabedit")
  util.jump_to_location(result[1], "utf-8")


end

return M
