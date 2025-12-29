return {
  {
    "kaarmu/typst.vim",
    ft = "typst", -- Load only for Typst files
    config = function()
      -- Optional: Enable concealment for italic, bold, math symbols, or emojis
      vim.g.typst_conceal = 1
      vim.g.typst_conceal_math = 1
      vim.g.typst_conceal_emoji = 1
      -- Enable syntax highlighting for embedded languages (e.g., code blocks)
      vim.g.typst_embedded_languages = { "python", "javascript" }
    end,
  },
}
