return {
  -- Install mini.diff
  {
    "echasnovski/mini.diff",
    version = false,
    config = function()
      require("mini.diff").setup({
        view = {
          style = "sign",
          signs = { add = "➕", change = "🔄", delete = "➖" },
        },
        mappings = {
          goto_prev = "[h",
          goto_next = "]h",
        },
      })
    end,
  },
}
