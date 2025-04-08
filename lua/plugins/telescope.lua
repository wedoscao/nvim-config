return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
	config = function()
		local arg = vim.fn.argv()[1]
		if arg ~= nil then
			local dir_path = arg
			if vim.fn.filereadable(arg) == 1 then
				dir_path = vim.fs.dirname(arg)
			end
			vim.fn.chdir(dir_path)
		end
		require("telescope").setup({})
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>fe", builtin.diagnostics, {})
	end,
}
