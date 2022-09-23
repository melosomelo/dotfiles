local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local nt_sync = require"plugins.nvimtree.sync"

-- Autocommand that reloads neovim whenever you save the packer-init.lua file
augroup("packer_user_config", { clear = true })
autocmd("BufWritePost", {
  group = "packer_user_config",
  desc = "Autocommand that reloads neovim whenever you save the packer-init.lua file",
  command = "source <afile> | PackerSync",
  pattern = "packer-init.lua"
})

augroup("default_settings", { clear = true })

autocmd("BufWritePre", {
  group = "default_settings",
  desc = "Remove postspaces",
  command = [[%s/\s\+$//e]],
  pattern = "*"
})
autocmd("FileType", {
  group = "default_settings",
  pattern = "*",
  command = "set formatoptions-=cro",
  desc = [[Disable continuation of comments when <CR> (insert mode)
    and o/O (normal) in a comment line"]]
})
autocmd("FileType", {
  group = "default_settings",
  pattern = { "text", "markdown", "html", "yaml" },
  command = "setlocal cc=0"
})

augroup("nvim_tree_sync", { clear = true })
autocmd("TabEnter", {
  group = "nvim_tree_sync",
  desc = "Open/close NvimTree when entering a new tab depending on its state",
  callback = function ()
    local cur_tab_num = vim.fn.tabpagenr()
    if(nt_sync.is_open_in_tab(cur_tab_num) and not nt_sync.is_open()) then
      nt_sync.close_tree(cur_tab_num)
    elseif (not nt_sync.is_open_in_tab(cur_tab_num) and nt_sync.is_open()) then
      nt_sync.open_tree(cur_tab_num)
    end
  end
})

autocmd("TabNew", {
  group = "nvim_tree_sync",
  desc = "Register a tab for nvim tree synchronization",
  callback = function ()
    local tab_list = vim.fn.gettabinfo()
    local new_tab = tab_list[#tab_list]
    nt_sync.register_tab(new_tab)
  end
})
