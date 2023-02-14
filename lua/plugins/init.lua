local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

---- Initialize Packer variables
local packer = require("packer")

--- Initialize Packer
packer.init({
	auto_clean = true,
	compile_on_sync = true,
	git = { clone_timeout = 6000 },
	display = {
		working_sym = "ﲊ",
		error_sym = "✗ ",
		done_sym = " ",
		removed_sym = " ",
		moved_sym = "",
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
})

--- Startup and add configure plugins
packer.startup(function(use)
	use({
		"wbthomason/packer.nvim",
	})

	use({
		"lewis6991/impatient.nvim",
		config = function()
			require("impatient")
		end,
	})

	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
	})

	use("nvim-lua/plenary.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" }, { "kdheepak/lazygit.nvim" } },
		tag = "0.1.0",
	})

	use({ "nvim-telescope/telescope-media-files.nvim" })

	use({ "hkupty/iron.nvim" })

	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			"MDeiml/tree-sitter-markdown", -- A markdown grammar for tree-sitter
			"David-Kunz/markid", -- A Neovim extension to highlight same-name identifiers with the same color.
			"nvim-treesitter/nvim-treesitter-textobjects", -- TODO: Setup textobjects
			"RRethy/nvim-treesitter-endwise", -- Wisely add "end" in Ruby, Vimscript, Lua, etc. Tree-sitter aware alternative to tpope's vim-endwise.
			{
				"nvim-treesitter/playground", --Treesitter playground integrated into Neovim
				event = "BufRead",
			},
			{
				"JoosepAlviste/nvim-ts-context-commentstring", -- Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
				event = "BufRead",
			},
		},
		run = ":TSUpdate",
	})

	use({ "rcarriga/nvim-notify" })

	use({ "vinacioo/minimal.nvim" })

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"ray-x/cmp-treesitter",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-calc",
			"lukas-reineke/cmp-rg",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"lukas-reineke/cmp-rg",
			"davidsierradz/cmp-conventionalcommits",
			"onsails/lspkind-nvim",
			"rafamadriz/friendly-snippets",
			"honza/vim-snippets",
		},
	})

	use({ "saadparwaiz1/cmp_luasnip" })

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				char = "▏",
			})
		end,
	})

	use({ "norcalli/nvim-colorizer.lua" })

	use({ "feline-nvim/feline.nvim" })

	use({ "lewis6991/gitsigns.nvim" })

	-- lsp stuff

	use({ "neovim/nvim-lspconfig" })

	use({ "williamboman/mason.nvim" })

	use({
		"williamboman/mason-lspconfig.nvim",
		requires = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	})

	use({
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		requires = {
			"williamboman/mason.nvim",
		},
	})

	use({
		"akinsho/bufferline.nvim",
		tag = "v3.*",
		requires = "nvim-tree/nvim-web-devicons",
	})

	use({
		"mrjones2014/legendary.nvim", -- Define your keymaps, commands, and autocommands as simple Lua tables, and create a legend for them at the same time, integrates with which-key.nvim.
		config = function()
			require("legendary").setup()
		end,
	})

	use({
		"folke/which-key.nvim", -- Neovim plugin that shows a popup with possible keybindings of the command you started typing.
		requires = "mrjones2014/legendary.nvim",
	})

	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
	})

	use("Vonr/align.nvim")

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	})

	use({ "jose-elias-alvarez/null-ls.nvim" })

	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})

	use({
		"lervag/vimtex",
		ft = { "tex", "bib" },
	})

	use({
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	-- use({
	-- 	"mfussenegger/nvim-dap-python",
	-- 	requires = {
	-- 		"theHamsta/nvim-dap-virtual-text",
	-- 		"mfussenegger/nvim-dap",
	-- 		"rcarriga/nvim-dap-ui",
	-- 		"rcarriga/cmp-dap",
	-- 		"nvim-telescope/telescope-dap.nvim",
	-- 	},
	-- })
	use({
		"mfussenegger/nvim-dap",
		opt = true,
		event = "BufReadPre",
		module = { "dap" },
		wants = { "nvim-dap-virtual-text", "DAPInstall.nvim", "nvim-dap-ui", "nvim-dap-python", "which-key.nvim" },
		requires = {
			"Pocco81/DAPInstall.nvim",
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap-python",
			"nvim-telescope/telescope-dap.nvim",
			{ "jbyuki/one-small-step-for-vimkind", module = "osv" },
		},
	})
	use({
		"preservim/vim-markdown",
		config = function()
			vim.g.vim_markdown_folding_style_pythonic = 1
			vim.g.vim_markdown_folding_level = 6
		end,
	})

	use({ "lukas-reineke/headlines.nvim" })

	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup()
		end,
	})

	use({
		"kkoomen/vim-doge",
		run = ":call doge#install()",
	})

	use({ "dkarter/bullets.vim" })

	use({ "xiyaowong/virtcolumn.nvim" })

	use({
		"declancm/cinnamon.nvim",
		config = function()
			require("cinnamon").setup()
		end,
	})

	use({ "Xuyuanp/scrollbar.nvim" })

	use({
		"sindrets/diffview.nvim",
		requires = "nvim-lua/plenary.nvim",
	})

	use({
		"TimUntersberger/neogit",
		requires = "nvim-lua/plenary.nvim",
	})

	use({ "kdheepak/lazygit.nvim" })

	use({
		"akinsho/git-conflict.nvim",
		tag = "*",
		config = function()
			require("git-conflict").setup()
		end,
	})

	-- Lua
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup()
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
