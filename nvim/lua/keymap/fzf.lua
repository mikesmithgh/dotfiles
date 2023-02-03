local fzf = require('fzf-lua')

-- TODO: these custom command options can be moved to setup

local function fzf_files()
  local fd_opts = [[--color=never --type f --hidden --follow --no-ignore --exclude node_modules --exclude .git ]]
  fzf.files({ fd_opts = fd_opts, debug = false })
end

local function fzf_live_grep()
  local rg_opts = "--sort-files --column --line-number --no-heading --color=always --smart-case --hidden --max-columns=512 -g '!{.git,node_modules}/'"
  fzf.live_grep({ rg_opts = rg_opts, debug = false, exec_empty_query =true, })
end

local function fzf_lgrep_curbuf()
  local rg_opts = "--sort-files --column --line-number --no-heading --color=always --smart-case --hidden --max-columns=512 -g '!{.git,node_modules}/'"
  fzf.lgrep_curbuf({ rg_opts = rg_opts, debug = false, { exec_empty_query=true } })
end

vim.keymap.set('n', 's<leader>', require("fzf-lua.cmd").load_command)
vim.keymap.set('n', 'sf', fzf_files)
vim.keymap.set('n', 'sp', fzf.git_files)
vim.keymap.set('n', 'sg', fzf_live_grep)
vim.keymap.set('n', 's/', fzf_lgrep_curbuf)
vim.keymap.set('n', 's?', fzf.spell_suggest)
vim.keymap.set('n', 'sb', fzf.buffers)
vim.keymap.set('n', 'sh', fzf.help_tags)
vim.keymap.set('n', 'sr', fzf.registers)
vim.keymap.set('n', 'st', fzf.tags)
vim.keymap.set('n', 'sj', fzf.jumps)
vim.keymap.set('n', 'sc', fzf.changes)
vim.keymap.set('n', 's8', fzf.grep_cword) -- TODO: add exact match
vim.keymap.set('n', 's*', fzf.grep_cWORD) -- TODO: add exact match
vim.keymap.set('n', 'sl', fzf.resume) -- TODO: not sure about this binding
vim.keymap.set('n', 'so', fzf.oldfiles) -- TODO: not sure about this binding
vim.keymap.set('n', 's:', fzf.commands)

vim.keymap.set('n', 'sT', fzf.lsp_typedefs)
vim.keymap.set('n', 'sR', fzf.lsp_references)
vim.keymap.set('n', 'sD', fzf.lsp_definitions)
vim.keymap.set('n', 'sE', fzf.lsp_declarations)
vim.keymap.set('n', 'sI', fzf.lsp_implementations)
vim.keymap.set('n', 'sS', fzf.lsp_document_symbols)
-- vim.keymap.set('n', 'sA', fzf.lsp_workspace_symbols)
vim.keymap.set('n', 'sA', fzf.lsp_live_workspace_symbols)
vim.keymap.set('n', 'sC', fzf.lsp_code_actions)
-- vim.keymap.set('n', 'sI', fzf.lsp_incoming_calls)
-- vim.keymap.set('n', 'sO', fzf.lsp_outgoing_calls)
vim.keymap.set('n', 'sW', fzf.diagnostics_document)
vim.keymap.set('n', 'sQ', fzf.diagnostics_workspace)
-- vim.keymap.set('n', 'sW', fzf.lsp_workspace_diagnostics)

vim.keymap.set('n', 'sdb', fzf.dap_breakpoints)
vim.keymap.set('n', 'sdf', fzf.dap_frames)
vim.keymap.set('n', 'sdc', fzf.dap_commands)
-- vim.keymap.set('n', 'sW', fzf.lsp_workspace_diagnostics)
