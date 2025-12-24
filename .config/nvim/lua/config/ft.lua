vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "scad",
  callback = function()
    vim.opt.commentstring = "// %s"
  end,
})