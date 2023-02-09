return {

  -- tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon" },
  },

  -- catppuccin
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
  },
  {
    "mikesmithgh/gruvsquirrel.nvim",
    priority = 1000,
    lazy = false,
    name = "gruvsquirrel",
    dev = true,
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme gruvsquirrel]])
    end,
  },
}
