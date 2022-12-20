local lsp = require("lsp-zero")

lsp.preset("recommended")

-- lsp servers are available at the below path
-- lua print(vim.fn.stdpath('data') .. '/site/pack/packer/start/nvim-lspconfig/lua/lspconfig/server_configurations/')

local lua_language_server = 'sumneko_lua' -- see https://github.com/sumneko/lua-language-server/wiki/Settings

-- Do not use the java language server in this config, it is setup independently
-- local java_language_server = 'nvim-jdtls' -- https://github.com/mfussenegger/nvim-jdtls
-- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jdtls
-- IMPORTANT: If you want all the features jdtls has to offer, nvim-jdtls is highly recommended. 
-- If all you need is diagnostics, completion, imports, gotos and formatting and some code actions 
-- you can keep reading here.


lsp.ensure_installed({
  lua_language_server,
})

lsp.nvim_workspace()

lsp.setup()

lsp.configure(lua_language_server, {
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          'vim',
        },
      },
    },
  },
})

