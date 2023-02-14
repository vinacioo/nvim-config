local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")

vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Setup custom options for the pop-up windows
local cmp_window_opts = {
	border = "rounded",
	-- winhighlight = "Normal:NormalFloat,FloatBorder:CmpWindowBorder,CursorLine:Visual,Search:None",
	winhighlight = "Normal:CmpPmenu,CursorLine:CmpItemMenu,Search:None",
}

local kind_icons = {
	Copilot = "",
	Namespace = "",
	Text = " ",
	Method = " ",
	Function = " ",
	Constructor = " ",
	Field = "ﰠ ",
	Variable = " ",
	Class = "ﴯ ",
	Interface = " ",
	Module = " ",
	Property = "ﰠ ",
	Unit = "塞 ",
	Value = " ",
	Enum = " ",
	Keyword = " ",
	Snippet = " ",
	Color = " ",
	File = " ",
	Reference = " ",
	Folder = " ",
	EnumMember = " ",
	Constant = " ",
	Struct = "פּ ",
	Event = " ",
	Operator = " ",
	TypeParameter = " ",
	Table = "",
	Object = " ",
	Tag = "",
	Array = "[]",
	Boolean = " ",
	Number = " ",
	Null = "ﳠ",
	String = " ",
	Calendar = "",
	Watch = " ",
	Package = "",
}

local config = {
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	enabled = function()
		local disabled = false
		disabled = disabled or (vim.api.nvim_buf_get_option(0, "buftype") == "prompt")
		return not disabled
	end,
	experimental = {
		-- native_menu = false,
		ghost_text = true,
	},
	formatting = {
		format = function(_, vim_item)
			vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
			if _.source.name == "copilot" then
				vim_item.kind = " Copilot"
			end
			return vim_item
		end,
	},
	mapping = {
		["<C-g>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping(function()
			cmp.close()
			cmp.abort()
		end),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping(function(confirm_selection)
			if cmp.visible() then
				cmp.confirm()
				cmp.close()
			else
				confirm_selection()
			end
		end),
		["<C-p>"] = cmp.mapping(function(copilot)
			cmp.mapping.abort()
			local copilot_keys = vim.fn["copilot#Accept"]()
			if copilot_keys ~= "" then
				vim.api.nvim_feedkeys(copilot_keys, "i", true)
			else
				copilot()
			end
		end),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif require("luasnip").expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif require("luasnip").jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "treesitter" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "calc" },
		{ name = "rg" },
		{ name = "copilot" },
		{
			name = "buffer",
			keyword_length = 5,
			option = {
				get_bufnr = function() -- all buffers
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		{ name = "crates" }, -- crates does check if file is a `Cargo.toml` file
	},
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,

			-- copied from cmp-under, but I don't think I need the plugin for this.
			-- I might add some more of my own.
			function(entry1, entry2)
				local _, entry1_under = entry1.completion_item.label:find("^_+")
				local _, entry2_under = entry2.completion_item.label:find("^_+")
				entry1_under = entry1_under or 0
				entry2_under = entry2_under or 0
				if entry1_under > entry2_under then
					return false
				elseif entry1_under < entry2_under then
					return true
				end
			end,

			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	view = {
		entries = { name = "custom", selection_order = "top_down" },
	},
	window = {
		completion = cmp.config.window.bordered(cmp_window_opts),
		documentation = cmp.config.window.bordered(cmp_window_opts),
	},
}
-- For filetype specific overrides see ftplugin folder

cmp.setup(config)
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
-- cmp.event:on("confirm_done", cmp.autopairs.on_confirm_done({ map_char = { tex = "" } }))

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
		{ name = "copilot" },
	}),
})

-- local color = require("colors.pallete").color
-- local function border(hl_name)
-- 	return {
-- 		{ "╭", hl_name },
-- 		{ "─", hl_name },
-- 		{ "╮", hl_name },
-- 		{ "│", hl_name },
-- 		{ "╯", hl_name },
-- 		{ "─", hl_name },
-- 		{ "╰", hl_name },
-- 		{ "│", hl_name },
-- 	}
-- end
--

--
-- vim.api.nvim_set_hl(0, "CmpBorder", { fg = color.red })
-- vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "#f8f8f2" })
-- vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#f8f8f2" })
-- vim.api.nvim_set_hl(0, "CmpPmenu", { fg = "#f8f8f2" })
-- vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282a36" })
-- vim.api.nvim_set_hl(0, "CmpDocBorder", { fg = color.bg_0 })
