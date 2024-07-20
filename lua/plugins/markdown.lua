return {
	{
		"MeanderingProgrammer/markdown.nvim",
		ft = {
			"markdown",
			"text",
			"tex",
			"plaintex",
			"norg",
		},
		name = "render-markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		config = function()
			require("render-markdown").setup({})
		end,
	},
	{
		"bullets-vim/bullets.vim",
		ft = "markdown",
		init = function()
			vim.g.bullets_checkbox_markers = " -x"
		end,
	},
	{
		"hedyhli/outline.nvim",
		ft = {
			"markdown",
			"text",
			"tex",
			"plaintex",
			"norg",
		},
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {},
	},
	{
		"lukas-reineke/headlines.nvim",
		ft = {
			"markdown",
			"text",
			"tex",
			"plaintex",
			"norg",
		},
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true, -- or `opts = {}`
	},
	{
		"toppair/peek.nvim",
		ft = "markdown",
		opts = {
			app = "browser",
		},
		build = "deno task --quiet build:fast",
		keys = {
			{
				"<leader>mp",
				function()
					require("peek").open()
				end,
				desc = "Open live preview",
			},
		},
	},
}
