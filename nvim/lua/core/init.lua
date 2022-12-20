vim.api.nvim_create_augroup("BashFixCommandPreventExecuteWithoutSave", { clear = true })
vim.api.nvim_create_augroup("FileTypeTOML", { clear = true })
vim.api.nvim_create_augroup("FileTypeJSONOrYAML", { clear = true })

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  group = "BashFixCommandPreventExecuteWithoutSave",
  pattern = {"bash-fc.*"},
  callback = function()
    vim.cmd('silent! !rm %')
  end
})

vim.api.nvim_create_autocmd({"FileChangedShell"}, {
  group = "BashFixCommandPreventExecuteWithoutSave",
  pattern = {"bash-fc.*"},
  callback = function()
    vim.api.nvim_echo({{"To execute the command you must write the buffer contents.", "WarningMsg"}}, true, {})
  end
})

-- -- may no longer be needed
-- vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
--   group = "FileTypeTOML",
--   pattern = { vim.fn.expand("~") .. "/.aws/config", vim.fn.expand("~") .. "/.aws/credentials" },
--   callback = function()
--     vim.cmd('setlocal filetype=confini')
--   end
-- })

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  group = "FileTypeJSONOrYAML",
  pattern = { "*.pipeline" },
  callback = function()
    -- TODO: rewrite in lua
    vim.cmd('if search(\'^---\\|\\s\\+\\w\\+:\\s*\', \'nW\') | setlocal filetype=yaml | else | setlocal filetype=json | endif')
  end
})
