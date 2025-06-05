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

-- takes a table and returns a string which is comprised of each
-- of the table's elements separated by sep
M.join = function(t, sep)
	local str = ""
	for i = 1, #t do
		str = str .. tostring(t[i])
		if i ~= #t then
			str = str .. sep
		end
	end
	return str
end

-- takes the elements from the interval [i,j] from t
-- and copies them into a new table.
M.slice = function(t, i, j)
	-- to make sure both indexes are in the valid intervals.
	i = math.min(math.max(0, i), #t)
	j = math.max(math.min(j or #t, #t), 0)
	local copy = {}
	for k = i, j do
		table.insert(copy, t[k])
	end
	return copy
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
	local fmt_commentstring =
		vim.o.commentstring:gsub("%*", "%%*"):gsub("%-", "%%-"):gsub("%%s", "(.*)")
	local pattern = "(%s*)" .. fmt_commentstring
	local line = vim.fn.getline(i)
	local indent, text = line:match(pattern)
	if indent ~= nil and text ~= nil then
		vim.fn.setline(i, indent .. text)
	end
end

return M
