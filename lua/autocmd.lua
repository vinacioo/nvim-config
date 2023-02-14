local exec = vim.api.nvim_exec

-- allow terminal width to dynamically adjust, useful with iron.nvim
vim.cmd('autocmd BufLeave * if &buftype == "terminal" | :set nowfw | endif')

-- auto close file explorer when quiting incase a single buffer is left
vim.cmd('autocmd BufEnter * if (winnr("$") == 1 && &filetype == "nvimtree") | q | endif')

-- highlight on yank
exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=400, on_visual=true}
  augroup end
]] ,
  false
)

-- toggle quickfix
exec(
  [[
    function! ToggleQuickFix()
        if empty(filter(getwininfo(), 'v:val.quickfix'))
            copen
        else
            cclose
        endif
    endfunction
]] ,
  false
)

-- dict of autocmd functions and keymaps
local aucmd_dict = {
  FileType = {
    --pretty json
    {
      pattern = "json",
      callback = function()
        vim.keymap.set(
          "n",
          "<leader>j",
          "<cmd> %!python -m json.tool --no-ensure-ascii<CR>",
          { noremap = true, silent = true, buffer = true }
        )
      end,
    },
    {
      pattern = "qf",
      callback = function()
        vim.opt_local.buflisted = false
      end,
    },
    {
      pattern = "markdown",
      command = "set tw=80 wrap",
    },
    -- disable dap-repl to open on start
    {
      pattern = "dap-repl",
      callback = function(args)
        vim.api.nvim_buf_set_option(args.buf, "buflisted", false)
      end,
    },
  },
  BufWinEnter = {
    -- don't auto commenting new lines
    {
      pattern = "*",
      command = "set formatoptions-=cro",
    },
  },
  BufNewFile = {
    -- don't auto commenting new lines
    {
      pattern = "*",
      command = "set formatoptions-=cro",
    },
  },
  BufReadPost = {
    -- open at the last line the file was closed
    {
      pattern = "*",
      callback = function()
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
          vim.api.nvim_exec("normal! g'\"", false)
        end
      end,
    },
  },
  -- trailing whitespace
  BufWritePre = {
    {
      pattern = { "*" },
      command = [[%s/\s\+$//e]],
    },
  },
  TermOpen = {
    {
      pattern = { "*" },
      command = "set nonumber norelativenumber",
    },
  },
  -- setting no colorcolumn for terminal and enter in insert mode
  BufEnter = {
    {
      pattern = { "*" },
      callback = function()
        if vim.bo.buftype == "terminal" then
          vim.cmd("startinsert | setlocal cc=")
        end
      end,
    },
  },
}

for event, opt_tbls in pairs(aucmd_dict) do
  for _, opt_tbl in pairs(opt_tbls) do
    vim.api.nvim_create_autocmd(event, opt_tbl)
  end
end

local enable_providers = {
  "python3_provider",
}

for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    pcall(vim.diagnostic.hide)
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "i:*",
  callback = function()
    pcall(vim.diagnostic.show)
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    -- setup keymaps
    local opts = { buffer = 0, noremap = true, silent = true }
    -- directional navigation <c-direction>
    vim.keymap.set("t", "<c-h>", "<c-\\><c-n><c-w>h", opts)
    vim.keymap.set("t", "<c-j>", "<c-\\><c-n><c-w>j", opts)
    vim.keymap.set("t", "<c-k>", "<c-\\><c-n><c-w>k", opts)
    vim.keymap.set("t", "<c-l>", "<c-\\><c-n><c-w>l", opts)
    -- quit - <c-a>q
    vim.keymap.set("t", "<space>rs", "<c-\\><c-n>:q<cr>", opts)
  end,
})

-- format on save
vim.api.nvim_command("autocmd BufWritePre *.py lua vim.lsp.buf.format(nil, 1000)")
vim.api.nvim_command("autocmd BufWritePre *.html lua vim.lsp.buf.format(nil, 1000)")
vim.api.nvim_command("autocmd BufWritePre *.css lua vim.lsp.buf.format(nil, 1000)")
vim.api.nvim_command("autocmd BufWritePre *.scss lua vim.lsp.buf.format(nil, 1000)")
vim.api.nvim_command("autocmd BufWritePre *.js lua vim.lsp.buf.format(nil, 1000)")
vim.api.nvim_command("autocmd VimEnter *.md set textwidth=80 linebreak wrap")

-- vim.api.nvim_command("autocmd BufWritePre *.js EslintFixAll")
-- autocmd BufWritePre <buffer> <cmd>EslintFixAll<CR>
vim.api.nvim_command("autocmd BufWritePre *.tex lua vim.lsp.buf.format(nil, 1000)")
vim.api.nvim_command("autocmd BufWritePre *.ts lua vim.lsp.buf.format(nil, 1000)")
-- vim.api.nvim_command("autocmd BufWritePre *.md lua vim.lsp.buf.format(nil, 1000)")
vim.api.nvim_command("autocmd BufWritePre *.lua lua vim.lsp.buf.format(nil, 1000)")

_G.xelatexcheck = function()
  local isxelatex = false
  local fifteenlines = vim.api.nvim_buf_get_lines(0, 0, 15, false)
  for l, line in ipairs(fifteenlines) do
    if (line:lower():match("xelatex"))
        or (line:match("\\usepackage[^}]*mathspec"))
        or (line:match("\\usepackage[^}]*fontspec"))
        or (line:match("\\usepackage[^}]*unicode-math"))
    then
      isxelatex = true
      break
    end
  end
  if isxelatex then
    local knapsettings = vim.b.knap_settings or {}
    knapsettings["textopdf"] = "xelatex -interaction=batchmode -halt-on-error -synctex=1 %docroot%"
    vim.b.knap_settings = knapsettings
  end
end
vim.api.nvim_create_autocmd({ "BufRead" }, { pattern = { "*.tex" }, callback = xelatexcheck })

vim.g.python3_host_prog = "/home/vagner/.env/py3_9/jupyter/bin/python"

vim.g.doge_doc_standard_python = "google"
