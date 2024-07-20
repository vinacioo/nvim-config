return {
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
		keys = {
			{
				"<leader><S-t>",
				"<cmd>StartupTime<cr>",
				desc = "Startup time",
			},
		},
	},
	{
		"akinsho/toggleterm.nvim",
		lazy = false,
		cmd = { "ToggleTerm", "TermExec" },
		opts = {
			on_create = function()
				vim.opt.foldcolumn = "0"
				vim.opt.signcolumn = "no"
			end,
		},
		keys = {
			{
				"\\h",
				"<cmd>ToggleTerm direction=horizontal name=Terminal<cr>",
				mode = { "n", "t" },
				desc = "ToggleTerm horizontal",
			},
			{
				"\\f",
				"<cmd>ToggleTerm direction=float name=Terminal<cr>",
				mode = { "n", "t" },
				desc = "ToggleTerm float",
			},
			{
				"\\v",
				"<cmd>ToggleTerm direction=vertical name=Terminal<cr>",
				mode = { "n", "t" },
				desc = "ToggleTerm vertical",
			},
			{ "<ESC>", [[<C-\><C-n>]], mode = "t" },
		},
	},
	-- buffer remove
	{
		"echasnovski/mini.bufremove",
		keys = {
			{
				"<leader>bd",
				function()
					require("mini.bufremove").delete(0, false)
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>bD",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Delete Buffer (Force)",
			},
		},
	},
}
