local map = vim.api.nvim_set_keymap

-- leader key
vim.g.mapleader = "\\"

-- move lines
map('v', 'J', ":m '>+1<CR>gv=gv", { noremap=true })
map('v', 'K', ":m '<-2<CR>gv=gv", { noremap=true })

-- buffer quit
map('n', '<leader>q', ":bp<CR>:bd #<CR>", { noremap=true })

-- better indenting
map('v', '<', '<gv', {noremap = true, silent = true})
map('v', '>', '>gv', {noremap = true, silent = true})


-- delete forward
map('i', '<C-q>', '<C-o>dw', {noremap = true, silent = true})
map('n', '<C-q>', 'dw', {noremap = true, silent = true})

-- Better save
map('n', '<C-s>', ':w<CR>', {noremap = true, silent = true})
map('i', '<C-s>', '<Esc>:w<CR>', {noremap = true, silent = true})

-- jupyter qtconsole
map('n', '<Leader>c', ':JupyterConnect<CR>', {noremap = true})
map('v', '<M-j>', ':JupyterSendRange<CR>', {noremap = true})
map('n', '<M-j>', ':JupyterSendRange<CR>', {noremap = true, silent = true})

-- bufferline
map('n', '<TAB>', ":BufferLineCycleNext <CR>", {noremap = true})
map('n', '<S-Tab>', ":BufferLineCyclePrev <CR>", {noremap = true})


-- use ESC to turn off search highlighting
map("n", '<Esc>', ":noh <CR>", {noremap = true})

-- nvim-tree toggle
map('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- close  buffer
-- map("n", '<leader>q', ":lua require('plugins.utils').close_buffer() <CR>", { noremap=true })

-- copy whole file content
map("n", '<leader>a', ":%y+ <CR>", { noremap=true }) -- copy whole file content

-- better window movement
map('n', '<C-h>', '<C-w>h', {noremap = true, silent = true})
map('n', '<C-j>', '<C-w>j', {noremap = true, silent = true})
map('n', '<C-k>', '<C-w>k', {noremap = true, silent = true})
map('n', '<C-l>', '<C-w>l', {noremap = true, silent = true})

-- json view
map('n', '<leader>j', ':%!python -m json.tool --no-ensure-ascii<CR>', { noremap=true })
map('v', '<leader>j', ':%!python -m json.tool --no-ensure-ascii<CR>', { noremap=true })

-- terminal mappings --
-- get out of terminal mode
map('t', 'jk', "<C-\\><C-n>", { noremap=true })
-- hide a term from within terminal mode
map('t', 'JK', "<C-\\><C-n> :lua require('plugins.utils').close_buffer() <CR>", { noremap=true })
-- pick a hidden term
map('n', '<leader>t', ":Telescope terms <CR>", { noremap=true })

-- Open terminals
-- map('n', '<leader>h', ":execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>", { noremap=true })
-- map("n", '<leader>v', ":execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert <CR>", { noremap=true })
map("n", '<leader>h', ":execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>", { noremap=true })

-- telescope
map("n", '<leader>fb', ":Telescope buffers <CR>", { noremap=true })
map("n", '<leader>ff', ":Telescope find_files <CR>", { noremap=true })
map("n", '<leader>fa', ":Telescope find_files hidden=true <CR>", { noremap=true })
map("n", '<leader>cm', ":Telescope git_commits <CR>", { noremap=true })
map("n", '<leader>gs', ":Telescope git_status <CR>", { noremap=true })
map("n", '<leader>fh', ":Telescope help_tags <CR>", { noremap=true })
map("n", '<leader>fw', ":Telescope live_grep <CR>", {noremap=true})
map("n", '<leader>fo', ":Telescope oldfiles <CR>", {noremap=true})

-- Example keybindings
map('n', '<c-t>', '<CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })
map('t', '<c-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })

-- toggle quickfix
vim.api.nvim_exec([[
    function! ToggleQuickFix()
        if empty(filter(getwininfo(), 'v:val.quickfix'))
            copen
        else
            cclose
        endif
    endfunction
]], false)

vim.cmd [[ nnoremap <silent> <F4> :call ToggleQuickFix()<CR> ]]

-- trouble nvim
map("n", "<leader>xx", ":TroubleToggle<cr>", {silent = true, noremap = true})

-- toggle lsp
map("n", "<leader>ls", "<cmd>lua vim.diagnostic.show()<CR>", { noremap = true, silent = true })
map("n", "<leader>lh", "<cmd>lua vim.diagnostic.hide()<CR>", { noremap = true, silent = true })

-- lsp on popup
map("n", "<leader>g", "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", { noremap = true, silent = true })

-- resize split
map('n', '<M-.>', ':vertical resize +1<CR>', { noremap=true})
map('n', '<M-,>', ':vertical resize -1<CR>', { noremap=true})

