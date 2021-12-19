local f = vim.fn
local gps = require("nvim-gps")
local color = require('colors.palette').custom

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
    NORMAL = color.green1,
    OP = color.green1,
    INSERT = color.blue,
    VISUAL = color.magenta,
    BLOCK = color.magenta,
    REPLACE = color.orange,
    ["V-REPLACE"] = color.orange,
    ENTER = color.yellow,
    MORE = color.yellow,
    SELECT = color.yellow,
    COMMAND = color.orange,
    SHELL = color.grey,
    TERM = color.grey,
    NONE = color.grey,
}

local function get_vim_mode()
    local mode = vim.api.nvim_get_mode().mode
    if mode then
        return mode_alias[mode]
    end
end

local function get_mode_color()
    local mode = get_vim_mode()
    if mode then
        return vi_mode_colors[mode] or color.green
    end
end

local lsp = require("feline.providers.lsp")
local git = require("feline.providers.git")
local devicons = require("nvim-web-devicons")

-- Initialize the components table
local components = {
   active = {},
   inactive = {},
}

-- Initialize left, mid and right
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})


components.active[1][1] = {
  provider = function()
    local mode = get_vim_mode()
    mode = mode or "TERM"
    if mode then
      return "  " .. mode .. " "
    end
  end,
  hl = function()
    return {
      fg = color.bg_darker,
      bg = get_mode_color(),
      style = "bold",
      }
  end,
  right_sep = {
    str = " ",
    hl = {
      fg = color.grey1,
      bg = color.grey1,
    },
  },
}

components.active[1][2] = {
  provider = function()
   local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
   return "  " .. dir_name .. ""
  end,
  hl =  {
     fg = color.white3,
     bg = color.grey,
   },
  right_sep = icons.separators.square
}

components.active[1][3] = {
  provider = function()
      local icon, _ = devicons.get_icon(f.expand("%:t"))
      return icon or ""
  end,
  hl = function()
      local _, cc = devicons.get_icon_color(f.expand("%:t"))
      return {
        fg = cc,
      }
  end,
  left_sep = " ",
}

components.active[1][4] = {
  provider = function()
    local filename = vim.fn.expand "%:t"
    local extension = vim.fn.expand "%:e"
    local icon = require("nvim-web-devicons").get_icon(filename, extension)
    if icon == nil then
       icon = " "
       return icon
    end
    return " " .. filename .. " "
  end,
  hl = {
      fg = color.white3,
  },
}

components.active[1][5] = {
  provider = 'git_branch',
  icon = ' ',
  hl = {
    fg = color.grey1,
  },
}

components.active[1][6] = {
  provider = function()
    return git.git_diff_added(0)
  end,
  icon = icons.diff.added,
  enabled = function()
    return git.git_diff_added(0) ~= ""
  end,
  hl = {
    fg = color.green,
  },
  left_sep = " ",
}

components.active[1][7] = {
  provider = function()
    return git.git_diff_changed(0)
  end,
  icon = icons.diff.changed,
  enabled = function()
    return git.git_diff_changed(0) ~= ""
  end,
  hl = {
    fg = color.yellow,
  },
  left_sep = " ",
}

components.active[1][8] = {
  provider = function()
    return git.git_diff_removed(0)
  end,
  icon = icons.diff.removed,
  enabled = function()
    return git.git_diff_removed(0) ~= ""
  end,
  hl = {
    fg = color.red,
  },
  left_sep = " ",

}

components.active[3][1] = {
  provider = "diagnostic_errors",
  icon = icons.diagnostic.error,
  enabled = function()
    return lsp.diagnostics_exist("Error")
  end,
  hl = {
      fg = color.red,
  },
}

components.active[3][2] = {
  provider = "diagnostic_warnings",
  icon = icons.diagnostic.warn,
  enabled = function()
    return lsp.diagnostics_exist("Warning")
  end,
  hl = {
      fg = color.yellow,
  },
}

components.active[3][3] = {
  provider = "diagnostic_hints",
  icon = icons.diagnostic.hint,
  enabled = function()
    return lsp.diagnostics_exist("Hint")
  end,
  hl = {
    fg = color.blue,
  },
}

components.active[3][4] = {
  provider = "diagnostic_info",
  icon = icons.diagnostic.info,
  enabled = function()
    return lsp.diagnostics_exist("Information")
  end,
  hl = {
    fg = color.blue,
  },
}

components.active[3][5] = {
  provider = function()
    return gps.get_location()
  end,
  enabled = function()
    return gps.is_available()
  end,
  hl = {
    fg = color.white2,
    -- bg = color.grey,
  },
  right_sep = {
    str = " ",
    hl = {
      fg = color.bg_darker,
      bg = color.bg_darker,
    },
  },
  left_sep = {
    str = " ",
    hl = {
      fg = color.bg_darker,
      bg = color.bg_darker,
    },
  },
}
 
components.active[3][6] = {
  provider = "lsp_client_names",
  icon = "  ",
  hl = {
    fg = color.grey1,
  },
  right_sep = " ",
}

components.active[3][7] = {
  provider = function()
    local c = require("feline.providers.cursor")
    return " " .. c.position() .. " " .. c.line_percentage() .. " "
  end,
  hl = {
    fg = color.bg,
    bg = color.blue,
  },
  left_sep = {
    str = " ",
    hl = {
      fg = color.grey1,
      bg = color.grey1,
    },
  },
}

components.active[3][8] = {
  provider = icons.separators.position_icon,
  hl =  {
    fg = color.bg_darker,
    bg = color.blue,
  }
}

require("feline").setup {
  colors = {
    bg = color.bg_darker,
    fg = color.bg,
  },
  components = components,
  force_inactive = {
    filetypes = {
      'NvimTree',
      'dbui',
      'packer',
      'startify',
      'fugitive',
      'fugitiveblame',
      'filittle',
      'quickrun',
    }
  }
}
