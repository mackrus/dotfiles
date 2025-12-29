return {
  {
    "nomnivore/ollama.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- Optional: for fuzzy-finding prompt selector
    },
    cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
    keys = {
      { "<leader>c", ":<c-u>lua require('ollama').prompt()<cr>", desc = "Ollama Prompt Menu", mode = { "n", "v" } },

    },
    opts = {
      model = "qwen3:0.6b", 
      url = "http://127.0.0.1:11434",
      promts = {
      prompt = "Refactor this code for better readability: $input",
      action = "replace",
    },
    Explain_Code = {
      prompt = "Explain this code in simple terms: $input",
      action = "display",
      },
    },
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy", 
    opts = {
      input = { enabled = true },
      select = {
        enabled = true,
        backend = { "telescope", "fzf", "builtin" }, 
      },
    },
  },
}
