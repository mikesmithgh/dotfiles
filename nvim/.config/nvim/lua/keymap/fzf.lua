local fzf = require('fzf-lua')

local function fzf_files() 
  local fzf_cmd = os.getenv("FZF_DEFAULT_COMMAND") or "fd --type f"
  fzf.files({ cmd = fzf_cmd })
end

local function fzf_live_grep()
    local rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --max-columns=512"
    fzf.live_grep({ rg_opts = rg_opts })
end

local function fzf_lgrep_curbuf()
    local rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --max-columns=512"
    fzf.lgrep_curbuf({ rg_opts = rg_opts })
end

vim.keymap.set('n', 's', '<nop>') 
-- TODO: map ss, S, SS 
-- vim.keymap.set('n', 'S', '<nop>') 


vim.keymap.set('n', 's<leader>', require("fzf-lua.cmd").load_command)
vim.keymap.set('n', 'sf', fzf_files)
vim.keymap.set('n', 'sg', fzf_live_grep)
vim.keymap.set('n', 's/', fzf_lgrep_curbuf)
vim.keymap.set('n', 's?', fzf.spell_suggest)
vim.keymap.set('n', 'sb', fzf.buffers)
vim.keymap.set('n', 'sh', fzf.help_tags)
vim.keymap.set('n', 'sr', fzf.registers)
vim.keymap.set('n', 'st', fzf.tags)
vim.keymap.set('n', 's8', fzf.grep_cword) -- TODO: add exact match
vim.keymap.set('n', 's*', fzf.grep_cWORD) -- TODO: add exact match
vim.keymap.set('n', 'sl', fzf.resume) -- TODO: not sure about this binding


