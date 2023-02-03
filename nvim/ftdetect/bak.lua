vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = { "*.bak" },
  callback = function()
    -- === is a special separator for my backup files
    local file_ext = vim.fn.fnamemodify(vim.fn.expand("%"):gsub("===.*===.*..", "."), ":r:e")
    vim.opt_local.ft = file_ext
  end
})

