return {
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended to pin to a version
		lazy = false, -- Load immediately for Rust files
		ft = { "rust" }, -- Load for Rust filetypes
		config = function()
			vim.g.rustaceanvim = {
				-- Server settings for rust-analyzer
				server = {
					capabilities = vim.lsp.protocol.make_client_capabilities(),
					on_attach = function(client, bufnr)
						-- Reuse existing LSP keymaps from lsp.lua
						local opts = { buffer = bufnr }
						-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
						-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
						-- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
						-- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
						-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
						-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
						-- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
						-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
						-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
						-- vim.keymap.set("n", "<leader>er", vim.diagnostic.open_float, opts)
						-- vim.keymap.set("n", "<leader>di", vim.diagnostic.setloclist, opts)
						-- Disable rustaceanvim's formatting to use conform.nvim
						client.server_capabilities.documentFormattingProvider = false
					end,
					settings = {
						["rust-analyzer"] = {
							check = {
								command = "clippy", -- Use clippy for diagnostics
							},
							diagnostics = {
								enable = true,
								experimental = { enable = true },
							},
						},
					},
				},
			}
		end,
	},
}
