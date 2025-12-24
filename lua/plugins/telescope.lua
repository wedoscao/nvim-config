return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
	config = function()
		local arg = vim.fn.argv()[1]
		if arg ~= nil then
			local path = arg
			if vim.fn.filereadable(arg) == 1 then
				path = vim.fs.dirname(arg)
			end
			if vim.fn.isdirectory(path) ~= 0 then
				vim.fn.chdir(path)
			end
		end
		local config = {
			-- 1. Configuration for file finders (e.g., :Telescope find_files)
			file_ignore_patterns = {
				"%.png$",
				"%.jpg$",
				"%.jpeg$",
				"%.gif$",
				"%.webp$",
				"%.ico$",
				"%.svg$",
				-- Add any other extensions you want to ignore
			},

			-- 2. Configuration for live text searching (e.g., :Telescope live_grep)
			-- This modifies the arguments passed to 'ripgrep' (rg)
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--type-not", -- Tells rg to exclude a file type
				"image", -- The file type defined by rg (includes jpg, png, gif, etc.)
			},
		}
		require("telescope").setup(config)
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>fe", builtin.diagnostics, {})
	end,
}
