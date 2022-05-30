local cmp = require "cmp"
local luasnip = require "luasnip"


local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- icons that will appear in the cmp menu
local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

cmp.setup {
  -- autocomplete = false, -- only invoke autocompletion manually?
  snippet = { -- required snippet engine
    expand = function(args)
      require "luasnip".lsp_expand(args.body)
    end
  },
  window = {
    -- gives some cute borders to windows
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- toggle completion
    ['<CR>'] = cmp.mapping.confirm({
      select = true
    }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<C-e>"] = function(fallback) -- aborts autocompletion
      if cmp.visible() then
        cmp.abort()
      else
        fallback()
      end
    end,
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
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" })
  },
  sources = cmp.config.sources { { -- possible sources for autocompletion
    name = "nvim_lsp" -- autocompletion from lsp servers
  }, {
    name = "luasnip" -- autocompletion from snippet engine (will do more later)
  }, {
    name = "buffer" -- autocompletion with words from the current buffer.
  }, {
    name = "path" -- autocompletion for filesystem paths.
  } },
  formatting = { -- for formatting the items that appear in the complete menu
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        path = "[Path]",
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]"
      })[entry.source.name]
      return vim_item
    end
  }
}
