-- install without yarn or npm
return {
  "iamcco/markdown-preview.nvim",
  enabled = true,
  install = function() vim.fn["mkdp#util#install"]() end,
}
