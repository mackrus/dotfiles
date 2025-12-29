return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          theme = "auto", -- Sync with your colorscheme (e.g., in ghostty)
          globalstatus = true, -- Single statusline for all windows
          component_separators = { left = "│", right = "│" }, -- Clean separators
          section_separators = { left = "", right = "" }, -- Minimalist, no fancy arrows
          disabled_filetypes = { statusline = { "lazy", "dashboard" } }, -- Disable for LazyVim dashboard
        },
        sections = {
          lualine_a = { -- Mode (shortened for minimalism)
            {
              "mode",
              fmt = function(str) return str:sub(1, 1) end, -- Show only first letter (N, I, V)
            },
          },
          lualine_b = { -- Git branch and diff
            {
              "branch",
              icon = "", -- Nerd Font icon for Git
              fmt = function(str) return str:sub(1, 15) end, -- Truncate long branch names
            },
            { "diff", symbols = { added = "+", modified = "~", removed = "-" } },
          },
          lualine_c = { -- File info
            {
              "filename",
              path = 1, -- Show relative path
              symbols = { modified = "●", readonly = "🔒", unnamed = "[No Name]" },
            },
            { "filetype", icon_only = true }, -- Show filetype icon (e.g., Typst)
          },
          lualine_x = { -- LSP diagnostics and status
            {
              "diagnostics",
              sources = { "nvim_lsp" },
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
            },
            {
              function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then return "" end
                local names = {}
                for _, client in ipairs(clients) do
                  table.insert(names, client.name)
                end
                return "LSP:" .. table.concat(names, ",")
              end,
              cond = function() return vim.bo.filetype == "typst" end, -- Show LSP for Typst
            },
          },
          lualine_y = { -- File encoding and format
            { "encoding" },
            { "fileformat", icons_enabled = true }, -- No icons for simplicity
          },
          lualine_z = { -- Cursor position
            { "location", padding = { left = 1, right = 1 } },
            { "progress", padding = { left = 0, right = 1 } },
          },
        },
        inactive_sections = { -- For inactive windows
          lualine_a = {client},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },
}
