vim.g.navic_available = true
vim.g.navic_silence = true

local navic = require("nvim-navic")
navic.setup({
  separator = " > ",
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("NavicLspAttach", { clear = true }),
  callback = function(args)
    local buffer = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    navic.attach(client, buffer)
  end,
})
