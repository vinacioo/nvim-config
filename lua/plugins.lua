local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'kyazdani42/nvim-web-devicons'

  use 'nvim-lua/plenary.nvim'

  use {
    'kyazdani42/nvim-tree.lua',
    after = 'nvim-web-devicons',
    config = function()
      require('plugins/nvim-tree')
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = 'TSUpdate',
    config = function()
      require('plugins.treesitter')
    end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    event = 'BufRead'
  }

  use {
    'akinsho/bufferline.nvim',
    after = 'nvim-web-devicons',
    config = function()
      require('plugins.bufferline')
    end
  }
  
  use {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufRead',
    config = function()
      require('plugins.blankline')
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    after = 'plenary.nvim',
    config = function()
      require('plugins.gitsigns')
    end
  }

  use {
    "famiu/feline.nvim",
    after = 'nvim-web-devicons',
    config = function()
      require('plugins.statusline')
    end
  }

  use {
    'SmiteshP/nvim-gps',
    after = "nvim-treesitter",
    ft = {'json'},
    module = "nvim-gps",
    config = function()
      require('plugins.nvim-gps')
    end
  }
  
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup{
        disable_filetype = {"TelescopePrompt", "vim"},
      }
    end
  }

  use {
    'andymass/vim-matchup',
    opt = true,
  }
  

  use {
    'neovim/nvim-lspconfig',
    config = function()
      require('plugins.lspconfig')
    end
  }

  use {
    'ray-x/lsp_signature.nvim',
    after = 'nvim-lspconfig',
    config = function()
      require('plugins.lsp-signature')
    end
    }
  
  use {
    -- Snippet Engine for Neovim written in Lua.
    'L3MON4D3/LuaSnip',
    requires = 'rafamadriz/friendly-snippets',
    config = function()
      require('plugins.luasnip')
    end
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp', -- nvim-cmp source for neovim builtin LSP client
      'hrsh7th/cmp-nvim-lua', -- nvim-cmp source for nvim lua
      'hrsh7th/cmp-buffer', -- nvim-cmp source for buffer words.
      'hrsh7th/cmp-path', -- nvim-cmp source for filesystem paths.
      'hrsh7th/cmp-calc', -- nvim-cmp source for math calculation.
      'saadparwaiz1/cmp_luasnip' -- luasnip completion source for nvim-cmp
    },
    config = function()
      require('plugins.cmp')
    end
  }

  use {
    'onsails/lspkind-nvim',
    config = function()
      require('plugins.lspkind')
    end
  }

  use({
    'iamcco/markdown-preview.nvim',
    run = 'cd app && npm install',
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    config = function()
      require('plugins.markdown')
    end
  })

  use {
    'numToStr/FTerm.nvim',
    config = function()
      require('plugins.fterm')
    end
  }

  use {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    event = "BufRead",
  }

  use{
    'jose-elias-alvarez/null-ls.nvim',
    after = { 'nvim-lspconfig', 'plenary.nvim' },
    config = function()
      require("plugins.nullls")
    end,
  }

  use {
    'terrortylor/nvim-comment',
    config = function()
      require('plugins.nvim-comment')
    end
  }

  use {
    'lervag/vimtex',
    config = function()
      require('plugins.vimtex')
    end
  }

  use {
    'jupyter-vim/jupyter-vim',
    event = 'BufRead',
    ft = { 'python' }
  }

  use {
    'dense-analysis/ale',
    ft={'tex', 'latex'},
    config = function()
      require('plugins.ale')
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    module = 'telescope',
    cmd = 'Telescope',
    requires = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
      },
      {
        "nvim-telescope/telescope-media-files.nvim",
      },
    },
    config = function()
      require('plugins.telescope')
    end
  }

  use {
    'sainnhe/gruvbox-material',
    config = function()
      require('plugins.gruvbox')
    end
  }

  use {
    'folke/trouble.nvim',
    after = 'nvim-web-devicons',
    config = function()
      require("trouble").setup {}
    end
  }

  use {
    'williamboman/nvim-lsp-installer',
    after = 'nvim-lspconfig',
    config = function()
      require('plugins.lspinstaller')
    end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
