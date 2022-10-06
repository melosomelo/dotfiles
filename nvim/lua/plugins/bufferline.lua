require("bufferline").setup({
	options = {
		mode = "tabs", -- only show tabs, not buffers
		diagnostics = "nvim_lsp",
    -- name_formatter - I'll implement this in the future!
    -- diagnostics_indicator - maybe this too
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_default_icon = false,
    show_close_icon = false,
	},
})
