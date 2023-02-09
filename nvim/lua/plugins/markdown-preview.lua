  -- install without yarn or npm
  return {
    "iamcco/markdown-preview.nvim",
    install = function() vim.fn["mkdp#util#install"]() end,
  }
