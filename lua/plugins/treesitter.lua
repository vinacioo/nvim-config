return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'html', 'lua', 'python', 'markdown', 'vim', 'latex' },
      auto_install = true,
      highlight = {
        enable = true,
        use_languagetree = true,
      },
    },
    indent = { enable = true },
  }
