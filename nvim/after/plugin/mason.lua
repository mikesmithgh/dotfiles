require("mason").setup()
require("mason-nvim-dap").setup({
  ensure_installed = { "python", "delve", "bash" }
})

