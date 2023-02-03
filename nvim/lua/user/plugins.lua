local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').reset()
require('packer').init({
  compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.lua',
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'solid' })
    end,
  },
})

local use = require('packer').use

-- Packer can manage itself.
use('wbthomason/packer.nvim')

use { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  requires = {
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    'j-hui/fidget.nvim',

    -- Additional lua configuration, makes nvim stuff amazing
    'folke/neodev.nvim',
  },
}

use { -- Autocompletion
  'hrsh7th/nvim-cmp',
  requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
}

use { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  run = function()
    pcall(require('nvim-treesitter.install').update { with_sync = true })
  end,
}

use { -- Additional text objects via treesitter
  'nvim-treesitter/nvim-treesitter-textobjects',
  after = 'nvim-treesitter',
}

use{ -- File tree sidebar
  'kyazdani42/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user/plugins/nvim-tree')
  end,
}
-- Git related plugins
use 'tpope/vim-fugitive'
use 'tpope/vim-rhubarb'
use 'lewis6991/gitsigns.nvim'

-- Small other plugins
use 'navarasu/onedark.nvim' -- Theme inspired by Atom
use 'nvim-lualine/lualine.nvim' -- Fancier statusline
use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
use 'tpope/vim-surround' -- Add, change, and delete surrounding text.
use 'tpope/vim-unimpaired'-- Pairs of handy bracket mappings, like [b and ]b.
use 'tpope/vim-commentary' -- Commenting support
use 'tpope/vim-sleuth' -- Indent autodetection with editorconfig support.
use 'jessarcher/vim-heritage' -- Create files in non existing folders

-- Fuzzy Finder (files, lsp, etc)
use({
  'nvim-telescope/telescope.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  },
  config = function()
    require('user/plugins/telescope')
  end,
})

-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

-- Floating terminal
use {"akinsho/toggleterm.nvim", tag = '*', config = function()
  require("toggleterm").setup{
  direction='float'
  }
end}

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
    require('packer').sync()
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>
  augroup end
]])
