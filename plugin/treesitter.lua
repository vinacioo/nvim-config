local status_ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	vim.notify("nvim-treesitter not found!")
	return
end

-- nvim_treesitter.setup({
--   ensure_installed = { "html", "css", "vue", "lua", "javascript", "typescript", "python" },
--   highlight = {
--     enable = true,
--     additional_vim_regex_highlighting = false,
--   },
--   -- indent = {
--   --   enable = true
--   -- },
--   incremental_selection = {
--     enable = true,
--     keymaps = {
--       init_selection = "<CR>",
--       node_incremental = "<CR>",
--       node_decremental = "<BS>",
--       scope_incremental = "<TAB>",
--     },
--   },
--   -- Folding
--   -- vim.wo.foldmethod = 'expr'
--   -- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
--   -- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
--   -- vim.wo.foldlevel = 99
-- })

require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	highlight = {
		enable = true,
		language_tree = true,
		additional_vim_regex_highlighting = { "org" },
	},
	-- indent = {
	--   enable = true,
	-- },
	refactor = {
		highlight_definitions = {
			enable = true,
		},
	},
	autotag = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25,
		persist_queries = true,
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
	textobjects = {
		select = {
			enable = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@comment.outer",
				["ic"] = "@comment.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
			},
		},
	},
	textsubjects = {
		enable = true,
		keymaps = {
			["<CR>"] = "textsubjects-smart",
			[";"] = "textsubjects-container-outer",
		},
	},
})
