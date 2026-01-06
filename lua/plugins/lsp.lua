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
					"texlab",
				},
				automatic_enable = {
					exclude = { "rust_analyzer", "bashls" },
				},
			})
			vim.lsp.config["rust_analyzer"] = {
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							checkOnSave = {
								command = "clippy",
							},
						},
					},
				},
			}
			vim.lsp.enable("rust_analyzer")

			vim.lsp.config["bashls"] = {
				filetypes = { "sh", "zsh" },
			}
			vim.lsp.enable("bashls")
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					rust = { "rustfmt" },
					bash = { "shfmt" },
					c = { "clang-format" },
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					javascriptreact = { "prettierd" },
					typescriptreact = { "prettierd" },
					html = { "prettierd" },
					json = { "prettierd" },
					cpp = { "clang-format" },
					go = { "gofmt" },
					xml = { "xmlformatter" },
					java = {
						"google-java-format",
					},
					tex = {
						"tex-fmt",
					},
					bib = { "bibtex-tidy" },
				},
				format_on_save = {
					timeout_ms = 3000,
					lsp_format = "fallback",
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
					["google-java-format"] = {
						prepend_args = { "--aosp" },
					},
					["xmlformatter"] = {
						prepend_args = { "--indent", "4" },
					},
					["tex-fmt"] = {
						prepend_args = { "--tabsize", "4" },
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
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_compiler_latexmk_engines = {
				_ = "-xelatex",
			}
			vim.g.vimtex_compiler_latexmk = {
				out_dir = "build",
			}
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_quickfix_mode = 0
		end,
	},
}
