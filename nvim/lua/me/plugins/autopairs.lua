local npairs = require("nvim-autopairs")

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")

-- add parenthesis when autocompleting with function/method
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

npairs.setup({})
