return {
	--------------------
	-- Surround
	--------------------
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	--------------------
	-- Miltiline
	--------------------
	{
		"smoka7/multicursors.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvimtools/hydra.nvim",
		},
		opts = {},
		cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
		keys = {
			{
				mode = { "v", "n" },
				"<Leader>ml",
				"<cmd>MCstart<cr>",
				desc = "Create a selection for selected text or word under the cursor",
			},
		},
	},
	--------------------
	-- Auto Pair
	--------------------
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		opts = {
			mappings = {
				["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\`].", register = { cr = false } },
			},
		},
		config = function(_, opts)
			require("mini.pairs").setup(opts)
		end,
	},
	--------------------
	-- Comments
	--------------------
	{
		"LudoPinelli/comment-box.nvim",
		event = "VeryLazy",
		opts = {
			doc_width = 100,
			box_width = 80,
		},
		keys = {
			{ "gcB", "<cmd>CBccbox10<CR>", desc = "Comment box ascii" },
		},
	},
	{
		"numToStr/Comment.nvim",
		event = "BufReadPost",
		opts = {
			ignore = "^$",
		},
		keys = {
			{ "gcc", "<Plug>(comment_toggle_linewise_current)" },
			{ "gbc", "<Plug>(comment_toggle_blockwise)" },
		},
	},
	-- -- todo comments
	-- {
	-- 	"folke/todo-comments.nvim",
	-- 	cmd = { "TodoTrouble", "TodoTelescope" },
	-- 	event = "BufReadPost",
	-- 	config = true,
	-- 	keys = {
	-- 		{
	-- 			"]t",
	-- 			function()
	-- 				require("todo-comments").jump_next()
	-- 			end,
	-- 			desc = "Next todo comment",
	-- 		},
	-- 		{
	-- 			"[t",
	-- 			function()
	-- 				require("todo-comments").jump_prev()
	-- 			end,
	-- 			desc = "Previous todo comment",
	-- 		},
	-- 		{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find Todo" },
	-- 	},
	-- },
	--------------------
	-- Code outline
	--------------------
	{
		"stevearc/aerial.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>o", "<cmd>AerialToggle<cr>", desc = "Toggle code outline window" },
		},
		opts = {
			attach_mode = "global",
			backends = { "lsp", "treesitter", "markdown", "man" },
			layout = { min_width = 28 },
			manage_folds = true,
			link_folds_to_tree = true,
			link_tree_to_folds = true,
			show_guides = true,
			filter_kind = false,
			autojump = true,
			guides = {
				mid_item = "├ ",
				last_item = "└ ",
				nested_top = "│ ",
				whitespace = "  ",
			},
		},
	},
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("illuminate").configure({
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
				delay = 120,
				filetypes_denylist = {
					"markdown",
					"gitcommit",
					"dirvish",
					"fugitive",
					"alpha",
					"NvimTree",
					"packer",
					"manson",
					"neogitstatus",
					"Trouble",
					"lir",
					"Outline",
					"spectre_panel",
					"toggleterm",
					"DressingSelect",
					"TelescopePrompt",
					"sagacodeaction",
					"dapui_console",
					"dapui_watches",
					"dapui_stacks",
					"dapui_breakpoints",
					"dapui_scopes",
					"lspsagafinder",
					"JABSwindow",
					"lspsagaoutline",
					"lazy",
					"help",
					"DressingInput",
					"",
				},
				filetypes_allowlist = {},
				modes_denylist = { "v", "i" },
				modes_allowlist = {},
				providers_regex_syntax_denylist = {},
				providers_regex_syntax_allowlist = {},
				under_cursor = true,
			})
		end,
	},
	-- {
	-- 	"otavioschwanck/telescope-alternate",
	-- 	config = function()
	-- 		require("telescope-alternate").setup({
	-- 			presets = { "rails", "rspec" },
	-- 			mappings = {
	-- 				-- jihulab rails
	-- 				{
	-- 					"jh/app/models/(.*).rb",
	-- 					{
	-- 						{ "jh/app/controllers/**/*[1:pluralize]_controller.rb", "JH Controller" },
	-- 						{ "jh/app/views/[1:pluralize]/*.html.haml", "JH View" },
	-- 						{ "jh/app/helpers/[1]_helper.rb", "JH Helper" },
	-- 					},
	-- 				},
	-- 				{
	-- 					"jh/app/controllers(.*)/(.*)_controller.rb",
	-- 					{
	-- 						{ "jh/app/models/**/*[2:singularize].rb", "JH Model" },
	-- 						{ "jh/app/views/[1][2]/*.html.haml", "JH View" },
	-- 						{ "jh/app/helpers/**/*[2]_helper.rb", "JH Helper" },
	-- 					},
	-- 				},
	-- 				-- jihulab rspec
	-- 				{ "jh/app/(.*).rb", { { "jh/spec/[1]_spec.rb", "JH Test" } } },
	-- 				{ "jh/spec/(.*)_spec.rb", { { "jh/app/[1].rb", "JH Original", true } } },
	-- 				{
	-- 					"jh/app/controllers/(.*)_controller.rb",
	-- 					{ { "jh/spec/requests/[1]_spec.rb", "JH Request Test" } },
	-- 				},
	-- 				{
	-- 					"jh/spec/requests/(.*)_spec.rb",
	-- 					{ { "jh/app/controllers/[1]_controller.rb", "JH Original Controller", true } },
	-- 				},
	-- 			},
	-- 		})
	-- 		require("telescope").load_extension("telescope-alternate")
	-- 	end,
	-- },

	--------------------
	-- LSP Renaming
	--------------------
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
		keys = function()
			vim.keymap.set("n", "<leader>rn", function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end, { expr = true })
		end,
	},
	--------------------
	-- Search and Replace
	--------------------

	{
		"cshuaimin/ssr.nvim",
		keys = {
			{
				"<leader>rs",
				function()
					require("ssr").open()
				end,
				mode = { "n", "x" },
				desc = "Structural Replace",
			},
		},
	},
	-- {
	-- 	"folke/lazydev.nvim",
	-- 	ft = "lua", -- only load on lua files
	-- 	opts = {
	-- 		library = {
	-- 			-- See the configuration section for more details
	-- 			-- Load luvit types when the `vim.uv` word is found
	-- 			{ path = "luvit-meta/library", words = { "vim%.uv" } },
	-- 		},
	-- 	},
	-- },
	{ -- optional completion source for require statements and module annotations
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre" },
		cmd = "ConformInfo",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},
	-- {
	-- 	"linux-cultist/venv-selector.nvim",
	-- 	lazy = true,
	-- 	dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
	-- 	config = function()
	-- 		require("venv-selector").setup({
	-- 			pyenv_path = "/home/vinacio/.pyenv/versions",
	-- 			name = "venv",
	-- 			auto_refresh = true,
	-- 		})
	-- 	end,
	-- 	event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
	-- 	keys = {
	-- 		-- Keymap to open VenvSelector to pick a venv.
	-- 		{ "<leader>vs", "<cmd>VenvSelect<cr>" },
	-- 		-- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
	-- 		{ "<leader>vc", "<cmd>VenvSelectCached<cr>" },
	-- 	},
	-- },
	--
}
