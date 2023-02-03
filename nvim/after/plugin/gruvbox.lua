-- color palette overrides
-- TODO: do this generically for all plugins
-- local status, colors = pcall(require, "gruvbox.palette")
-- if not status then
--   return
-- end
-- local palette_overrides = {
--   black0 = "#000000",
--   black1 = "#070707",
--   black2 = "#0d0d0d",
--   black3 = "#1a1a1a",
--   -- bright_green = "#a7c080",
--   bright_green = "#8faa80",
--   bright_yellow = "#dbbc5f",
--   bright_red = "#ff6961",
--   light1 = "#c7c7c7",
--   bright_aqua = "#9dbad4",
--   bright_blue = "#83a598", -- default
--   -- defaults start
--   -- bright_red = "#fb4934",
--   -- bright_green = "#b8bb26",
--   -- bright_yellow = "#fabd2f",
--   -- bright_blue = "#83a598",
--   -- bright_purple = "#d3869b",
--   -- bright_aqua = "#8ec07c",
--   -- bright_orange = "#fe8019",
--   -- defaults stop
-- -- rose pine
-- 		-- base = '#191724',
-- 		-- surface = '#1f1d2e',
-- 		-- overlay = '#26233a',
-- 		-- muted = '#6e6a86',
-- 		-- subtle = '#908caa',
-- 		-- text = '#e0def4',
-- 		-- love = '#eb6f92',
-- 		-- gold = '#f7ae18',
-- 		-- rose = '#ebbcba',
-- 		-- pine = '#31748f',
-- 		-- foam = '#9ccfd8',
-- 		-- iris = '#c4a7e7',
-- 		-- highlight_low = '#21202e',
-- 		-- highlight_med = '#403d52',
-- 		-- highlight_high = '#524f67',
-- 		-- none = 'NONE',
-- --
--   mint = "#a9d5c4",
--   dim_light1 = "#a0a0a0",
--   bright_orange = "#d6991d",
--   tint_of_red = "#b7a7b7"
--
-- -- let g:terminal_color_0  = '#352F2A'
-- -- let g:terminal_color_1  = '#B65C60'
-- -- let g:terminal_color_2  = '#78997A'
-- -- let g:terminal_color_3  = '#EBC06D'
-- -- let g:terminal_color_4  = '#9AACCE'
-- -- let g:terminal_color_5  = '#B380B0'
-- -- let g:terminal_color_6  = '#86A3A3'
-- -- let g:terminal_color_7  = '#A38D78'
-- -- let g:terminal_color_8  = '#4D453E'
-- -- let g:terminal_color_9  = '#F17C64'
-- -- let g:terminal_color_10 = '#99D59D'
-- -- let g:terminal_color_11 = '#EBC06D'
-- -- let g:terminal_color_12 = '#9AACCE'
-- -- let g:terminal_color_13 = '#CE9BCB'
-- -- let g:terminal_color_14 = '#88B3B2'
-- -- let g:terminal_color_15 = '#C1A78E'
-- }
-- palette_overrides["dark0_hard"] = palette_overrides.black1
-- for k,v in pairs(palette_overrides) do
--   colors[k] = v
-- end
--
-- -- highlight overrides
-- local highlight_groups_overrides = {
-- }
--
--
local config = {
  undercurl = true,
  underline = true,
  bold = true,
  italic = true,
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = true,
  transparent_mode = false,
}
--
require("gruvbox").setup(config)
-- -- vim.cmd("colorscheme gruvbox")
-- vim.cmd("hi CursorLine ctermfg=white") -- hack, see https://github.com/neovim/neovim/issues/9800
