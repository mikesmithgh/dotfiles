-- leader key
vim.g.mapleader = ' '
vim.keymap.set('n', '<space>', '<nop>') 


-- pseudo leaders
vim.keymap.set('n', 's', '<nop>') -- used by kemap.fzf 
vim.keymap.set('n', '<c-n>', '<nop>') -- used by NvimTree still in init.vim

-- TODO: more pseudo leaders
vim.keymap.set('n', 'S', function() vim.api.nvim_echo({{"~ TODO: map S as pseudo leader ~", "Comment"}}, false, {}) end)
-- vim.keymap.set('n', '<bs>', function() vim.api.nvim_echo({{"~ TODO: map <bs> as pseudo leader ~", "Comment"}}, false, {}) end)
-- vim.keymap.set('n', '<cr>', function() vim.api.nvim_echo({{"~ TODO: map <cr> as pseudo leader ~", "Comment"}}, false, {}) end) -- conflicts with enter in q: mode
vim.keymap.set('n', '<left>', function() vim.api.nvim_echo({{"~ TODO: map <left> as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<up>', function() vim.api.nvim_echo({{"~ TODO: map <up> as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<right>', function() vim.api.nvim_echo({{"~ TODO: map <right> as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<down>', function() vim.api.nvim_echo({{"~ TODO: map <down> as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<esc>', function() vim.api.nvim_echo({{"~ TODO: map <esc> as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<del>', function() vim.api.nvim_echo({{"~ TODO: map <del> as pseudo leader ~", "Comment"}}, false, {}) end)
-- vim.keymap.set('n', '<tab>', function() vim.api.nvim_echo({{"~ TODO: map <tab> as pseudo leader ~", "Comment"}}, false, {}) end) -- conflicts with <c-i>
vim.keymap.set('n', '<s-tab>', function() vim.api.nvim_echo({{"~ TODO: map <s-tab> as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<home>', function() vim.api.nvim_echo({{"~ TODO: map <home> as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<end>', function() vim.api.nvim_echo({{"~ TODO: map <end> as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '+', function() vim.api.nvim_echo({{"~ TODO: map + as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '-', function() vim.api.nvim_echo({{"~ TODO: map - as pseudo leader ~", "Comment"}}, false, {}) end)
-- vim.keymap.set('n', '<c-m>', function() vim.api.nvim_echo({{"~ TODO: map <c-m> as pseudo leader ~", "Comment"}}, false, {}) end) -- conflicts with enter in q: mode
vim.keymap.set('n', '<c-p>', function() vim.api.nvim_echo({{"~ TODO: map <c-p> as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<c-end>', function() vim.api.nvim_echo({{"~ TODO: map <c-end> as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<c-home>', function() vim.api.nvim_echo({{"~ TODO: map <c-home> as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<s-left>', function() vim.api.nvim_echo({{"~ TODO: map <s-left> as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<s-up>', function() vim.api.nvim_echo({{"~ TODO: map <s-up> as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<s-right>', function() vim.api.nvim_echo({{"~ TODO: map <s-right> as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<s-down>', function() vim.api.nvim_echo({{"~ TODO: map <s-down> as pseudo leader ~", "Comment"}}, false, {}) end)
-- vim.keymap.set('n', '<w>', function() vim.api.nvim_echo({{"~ TODO: map <w> as pseudo leader ~", "Comment"}}, false, {}) end)
-- vim.keymap.set('n', '<w>', function() vim.api.nvim_echo({{"~ TODO: map <w> as pseudo leader ~", "Comment"}}, false, {}) end)
-- vim.keymap.set('n', '<w>', function() vim.api.nvim_echo({{"~ TODO: map <w> as pseudo leader ~", "Comment"}}, false, {}) end)
-- vim.keymap.set('n', '<w>', function() vim.api.nvim_echo({{"~ TODO: map <w> as pseudo leader ~", "Comment"}}, false, {}) end)
-- vim.keymap.set('n', '<w>', function() vim.api.nvim_echo({{"~ TODO: map <w> as pseudo leader ~", "Comment"}}, false, {}) end)
-- alt keys are up for grabs
vim.keymap.set('n', '<a-down>', function() vim.api.nvim_echo({{"~ TODO: map <a-down> as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<a-j>', function() vim.api.nvim_echo({{"~ TODO: map <a-j> as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<c-a-j>', function() vim.api.nvim_echo({{"~ TODO: map <c-a-j> as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<s-c-j>', function() vim.api.nvim_echo({{"~ TODO: map <s-c-j> as pseudo leader ~", "Comment"}}, false, {}) end)

-- fn keys
-- macos > f11 disable mission control > show desktop binding to f11
vim.keymap.set('n', '<f11>', function() vim.api.nvim_echo({{"~ TODO: map <f11> as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<fn>', function() vim.api.nvim_echo({{"~ TODO: map <fn> as pseudo leader ~", "Comment"}}, false, {}) end)
-- fn globe key on mac?


vim.keymap.set('n', '<leader>w', function() vim.api.nvim_echo({{"~ use <bs> instead of <leader>w", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<c-w>', function() vim.api.nvim_echo({{"~ use <bs> instead of <c-w>", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<bs>', '<c-w>') vim.keymap.set('n', '<bs><bs>', '<c-w><c-w>')

-- toggle
vim.keymap.set('n', '<leader>t/', ':set hlsearch! <cr>') 
vim.keymap.set('n', '<leader>tl', ':set list! <cr>') 
vim.keymap.set('n', '/', ':set hlsearch<cr>/')
vim.keymap.set('n', '?', ':set hlsearch<cr>?') 
vim.keymap.set('n', '*', ':set hlsearch<cr>*') 
vim.keymap.set('n', '#', ':set hlsearch<cr>#') 
vim.keymap.set('n', 'g*', ':set hlsearch<cr>g*') 
vim.keymap.set('n', 'g#', ':set hlsearch<cr>g#') 

-- esc insert mode
vim.keymap.set('i', 'jk', '<esc>') 

-- black hole register "_
vim.keymap.set('n', 'x', '"_x') 

-- tasty keymaps from https://github.com/ThePrimeagen/init.lua/blob/bc8324fa1c31bd1bc81fb8a5dde684dffd324f84/lua/theprimeagen/remap.lua
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Show all diagnostics on current line in floating window
vim.api.nvim_set_keymap('n', '<Leader>d', ':lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })

-- TODO: make this return a table
require("keymap.fzf")

