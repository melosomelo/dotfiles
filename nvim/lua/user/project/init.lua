local util = require "user.project.util"

local LIMIT_DIRECTORY = os.getenv("HOME")
local current_directory = vim.fn.expand("%:p")

local has_matched_patterns = false

local M = {}

local matched_project_types = {}

function M.setup(config)
  if current_directory == "" then
    return
  end
  while current_directory ~= LIMIT_DIRECTORY and not has_matched_patterns do
    local dir = util.read_directory(current_directory)
    for project_type_name, project_type_config in pairs(config.project_types) do
      if util.has_pattern_match_within_dir(project_type_config.patterns, dir) then
        matched_project_types[#matched_project_types + 1] = project_type_name
        has_matched_patterns = true
      end
    end
    if not has_matched_patterns then
      current_directory = util.calculate_parent_dir(current_directory)
    end
  end

  if has_matched_patterns then
    vim.cmd(string.format("cd %s", current_directory))
  end
end

function M.project_has_type(type)
  return matched_project_types[type] ~= nil
end

vim.api.nvim_create_user_command("LProjectTypes", function()
  print(vim.inspect(matched_project_types))
end, {})

return M

