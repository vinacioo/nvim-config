local present, feline = pcall(require, "feline")
local color = require("colors.pallete").color

if not present then
  return
end

local icons = {
  diagnostic = {
    error = "  ",
    warn = "  ",
    hint = "  ",
    info = "  ",
  },
  diff = {
    added = " ",
    changed = " ",
    removed = " ",
  },
  separators = {
    left_round = "",
    right_round = "",
    square = "▊",
    right = " ",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },
}

local mode_alias = {
  ["n"] = "NORMAL",
  ["no"] = "OP",
  ["nov"] = "OP",
  ["noV"] = "OP",
  ["no"] = "OP",
  ["niI"] = "NORMAL",
  ["niR"] = "NORMAL",
  ["niV"] = "NORMAL",
  ["nt"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "LINES",
  [""] = "BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT",
  [""] = "BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["ix"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rc"] = "REPLACE",
  ["Rv"] = "V-REPLACE",
  ["Rx"] = "REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "COMMAND",
  ["ce"] = "COMMAND",
  ["r"] = "ENTER",
  ["rm"] = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERM",
  ["null"] = "NONE",
}

local vi_mode_colors = {
  ["NORMAL"] = color.green,
  ["OP"] = color.blue,
  ["INSERT"] = color.cyan,
  ["VISUAL"] = color.yellow,
  ["LINES"] = color.red,
  ["BLOCK"] = color.orange,
  ["REPLACE"] = color.purple,
  ["V-REPLACE"] = color.magenta,
  ["ENTER"] = color.magenta,
  ["MORE"] = color.magenta,
  ["SELECT"] = color.red,
  ["SHELL"] = color.cyan,
  ["TERM"] = color.green,
  ["NONE"] = color.gray_2,
  ["COMMAND"] = color.blue,
}

local component = {}

local function get_vim_mode()
  local mode = vim.api.nvim_get_mode().mode
  if mode then
    return mode_alias[mode]
  end
end

local function get_mode_color()
  local mode = get_vim_mode()
  if mode then
    return vi_mode_colors[mode]
  end
end

component.vi_mode = {
  provider = function()
    local mode = get_vim_mode()
    mode = mode or "TERM"
    if mode then
      return "  " .. mode .. " "
    end
  end,
  hl = function()
    return {
      fg = color.bg_0,
      bg = get_mode_color(),
      style = "bold",
    }
  end,
}

component.vi_mode_sep = {
  provider = icons.separators.right_round,
  hl = function()
    return {
      fg = get_mode_color(),
      bg = color.bg_1,
    }
  end,
}

component.git_branch = {
  provider = "git_branch",
  icon = " ",
  hl = {
    fg = color.gray_2,
    bg = color.bg_0,
  },
  left_sep = "block",
  right_sep = "",
}

component.file_info = {
  provider = "file_info",
  hl = {
    fg = color.white_darker,
  },
  left_sep = "block",
}

component.diagnostic_errors = {
  provider = "diagnostic_errors",
  hl = {
    fg = color.red,
    bg = color.gray_1,
  },
}

component.diagnostic_warnings = {
  provider = "diagnostic_warnings",
  hl = {
    fg = color.yellow,
    bg = color.gray_1,
  },
}

component.diagnostic_hints = {
  provider = "diagnostic_hints",
  hl = {
    fg = color.cyan,
    bg = color.gray_1,
  },
}

component.diagnostic_info = {
  provider = "diagnostic_info",
  hl = {
    fg = color.white_darker,
    bg = color.gray_1,
  },
}

component.lsp = {
  provider = "lsp_client_names",
  hl = {
    fg = color.white_darker,
    bg = color.gray_1,
  },
}

component.position = {
  provider = "position",
  left_sep = "block",
  right_sep = "block",
  hl = {
    fg = color.white_darker,
    bg = color.bg_0,
  },
}

component.line_percentage = {
  provider = "line_percentage",
  hl = {
    fg = color.white_darker,
    bg = color.bg_0,
  },
  left_sep = "block",
  right_sep = "block",
}

component.scroll_bar = {
  provider = "scroll_bar",
  hl = {
    fg = color.white_darker,
    style = "bold",
  },
}
--
component.git_add = {
  provider = "git_diff_added",
  hl = {
    fg = color.green,
    -- bg = "bg",
  },
  left_sep = "",
  right_sep = "",
}

component.git_delete = {
  provider = "git_diff_removed",
  hl = {
    fg = color.red,
    -- bg = "bg",
  },
  left_sep = "",
  right_sep = "",
}

component.git_change = {
  provider = "git_diff_changed",
  hl = {
    fg = color.magenta,
    -- bg = "bg",
  },
  left_sep = "",
  right_sep = "",
}

component.separator = {
  provider = " ",
  hl = {
    fg = color.gray_1,
    bg = color.gray_1,
  },
}

component.separator_lsp_left_0 = {
  provider = "",
  hl = {
    fg = color.bg_1,
    bg = color.bg_0,
  },
}

component.separator_lsp_left_1 = {
  provider = "",
  hl = {
    fg = color.gray_1,
    bg = color.bg_1,
  },
}

component.separator_lsp_right_0 = {
  provider = "",
  hl = {
    fg = color.gray_1,
    bg = color.bg_1,
  },
}

component.separator_lsp_right_1 = {
  provider = "",
  hl = {
    fg = color.bg_1,
    bg = color.bg_0,
  },
}

component.file_type = {
  provider = {
    name = "file_type",
    opts = {
      filetype_icon = true,
      case = "lowercase",
    },
  },
  hl = {
    fg = color.white_darker,
    -- bg = ,
  },
  left_sep = "block",
  right_sep = "block",
}

component.navic_position = {
  provider = function()
    if not vim.g.navic_available then
      return nil
    end
    local has_navic, nvim_navic = pcall(require, "nvim-navic")
    if not has_navic then
      return nil
    end

    local str = nvim_navic.get_location()
    return str == "" and "" or string.format(" %s", str)
  end,
  enabled = function()
    if not vim.g.navic_available then
      return nil
    end
    local has_navic, nvim_navic = pcall(require, "nvim-navic")
    return has_navic and nvim_navic and nvim_navic.is_available()
  end,
  hl = {
    fg = color.gray_3,
    bg = color.bg_0,
  },
}

local left = {
  component.vi_mode,
  component.vi_mode_sep,
  component.separator_lsp_right_1,
  component.file_info,
  component.git_branch,
  component.git_add,
  component.git_delete,
  component.git_change,
}
local middle = {
  component.navic_position,
}
local right = {
  component.file_type,
  component.separator_lsp_left_0,
  component.separator_lsp_left_1,
  component.lsp,
  component.diagnostic_errors,
  component.diagnostic_warnings,
  component.diagnostic_info,
  component.diagnostic_hints,
  component.separator_lsp_right_0,
  component.separator_lsp_right_1,
  component.position,
  component.line_percentage,
  -- component.scroll_bar,
}

local components = {
  active = {
    left,
    middle,
    right,
  },
}

feline.setup({
  components = components,
  theme = {
    bg = color.bg_0,
  },
  vi_mode_colors = vi_mode_colors,
})
