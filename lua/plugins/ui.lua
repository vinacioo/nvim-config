return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		keys = {
			{ "<leader>fw", ":Telescope live_grep<CR>", { desc = "telescope live grep" } },
			{ "<leader>fb", ":Telescope buffers<CR>", { desc = "telescope find buffers" } },
			{ "<leader>fh", ":Telescope help_tags<CR>", { desc = "telescope help page" } },
			{ "<leader>fm", ":Telescope marks<CR>", { desc = "telescope find marks" } },
			{ "<leader>fo", ":Telescope oldfiles<CR>", { desc = "telescope find oldfiles" } },
			{ "<leader>fz", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" } },
			{ "<leader>cm", ":Telescope git_commits<CR>", { desc = "telescope git commits" } },
			{ "<leader>tk", ":Telescope keymaps<CR>", { desc = "telescope keymaps" } },
			{ "<leader>tr", ":Telescope resume<CR>", { desc = "telescope resume" } },
			{ "<leader>fh", ":Telescope themes<CR>", { desc = "telescope themes" } },
			{ "<leader>ff", ":Telescope find_files<CR>", { desc = "telescope find files" } },
			{
				"<leader>fa",
				":Telescope find_files follow=true no_ignore=true hidden=true<CR>",
				{ desc = "telescope find all files" },
			},
		},
		config = function()
			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},
	{
		"j-hui/fidget.nvim",
		lazy = false,
		opts = {},
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		event = { "BufReadPost", "BufReadPre", "BufNewFile" },
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local barbecue = require("barbecue")
			local ui = require("barbecue.ui")

			barbecue.setup({
				show_dirname = false,
				show_basename = false,
				exclude_filetypes = { "netrw", "toggleterm" },
			})

			ui.toggle(false)
		end,
		keys = {
			{
				"<leader>tw",
				function()
					require("barbecue.ui").toggle()
				end,
				desc = "Toggle barbecue winbar",
			},
		},
	},
	{
		"akinsho/bufferline.nvim",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		name = "BufferLine",
		opts = {
			options = {
				offsets = {
					{
						filetype = "NvimTree",
						highlight = "NvimTreeNormal",
					},
				},
				hover = {
					enabled = true,
					delay = 25,
					reveal = { "close" },
				},
				indicator = { icon = " ", style = " " },
				separator_style = "none",
			},
		},
		config = function(_, opts)
			local bufferline = require("bufferline")
			opts.options.style_preset = {
				bufferline.style_preset.no_italic,
				bufferline.style_preset.no_bold,
			}

			bufferline.setup(opts)
		end,
		keys = {
			{ "<S-tab>", "<cmd>BufferLineCyclePrev<CR>" },
			{ "<tab>", "<cmd>BufferLineCycleNext<CR>" },
			{ "<leader>bb", "<cmd>BufferLinePick<CR>", desc = "Pick" },
			{ "<leader>bq", "<cmd>BufferLinePickClose<CR>", desc = "Pick to close" },
			{ "<leader>bl", "<cmd>BufferLineCloseRight<CR>", desc = "Close all to right" },
			{ "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", desc = "Close all to left" },
			{
				"<leader>ba",
				"<cmd>BufferLineCloseLeft<CR><cmd>BufferLineCloseRight<CR>",
				desc = "Close all but current",
			},
		},
	},

	{
		"freddiehaddad/feline.nvim",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		config = function()
			local present, feline = pcall(require, "feline")

			if not present then
				return
			end

			local color = {
				bg_0 = "#202327",
				bg_1 = "#30343a",
				gray_0 = "#40464e",
				gray_1 = "#42464c",
				gray_2 = "#505861",
				gray_3 = "#606975",
				white_darker = "#bdae93",
				white_medium = "#d5c4a1",
				white_lighter_1 = "#ebdbb2",
				white_lighter = "#fbf1c7",
				red = "#fb4934",
				orange = "#fe8019",
				yellow = "#fabd2f",
				green_lime = "#b8bb26",
				green = "#8ec07c",
				blue = "#83a598",
				cyan = "#70C0BA",
				magenta = "#d3869b",
				purple = "#C397D8",
				orange_lighter = "#d65d0e",
			}

			local icons = {
				diagnostic = {
					error = "  ",
					warn = "  ",
					hint = "  ",
					info = "  ",
				},
				diff = {
					added = " ",
					changed = " ",
					removed = " ",
				},
				separators = {
					left_round = "",
					right_round = "",
					square = "▊",
					right = "",
					main_icon = "  ",
					vi_mode_icon = " ",
					position_icon = " ",
				},
			}

			local mode_alias = {
				["n"] = "NORMAL",
				["no"] = "OP",
				["nov"] = "OP",
				["noV"] = "OP",
				["no"] = "OP",
				["niI"] = "NORMAL",
				["niR"] = "NORMAL",
				["niV"] = "NORMAL",
				["nt"] = "NORMAL",
				["v"] = "VISUAL",
				["V"] = "LINES",
				[""] = "BLOCK",
				["s"] = "SELECT",
				["S"] = "SELECT",
				[""] = "BLOCK",
				["i"] = "INSERT",
				["ic"] = "INSERT",
				["ix"] = "INSERT",
				["R"] = "REPLACE",
				["Rc"] = "REPLACE",
				["Rv"] = "V-REPLACE",
				["Rx"] = "REPLACE",
				["c"] = "COMMAND",
				["cv"] = "COMMAND",
				["ce"] = "COMMAND",
				["r"] = "ENTER",
				["rm"] = "MORE",
				["r?"] = "CONFIRM",
				["!"] = "SHELL",
				["t"] = "TERM",
				["null"] = "NONE",
			}

			local vi_mode_colors = {
				["NORMAL"] = color.green,
				["OP"] = color.blue,
				["INSERT"] = color.cyan,
				["VISUAL"] = color.yellow,
				["LINES"] = color.red,
				["BLOCK"] = color.orange,
				["REPLACE"] = color.purple,
				["V-REPLACE"] = color.magenta,
				["ENTER"] = color.magenta,
				["MORE"] = color.magenta,
				["SELECT"] = color.red,
				["SHELL"] = color.cyan,
				["TERM"] = color.green,
				["NONE"] = color.gray_2,
				["COMMAND"] = color.blue,
			}

			-- Navic Setup
			vim.g.navic_available = true
			vim.g.navic_silence = true

			local navic_present, navic = pcall(require, "nvim-navic")
			if navic_present then
				navic.setup({
					separator = " > ",
				})

				vim.api.nvim_create_autocmd("LspAttach", {
					group = vim.api.nvim_create_augroup("NavicLspAttach", { clear = true }),
					callback = function(args)
						local buffer = args.buf
						local client = vim.lsp.get_client_by_id(args.data.client_id)
						navic.attach(client, buffer)
					end,
				})
			else
				vim.g.navic_available = false
			end

			local component = {}

			local function get_vim_mode()
				local mode = vim.api.nvim_get_mode().mode
				if mode then
					return mode_alias[mode]
				end
			end

			local function get_mode_color()
				local mode = get_vim_mode()
				if mode then
					return vi_mode_colors[mode]
				end
			end

			component.vi_mode = {
				provider = function()
					local mode = get_vim_mode()
					mode = mode or "TERM"
					if mode then
						return "  " .. mode .. " "
					end
				end,
				hl = function()
					return {
						fg = color.bg_0,
						bg = get_mode_color(),
						style = "bold",
					}
				end,
			}

			component.vi_mode_sep = {
				provider = icons.separators.right,
				hl = function()
					return {
						fg = get_mode_color(),
						bg = color.bg_1,
					}
				end,
			}

			component.git_branch = {
				provider = "git_branch",
				icon = " ",
				hl = {
					fg = color.gray_2,
					bg = color.bg_0,
				},
				left_sep = "block",
				right_sep = "",
			}

			component.file_info = {
				provider = "file_info",
				hl = {
					fg = color.white_darker,
				},
				left_sep = "block",
			}

			component.diagnostic_errors = {
				provider = "diagnostic_errors",
				hl = {
					fg = color.red,
					bg = color.gray_1,
				},
			}

			component.diagnostic_warnings = {
				provider = "diagnostic_warnings",
				hl = {
					fg = color.yellow,
					bg = color.gray_1,
				},
			}

			component.diagnostic_hints = {
				provider = "diagnostic_hints",
				hl = {
					fg = color.cyan,
					bg = color.gray_1,
				},
			}

			component.diagnostic_info = {
				provider = "diagnostic_info",
				hl = {
					fg = color.white_darker,
					bg = color.gray_1,
				},
			}

			component.lsp = {
				provider = "lsp_client_names",
				hl = {
					fg = color.white_darker,
					bg = color.gray_1,
				},
			}

			component.position = {
				provider = "position",
				left_sep = "block",
				right_sep = "block",
				hl = {
					fg = color.white_darker,
					bg = color.bg_0,
				},
			}

			component.line_percentage = {
				provider = "line_percentage",
				hl = {
					fg = color.white_darker,
					bg = color.bg_0,
				},
				left_sep = "block",
				right_sep = "block",
			}

			component.total_lines = {
				provider = function()
					return "%L"
				end,
				hl = {
					fg = color.white_darker,
					bg = color.bg_0,
				},
				left_sep = "block",
				right_sep = "block",
			}

			component.scroll_bar = {
				provider = "scroll_bar",
				hl = {
					fg = color.white_darker,
					style = "bold",
				},
			}

			component.git_add = {
				provider = "git_diff_added",
				hl = {
					fg = color.green,
				},
				left_sep = "",
				right_sep = "",
			}

			component.git_delete = {
				provider = "git_diff_removed",
				hl = {
					fg = color.red,
				},
				left_sep = "",
				right_sep = "",
			}

			component.git_change = {
				provider = "git_diff_changed",
				hl = {
					fg = color.magenta,
				},
				left_sep = "",
				right_sep = "",
			}

			component.separator = {
				provider = " ",
				hl = {
					fg = color.gray_1,
					bg = color.gray_1,
				},
			}
			component.separator_mode_right_bg = {
				provider = "",
				hl = {
					fg = color.bg_1,
					bg = color.bg_0,
				},
			}

			component.separator_lsp_left_0 = {
				provider = "",
				hl = {
					fg = color.bg_1,
					bg = color.bg_0,
				},
			}

			component.separator_lsp_left_1 = {
				provider = "",
				hl = {
					fg = color.gray_1,
					bg = color.bg_1,
				},
			}

			component.separator_lsp_right_0 = {
				provider = "",
				hl = {
					fg = color.gray_1,
					bg = color.bg_1,
				},
			}

			component.separator_lsp_right_1 = {
				provider = "",
				hl = {
					fg = color.bg_1,
					bg = color.bg_0,
				},
			}

			component.file_type = {
				provider = {
					name = "file_type",
					opts = {
						filetype_icon = true,
						case = "lowercase",
					},
				},
				hl = {
					fg = color.white_darker,
				},
				left_sep = "block",
				right_sep = "block",
			}

			-- Add Navic Provider
			component.navic_position = {
				provider = function()
					if vim.g.navic_available then
						return navic.get_location()
					end
				end,
				enabled = function()
					return navic.is_available()
				end,
				hl = {
					fg = color.cyan,
					bg = color.bg_0,
				},
				left_sep = "block",
			}

			local left = {
				component.vi_mode,
				component.vi_mode_sep,
				component.separator_mode_right_bg,
				component.file_info,
				component.git_branch,
				component.git_add,
				component.git_delete,
				component.git_change,
			}
			local middle = {
				-- component.navic_position,
			}
			local right = {
				component.file_type,
				component.separator_lsp_left_0,
				component.separator_lsp_left_1,
				component.lsp,
				component.diagnostic_errors,
				component.diagnostic_warnings,
				component.diagnostic_info,
				component.diagnostic_hints,
				component.separator_lsp_right_0,
				component.separator_lsp_right_1,
				component.position,
				component.total_lines,
				component.line_percentage,
			}

			local components = {
				active = {
					left,
					middle,
					right,
				},
			}

			feline.setup({
				components = components,
				theme = {
					bg = color.bg_0,
				},
				vi_mode_colors = vi_mode_colors,
			})
		end,
	},
}
