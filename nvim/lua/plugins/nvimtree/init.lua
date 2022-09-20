local nvimtree_util = require("plugins.nvimtree.util")

-- disabling netrw
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	disable_netrw = true, -- disable neovims default file explorer
  -- Automatically open tree when buffer is dir, empty or unnamed.
	open_on_setup = true,
  -- Creating a file with the cursor inside a close folder will set the parent
  -- directory to be the closed folder.
	create_in_closed_folder = true,
	hijack_cursor = true, -- Keep the cursor on the first letter of the filename.
  sync_root_with_cwd = true, -- Changes the tree's directory whenever cwd changes.
	view = {
		width = 30,
		side = "right",
		signcolumn = "no",
		mappings = {
			custom_only = true, -- Disregard default mappings and only use custom ones.
			list = {
				{
					key = "l",
					action = "open",
				},
				{
					key = "<C-v>",
					action = "vsplit",
				},
				{
					key = "<C-x>",
					action = "split",
				},
				{
					key = "<Tab>",
					action = "preview",
				},
				{
					key = "d",
					action = "remove",
				},
				{
					key = "r",
					action = "full_rename",
				},
				{
					key = "<C-n>",
					action = "new",
					action_cb = nvimtree_util.create,
				},
				{
					key = "m",
					action = "move",
					action_cb = nvimtree_util.move,
				},
				{
					key = "<C-t>",
					action = "tab",
					action_cb = nvimtree_util.tab,
				},
			},
		},
	},
	renderer = {
		add_trailing = true, -- Add trailing slash to folder names.
		highlight_git = true,
		highlight_opened_files = "name",
		indent_markers = {
			enable = true
		},
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_closed = "",
					arrow_open = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
		special_files = { "Makefile", "README.md", "readme.md", "package.json" },
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	git = {
		enable = true,
		ignore = false, -- Show files even if they are git ignored.
	}
})
