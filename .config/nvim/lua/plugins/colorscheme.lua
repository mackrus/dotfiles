return {
	{
		"local/seashells",
		dir = vim.fn.stdpath("config") .. "/lua/plugins/seashells",
		name = "seashells",
		lazy = false,
		priority = 1000,
		config = function()
			vim.o.termguicolors = true
			require("seashells").setup()
		end,
	},
	-- {
	-- "projekt0n/github-nvim-theme",
	-- name = "github-theme",
	-- lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- priority = 1000, -- make sure to load this before all the other start plugins
	-- config = function()
	-- 	require("github-theme").setup({
	-- 		-- ...
	-- 	})
	--
	-- 	vim.cmd("colorscheme github_dark_colorblind")
	-- 	end,
	-- },
}
