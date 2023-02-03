-- leader key
vim.g.mapleader = ' '
vim.keymap.set('n', '<space>', '<nop>') 


-- pseudo leaders
vim.keymap.set('n', 's', '<nop>') -- used by kemap.fzf 
vim.keymap.set('n', '<c-n>', '<nop>') -- used by NvimTree still in init.vim

-- TODO: more pseudo leaders

-- TODO: ctrl enter, shift enter https://stackoverflow.com/questions/16359878/how-to-map-shift-enter/42461580#42461580


-- TODO: check if terminal and was normal mode, if so set to normal mode
vim.api.nvim_set_keymap('n', '<c-w><c-o>', '<cmd>ZenMode<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-w>o', '<cmd>ZenMode<cr>', { noremap = true, silent = true })

vim.keymap.set('n', 'S', function() vim.api.nvim_echo({{"~ TODO: map S as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<bs>', function() vim.api.nvim_echo({{"~ TODO: map <bs> as pseudo leader ~", "Comment"}}, false, {}) end)
vim.keymap.set('n', '<s-bs>', function() vim.api.nvim_echo({{"~ TODO: map <bs> as pseudo leader ~", "Comment"}}, false, {}) end)
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
-- vim.keymap.set('n', '<c-w>', function() vim.api.nvim_echo({{"~ use <bs> instead of <c-w>", "Comment"}}, false, {}) end)
-- vim.keymap.set('n', '<bs>', '<c-w>')
-- vim.keymap.set('n', '<bs><bs>', '<c-w><c-w>')
-- vim.keymap.set('n', '<bs><s-bs>', '<c-w><c-w>')
-- vim.keymap.set('n', '<s-bs>', '<c-w>')
-- vim.keymap.set('n', '<s-bs><s-bs>', '<c-w><c-w>')
-- vim.keymap.set('n', '<s-bs><bs>', '<c-w><c-w>')

-- toggle
-- vim.keymap.set('n', '<leader>t/', ':set hlsearch! <cr>') 
-- vim.keymap.set('n', '<leader>tl', ':set list! <cr>') 
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

-- tasty keymaps modified from https://github.com/ThePrimeagen/init.lua/blob/bc8324fa1c31bd1bc81fb8a5dde684dffd324f84/lua/theprimeagen/remap.lua
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "<C-t>", "<C-t>zz")
vim.keymap.set("n", "<C-]>", "<C-]>zz")
vim.keymap.set("n", "]c", "]czz")
vim.keymap.set("n", "[c", "[czz")
vim.keymap.set("n", "do", "do]czz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<a-n>", 'j0nzzzv')
vim.keymap.set("n", "<a-s-n>", '0Nzzzv')

-- Show all diagnostics on current line in floating window
vim.api.nvim_set_keymap('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n',  ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', {})
vim.api.nvim_set_keymap('n',  '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', {})

-- yanks and puts
vim.api.nvim_set_keymap('v', '<leader>Y', '"+Y', {})
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', {})
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', {})
vim.api.nvim_set_keymap('v', '<leader>P', '"+P', {})

vim.api.nvim_set_keymap('n', '<leader>Y', '"+y$', {})
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', {})
vim.api.nvim_set_keymap('n', '<leader>yy', '"+yy', {})
vim.api.nvim_set_keymap('n', '<leader>p', '"+p<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>P', '"+P<CR>', {})

-- todo zy and zp mappings

vim.api.nvim_set_keymap('c', 'w!!', 'w !sudo tee > /dev/null %', {})


vim.api.nvim_set_keymap('n', '<C-e>', '5<C-e>', {})
vim.api.nvim_set_keymap('n', '<C-y>', '5<C-y>', {})
vim.api.nvim_set_keymap('n', '<C-h>', '3h', {})
vim.api.nvim_set_keymap('n', '<C-j>', '5j', {})
vim.api.nvim_set_keymap('n', '<C-k>', '5k', {})
vim.api.nvim_set_keymap('n', '<C-l>', '3l', {})
vim.api.nvim_set_keymap('v', '<C-h>', '3h', {})
vim.api.nvim_set_keymap('v', '<C-j>', '5j', {})
vim.api.nvim_set_keymap('v', '<C-k>', '5k', {})
vim.api.nvim_set_keymap('v', '<C-l>', '3l', {})

-- Don't use Q for Ex mode, use it for formatting.  Except for Select mode.
vim.keymap.set("n", "Q", "gq")

-- TODO: convert to more lua
vim.api.nvim_set_keymap('n', '<a-left>', ':vertical resize -5<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<a-right>', ':vertical resize +5<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<a-up>', ':resize +5<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<a-down>', ':resize -5<cr>', { silent = true })

vim.api.nvim_set_keymap('n', '<c-n>n', ':NvimTreeToggle<CR>', {})
vim.keymap.set('n', '<C-n><C-n>', function()
  -- TODO: improve in lua 
  if vim.opt.filetype:get() == 'NvimTree' then
    vim.cmd('wincmd p')
  else
    vim.cmd('NvimTreeFindFile | NvimTreeFocus')
  end
end, {})
vim.api.nvim_set_keymap('n', '<c-n><C-q>', ':copen<CR>', {})
vim.api.nvim_set_keymap('n', '<c-n>q', ':cclose<CR>', {})
vim.api.nvim_set_keymap('n', '<c-n><C-l>', ':lopen<CR>', {})
vim.api.nvim_set_keymap('n', '<c-n>l', ':lclose<CR>', {})

-- TODO: keep this until it conflicts
vim.keymap.set("t", "<esc>", '<c-\\><c-n>')

vim.keymap.set('t', '<c-w>', '<c-\\><c-n><c-w>')
vim.api.nvim_set_keymap('t', '<c-w><c-o>', '<c-\\><c-n><cmd>ZenMode<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<c-w>o', '<c-\\><c-n><cmd>ZenMode<CR>', { noremap = true, silent = true })

vim.keymap.set('i', '<c-w>', '<esc><c-w>')

-- assumption sidepane on left TODO: turn into function
vim.keymap.set({'n', 'i', 't'}, '<c-w>k', function()
  -- if vim.opt.filetype:get() == 'toggleterm' then
    vim.cmd('wincmd k')
    if vim.opt.filetype:get() == 'NvimTree' then
      vim.cmd('wincmd l')
    end
  -- else
    -- vim.cmd('wincmd k')
  -- end
end, {})

-- assumption sidepane on left TODO: turn into function
vim.keymap.set({'n', 'i', 't'}, '<c-w>j', function()
  -- if vim.opt.filetype:get() == 'toggleterm' then
    vim.cmd('wincmd j')
    if vim.opt.filetype:get() == 'NvimTree' then
      vim.cmd('wincmd l')
    end
  -- else
    -- vim.cmd('wincmd k')
  -- end
end, {})


--- Enable completion triggered by <c-x><c-o>

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
local bufopts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>lD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', '<leader>lk', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, bufopts)
vim.keymap.set('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, bufopts)
vim.keymap.set('n', '<leader>lwl', function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, bufopts)
vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, bufopts)
vim.keymap.set('n', '<leader>lR', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', '<leader>lc', vim.lsp.buf.code_action, bufopts)
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, bufopts)
vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, bufopts)

-- vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")
-- TODO: make this return a table
require("keymap.fzf")
