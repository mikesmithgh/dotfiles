-- TODO: causes start page issues
-- HACK: this is a hack
vim.api.nvim_create_augroup("Intro", { clear = true })
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "ModeChanged", "InsertEnter", "StdinReadPre" }, {
  group = "Intro",
  pattern = { "<buffer=1>" },
  callback = function()
    local status, lualine = pcall(require, "lualine")
    if not status then
      return true
    end
    lualine.setup {
      options = {
        icons_enabled = true,
        theme = 'gruvsquirrel',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        -- lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        -- lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {
        -- lualine_a = {'buffers'},
        -- lualine_b = {},
        -- lualine_c = {},
        -- lualine_x = {},
        -- lualine_y = {},
        -- lualine_z = {'tabs'}
      },
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
    return true -- return true to delete the autocommand
  end
})

return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  dependencies = { 'nvim-tree/nvim-web-devicons', 'mikesmithgh/gruvsquirrel.nvim' },
}
