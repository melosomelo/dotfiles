-- I want to synchronize NvimTree across all tabs that I'm using, just like VSCode.
-- For example, if I'm in a tab with NvimTree open and I open a new tab, I want that
-- new tab to also have NvimTree open. Similarly, if I close NvimTree in any tab,
-- I want it to close for all other tabs.
local nt_api = require"nvim-tree.api"
local M = {}

local is_nt_open = false

-- Does tab i have nvim tree open?
local tab_has_nt = {}

function M.set_open()
  is_nt_open = true
end

function M.set_close()
  is_nt_open = false
end

function M.is_open()
  return is_nt_open
end

function M.register_tab(tab_info)
  tab_has_nt[tab_info.tabnr] = false
end

function M.is_open_in_tab(tab_index)
  return tab_has_nt[tab_index]
end

function M.open_tree(tab_index)
  nt_api.tree.open()
  tab_has_nt[tab_index] = true
end

function M.close_tree(tab_index)
  nt_api.tree.close()
  tab_has_nt[tab_index] = false
end

return M
