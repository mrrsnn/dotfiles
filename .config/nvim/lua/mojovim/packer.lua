-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Fuzzy Finder
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- Colorschemes
  use {
    'rose-pine/neovim',
    as = "rose-pine",
  }
  use {
    'folke/tokyonight.nvim',
    as = 'tokyonight'
  }
  use {
    'shaunsingh/nord.nvim',
    as = 'nord'
  }
  use {
    "catppuccin/nvim",
    as = "catppuccin"
  }
  use {
    'Mofiqul/dracula.nvim',
    as = 'dracula'
  }
  use {
    'everviolet/nvim',
    as = 'evergarden'
  }
  use {
    'RomanAverin/charleston.nvim',
    as = 'charleston'
  }
  use {
    'vague2k/vague.nvim',
    as = 'vague'
  }
  use {
    'thesimonho/kanagawa-paper.nvim',
    as = 'kanagawa-paper'
  }
  use {
    'wadackel/vim-dogrun',
    as = 'dogrun'
  }
  use {
    'slugbyte/lackluster.nvim',
    as = 'lackluster'
  }

  -- Abstract Syntax Tree
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'nvim-treesitter/nvim-treesitter-context',
    name = 'treesitter-context',
    config = function()
      require('treesitter-context').setup({
        enable = true,
        multiline_threshold = 1
      })
    end,
  }

  use 'nvim-tree/nvim-web-devicons'
  use { 'echasnovski/mini.icons', name = 'mini.icons' }

  -- Auto closing tags
  use 'm4xshen/autoclose.nvim'
  use {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    -- lazy = true,
    -- event = "VeryLazy"
  }
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end
  }
  use { 'jose-elias-alvarez/null-ls.nvim' }
  use { 'MunifTanjim/prettier.nvim' }

  -- Language Server Protocol setup
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'neovim/nvim-lspconfig' },
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
    }
  }

  -- Additional Plugins
  use('theprimeagen/harpoon')
  use('tpope/vim-fugitive')
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use { 'lewis6991/gitsigns.nvim' }
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 1000
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' }
  }


  -- Avante dependencies
  use 'stevearc/dressing.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'MunifTanjim/nui.nvim'
  use 'MeanderingProgrammer/render-markdown.nvim'

  use 'hrsh7th/nvim-cmp'
  use 'HakonHarnes/img-clip.nvim'
  use 'zbirenbaum/copilot.lua'

  -- AI assistant
  use {
    'yetone/avante.nvim',
    branch = 'main',
    run = 'make',
  }


end)
