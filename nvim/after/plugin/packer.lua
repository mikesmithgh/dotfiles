-- referenced https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/plugins-setup.lua

-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- add list of plugins to install
return packer.startup(function(use)
  -- packer can manage itself
  use("wbthomason/packer.nvim")

  -- fzf finder
  use { 'ibhagwan/fzf-lua',
    -- optional for icon support
    requires = { 'nvim-tree/nvim-web-devicons' }
  }

  -- treesitter configuration
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })
  use('nvim-treesitter/playground')

  -- guvbox theme
  use("ellisonleao/gruvbox.nvim")


  -- statusline, tabline, windowline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- project drawer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- kinesis advantage syntax highlighting
  use("https://github.com/arjenl/vim-kinesis")

  -- code commenter
  use('https://github.com/preservim/nerdcommenter')

  -- git integration
  use('https://github.com/tpope/vim-fugitive')

  -- git browser integration
  use('https://github.com/tpope/vim-rhubarb')

  -- git diff in sign column
  use('https://github.com/airblade/vim-gitgutter')

  -- vimWiki https://github.com/vimwiki/vimwiki
  use('vimwiki/vimwiki')

  -- improved keybindings
  use('tpope/vim-unimpaired')

  -- improved repeatable commands
  use('tpope/vim-repeat')

  -- disable hybrid line numbers for non-active buffers
  use('https://github.com/jeffkreeftmeijer/vim-numbertoggle')

  use {
    'theprimeagen/harpoon',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  use('mbbill/undotree')

  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  if packer_bootstrap then
    require("packer").sync()
  end
end)
