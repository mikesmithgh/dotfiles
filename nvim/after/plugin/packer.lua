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

--   -- code commenter
--   use('https://github.com/preservim/nerdcommenter')

-- git integration
use('https://github.com/tpope/vim-fugitive')

-- git browser integration
use('https://github.com/tpope/vim-rhubarb')

-- -- git diff in sign column
-- use('https://github.com/airblade/vim-gitgutter')

-- install without yarn or npm
use({
  "iamcco/markdown-preview.nvim",
  run = function() vim.fn["mkdp#util#install"]() end,
})

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

use('jose-elias-alvarez/null-ls.nvim')

-- java jdtls language server is setup independently
-- see ~/.config/nvim/ftplugin/java.lua for configuration
use('mfussenegger/nvim-jdtls')

use('mfussenegger/nvim-dap') -- debug adapter protocol 
use { "leoluz/nvim-dap-go" }
use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
use 'theHamsta/nvim-dap-virtual-text'

use { "jayp0521/mason-nvim-dap.nvim", requires = {"williamboman/mason.nvim", "mfussenegger/nvim-dap"}}

use 'mfussenegger/nvim-dap-python'


use 'norcalli/nvim-colorizer.lua'

use ('numToStr/Comment.nvim')

use {"akinsho/toggleterm.nvim", tag = '2.*' }

-- use 'eandrju/cellular-automaton.nvim'

-- use { 'm00qek/baleia.nvim', tag = 'v1.2.0' }

use { 'lewis6991/gitsigns.nvim' }

-- use { 'folke/tokyonight.nvim' }

-- use { 'rktjmp/lush.nvim' }

-- use {
--   "max397574/colortils.nvim",
--   cmd = "Colortils",
--   config = function()
--     require("colortils").setup()
--   end
-- }


-- use 'karb94/neoscroll.nvim'

use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

use {
  'andymass/vim-matchup',
  setup = function()
    -- may set any options here
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
  end
}

-- use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

use({
  "kylechui/nvim-surround",
  tag = "*", -- Use for stability; omit to use `main` branch for the latest features
  config = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
    })
  end
})

-- Lua
use {
  "folke/zen-mode.nvim",
  config = function()
    require("zen-mode").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
  window = {
    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    -- * a function that returns the width or the height
    width = 180, -- width of the Zen window
    height = 1, -- height of the Zen window
    -- by default, no options are changed for the Zen window
    -- uncomment any of the options below, or add other vim.wo options you want to apply
    options = {
      -- signcolumn = "no", -- disable signcolumn
      -- number = false, -- disable number column
      -- relativenumber = false, -- disable relative numbers
      -- cursorline = false, -- disable cursorline
      -- cursorcolumn = false, -- disable cursor column
      -- foldcolumn = "0", -- disable fold column
      -- list = false, -- disable whitespace characters
    },
  },
      }
    end
  }


  use { 'romgrk/barbar.nvim', wants = 'nvim-web-devicons' }

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }


  -- use { 'chomosuke/term-edit.nvim', tag = 'v1.*' }

  -- use {'hkupty/iron.nvim'}

  use 'Olical/conjure'


  use "folke/neodev.nvim"

  use {
    '/Users/mike/gitrepos/gruvsquirrel',
    config = function()
      require("gruvsquirrel").setup()
    end
  }

  -- use {
  --   '/Users/mike/gitrepos/ugbi'
  -- }

  use {
    'm00qek/baleia.nvim',
    tag = 'v1.2.0',
    config = function()
      local baleia = require("baleia").setup()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.api.nvim_create_user_command("BaleiaColorize",
        function()
          baleia.once(vim.fn.bufnr(bufnr))
        end,
        {})
      vim.api.nvim_create_user_command("BaleiaLess",
        function()
          baleia.once(vim.fn.bufnr(bufnr))
          vim.bo.buftype='nofile'
          vim.bo.bufhidden='wipe'
          vim.bo.swapfile=false
        end,
        {})
      vim.api.nvim_create_user_command("BaleiaClear",
        function()
          local ns = vim.api.nvim_get_namespaces()["BaleiaColors"]
          vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
        end,
        {})

    end
  }

  if packer_bootstrap then
    require("packer").sync()
  end
end)
