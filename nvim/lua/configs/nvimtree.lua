return {
	filters = {
		custom = { "^.git" },
	},
	disable_netrw = true, -- disable neovims default file explorer
	hijack_cursor = true, -- Keep the cursor on the first letter of the filename when navigating
	update_focused_file = { -- Update the focused file on BufEnter
		enable = true,
	},
	view = {
		side = "right",
		signcolumn = "no",
	},
	git = {
		enable = true,
		ignore = false, -- Show files even if they are git ignored.
	},
	renderer = {
		add_trailing = true, -- Add trailing slash to folder names.
		highlight_git = true,
		indent_markers = {
			enable = true,
		},
		group_empty = true,
		icons = {
			show = {
				git = true,
				file = true,
				folder = true,
				folder_arrow = true,
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
	actions = {
		open_file = {
			-- Close the explorer whenever opening a file
			quit_on_open = true,
		},
		change_dir = {
			enable = false,
		},
	},
	tab = {
		sync = {
			close = true,
		},
	},
	on_attach = function(bufnr)
		local api = require("nvim-tree.api")

		local function opts(desc)
			return {
				desc = "nvim-tree: " .. desc,
				buffer = bufnr,
				noremap = true,
				silent = true,
				nowait = true,
			}
		end

		vim.keymap.set("n", "l", api.node.open.edit, opts("Open: Edit"))
		vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
		vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
		vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
		vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
		vim.keymap.set("n", "r", api.fs.rename_sub, opts("Rename: Omit Filename"))
		vim.keymap.set("n", "<C-n>", api.fs.create, opts("Create"))
		vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
		vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
		vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
		vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
		vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
		vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
		vim.keymap.set("n", "<ESC>", api.tree.close, opts("Close"))
	end,
}
