vim.api.nvim_create_augroup("BashFixCommandPreventExecuteWithoutSave", { clear = true })
vim.api.nvim_create_augroup("Unhighlight", { clear = true })
vim.api.nvim_create_augroup("Backup", { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = "BashFixCommandPreventExecuteWithoutSave",
  pattern = { "bash-fc.*" },
  callback = function()
    vim.cmd('silent! !rm %')
  end
})

vim.api.nvim_create_autocmd({ "FileChangedShell" }, {
  group = "BashFixCommandPreventExecuteWithoutSave",
  pattern = { "bash-fc.*" },
  callback = function()
    vim.api.nvim_echo({ { "To execute the command you must write the buffer contents.", "WarningMsg" } }, true, {})
  end
})

vim.api.nvim_create_autocmd({ "CursorHold", "InsertEnter", "TextChanged" }, {
  group = "Unhighlight",
  pattern = { "*" },
  callback = function()
    vim.opt_local.hlsearch = false
  end
})

vim.api.nvim_create_augroup("Backup", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = "Backup",
  pattern = { "*" },
  callback = function()
    -- thank you https://gist.github.com/nepsilon/003dd7cfefc20ce1e894db9c94749755
    local current_file_dir = vim.fn.expand("%:p:h") .. '/'
    vim.opt.backupext = "===" .. current_file_dir:gsub("/", "%%") .. "===" .. vim.fn.strftime("%Y%m%dT%H%M%S") .. ".bak"
  end
})


vim.api.nvim_create_user_command('DiffOrig', function()
  -- TODO: make this not gross
  -- TODO: saw something similar on this week in neovim , check it out to see if it is different
  vim.cmd('let temp_ft=&ft | vert new | setlocal shortmess=a | set noswapfile | setlocal bufhidden=wipe | setlocal buftype=nofile | r ++edit # | silent 0d_ | let &ft=temp_ft | setlocal nomodifiable | diffthis | wincmd p | diffthis')
end, {})

vim.api.nvim_create_user_command('Woman', function(params)
  local man = require('man')
  if params.bang then
    man.init_pager()
  else
    -- TODO: there is probably a better way to write this
    local vertical_help = true
    local man_ok, man_err = pcall(man.open_page, params.count, params.smods, params.fargs)
    if not man_ok then
      vim.notify(man.errormsg or man_err, vim.log.levels.INfO)
      vertical_help = false
    end
    local help_ok, help_err
    help_ok, help_err = pcall(vim.api.nvim_cmd,
      { cmd = 'help', args = params.fargs, mods = { vertical = vertical_help } }
      , {})
    if not help_ok then
      vim.notify(help_err, vim.log.levels.INFO)
    end
  end
end, {
  bang = true,
  bar = true,
  addr = 'other',
  nargs = '*',
  complete = function(...)
    -- TODO: add help completion
    return require('man').man_complete(...)
  end,
})
