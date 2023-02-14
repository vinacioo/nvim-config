local nmap = function(lhs, rhs)
	vim.keymap.set("n", lhs, rhs, { noremap = false, silent = true })
end
local imap = function(lhs, rhs)
	vim.keymap.set("i", lhs, rhs, { noremap = false, silent = true })
end

local vmap = function(lhs, rhs)
	vim.keymap.set("v", lhs, rhs, { noremap = false, silent = true })
end

local tmap = function(lhs, rhs)
	vim.keymap.set("t", lhs, rhs, { noremap = false, silent = true })
end

local xmap = function(lhs, rhs)
	vim.keymap.set("x", lhs, rhs, { noremap = true, silent = true })
end

nmap("<leader>cd", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>")
nmap("<C-k>", ":bnext<CR>")
nmap("<C-j>", ":bprev<CR>")
nmap("<C-n>", ":NvimTreeToggle<CR>")

-- Better window navigation
nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")

-- Packer
nmap("<leader>ps", "<cmd>PackerSync<CR>")
nmap("<leader>pc", "<cmd>PackerCompile<CR>")

-- Save with CTRL + S
nmap("<C-s>", "<C-c>:w<CR>")
imap("<C-s>", "<C-c>:w<CR>")

-- Cycle between buffers
nmap("<Tab>", ":BufferLineCycleNext<CR>")
nmap("<S-Tab>", ":BufferLineCyclePrev<CR>")

-- Telescope keymaps
nmap("<leader>tk", "<cmd>Telescope keymaps<CR>")
nmap("<leader>ff", "<cmd>Telescope find_files<CR>")
nmap("<leader>tr", "<cmd>Telescope resume<CR>")
nmap("<leader>fm", ":Telescope media_files<CR>")
nmap("<leader>fw", ":Telescope live_grep<CR>")
nmap("<leader>ft", ":Telescope themes<CR>")

-- Trouble toggle<cmd>silent execute '!xdg-open ' .. shellescape(expand('<cfile>'), v:true)<CR>
nmap("<leader>xx", "<cmd>TroubleToggle<CR>")

-- Cwd
nmap("<leader>cd", ":cd %:p:h<CR>")

-- Delete without cut
nmap("<leader>d", '"_d')
nmap("<leader>D", '"_D')
nmap("<leader>dd", '"_dd^')

-- Highlight spell
nmap("<leader>he", ":highlight SpellBad ctermfg=011 ctermbg=009 guifg=#282828 guibg=#ffff00<CR>")
nmap("<leader>hd", ":highlight clear SpellBad ctermfg=011 ctermbg=009 guifg=#282828 guibg=#ffff00<CR>")

-- Move lines
nmap("<M-j>", ":m .+1<CR>==")
nmap("<M-k>", ":m .-2<CR>==")
vmap("<M-j>", ":m '>+1<CR>gv=gv")
vmap("<M-k>", ":m '<-2<CR>gv=gv")

-- Open link
nmap("gx", "<cmd>silent execute '!xdg-open ' .. shellescape(expand('<cfile>'), v:true)<CR>")

-- Folding
nmap(
	"<leader>zt",
	":setlocal foldmethod=indent expandtab tabstop=4 shiftwidth=4 softtabstop=4 foldlevel=1 foldlevelstart=1<CR>"
)

-- Resize panels
nmap("<M-Up>", ":resize -2<CR>")
nmap("<M-Down>", ":resize +2<CR>")
nmap("<M-Left>", ":vertical resize -2<CR>")
nmap("<M-Right>", ":vertical resize +2<CR>")

-- Don't yank on delete char
nmap("x", '"_x')
nmap("X", '"_X')
vmap("x", '"_x')
vmap("X", '"_X')

-- Exit terminal
tmap("<Esc>", "<C-\\><C-n>:q<cr>")

-- Toggle quickfix
nmap("<F4>", "<cmd> :call ToggleQuickFix()<CR>")

-- Easy align
xmap("<leader>n", function()
	require("align").align_to_char(1, true)
end) -- Aligns to 1 character, looking left
xmap("<leader>ns", function()
	require("align").align_to_char(2, true, true)
end) -- Aligns to 2 characters, looking left and with previews
xmap("<leader>m", function()
	require("align").align_to_string(false, true, true)
end) -- Aligns to a string, looking left and with previews
xmap("<leader>ms", function()
	require("align").align_to_string(true, true, true)
end) -- Aligns to a Lua pattern, looking left and with preview

-- ToogleTerm
nmap("<M-h>", "<cmd>ToggleTerm direction=horizontal<cr>")
nmap("<M-v>", "<cmd>ToggleTerm direction=vertical<cr>")

-- Json viwer
nmap("<leader>j", "<cmd>%!jq<cr>")

-- Function to close buffer
local function close_buffer(force)
	local tv = require("nvim-tree.view")
	local bl = require("bufferline")
	local tw = tv.get_winnr()
	if tw == nil then
		vim.cmd("bdelete! ")
		return
	end
	local wo = vim.api.nvim_win_is_valid(tw)
	local tb = vim.api.nvim_get_current_buf()
	if wo then
		bl.cycle(-1)
	end
	vim.cmd("bdelete" .. (force and "! " or " ") .. tb)
end

-- Bindings for closing buffers.
vim.keymap.set("n", "<Leader>c", function()
	close_buffer(false)
end, opts)
vim.keymap.set("n", "<Leader>d", function()
	close_buffer(true)
end, opts)

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

-- vim.keymap.set("n", "<leader>q", '<cmd>lua require("utils").close_buffer()<cr>') -- Quit
vim.keymap.set("n", "<leader>q", "<cmd>bprevious <bar> bdelete #<cr>", { desc = "buffer kill" })

-- Hop
-- place this in one of your configuration file(s)
local hop = require("hop")
local directions = require("hop.hint").HintDirection
vim.keymap.set("", "f", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, { remap = true })
vim.keymap.set("", "F", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, { remap = true })
vim.keymap.set("", "t", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })
vim.keymap.set("", "T", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })
vim.keymap.set("n", "<leader>2", ":HopChar2<cr>")
vim.keymap.set("n", "<leader>w", ":HopWord<cr>")
vim.keymap.set("n", "<leader>l", ":HopLine<cr>")
vim.keymap.set("n", "<leader>p", ":HopPattern<cr>")

-- Markdown Preview
nmap("<leader>m", ":MarkdownPreview<CR>")

-- Wrap whole file with gq
nmap("<leader>g", "ggVGgq")

-- definition on hover
nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>")

-- Disable Highlights
nmap("<Esc>", ":noh<CR>")

nmap("cn", "g*Ncgn")

-- lazegit
nmap("<leader>gg", ":LazyGit<CR>")

-- open config
nmap("<leader>en", ":Telescope find_files cwd=~/.config/nvim_configs/custom_nvim<cr>")
