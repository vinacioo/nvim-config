return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason.nvim" },
			{ "tamago324/nlsp-settings.nvim" },
			{ "b0o/SchemaStore.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
			{
				"j-hui/fidget.nvim",
				branch = "main",
				opts = {
					progress = {
						poll_rate = 0,
						suppress_on_insert = true,
						ignore_done_already = true,
						ignore_empty_message = false,
						display = {
							progress_icon = { pattern = "dots", period = 1 },
						},
					},
					notification = {
						window = {
							normal_hl = "Comment", -- Base highlight group in the notification window
							winblend = 1, -- Background color opacity in the notification window
							border = "none", -- Border around the notification window
							zindex = 45, -- Stacking priority of the notification window
							max_width = 0, -- Maximum width of the notification window
							max_height = 0, -- Maximum height of the notification window
							x_padding = 1, -- Padding from right edge of window boundary
							y_padding = 0, -- Padding from bottom edge of window boundary
							align = "bottom", -- How to align the notification window
							relative = "editor", -- What the notification window position is relative to
						},
					},

					integration = {
						["nvim-tree"] = {
							enable = true,
						},
					},
				},
				event = "VeryLazy",
			},
		},
		config = function()
			local status_ok, _ = pcall(require, "lspconfig")
			if not status_ok then
				return
			end

			require("lspconfig")
			require("lsp.settings.lua_ls")
			require("lsp.handler").setup()

			-- config keymap
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go prev diagnosis" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go next diagnosis" })
			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "list diagnosis" })
			vim.keymap.set("n", "<space>Q", vim.diagnostic.open_float, { desc = "open float window on diagnosis" })

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<gs>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<space>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<space>fm", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})

			-- capabilities
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			capabilities.textDocument.completion.completionItem = {
				documentationFormat = { "markdown", "plaintext" },
				snippetSupport = true,
				preselectSupport = true,
				insertReplaceSupport = true,
				labelDetailsSupport = true,
				deprecatedSupport = true,
				commitCharactersSupport = true,
				tagSupport = { valueSet = { 1 } },
				resolveSupport = {
					properties = {
						"documentation",
						"detail",
						"additionalTextEdits",
					},
				},
			}

			-- UI config
			local signs = {

				{ name = "DiagnosticSignError", text = "" },
				{ name = "DiagnosticSignWarn", text = "" },
				{ name = "DiagnosticSignHint", text = "󰌵" },
				{ name = "DiagnosticSignInfo", text = "" },
			}

			for _, sign in ipairs(signs) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
			end

			local config = {
				virtual_text = {
					prefix = "",
				},
				signs = {
					active = signs, -- show signs
				},
				update_in_insert = true,
				underline = true,
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			}

			vim.diagnostic.config(config)

			-- Toogle diagnostics
			DiagnosticsActive = true
			local ToggleDiagnostics = function()
				DiagnosticsActive = not DiagnosticsActive
				if DiagnosticsActive then
					vim.api.nvim_echo({ { "Diagnostics enabled" } }, false, {})
					vim.diagnostic.enable()
				else
					vim.api.nvim_echo({ { "Diagnostics disabled" } }, false, {})
					vim.diagnostic.enable(false)
				end
			end

			vim.keymap.set(
				"n",
				"<leader>di",
				ToggleDiagnostics,
				{ noremap = true, silent = true, desc = "Toggle diagnostics" }
			)

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "rounded",
			})
		end,
	},

	{
		"williamboman/mason.nvim",
		dependencies = {
			{ "williamboman/mason-lspconfig.nvim" },
			"neovim/nvim-lspconfig",
		},
		config = function()
			local status_ok, mason = pcall(require, "mason")
			if not status_ok then
				return
			end

			local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
			if not status_ok_1 then
				return
			end

			local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
			if not lspconfig_status_ok then
				return
			end

			local servers = {
				-- "tsserver",
				"dockerls",
				"jsonls",
				"yamlls",
				"bashls",
				"lua_ls",
				"pyright",
				"html",
				"cssls",
				"vimls",
				-- "cmake",
				-- "tailwindcss",
				"marksman",
				-- "lemminx",
				-- "taplo",
				"texlab",
			}

			local settings = {
				ui = {
					border = "rounded",
					icons = {
						package_installed = "◍",
						package_pending = "◍",
						package_uninstalled = "◍",
					},
				},
				log_level = vim.log.levels.INFO,
				max_concurrent_installers = 4,
			}

			mason.setup(settings)
			mason_lspconfig.setup({
				ensure_installed = servers,
				automatic_installation = true,
			})

			for _, server in pairs(servers) do
				local opts = {
					on_attach = require("lsp.handler").on_attach,
					capabilities = require("lsp.handler").capabilities,
				}
				local has_custom_opts, server_custom_opts = pcall(require, "lsp.settings." .. server)
				if has_custom_opts then
					opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
				end
				lspconfig[server].setup(opts)
			end
		end,
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Lua
					"lua_ls",
					"stylua",
					-- Vim
					"vim-language-server",
					-- Yaml
					"yamlls",
					-- Json
					"json-lsp",
					-- Bash
					"shellcheck",
					"bash-language-server",
					-- Helm
					"helm-ls",
					-- Markdown
					"markdownlint-cli2",
					-- CSS
					"css-lsp",
					-- HTLM
					"html-lsp",
					-- Python
					"pyright",
					"autopep8",
					"flake8",
					"black",
					"ruff",
					"isort",
					"mypy",
				},
				auto_update = true,
				run_on_start = true,
			})
		end,
	},

	-- LspDecorators
	{
		"ray-x/lsp_signature.nvim",
		event = { "VeryLazy" },
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			local status_ok, signature = pcall(require, "lsp_signature")
			if not status_ok then
				return
			end

			local icons = require("config.icons")

			local cfg = {
				debug = false,
				log_path = "debug_log_file_path",
				verbose = false,
				bind = true,
				doc_lines = 0,
				floating_window = false,
				floating_window_above_cur_line = false,
				fix_pos = false,
				hint_enable = true,
				hint_prefix = icons.diagnostics.Hint .. " ",
				hint_scheme = "Function",
				hi_parameter = "LspSignatureActiveParameter",
				max_height = 12,
				max_width = 120,
				handler_opts = {
					border = "rounded",
				},
				always_trigger = false,
				auto_close_after = nil,
				extra_trigger_chars = {},
				zindex = 200,
				padding = "",
				transparency = nil,
				shadow_blend = 36,
				shadow_guibg = "Black",
				timer_interval = 200,
				toggle_key = nil,
			}
			signature.setup(cfg)
			signature.on_attach(cfg)
		end,
	},
	-- {
	-- 	"SmiteshP/nvim-navic",
	-- 	lazy = false,
	-- 	event = {
	-- 		"CursorMoved",
	-- 		"CursorHold",
	-- 		"BufWinEnter",
	-- 		"BufFilePost",
	-- 		"InsertEnter",
	-- 		"BufWritePost",
	-- 		"TabClosed",
	-- 	},
	-- 	dependencies = {
	-- 		"neovim/nvim-lspconfig",
	-- 		-- "nvim-tree/nvim-web-devicons"
	-- 		"echasnovski/mini.icons",
	-- 	},
	-- 	config = function()
	-- 		local status_ok, navic = pcall(require, "nvim-navic")
	-- 		if not status_ok then
	-- 			return
	-- 		end
	-- 		vim.api.nvim_create_autocmd("LspAttach", {
	-- 			group = vim.api.nvim_create_augroup("NavicLspAttach", { clear = true }),
	-- 			callback = function(args)
	-- 				local buffer = args.buf
	-- 				local client = vim.lsp.get_client_by_id(args.data.client_id)
	-- 				navic.attach(client, buffer)
	-- 			end,
	-- 		})
	-- 	end,
	-- },

	-- {
	-- 	"weilbith/nvim-code-action-menu",
	-- 	cmd = "CodeActionMenu",
	-- 	keys = {
	-- 		{ "<leader>a", "<cmd>CodeActionMenu<cr>", desc = "show code actions" },
	-- 	},
	-- },
	{
		{
			"jose-elias-alvarez/null-ls.nvim",
			event = "BufReadPre",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = function()
				local nls = require("null-ls")
				return {
					sources = {
						-- python
						nls.builtins.diagnostics.pylint,
						nls.builtins.diagnostics.mypy.with({
							extra_args = { "--ignore-missing-imports" },
						}),
						nls.builtins.diagnostics.flake8,
						-- nls.builtins.formatting.black.with({ filetypes = { "python" } }),

						-- lua
						-- nls.builtins.formatting.stylua,
						-- nls.builtins.diagnostics.luacheck,
						nls.builtins.diagnostics.luacheck.with({
							extra_args = { "--globals", "vim", "jit" },
						}),

						-- webdev
						nls.builtins.formatting.prettier.with({ filetypes = { "html", "markdown", "css" } }), -- so prettier works only on these filetypes
						nls.builtins.diagnostics.stylelint,
						nls.builtins.formatting.stylelint,

						-- zsh
						nls.builtins.diagnostics.zsh.with({
							filetypes = { "zsh" },
						}),
					},
				}
			end,
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

					vim.api.nvim_create_autocmd("BufWritePre", {
						group = vim.api.nvim_create_augroup("LspFormatting", {}),
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								bufnr = bufnr,
								async = false,
								-- filter = function(localClient) return localClient.name ~= "tsserver" end,
							})
						end,
					})
				end
			end,
		},
	},
}
