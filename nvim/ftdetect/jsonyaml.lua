vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = { "*.pipeline" },
  callback = function()
    -- TODO: rewrite in lua
    vim.cmd('if search(\'^---\\|\\s\\+\\w\\+:\\s*\', \'nW\') | setlocal filetype=yaml | else | setlocal filetype=json | endif')
  end
})

