-- changing the signs of diagnostics in the sign column
local diagnostics = {
  {severity = "Error", icon = ""},
  {severity = "Warn", icon = ""},
  {severity = "Info", icon = ""},
  {severity = "Hint", icon = ""}
}

for i = 1, #diagnostics do
  local hl = "DiagnosticSign" .. diagnostics[i].severity
	vim.fn.sign_define(hl, {
		text = diagnostics[i].icon,
		texthl = hl,
		numhl = hl,
	})
end


-- global configurations for diagnostics
vim.diagnostic.config({
	virtual_text = { format = function (diagnostic)
   local icon = diagnostics[diagnostic.severity].icon
	 return string.format("%s %s", icon, diagnostic.message)
	end,
  prefix = ""},
	signs = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})
