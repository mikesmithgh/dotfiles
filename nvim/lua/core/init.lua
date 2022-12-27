vim.api.nvim_create_augroup("BashFixCommandPreventExecuteWithoutSave", { clear = true })
vim.api.nvim_create_augroup("Unhighlight", { clear = true })

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

vim.api.nvim_create_user_command('DiffOrig', function()
  -- TODO: make this not gross
  vim.cmd('let temp_ft=&ft | vert new | setlocal shortmess=a | set noswapfile | setlocal bufhidden=wipe | setlocal buftype=nofile | r ++edit # | silent 0d_ | let &ft=temp_ft | setlocal nomodifiable | diffthis | wincmd p | diffthis')
end, {})
