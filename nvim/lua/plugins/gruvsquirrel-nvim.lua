return {
  {
    "mikesmithgh/gruvsquirrel.nvim",
    priority = 1000,
    lazy = false,
    name = "gruvsquirrel",
    dev = true,
    config = function()
      -- load colorscheme on startup
      vim.cmd([[colorscheme gruvsquirrel]])
    end,
  },
}
