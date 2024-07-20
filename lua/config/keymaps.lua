vim.g.mapleader = " "

local map = vim.keymap.set

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "file save" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "file copy whole" })

--change root
map("n", "<leader>cd", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "change root" })

-- Remap for dealing with word wrap
map("n", "j", "gj", { silent = true })
map("n", "k", "gk", { silent = true })

-- Go to beginning of line. Goes to previous line if repeated
map("n", "H", "getpos('.')[2] == 1 ? 'k' : '^'", { expr = true })

-- Go to end of line. Goes to next line if repeated
map("n", "L", "len(getline('.')) == 0 || len(getline('.')) == getpos('.')[2] ? 'jg_' : 'g_'", { expr = true })

-- core useful
map("n", "<leader><leader>", "<c-^>") -- Switch between 2 buffers

vim.cmd('nnoremap <leader>p "*p') -- Paste content from OS's clipboard
vim.cmd('vnoremap <leader>y "*y') -- Yank content in OS's clipboard

-- Better escape using jk in insert and terminal mode
map("i", "jk", "<ESC>")
map("t", "jk", "<C-\\><C-n>")

-- Quick split window
map("n", "_", [[<Cmd>sp<CR>]])
map("n", "<bar>", [[<Cmd>vsp<CR>]])

-- Resize window using <shift> arrow keys
map("n", "<A-Up>", "<cmd>resize +5<CR>")
map("n", "<A-Down>", "<cmd>resize -5<CR>")
map("n", "<A-Left>", "<cmd>vertical resize -5<CR>")
map("n", "<A-Right>", "<cmd>vertical resize +5<CR>")

-- Move Lines
map("n", "<A-j>", ":m .+1<CR>==")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
map("n", "<A-k>", ":m .-2<CR>==")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- go back the original place from jumping to definitions like ctags
map("n", "<BS>", "<C-o>")

-- Lazy
map("n", "<leader>L", "<cmd>:Lazy<cr>", { desc = "Plugin Manager" })

-- Delete a word backwards
map("n", "dw", 'vb"_d')

-- Delete without copy
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- delete single character without copying into register
map("n", "x", '"_x', { desc = "Delete character without register" })
