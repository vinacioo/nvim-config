local null_ls = require("null-ls")

require("null-ls").setup({
	sources = {
		-- python
		null_ls.builtins.formatting.autopep8,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.pylint,
    -- null_ls.builtins.formatting.black,

		-- shell
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.shellharden,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.code_actions.shellcheck,

		-- JS yaml html markdown
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.formatting.json_tool,

		-- markdown
		null_ls.builtins.diagnostics.markdownlint,

    -- latex
    null_ls.builtins.diagnostics.chktex,

		-- Lua
		-- null_ls.builtins.diagnostics.luacheck,
		-- null_ls.builtins.formatting.stylua,

		-- Spell checking
		null_ls.builtins.diagnostics.codespell.with({
			args = { "--builtin", "clear,rare,code", "-" },
		}),

    -- latex
    null_ls.builtins.formatting.latexindent,

		-- Git
		null_ls.builtins.code_actions.gitsigns,
	},
})
-- require("lspconfig")["null-ls"].setup({
-- 	on_attach = function()
-- 		vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
-- 	end,
-- })
