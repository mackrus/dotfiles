return {
    {
        "GCBallesteros/jupytext.nvim",
        dependencies = {
            "kana/vim-textobj-user",
            "preservim/vim-textobj-quote",
        },
        config = function()
            require("jupytext").setup({
                style = "markdown",
                output_extension = "md",
                force_ft = "markdown",
                -- Automatically sync on save
                sync_on_save = true,
            })
        end,
    },
    {
        "benlubas/molten-nvim",
        dependencies = {
            "3rd/image.nvim",
        },
        build = ":UpdateRemotePlugins",
        init = function()
            -- Initialize molten-nvim settings
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
            vim.g.molten_auto_open_output = true
        end,
        config = function()
            vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize Molten" })
            vim.keymap.set("n", "<leader>mr", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "Run Cell" })
            vim.keymap.set("n", "<leader>mc", ":MoltenReevaluateCell<CR>", { silent = true, desc = "Re-run Cell" })
            vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>", { silent = true, desc = "Delete Cell" })
            vim.keymap.set("n", "<leader>mh", ":MoltenHideOutput<CR>", { silent = true, desc = "Hide Output" })
            vim.keymap.set("n", "<leader>ms", ":MoltenShowOutput<CR>", { silent = true, desc = "Show Output" })
            
            -- Jupytext specific conversions
            vim.keymap.set("n", "<leader>jc", function()
                local current_file = vim.fn.expand("%:p")
                if vim.fn.expand("%:e") == "ipynb" then
                    vim.cmd("!jupytext --to md " .. current_file)
                elseif vim.fn.expand("%:e") == "md" then
                    vim.cmd("!jupytext --to notebook " .. current_file)
                end
            end, { silent = true, desc = "Convert Jupyter Format" })
        end,
    }
}

