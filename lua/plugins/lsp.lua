return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "<leader>hv", function()
						vim.lsp.buf.hover({ border = "rounded" })
					end, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
					vim.keymap.set("n", "<leader>er", function()
						local _opts = {
							focusable = false,
							close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
							border = "rounded",
							source = "always",
							prefix = " ",
							scope = "cursor",
						}
						vim.diagnostic.open_float(nil, _opts)
					end)
				end,
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
					"asm_lsp",
					"bashls",
				},
				automatic_enable = {
					exclude = { "rust_analyzer", "bashls" },
				},
			})
			require("lspconfig").rust_analyzer.setup({
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							checkOnSave = {
								command = "clippy",
							},
						},
					},
				},
			})

			require("lspconfig").bashls.setup({
				filetypes = { "sh", "zsh" },
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					rust = { "rustfmt", lsp_format = "fallback" },
					bash = { "shfmt" },
					c = { "clang-format" },
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					json = { "prettierd" },
					cpp = { "clang-format" },
					go = { "gofmt" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
					quiet = true,
				},
				formatters = {
					prettierd = {
						env = {
							PRETTIERD_DEFAULT_CONFIG = vim.fn.expand(
								vim.fn.stdpath("config") .. "/utils/.prettierrc.json"
							),
						},
					},
					["clang-format"] = {
						prepend_args = {
							"--style=file:" .. vim.fn.expand(vim.fn.stdpath("config") .. "/utils/.clang-format"),
						},
					},
				},
			})
		end,
	},
	{
		"zapling/mason-conform.nvim",
		config = function()
			require("mason-conform").setup({
				ignore_install = { "rustfmt" },
			})
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
