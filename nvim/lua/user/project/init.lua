local LIMIT_DIRECTORY = os.getenv("HOME")
local current_directory = vim.fn.getcwd()
local has_matched_patterns = false

local project_types = {
  git = {
    patterns = {".git"}
  },
  javascript = {
    patterns = {"package.json"}
  }
}

local matched_project_types = {}

local function read_directory(dir)
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

local function has_pattern_match_within_dir(patterns, dir)
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

local function calculate_parent_dir(dir)
  local final_slash_index = find_last_slash_index(dir)
  return string.sub(dir, 1, final_slash_index - 1)
end

while current_directory ~= LIMIT_DIRECTORY and not has_matched_patterns do
  local dir = read_directory(current_directory)
  for project_type_name, project_type_config in pairs(project_types) do
    if has_pattern_match_within_dir(project_type_config.patterns, dir) then
      matched_project_types[#matched_project_types + 1] = project_type_name
      has_matched_patterns = true
    end
  end
  if not has_matched_patterns then
    current_directory = calculate_parent_dir(current_directory)
  end
end

if has_matched_patterns then
  vim.cmd(string.format("cd %s", current_directory))
end

print(vim.inspect(matched_project_types))
