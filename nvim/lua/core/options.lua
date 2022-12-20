vim.api.nvim_create_augroup("Options", { clear = true })

-- globals
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- options
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.opt.hidden = true

vim.opt.mouse = 'a'

vim.opt.autoread = true

vim.opt.undodir = vim.fn.stdpath('state') .. '/undo'
vim.opt.undofile = true

vim.opt.scroll = 5
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = "Options",
  pattern = { "*" },
  callback = function()
    vim.opt.scroll = 5
  end
})

-- Set 7 lines visible above/below the cursor
vim.opt.scrolloff = 7


-- Ignore case when searching
vim.opt.ignorecase = true


-- Case sensitive when searching with at least one uppcase letter
vim.opt.smartcase = true

-- Highlight search results
vim.opt.hlsearch = true

-- Makes search act like search in modern browsers
vim.opt.incsearch = true

-- Always show current position
vim.opt.ruler = true

-- Configure backspace so it acts as it should act
vim.opt.backspace = {'eol','start','indent'}
vim.opt.whichwrap:append('<,>,h,l')


