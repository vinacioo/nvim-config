vim.cmd('filetype plugin indent on')
local exec = vim.api.nvim_exec
local set = vim.opt
local cmd = vim.cmd

set.clipboard = "unnamedplus"
set.cmdheight = 1
set.ruler = false
set.hidden = false
set.swapfile = false
set.ignorecase = true
set.smartcase = true
set.mouse = "a"
set.number = true
set.numberwidth = 2
set.relativenumber = true
set.expandtab = true
set.shiftwidth = 2
set.smartindent = true
set.tabstop = 8
set.timeoutlen = 400
set.updatetime = 250
set.undofile = true
set.termguicolors = true
set.splitbelow = true
set.splitright = false
set.signcolumn = "yes"
set.cul = true -- cursor line
set.title = true
vim.wo.colorcolumn = '79'
vim.wo.cursorline = false

exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=400, on_visual=true}
  augroup end
]], false)

-- Don't show any numbers inside terminals
cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]

-- Don't show any numbers inside terminals
cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]

-- don't auto commenting new lines
cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])

-- remove line lenght marker for selected filetypes
cmd [[autocmd FileType text,markdown,html,latex,tex setlocal cc=0]]

-- 2 spaces for selected filetypes
cmd [[
  autocmd FileType xml,html,xhtml,css,scss,latex,tex,lua,yaml setlocal shiftwidth=2 tabstop=2
]]

-- disable some builtin vim plugins
local disabled_built_ins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
   vim.g["loaded_" .. plugin] = 1
end

-- jupyter env
vim.api.nvim_exec([[
" Always use the same virtualenv for vim, regardless of what Python
" environment is loaded in the shell from which vim is launched
let g:vim_virtualenv_path = '/home/vagner/.env/py3_9/jupyter'
if exists('g:vim_virtualenv_path')
    pythonx import os; import vim
    pythonx activate_this = os.path.join(vim.eval('g:vim_virtualenv_path'), 'bin/activate_this.py')
    pythonx with open(activate_this) as f: exec(f.read(), {'__file__': activate_this})
endif

if has('nvim')
    let g:python3_host_prog = '/home/vagner/.env/py3_9/jupyter/bin/python'
else
    set pyxversion=3
endif
]], true)
