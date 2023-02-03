-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

local lsp = require("lsp-zero")

-- lsp.preset("recommended")
lsp.set_preferences({
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = true,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = 'local',
  sign_icons = {
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = ''
  }
})

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

-- lsp.nvim_workspace()

-- some information from :h lspconfig-all
lsp.configure(lua_language_server, {
  settings = {
    Lua = {
      format = {
        enable = true,
        -- Put format options here
        -- NOTE: the value should be STRING!!
        -- defaultConfig = {
        --   indent_style = "space",
        --   indent_size = "2",
        -- }
      },
      completion = {
        autoRequire = true,
        callSnippet = "Both",
        displayContext = 5,
        enable = true,
        keywordSnippet = "Both",
        postfix = '@',
        requireSeparator = '.',
        showParams = true,
        showWord = "Enable",
        workspaceWord = true,
      },
      {
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
      },
      runtime = {
        -- :lua print(jit.version)  =>  LuaJIT 2.1.0-beta3
        version = 'LuaJIT',
      },
      telemetry = {
        enable = false,
      },
      diagnostics = {
        globals = {
          'vim',
        },
      },
      hint = {
        arrayIndex = "Enable",
        await = true,
        enable = true,
        paramName = "All",
        paramType = true,
        semicolon = "SameLine",
        setType = true,
      },
      hover = {
        enable = true,
        enumsLimit = 10,
        expandAlias = true,
        previewFields = 50,
        viewNumber = true,
        viewStringMax = 1000,
      },
      codeLens = {
        enable = true,
      }
    },
  },
})

lsp.configure("pylsp", {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { 'W391' },
          maxLineLength = 100
        },
      },
    },
  },
})

lsp.setup()
