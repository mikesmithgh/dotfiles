-- leader key
vim.g.mapleader = ' '
vim.keymap.set('n', '<space>', '<nop>') 

vim.keymap.set('n', '<leader>w', '<c-w>') 

-- toggle
vim.keymap.set('n', '<leader>t/', ':set hlsearch! <cr>') 
vim.keymap.set('n', '<leader>tl', ':set list! <cr>') 
vim.keymap.set('n', 'x', 'y') 
vim.keymap.set('n', '/', ':set hlsearch<cr>/')
vim.keymap.set('n', '?', ':set hlsearch<cr>?') 
vim.keymap.set('n', '*', ':set hlsearch<cr>*') 
vim.keymap.set('n', '#', ':set hlsearch<cr>#') 
vim.keymap.set('n', 'g*', ':set hlsearch<cr>g*') 
vim.keymap.set('n', 'g#', ':set hlsearch<cr>g#') 

-- esc insert mode
vim.keymap.set('i', 'jk', '<esc>') 

require("keymap.fzf")
