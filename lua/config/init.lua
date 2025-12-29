require("config.settings")
require("config.remap")
require("config.lazy")

local function set_colorscheme(colorscheme)
	colorscheme = colorscheme or vim.g.colorscheme or "default"
	vim.cmd.colorscheme(colorscheme)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

set_colorscheme()
