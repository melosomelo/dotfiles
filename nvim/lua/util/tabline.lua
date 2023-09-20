-- collection of utility functions to create the tabline

local devicons = require"nvim-web-devicons"

local M = {}

M.cell = function (i)
  local buflist = vim.fn.tabpagebuflist(i)
  local winnr = vim.fn.tabpagewinnr(i)
  local bufnr = buflist[winnr]
end

M.tabline = function ()
  local line = ""
  for i = 1, vim.fn.tabpagenr("$") do
    line = line .. M.cell(i)
  end
end


return M
