return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.general = {
				positionEncodings = { "utf-16" },
			}

			-- Find project root and .venv
			local function find_project_root()
				local path = vim.fn.expand("%:p:h")
				while path ~= "/" do
					if vim.fn.isdirectory(path .. "/.venv") == 1 then
						local python_path = path .. "/.venv/bin/python"
						if vim.fn.executable(python_path) == 1 then
							return path, python_path
						end
					elseif
						vim.fn.filereadable(path .. "/pyproject.toml") == 1
						or vim.fn.isdirectory(path .. "/.git") == 1
					then
						return path, nil
					end
					path = vim.fn.fnamemodify(path, ":h")
				end
				return vim.fn.getcwd(), nil
			end

			-- Get uv’s Python path
			local function get_uv_python()
				local handle = io.popen("uv run which python3 2>/dev/null")
				local result = handle:read("*a")
				handle:close()
				return result:match("^%s*(.-)%s*$") or vim.fn.exepath("python3")
			end

			-- Ruff setup (linting/formatting only, no hover)
			vim.lsp.config.ruff = {
				filetypes = { "python" },
				root_dir = select(1, find_project_root),
				settings = {
					pythonPath = select(2, find_project_root()) or get_uv_python(),
					lint = {
						select = { "E", "F", "B", "I" },
						ignore = {},
						perFileIgnores = {},
						isort = { knownFirstParty = {} },
					},
				},
				init_options = {
					settings = {
						args = { "--config", vim.fn.expand("~/.config/ruff/ruff.toml") },
					},
				},
				capabilities = capabilities,
				-- capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
				-- 	textDocument = {
				-- 		publishDiagnostics = { enabled = true },
				-- 	},
				-- }),
				on_attach = function(client, bufnr)
					client.server_capabilities.hoverProvider = true
					-- Ensure hover keybinding
					vim.api.nvim_buf_set_keymap(
						bufnr,
						"n",
						"K",
						"<cmd>lua vim.lsp.buf.hover()<CR>",
						{ noremap = true, silent = true }
					)
					-- Debugging: Print when Ruff attaches
					print("Ruff LSP attached to buffer " .. bufnr)
				end,
			}

			-- Pyright setup (handles hover)
			-- vim.lsp.config.pyright = {
			-- 	filetypes = { "python" },
			-- 	root_dir = select(1, find_project_root),
			-- 	settings = {
			-- 		python = {
			-- 			pythonPath = select(2, find_project_root()) or get_uv_python(),
			-- 			analysis = {
			-- 				autoSearchPaths = true,
			-- 				useLibraryCodeForTypes = true,
			-- 				diagnosticMode = "openFilesOnly",
			-- 				typeCheckingMode = "basic",
			-- 			},
			-- 		},
			-- 	},
			-- 	before_init = function()
			-- 		vim.env.NODE_OPTIONS = "--max-old-space-size=4096"
			-- 	end,
			-- 	capabilities = capabilities,
			-- 	on_attach = function(client, bufnr)
			-- 		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Hover" })
			-- 	end,
			--
			-- Minimal Pyright setup (hover only)
			vim.lsp.config.pyright = {
				filetypes = { "python" },
				-- root_dir = select(1, find_project_root),
				settings = {
					python = {
						pythonPath = select(2, find_project_root()) or get_uv_python(),
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = false, -- Minimize memory usage
							diagnosticMode = "off", -- Disable diagnostics
							typeCheckingMode = "off", -- Disable type checking
						},
					},
				},
				capabilities = vim.tbl_deep_extend("force", capabilities, {
					textDocument = {
						hover = { enabled = true },
						-- Disable everything else
						completion = { enabled = false },
						signatureHelp = { enabled = false },
						declaration = { enabled = false },
						definition = { enabled = false },
						implementation = { enabled = false },
						references = { enabled = false },
						documentHighlight = { enabled = false },
						codeAction = { enabled = false },
						rename = { enabled = false },
						publishDiagnostics = { enabled = false },
					},
					workspace = {
						symbol = { enabled = false },
					},
				}),
				-- on_attach = function(client, bufnr)
				-- 	-- Disable all capabilities except hover
				-- 	client.server_capabilities = {
				-- 		hoverProvider = true,
				-- 		completionProvider = false,
				-- 		signatureHelpProvider = false,
				-- 		declarationProvider = false,
				-- 		definitionProvider = false,
				-- 		implementationProvider = false,
				-- 		referencesProvider = false,
				-- 		documentHighlightProvider = true,
				-- 		codeActionProvider = false,
				-- 		renameProvider = false,
				-- 		publishDiagnostics = false,
				-- 		workspace = { symbolProvider = false },
				-- 	}
				-- 	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Hover" })
				-- 	-- Debugging: Print when Pyright attaches
				-- 	print("Pyright LSP attached to buffer " .. bufnr)
				-- end,
			}

			-- -- Tinymist setup
			-- vim.lsp.config.tinymist = {
			-- 	settings = {
			-- 		exportPdf = "onType",
			-- 	},
			-- 	filetypes = { "typst" },
			-- 	root_dir = select(1, find_project_root),
			-- 	capabilities = capabilities,
			-- }

			-- Tinymist setup (updated)
			vim.lsp.config.tinymist = {
				filetypes = { "typst" },
				root_dir = function(fname)
					-- Look for typst.toml or .git
					local root = vim.fs.dirname(
						vim.fs.find({ "typst.toml", ".git" }, { upward = true, path = vim.fs.dirname(fname) })[1]
					)
					return root or vim.fn.getcwd()
				end,
				settings = {
					exportPdf = "onSave", -- Changed from onType to reduce load
					formatterMode = "typstyle", -- Enable typstyle formatting
				},
				capabilities = vim.tbl_deep_extend("force", capabilities, {
					textDocument = {
						positionEncoding = "utf-16", -- Explicitly set encoding
						synchronization = {
							didSave = true,
							willSave = false,
							willSaveWaitUntil = false,
						},
					},
				}),
				on_attach = function(client, bufnr)
					-- Force full sync to avoid incremental sync issues
					client.server_capabilities.textDocumentSync = vim.lsp.protocol.TextDocumentSyncKind.Full
					print("Tinymist LSP attached to buffer " .. bufnr)
				end,
			}

			-- Manual start for Tinymist
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "typst",
				callback = function(args)
					local config = vim.lsp.config.tinymist
					if config then
						-- Create a copy to avoid modifying the original config
						local client_config = vim.deepcopy(config)
						client_config.name = "tinymist"

						-- Resolve root_dir if it's a function
						if type(client_config.root_dir) == "function" then
							client_config.root_dir = client_config.root_dir(vim.api.nvim_buf_get_name(args.buf))
						end

						-- Fallback if root_dir is nil
						if not client_config.root_dir then
							client_config.root_dir = vim.fn.getcwd()
						end

						vim.lsp.start(client_config)
					end
				end,
			})

			-- Manual start for Python servers (Ruff, Pyright)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "python",
				callback = function(args)
					local servers = { "ruff", "pyright" }
					for _, server_name in ipairs(servers) do
						local config = vim.lsp.config[server_name]
						if config then
							-- Create a copy to avoid modifying the original config
							local client_config = vim.deepcopy(config)
							client_config.name = server_name

							-- Resolve root_dir if it's a function
							if type(client_config.root_dir) == "function" then
								client_config.root_dir = client_config.root_dir(vim.api.nvim_buf_get_name(args.buf))
							end

							-- Fallback if root_dir is nil
							if not client_config.root_dir then
								client_config.root_dir = vim.fn.getcwd()
							end

							vim.lsp.start(client_config)
						end
					end
				end,
			})

			-- Diagnostic config
			vim.diagnostic.config({
				virtual_text = false,
				signs = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- LSP keybindings
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local opts = { buffer = bufnr }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
					vim.keymap.set("n", "<leader>er", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "<leader>di", vim.diagnostic.setloclist, opts)
				end,
			})

			-- Python interpreter check
			vim.keymap.set("n", "<leader>pi", function()
				local clients = vim.lsp.get_clients({ name = "ruff" })
				if #clients > 0 then
					local settings = clients[1].config.settings or {}
					print("Ruff pythonPath: " .. (settings.pythonPath or "nil"))
				else
					print(clients)
				end
				-- clients = vim.lsp.get_clients({ name = "pyright" })
				-- if #clients > 0 then
				-- 	local settings = clients[1].config.settings or {}
				-- 	print("Pyright pythonPath: " .. (settings.python and settings.python.pythonPath or "nil"))
				-- else
				-- 	print("No Pyright client found")
				-- end
			end, { desc = "Show Python interpreter" })
		end,
	},
}
