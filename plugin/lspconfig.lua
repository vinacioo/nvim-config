local lspconfig = require("lspconfig")
-- https://github.com/neovim/nvim-lspconfig#suggested-configuration
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- https://github.com/cloudlena/dotfiles/blob/main/nvim/.config/nvim/lua/plugins.lua
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
  -- print("Attaching LSP: " .. client.name)

  local formatting_augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  if client.server_capabilities.document_formatting then
    vim.cmd("au BufWritePre <buffer> lua vim.lsp.buf.format { async = true }")
  end

  local function buf_opts(desc)
    return { noremap = true, silent = true, buffer = bufnr, desc = desc }
  end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
  vim.keymap.set("n", "<Leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, buf_opts("Format current file"))

  -- Format on save
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = formatting_augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = formatting_augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
end

-- diagnostic
vim.diagnostic.config({
  virtual_text = {
    prefix = "",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
  float = {
    border = "rounded",
  },
})

-- Toggle diagnostics helper
local notify = require("notify")
vim.diagnostic.disable()
vim.g.diagnostics_active = false
function _G.toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.diagnostic.disable()
    notify("Diagnostics disabled!")
  else
    vim.g.diagnostics_active = true
    vim.diagnostic.enable()
    notify("Diagnostics enabled")
  end
end

vim.keymap.set("n", "<leader>td", toggle_diagnostics)

-- set signs
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local on_attach_without_formatting = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentOnTypeFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  on_attach(client, bufnr)
end

lspconfig.bashls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.sumneko_lua.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "python" },
      },
    },
    telemetry = {
      enabled = false,
    },
  },
  capabilities = capabilities,
})

lspconfig.tsserver.setup({
  on_attach = on_attach_without_formatting,
  capabilities = capabilities,
})

lspconfig.pyright.setup({
  on_attach = on_attach_without_formatting,
  capabilities = capabilities,
})

lspconfig.texlab.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.jsonls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "single",
  focusable = false,
  relative = "cursor",
})

local navic = require("nvim-navic")

require("lspconfig").clangd.setup({
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end,
})

-- Use LSP as the handler for formatexpr
vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

-- Use internal formatting for bindings like gq.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.bo[args.buf].formatexpr = nil
  end,
})
