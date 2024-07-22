return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
			})
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"Everblush/nvim",
		enabled = false,
		name = "everblush",
		config = function()
			vim.cmd.colorscheme("everblush")
		end,
	},
	{
		"navarasu/onedark.nvim",
		enabled = false,
		opts = {
			style = "darker",
		},
		config = function()
			vim.cmd.colorscheme("onedark")
		end,
	},
	{
		"folke/tokyonight.nvim",
		enabled = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},
}
