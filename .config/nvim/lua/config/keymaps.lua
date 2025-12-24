------------------------------------------------------------
-------- Basics --------------------------------------------
------------------------------------------------------------
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>s", "<cmd>wq<cr>", { desc = "Save and Quit" })
vim.keymap.set("n", "<leader>a", "ggVG", { desc = "Select all text in buffer" })
vim.keymap.set("n", "<leader>dm", "<cmd>delm!<cr>", { desc = "Delete all local marks in buffer" })

-- Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Global yank for debugging
vim.keymap.set("n", "<leader>y", function()
	local content = vim.fn.getline(1, "$")
	content = table.concat(content, "\n")
	content = content:gsub("markusbajlo", "user")
	vim.fn.setreg("+", content) -- Use + for system clipboard
	print("Yanked file to clipboard")
end, { desc = "Yank file with markusbajlo -> user" })

------------------------------------------------------------
---------Typst----------------------------------------------
------------------------------------------------------------
vim.keymap.set("n", "<leader>wt", "<cmd>write | TypstWatch<cr>", { desc = "Watch Typst document" })

------------------------------------------------------------
-------- General --------------------------------------------
------------------------------------------------------------
vim.keymap.set("n", "<leader>m", "<cmd>write | make<cr>", { desc = "Compile and check for errors" })