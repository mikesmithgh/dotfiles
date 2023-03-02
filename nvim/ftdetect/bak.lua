vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.bak" },
  callback = function()
    local file_ext = vim.fn.expand("<afile>:r:e")
    vim.opt_local.ft = file_ext
  end
})


vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "%*%*.bak" },
  callback = function()
    -- special format for backup files
    local file_ext = vim.fn.fnamemodify(vim.fn.expand('<afile>:t'):gsub("[0-9]+T[0-9]+%.bak", "bak"), ":t:r:e")
    vim.opt_local.ft = file_ext
  end
})
