local present, telescope = pcall(require, "telescope")
if not present then
  return
end

telescope.setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "absolute" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    media_files = {
      filetypes = { "png", "webp", "jpg", "jpeg" },
      find_cmd = "rg", -- find command (defaults to `fd`)
    },
  },
})

local extensions = { "themes", "terms", "fzf", "lazygit" }
local packer_repos = [["extensions", "telescope-fzf-native.nvim"]]

if vim.fn.executable("ueberzug") == 1 then
  table.insert(extensions, "media_files")
  packer_repos = packer_repos .. ', "telescope-media-files.nvim"'
end

pcall(function()
  for _, ext in ipairs(extensions) do
    telescope.load_extension(ext)
  end
end)

-- local color = require("colors.pallete").color
--
-- vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = color.bg_darker, bg = color.bg_darker })
-- vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = color.bg, bg = color.bg })
-- vim.api.nvim_set_hl(0, "TelescopePromptNormal", { fg = color.white_darker, bg = color.bg })
-- vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = color.white_darker, bg = color.bg })
-- vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = color.white_darker, bg = color.bg_darker })
-- vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = color.bg_darker, bg = color.purple })
-- vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = color.bg_darker, bg = color.red })
-- vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = color.bg_darker, bg = color.bg_darker })
-- vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = color.white_darker, bg = "#333333" })
-- vim.api.nvim_set_hl(0, "TelescopeResultsDiffAdd", { fg = color.red, bg = "#333333" })
-- vim.api.nvim_set_hl(0, "TelescopeResultsDiffChange", { fg = color.red, bg = "#333333" })
-- vim.api.nvim_set_hl(0, "TelescopeResultsDiffDelete", { fg = color.red, bg = "#333333" })
-- vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = color.bg_darker, bg = color.bg_darker })
-- vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = color.bg_darker, bg = color.bg_darker })
