require("config.settings")
require("config.remap")
require("config.lazy")

local theme_cache = vim.fn.stdpath("data") .. "/last_theme.lua"

local function save_theme()
	local current_theme = vim.g.colors_name
	if current_theme then
		local file = io.open(theme_cache, "w")
		if file then
			file:write('vim.cmd("colorscheme ' .. current_theme .. '")')
			file:close()
		end
	end
end

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("ThemePersistence", { clear = true }),
	callback = save_theme,
})

local f = io.open(theme_cache, "r")
if f then
	f:close()
	pcall(dofile, theme_cache)
end
