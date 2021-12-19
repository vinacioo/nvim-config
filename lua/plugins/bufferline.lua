local color = require('colors.palette').custom

require('bufferline').setup{
     options = {
      offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
      buffer_close_icon = "",
      modified_icon = "",
      -- close_icon = "%@NvChad_bufferline_quitvim@%X",
      close_icon = "",
      show_close_icon = true,
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 14,
      max_prefix_length = 13,
      tb_size = 20,
      show_tab_indicators = true,
      enforce_regular_tabs = false,
      view = "multiwindow",
      show_buffer_close_icons = true,
      separator_style = "thin",
      always_show_bufferline = true,
      diagnostics = false, -- "or nvim_lsp"
      custom_filter = function(buf_number)
         -- Func to filter out our managed/persistent split terms
         local present_type, type = pcall(function()
            return vim.api.nvim_buf_get_var(buf_number, "term_type")
         end)

         if present_type then
            if type == "vert" then
               return false
            elseif type == "hori" then
               return false
            else
               return true
            end
         else
            return true
         end
      end,
   },
    highlights = {
      background = {
         guifg = color.grey,
         guibg = color.bg_darker,
      },

      -- buffers
      buffer_selected = {
         guifg = color.white,
         guibg = color.bg,
         gui = "bold",
      },
      buffer_visible = {
         guifg = color.grey,
         guibg = color.bg_darker,
      },

      -- for diagnostics = "nvim_lsp"
      error = {
         guifg = color.grey,
         guibg = color.bg_darker,
      },
      error_diagnostic = {
         guifg = color.grey,
         guibg = color.bg_darker,
      },

      -- close buttons
      close_button = {
         guifg = color.grey,
         guibg = color.bg_darker,
      },
      close_button_visible = {
         guifg = color.grey,
         guibg = color.bg_darker,
      },
      close_button_selected = {
         guifg = color.red,
         guibg = color.bg_darker,
      },
      fill = {
         guifg = color.grey,
         guibg = color.bg_darker,
      },
      indicator_selected = {
         guifg = color.bg_darker,
         guibg = color.bg_darker,
      },

      -- modified
      modified = {
         guifg = color.red,
         guibg = color.bg_darker,
      },
      modified_visible = {
         guifg = color.red,
         guibg = color.bg_darker,
      },
      modified_selected = {
         guifg = color.green,
         guibg = color.bg_darker,
      },

      -- separators
      separator = {
         guifg = color.bg_darker,
         guibg = color.bg_darker,
      },
      separator_visible = {
         guifg = color.orange,
         guibg = color.blue,
      },
      separator_selected = {
         guifg = color.bg_darker,
         guibg = color.grey,
      },
      -- tabs
      tab = {
         guifg = color.grey,
         guibg = color.bg,
      },
      tab_selected = {
         guifg = color.bg_darker,
         guibg = color.blue,
      },
      tab_close = {
         guifg = color.red,
         guibg = color.bg_darker,
      },
   },
}

