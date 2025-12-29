return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPost", "BufWritePre" }, -- Load early
		cmd = { "Format", "ConformInfo" }, -- Explicitly register commands
		opts = {
			formatters_by_ft = {
				python = { "ruff_format" },
				lua = { "stylua" },
				typst = { "typstyle" },
				rust = { "rustfmt" },
				nush = { "nu" },
				sh = { "shfmt" },
			},
			formatters = {
				ruff_format = {
					command = "ruff",
					args = { "format", "--quiet", "--stdin-filename", "$FILENAME", "-" },
					stdin = true,
				},
				nu = {
					command = "nu",
					args = { "--stdin", "format", "nu" },
					stdin = true,
				},

				shfmt = {
					command = "shfmt",
					args = { "-i", "2" },
					stdin = true,
				},
			},
			format_on_save = { -- Auto-format for testing
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
		config = function(_, opts)
			require("conform").setup(opts) -- Force setup
		end,

		vim.keymap.set("n", "<leader>lf", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, { desc = "Format buffer" }),

		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = { ".zshrc", ".zshenv", "*.zsh" },
			callback = function()
				vim.bo.filetype = "sh"
			end,
		}),
	},
}
