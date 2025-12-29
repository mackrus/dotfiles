return {
  {
    "tpope/vim-fugitive", -- Git integration for vim gods
    config = function()
      vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", { desc = "Fuzzy switch git branch" })
      vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" })
      vim.keymap.set("n", "<leader>gc", function()
        local msg = vim.fn.input("Commit message: ")
        if msg ~= "" then
          vim.cmd("Git add .")
          vim.cmd("Git commit -m '" .. msg .. "'")
          print("Committed: " .. msg)
        else
          print("No message, no commit, you dingus.")
        end
      end, { desc = "Git commit with message" })
    end,
  },
}

