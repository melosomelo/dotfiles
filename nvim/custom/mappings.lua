---@type MappingsTable
local M = {}

local opts = {
  silent = true,
  remap = false
}

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

M.general = {
  n = {
    [";"] = {
      ":",
      "enter command mode",
      opts = {
        nowait = true
      }
    },
    ["<A-j>"] = {"ddp", "Move current line down", opts},
    ["<A-k>"] = {"ddkP", "Move current line up", opts},
    -- better window navigation
    ["<C-h>"] = {"<C-w>h", "", opts},
    ["<C-j>"] = {"<C-w>j", "", opts},
    ["<C-k>"] = {"<C-w>k", "", opts},
    ["<C-l>"] = {"<C-w>l", "", opts},
    -- better tag navigation
    ["<S-h>"] = {"gT", "Go to previous tab", opts},
    ["<S-l>"] = {"gt", "Go to next tab", opts},
    -- Remap CTRL + U and CTRL + D to Shift+K and Shift+J, respectively
    ["<S-j>"] = {"<C-d>zz", "", opts},
    ["<S-k>"] = {"<C-u>zz", "", opts},
    ["<C-u>"] = {"<nop>", "", opts},
    -- Diagnostics
    ["[d"] = {"<cmd>lua vim.diagnostic.goto_prev()<CR>", "Go to previous diagnostic", opts},
    ["]d"] = {"<cmd>lua vim.diagnostic.goto_prev()<CR>", "Go to next diagnostic", opts},
    ["[e"] = {"<cmd>lua vim.diagnostic.goto_prev({severity=vim.diagnostic.severity.ERROR})<CR>",
              "Go to previous error diagnostic", opts},
    ["]e"] = {"<cmd>lua vim.diagnostic.goto_prev({severity=vim.diagnostic.severity.ERROR})<CR>",
              "Go to next error diagnostic", opts},
    --  format with conform
    ["<leader>fm"] = {function()
      require("conform").format()
    end, "formatting"}
  },
  v = {
    [">"] = {">gv", "indent"}
  }
}

-- more keybinds!

M.lspconfig = {
  n = {
    ["<leader>h"] = {"<cmd>lua vim.lsp.buf.hover()<cr>", "LSP hover", opts},
    ["<leader>rn"] = {"<cmd>lua vim.lsp.buf.rename()<cr>", "LSP rename", opts},
    ["<leader>d"] = {"<cmd>lua vim.lsp.buf.definition()<cr>", "Go to LSP def", opts}
  }
}

M.nvimtree = {
  n = {
    ["<C-d>"] = {"<cmd>NvimTreeToggle<CR>", "Toggle nvimtree", opts}
  }
}

M.telescope = {
  n = {
    ["<C-p>"] = {"<cmd>lua require('telescope.builtin').find_files({hidden = true, no_ignore=true})<cr>",
                 "Open Telescope file picker", opts},
    ["<C-S-p>"] = {"<cmd>lua require('telescope.builtin').live_grep()<cr>", "Open Telescope live grep", opts}
  }
}

return M
