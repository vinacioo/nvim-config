return {
	--  +------------------------------------------------------------------------------+
	--  |                                 Colorshemes                                  |
	--  +------------------------------------------------------------------------------+
	{
		"AlexvZyl/nordic.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").load()
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "nordic",
				callback = function()
					vim.cmd("highlight FoldColumn guibg=#242933")
					vim.cmd("highlight BqfPreviewBorder guifg=#191D24 guibg=#191D24")
					vim.cmd("highlight FloatBorder guifg=#191D24 guibg=NONE")
					vim.cmd("highlight BqfPreviewFloat guibg=#191D24")
				end,
			})
		end,
	},
	{
		"catppuccin/nvim",
		enabled = true,
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		opts = {},
	},
	{
		"gmr458/vscode_modern_theme.nvim",
		lazy = false,
		enabled = true,
		priority = 1000,
		config = function()
			require("vscode_modern").setup({
				cursorline = true,
				transparent_background = false,
				nvim_tree_darker = true,
			})
			vim.cmd.colorscheme("vscode_modern")
		end,
	},
	{
		"lunarvim/horizon.nvim",
		enabled = true,
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"Johan-Palacios/onedarker",
		enabled = true,
		priority = 1000,
		lazy = false,
		config = function()
			vim.cmd.colorscheme("onedarker")
		end,
	},
	{
		"Mofiqul/vscode.nvim",
		enabled = true,
		lazy = false,
		config = function()
			require("vscode").setup({}) -- optional, see configuration section.
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		enabled = true,
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		-- priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
				-- ...
			})
		end,
	},
	{
		"marko-cerovac/material.nvim",
		enabled = true,
		lazy = false,
		opts = {},
	},
	--  +------------------------------------------------------------------------------+
	--  |                              Theme Switcher                                  |
	--  +------------------------------------------------------------------------------+

	{
		"andrew-george/telescope-themes",
		lazy = false,
		enabled = true,
		config = function()
			require("telescope").setup({
				extensions = {
					themes = {
						persist = {
							enabled = true,
							path = vim.fn.stdpath("config") .. "/lua/utils/set-colorscheme.lua",
						},
					},
				},
			})
			require("telescope").load_extension("themes")
			require("utils.set-colorscheme")
		end,
		keys = {
			{ "<leader>th", "<cmd>Telescope themes<cr>", desc = "Telescope themes" },
		},
	},
	--  +------------------------------------------------------------------------------+
	--  |                                 Colorizer                                    |
	--  +------------------------------------------------------------------------------+
	{
		"norcalli/nvim-colorizer.lua",
		event = { "BufAdd *.*", "VeryLazy" },
		config = function()
			require("colorizer").setup()
		end,
	},
}
