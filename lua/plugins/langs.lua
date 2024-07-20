return {
	"lervag/vimtex",
	ft = { "tex" },
	config = function()
		vim.g.tex_flavor = "latex"
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_view_general_viewer = "zathura"
		vim.g.vimtex_fold_enabled = 0
		vim.g.vimtex_quickfix_mode = 0
		vim.g.vimtex_indent_enabled = 0

		-- 2 spaces
		vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
			pattern = { "*.md", "*.tex" },
			callback = function()
				vim.opt_local.shiftwidth = 2
				vim.opt_local.tabstop = 2
			end,
		})

		-- setting spell
		vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
			pattern = { "*.md", "*.tex" },
			callback = function()
				vim.opt_local.spell = true
				vim.opt_local.spelllang = { "pt", "en" }
			end,
		})

		-- highlight mispelling
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				vim.api.nvim_set_hl(0, "SpellBad", { ctermfg = 11, ctermbg = 9, guifg = "#282828", guibg = "#ffff00" })
			end,
		})

		-- set indentexpr for tex files
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "tex",
			callback = function()
				vim.opt_local.indentexpr = ""
			end,
		})

		-- latexmk build directory
		vim.g.vimtex_compiler_latexmk = { build_dir = "build" }
	end,
}

-- return {
-- 	"lervag/vimtex",
-- 	ft = { "tex" },
-- 	config = function()
-- 		vim.g.tex_flavor = "latex"
-- 		vim.g.vimtex_view_method = "zathura"
-- 		vim.g.vimtex_view_general_viewer = "zathura"
-- 		vim.g.vimtex_fold_enabled = 0
-- 		vim.g.vimtex_quickfix_mode = 0
-- 		vim.g.vimtex_indent_enabled = 0
-- 		-- 2 spaces
-- 		vim.cmd([[
-- 			autocmd BufNewFile,BufRead *.md,*.tex setlocal shiftwidth=2 tabstop=2
-- 		]])

-- 		-- setting spell
-- 		vim.cmd([[
-- 			autocmd BufNewFile,BufRead *.md,*.tex setlocal spell spelllang=pt,en
-- 		]])

-- 		-- highlight mispelling
-- 		vim.cmd([[
-- 			au VimEnter * highlight SpellBad ctermfg=011 ctermbg=009 guifg=#282828 guibg=#ffff00
-- 		]])

-- 		-- set indentexpr for tex files
-- 		vim.cmd([[
-- 			autocmd FileType tex setlocal indentexpr=
-- 		]])

-- 		-- latexmk build directory
-- 		vim.cmd([[let g:vimtex_compiler_latexmk = {'build_dir' : 'build'}]])
-- 	end,
-- }
