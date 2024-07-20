-- Restart with cursor in the location from last session.
vim.api.nvim_create_autocmd("BufReadPost", {
	command = 'if &filetype != "gitcommit" && line("\'\\"") > 1 && line("\'\\"") <= line("$") | execute "normal! g`\\"" | endif',
	group = vim.api.nvim_create_augroup("myAuGroup", { clear = true }),
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("yankcolor", { clear = true }),
	command = "silent! lua vim.highlight.on_yank {higroup='IncSearch', timeout=70}",
})
