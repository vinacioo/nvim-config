return {
	{
		"echasnovski/mini.icons",
		lazy = false,
		version = false,
		config = function()
			require("mini.icons").setup()
		end,
	},
	{
		'nvim-tree/nvim-web-devicons',
		lazy = false,
	},
}
-- local M = {}
--
-- M.setup = function()
--   local signs = {
--
--     { name = "DiagnosticSignError", text = "" },
--     { name = "DiagnosticSignWarn", text = "" },
--     { name = "DiagnosticSignHint", text = "󰌵" },
--     { name = "DiagnosticSignInfo", text = "" },
--   }
--
--   for _, sign in ipairs(signs) do
--     vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
--   end
--
--   local config = {
--     virtual_text = {
--       prefix = "",
--     },
--     signs = {
--       active = signs, -- show signs
--     },
--     update_in_insert = true,
--     underline = true,
--     severity_sort = true,
--     float = {
--       focusable = true,
--       style = "minimal",
--       border = "rounded",
--       source = "always",
--       header = "",
--       prefix = "",
--     },
--   }
--
--   vim.diagnostic.config(config)
--
--   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--     border = "rounded",
--   })
--
--   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
--     border = "rounded",
--   })
-- end
--
-- return M
-- -- Tweak the UI for diagnostics' signs and floating windows.
-- local signs = {
--   { name = "DiagnosticSignError", text = "" },
--   { name = "DiagnosticSignWarn", text = "" },
--   { name = "DiagnosticSignHint", text = "" },
--   { name = "DiagnosticSignInfo", text = "" },
-- }
--
-- for _, sign in ipairs(signs) do
--   vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
-- end
--
-- vim.diagnostic.config({
--   virtual_text = {
--     prefix = "",
--   },
--   signs = { active = signs, },
--   update_in_insert = true,
--   underline = true,
--   severity_sort = true,
--   -- float = { focusable = false, style = "minimal", border = "rounded", source = "always", header = "", prefix = "", },
-- })
--
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", })
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded", })
--
-- -- vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = '#88088F', })
-- -- vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = 'DarkOrange', })
-- -- vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = 'Blue', })
-- -- vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = 'Green', })
--
-- -- vim.fn.sign_define("DiagnosticSignError", {text = "", texthl = "DiagnosticError"})
-- -- vim.fn.sign_define("DiagnosticSignWarn", {text = "", texthl = "DiagnoticWarn"})
-- -- vim.fn.sign_define("DiagnosticSignInfo", {text = "󰋼", texthl = "DiagnosticInfo"})
-- -- vim.fn.sign_define("DiagnosticSignHint", {text = "󰌵", texthl = "DiagnosticHint"})
--
-- vim.cmd([[
--     highlight clear CursorLine
--     hi CursorLineNr term=bold cterm=bold ctermfg=010 gui=bold
--
--     " Highlight yanked text
--     augroup highlight_yank
--     autocmd!
--     autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
--     augroup END
-- ]])
--
-- -- " Snippets "
-- -- if (&ft=='rb')
-- --    :let g:vsnip_filetypes.ruby = ['rails']
-- -- endif
-- --
-- -- " LSP & formatter "
-- -- autocmd FileType python setlocal omnifunc=LanguageClient#complete
