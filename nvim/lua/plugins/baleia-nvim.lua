return {
  "m00qek/baleia.nvim",
  enabled = true,
  config = function()
    local baleia = require("baleia").setup()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_create_user_command("BaleiaColorize",
      function()
        baleia.once(vim.fn.bufnr(bufnr))
      end,
      {})
    vim.api.nvim_create_user_command("BaleiaLess",
      function()
        baleia.once(vim.fn.bufnr(bufnr))
        vim.bo.buftype = 'nofile'
        vim.bo.bufhidden = 'wipe'
        vim.bo.swapfile = false
      end,
      {})
    vim.api.nvim_create_user_command("BaleiaClear",
      function()
        local ns = vim.api.nvim_get_namespaces()["BaleiaColors"]
        vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
      end,
      {})
  end,
}
