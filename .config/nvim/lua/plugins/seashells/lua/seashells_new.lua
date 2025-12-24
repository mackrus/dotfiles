local M = {}

-- Define the Snacks palette
local colors = {
	black = "#2D2A2E",
	bright_black = "#434b53",
	red = "#FC8181",
	bright_red = "#d48678",
	green = "#A8CC8C",
	bright_green = "#628d98",
	yellow = "#DBAB79",
	bright_yellow = "#fdd39f",
	blue = "#6A95E9",
	bright_blue = "#1bbcdd",
	magenta = "#D3A7EE",
	bright_magenta = "#bbe3ee",
	cyan = "#95C6E9",
	bright_cyan = "#87acb4",
	white = "#D9D7D6",
	bright_white = "#fee4ce",
	bg = "#2D2A2E",
	fg = "#D9D7D6",
	cursor = "#fca02f",
	cursor_text = "#08131a",
	selection_bg = "#3B4252",
	selection_fg = "#fee4ce",
}

-- Function to set highlight groups
M.setup = function()
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
	vim.g.colors_name = "seashells"
	vim.o.background = "dark"
	local set_hl = vim.api.nvim_set_hl
	set_hl(0, "Normal", { fg = colors.fg, bg = "NONE" })
	set_hl(0, "NormalFloat", { fg = colors.fg, bg = colors.selection_bg })
	set_hl(0, "Comment", { fg = colors.white, italic = true })
	set_hl(0, "Constant", { fg = colors.red })
	set_hl(0, "String", { fg = colors.green })
	set_hl(0, "Identifier", { fg = colors.cyan })
	set_hl(0, "Function", { fg = colors.bright_cyan })
	set_hl(0, "Statement", { fg = colors.yellow, bold = true })
	set_hl(0, "Conditional", { fg = colors.bright_yellow, bold = true })
	set_hl(0, "PreProc", { fg = colors.magenta })
	set_hl(0, "Type", { fg = colors.bright_blue })
	set_hl(0, "Special", { fg = colors.bright_red })
	set_hl(0, "Underlined", { fg = colors.bright_blue, underline = true })
	set_hl(0, "Todo", { fg = colors.bg, bg = colors.yellow, bold = true })
	set_hl(0, "Error", { fg = colors.red, bg = colors.bg, bold = true })
	set_hl(0, "Visual", { bg = colors.selection_bg })
	set_hl(0, "VisualNOS", { bg = colors.selection_bg })
	set_hl(0, "Cursor", { fg = colors.cursor_text, bg = colors.cursor })
	set_hl(0, "CursorLine", { bg = colors.selection_bg })
	set_hl(0, "CursorLineNr", { fg = colors.yellow, bold = true })
	set_hl(0, "LineNr", { fg = colors.bright_black })
	set_hl(0, "Pmenu", { fg = colors.fg, bg = colors.selection_bg })
	set_hl(0, "PmenuSel", { fg = colors.selection_fg, bg = colors.blue })
	set_hl(0, "PmenuSbar", { bg = colors.black })
	set_hl(0, "PmenuThumb", { bg = colors.black })
	set_hl(0, "StatusLine", { fg = colors.fg, bg = colors.selection_bg })
	set_hl(0, "StatusLineNC", { fg = colors.bright_black, bg = colors.selection_bg })
	set_hl(0, "VertSplit", { fg = colors.bright_white })
	set_hl(0, "WinSeparator", { fg = colors.bright_white })
	set_hl(0, "Search", { fg = colors.fg, bg = colors.bright_yellow })
	set_hl(0, "IncSearch", { fg = colors.bg, bg = colors.bright_yellow })
	set_hl(0, "MatchParen", { fg = colors.magenta, bg = colors.selection_bg, bold = true })
	set_hl(0, "LazyButton", { fg = colors.fg, bg = colors.selection_bg })
	set_hl(0, "LazyButtonActive", { fg = colors.fg, bg = colors.yellow, bold = true })
	set_hl(0, "LazyH1", { fg = colors.red, bold = true })
	set_hl(0, "LazySpecial", { fg = colors.bright_cyan })
	set_hl(0, "Keyword", { fg = colors.yellow, bold = true })
	set_hl(0, "Operator", { fg = colors.bright_white })
	set_hl(0, "Delimiter", { fg = colors.bright_white })
end

return M
