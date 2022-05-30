local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require "cmp"
local luasnip = require "luasnip"

cmp.setup {
  snippet = {
    expand = function(args)
      require"luasnip".lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-Space>"] = cmp.mapping.complete(), -- toggle completion
    -- overloads tab and shift-tab to scroll through the autocompletion options
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {"i", "s"}),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {"i", "s"})
  },
  sources = cmp.config.sources {{
    name = "nvim_lsp" -- autocompletion from lsp servers
  }, {
    name = "luasnip" -- autocompletion from snippet engine (will do more later)
  }, {
    name = "buffer" -- autocompletion with words from the current buffer.
  }, {
    name = "path" -- autocompletion for filesystem paths.
  }}
}
