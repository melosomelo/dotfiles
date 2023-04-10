-- This module is a collection of utility functions.
local M = {}

-- takes a str and a sep and returns an array of substrings
M.split = function(str, sep)
	local result = {}
	local substr = ""
	for i = 1, string.len(str) do
		local char = string.sub(str, i, i)
		if char == sep then
			result[#result + 1] = substr
			substr = ""
		else
			substr = substr .. char
		end
	end
	result[#result + 1] = substr
	return result
end

M.comment_line = function(i)
  local line = vim.fn.getline(i)
  local indent, text = line:match("(%s*)(.*)")
  vim.fn.setline(i, indent .. string.format(vim.o.commentstring, text))
end

M.uncomment_line = function(i)
  -- Since we're going to use the comment string as a pattern, we need to deal with
  -- some characters that are common to comments but that are also special characters within the context
  -- of pattern matching in Lua (like * and -). Also, we need to substitute the %s in the commentstring option.
  local fmt_commentstring = vim.o.commentstring:gsub("%*", "%%*"):gsub("%-", "%%-"):gsub("%%s", "(.*)")
  local pattern = "(%s*)" .. fmt_commentstring
  local line = vim.fn.getline(i)
  local indent, text = line:match(pattern)
  if(indent ~= nil and text ~= nil) then
    vim.fn.setline(i, indent .. text)
  end
end

return M
