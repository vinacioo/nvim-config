local present, dap = pcall(require, "dap")
if not present then
	return
end

require("dapui").setup()
require("nvim-dap-virtual-text").setup()
require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
require("dap-python").test_runner = "pytest"

vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#993939", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379", bg = "#31353f" })

vim.fn.sign_define(
	"DapBreakpoint",
	{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
	"DapBreakpointCondition",
	{ text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
	"DapBreakpointRejected",
	{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
	"DapLogPoint",
	{ text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
)
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })

-- keymaps
vim.keymap.set("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<cr>")
vim.keymap.set("n", "<leader>dc", ":lua require'dap'.continue()<cr>")
vim.keymap.set("n", "<leader>do", ":lua require'dap'.step_over()<cr>")
vim.keymap.set("n", "<leader>da", ":lua require'dap'.step_out()<cr>")
vim.keymap.set("n", "<leader>di", ":lua require'dap'.step_into()<cr>")
vim.keymap.set("n", "<leader>dl", ":lua require'dap'.run_last()<cr>")
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.toggle()<cr>")
vim.keymap.set("n", "<leader>dq", ":lua require'dap'.disconnect()<cr>")
vim.keymap.set("n", "<leader>du", ':lua require("dapui").toggle()<cr>')
vim.keymap.set("n", "<leader>du", ':lua require("dapui").toggle()<cr>')
vim.keymap.set("n", "<leader>dt", ":DapVirtualTextToggle<cr>")
-- vim.keymap.set("n", "<leader>dt", ":lua require'dap.ui.widgets'.hover()<cr>")
vim.keymap.set(
	"n",
	"<leader>ds",
	":lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<cr>"
)

vim.keymap.set("n", "<leader>dpm", "<cmd>lua require('dap-python').test_method()<CR>")
vim.keymap.set("n", "<leader>dpc", "<cmd>lua require('dap-python').test_class()<CR>")
vim.keymap.set("v", "<leader>dps", "<cmd>lua require('dap-python').debug_selection()<CR>")

-- DEPOIS VERIFICAR PARA FECHAR O DAP
-- local M = {}
--
-- function M.start_dap()
-- 	require('dapui').open()
-- 	if vim.fn.expand('%:e') == 'rs' then
-- 		require("rust-tools.debuggables").debuggables()
-- 	else
-- 		require("dap").continue()
-- 	end
-- end
--
-- function M.close_dap()
-- 	require("dap").close()
-- 	require("dapui").close()
-- 	vim.api.nvim_command [[
-- 		bdelete! \[dap-repl]
-- 		bdelete! term
-- 	]]
-- end
--
-- return M
