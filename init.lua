require("config.options")
require("config.lazy")

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("config.autocmds")
		require("config.keymaps")
	end,
})

-- Set colorscheme
require("utils.set-colorscheme")

-- Set terminal background
require("utils.set-terminal-bg").setup()
