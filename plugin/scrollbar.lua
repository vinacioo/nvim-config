vim.cmd([[
  augroup ScrollbarInit
    autocmd!
    autocmd WinScrolled,VimResized,QuitPre * silent! lua require('scrollbar').show()
    autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
    autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
  augroup end
]])

vim.cmd([[
  let g:scrollbar_shape = {
    \ 'head': '▲',
    \ 'body': '█',
    \ 'tail': '▼',
    \ }
]])

vim.cmd([[
    let g:scrollbar_highlight = {
    \ 'head': 'Scrollbar',
    \ 'body': 'Scrollbar',
    \ 'tail': 'Scrollbar',
    \ }
]])
