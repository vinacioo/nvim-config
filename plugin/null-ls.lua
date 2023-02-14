local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  debug = true,
  sources = {

    -- webdev stuff
    -- b.formatting.deno_fmt.with {filetypes = { "json"} },
    b.formatting.prettier.with({ filetypes = { "html", "markdown", "css" } }),

    -- Lua
    b.formatting.stylua,

    -- Shell
    b.formatting.shfmt,
    b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),

    -- cpp
    b.formatting.clang_format,
    b.formatting.rustfmt,

    -- python
    b.diagnostics.flake8,
    b.formatting.autopep8,
    b.formatting.isort,
    b.diagnostics.pylint,
    b.formatting.black,

    -- latex
    b.diagnostics.chktex,

    --spell
    -- b.diagnostics.misspell.with { filetypes = { "markdown", "latex", "tex" } },
    b.diagnostics.cspell.with({
      filetypes = { "markdown", "latex", "tex" },
      extra_args = { "--config", "/home/vagner/.config/.cspell.json" },
    }),

    -- markdown
    b.diagnostics.markdownlint,

    -- pyproject
    b.diagnostics.pyproject_flake8.with({ filetypes = { "toml" } }),

    -- json
    b.diagnostics.jsonlint,
  },

  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          vim.lsp.buf.format({ bufnr = bufnr })
          -- vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
})
