local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("default_settings", { clear = true })

autocmd("BufWritePre", {
  group = "default_settings",
  desc = "Remove postspaces",
  callback = function()
    -- Since substitution may lead to the cursor jumping,
    -- I create a mark on the current position, so that I can jump
    -- back to it after removing the postspaces.
    vim.cmd([[
      norm mz
      %s/\s\+$//e
      norm `z
    ]])
  end,
  pattern = "*",
})

autocmd("FileType", {
  group = "default_settings",
  pattern = "*",
  command = "set formatoptions-=cro",
  desc = [[Disable continuation of comments when <CR> (insert mode)
    and o/O (normal) in a comment line"]],
})

augroup("markdown", { clear = true })

autocmd("FileType", {
  group = "markdown",
  pattern = "markdown",
  callback = function()
    vim.cmd([[
      set cc=100
      set wrap
      set showbreak=>>>
      nnoremap j gj
      nnoremap k gk
    ]])
  end,
})

augroup("css", { clear = true })

autocmd("FileType", {
  group = "css",
  pattern = "css",
  callback = function()
    vim.cmd([[
      set foldmethod=syntax
      set foldopen=all
      set foldclose=all
    ]])
  end,
})

augroup("c", { clear = true })

autocmd("FileType", {
  group = "c",
  pattern = "c",
  callback = function()
    vim.cmd([[
      set commentstring=//%s
    ]])
  end,
})

augroup("NvimTree", { clear = true })

autocmd("VimEnter", {
  callback = function(data)
    local directory = vim.fn.isdirectory(data.file) == 1

    if not directory then
      return
    end
    vim.cmd.cd(data.file)
    require("nvim-tree.api").tree.open()
  end,
})

augroup("ToggleTerm", { clear = true })

autocmd("TermOpen", {
  callback = function()
    print("eai!")
    local opts = { buffer = 0, silent = true, remap = false }
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
    -- window moving
    vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  end,
})
