-- A collection of utility functions
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

return M
