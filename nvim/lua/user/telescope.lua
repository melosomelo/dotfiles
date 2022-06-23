local telescope = require("telescope")

telescope.setup({
	defaults = {
		scroll_strategy = "limit",
		initial_mode = "normal",
		file_ignore_patterns = {
			".git/",
		},
	},
})
