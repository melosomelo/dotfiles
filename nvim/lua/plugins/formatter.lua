local prettier_filetypes = {
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"markdown",
	"css",
	"html",
}

local filetype_table = {
	lua = {
		require("formatter.filetypes.lua").stylua,
	},
}

for _, ft in ipairs(prettier_filetypes) do
	filetype_table[ft] = require("formatter.filetypes." .. ft).prettier
end

require("formatter").setup({
	filetype = filetype_table,
})
