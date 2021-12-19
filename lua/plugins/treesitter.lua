require('nvim-treesitter.configs').setup{
  ensure_installed = {
    "lua",
    "json",
    "latex",
    "python",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
}
