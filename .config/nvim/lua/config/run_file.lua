vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		local function run_file()
			vim.cmd("update")
			local filetype = vim.bo.filetype
			local file = vim.fn.expand("%:p")
			
			-- Table defining how to run each filetype
			-- Each entry can be a string (command) or a function returning a string/nil
			local commands = {
				rust = "cargo run",
				go = "go run " .. vim.fn.shellescape(file),
				javascript = "node " .. vim.fn.shellescape(file),
				sh = "bash " .. vim.fn.shellescape(file),
				zsh = "zsh " .. vim.fn.shellescape(file),
				nu = "nu " .. vim.fn.shellescape(file),
				java = "java " .. vim.fn.shellescape(file),
				tex = "pdflatex -shell-escape " .. vim.fn.shellescape(file),
							typescript = function()
								local ts_node = vim.fn.exepath("ts-node")
								local deno = vim.fn.exepath("deno")
								if ts_node ~= "" then
										return ts_node .. " " .. vim.fn.shellescape(file)
								elseif deno ~= "" then
										return deno .. " run " .. vim.fn.shellescape(file)
								else
										vim.notify("No typescript runner found (ts-node/deno)", vim.log.levels.WARN)
										return nil
								end
							end,

				python = function()
					local uv_path = vim.fn.exepath("uv")
					if uv_path == "" then
						return "python3 " .. vim.fn.shellescape(file)
					else
						return uv_path .. " run python " .. vim.fn.shellescape(file)
					end
				end,

				typst = function()
					if vim.fn.exists(":TypstPreview") > 0 then
						vim.cmd("TypstPreview")
					else
						vim.notify("TypstPreview command not found", vim.log.levels.ERROR)
					end
					return nil -- Command handled internally
				end,

				lua = function()
					vim.cmd("source " .. file)
					vim.notify("Lua sourced: " .. file, vim.log.levels.INFO)
					return nil -- Command handled internally
				end,
			}

			local cmd_entry = commands[filetype]
			local cmd = nil

			if type(cmd_entry) == "function" then
				cmd = cmd_entry()
			elseif type(cmd_entry) == "string" then
				cmd = cmd_entry
			else
				vim.notify("No run command for filetype: " .. filetype, vim.log.levels.WARN)
				return
			end

			if cmd then
				vim.cmd("botright vsplit")
				vim.cmd("term " .. cmd)
				vim.cmd("startinsert")
			end
		end

		vim.keymap.set("n", "<leader>r", run_file, { desc = "Run file", noremap = true, silent = true })

		-- Easy exit from terminal mode with <Esc><Esc>
		vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode", noremap = true, silent = true })
	end,
})