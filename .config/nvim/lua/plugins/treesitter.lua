return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "python",
                    "markdown",
                    "markdown_inline",
                    "lua",
                    "typst",
                     "css",
                     "html",
                     "javascript",
                     "latex",
                     "norg",
                     "scss",
                     "svelte",
                     "tsx",
                     "vue",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "markdown" },
                },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<leader>v",
                        node_incremental = "<leader>vi",
                        node_decremental = "<leader>vd",
                        scope_incremental = "<leader>vc",
                    },
                },
            })
        end,
    },
}

