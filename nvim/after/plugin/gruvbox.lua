-- color palette overrides
local colors = require("gruvbox.palette")
local palette_overrides = {
  black0 = "#000000",
  black1 = "#070707",
  black2 = "#0d0d0d",
  black3 = "#1a1a1a",
  bright_green = "#a7c080",
  bright_yellow = "#dbbc7f",
  bright_red = "#ff6961",
  light1 = "#c7c7c7",
  mint = "#a9d5c4",
  dim_light1 = "#a0a0a0",
  bright_orange = "#f6c177",
  tint_of_red = "#b7a7b7"
}
palette_overrides["dark0_hard"] = palette_overrides.black1
for k,v in pairs(palette_overrides) do
  colors[k] = v
end

-- highlight overrides
local highlight_groups_overrides = {
  NormalNC = { fg = colors.dim_light1, bg = colors.dark0_hard },
  Search = { fg = colors.mint, bg = colors.bg0 },
  IncSearch = { fg = colors.bright_yellow, bg = colors.bg0 },
  LineNr = { bg = colors.black1 },
  SignColumn = { bg = colors.black2 },
  ColorColumn = { bg = colors.black1 },
  VertSplit = { fg = colors.black3, bg = colors.bg0 },
  Function = { link = "GruvboxGreen" }, -- disable bold
}
highlight_groups_overrides['@string'] = { fg = colors.tint_of_red }


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
  palette_overrides = colors,
  overrides = highlight_groups_overrides,
  dim_inactive = true,
  transparent_mode = false,
}

require("gruvbox").setup(config)
vim.cmd("colorscheme gruvbox")
