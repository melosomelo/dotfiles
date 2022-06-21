local M = {};

function M.read_directory(dir)
  local stream = io.popen(string.format("ls -a %s", current_directory))
  local directory = {}
  for file in stream:lines() do
    directory[#directory + 1] = file
  end
  return directory
end

local function file_matches_any_pattern(patterns, filename)
  for _, pattern in pairs(patterns) do
    if filename == pattern then
      return true
    end
  end
  return false
end

function M.has_pattern_match_within_dir(patterns, dir)
  for _, filename in pairs(dir) do
    if file_matches_any_pattern(patterns, filename) then
      return true
    end
  end
  return false
end

local function find_last_slash_index(str)
  local index = nil
  for i = 1, #str do
    if str:sub(i, i) == '/' then
      index = i
    end
  end
  return index
end

function M.calculate_parent_dir(dir)
  local final_slash_index = find_last_slash_index(dir)
  return string.sub(dir, 1, final_slash_index - 1)
end

return M
