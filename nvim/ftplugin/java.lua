-- referenced https://github.com/mfussenegger/dotfiles/blob/833d634251ebf3bf7e9899ed06ac710735d392da/vim/.config/nvim/ftplugin/java.lua#L1-L149

-- jdtls is required to be installed
-- e.g, brew install jdtls
local jdtls = require('jdtls')

local root_markers = { 'gradlew', '.git', 'mvnw' }
local root_dir = require('jdtls.setup').find_root(root_markers)
local home = os.getenv('HOME')
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

if not vim.g.jdtls then
  local java_home = string.gsub(vim.fn.system("/usr/libexec/java_home -F"), "%s+", "")
  local java_version = string.gsub(vim.fn.system("/usr/libexec/java_home -F --exec javap -version"), "%s+", "")
  local java_major_version = string.match(java_version, "([^.]+)") -- split by . and get first match
  local java_runtime = 'JavaSE-' .. java_major_version
  vim.g.jdtls = {
    java_home = java_home,
    java_version = java_version,
    java_major_version = java_major_version,
    java_runtime = java_runtime,
    java = java_home .. '/bin/java',
  }
end

local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    vim.g.jdtls.java,

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1G',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    '-jar', '/opt/homebrew/Cellar/jdtls/1.18.0/libexec/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',

    '-configuration', '/opt/homebrew/Cellar/jdtls/1.18.0/libexec/config_mac',

    '-data', workspace_folder,
  },

  settings = {
    java = {
      home = vim.g.jdtls.java_home,
      configuration = {
        runtimes = {
          {
            name = vim.g.jdtls.java_runtime,
            path = vim.g.jdtls.java_home,
            default = true,
          },
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        },
      },
    },
  },
}
-- config['on_attach'] = function(client, bufnr)
--   -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
--   -- you make during a debug session immediately.
--   -- Remove the option if you do not want that.
--   -- You can use the `JdtHotcodeReplace` command to trigger it manually
--   require('jdtls').setup_dap({ hotcodereplace = 'auto' })
-- 
-- end

local on_attach = function(client, bufnr)
  print("starty")
  -- ok I officially have no idea what is going on here
  -- copied from https://github.com/mfussenegger/nvim-jdtls/wiki/Sample-Configurations
  require 'jdtls.setup'.add_commands()
  print("party1")
--   require 'jdtls'.setup_dap()
  require('jdtls').setup_dap({ hotcodereplace = 'auto' })
  print("party2")
--   require 'lsp-status'.register_progress()
  print("party3")
--   require 'compe'.setup {
--     enabled = true;
--     autocomplete = true;
--     debug = false;
--     min_length = 1;
--     preselect = 'enable';
--     throttle_time = 80;
--     source_timeout = 200;
--     incomplete_delay = 400;
--     max_abbr_width = 100;
--     max_kind_width = 100;
--     max_menu_width = 100;
--     documentation = true;
-- 
--     source = {
--       path = true;
--       buffer = true;
--       calc = true;
--       vsnip = false;
--       nvim_lsp = true;
--       nvim_lua = true;
--       spell = true;
--       tags = true;
--       snippets_nvim = false;
--       treesitter = true;
--     };
--   }
  print("party4")

--   require 'lspkind'.init()
--   require 'lspsaga'.init_lsp_saga()
-- 
--   -- Kommentary
--   vim.api.nvim_set_keymap("n", "<leader>/", "<plug>kommentary_line_default", {})
--   vim.api.nvim_set_keymap("v", "<leader>/", "<plug>kommentary_visual_default", {})
-- 
--   require 'formatter'.setup {
--     filetype = {
--       java = {
--         function()
--           return {
--             exe = 'java',
--             args = { '-jar', os.getenv('HOME') .. '/.local/jars/google-java-format.jar', vim.api.nvim_buf_get_name(0) },
--             stdin = true
--           }
--         end
--       }
--     }
--   }
-- 
--   vim.api.nvim_exec([[
--         augroup FormatAutogroup
--           autocmd!
--           autocmd BufWritePost *.java FormatWrite
--         augroup end
--       ]], true)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  print("party5")

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  print("party6")

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  print("party7")

  -- Mappings.
  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.defnition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_defnition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references() && vim.cmd("copen")<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- Java specific
  buf_set_keymap("n", "<leader>di", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
  buf_set_keymap("n", "<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
  buf_set_keymap("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
  buf_set_keymap("v", "<leader>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
  buf_set_keymap("n", "<leader>de", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
  buf_set_keymap("v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)

  buf_set_keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  print("party hardy")
  vim.api.nvim_exec([[
          hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
          hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
          hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
          augroup lsp_document_highlight
            autocmd!
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
      ]], false)
  print("yay")

end

config['on_attach'] = on_attach



-- setup jars for debug and test runners
-- local jar_patterns = {

  -- java 19 not compatible as of 12/20/22 https://github.com/eclipse-tycho/tycho/issues/958 fails on mvnw clean install
  -- git clone git@github.com:microsoft/java-debug.git && cd java-debug
  -- JAVA_HOME="$(/usr/libexec/java_home -F -v 18)" M2_HOME="$(dirname $(dirname $(readlink -f $(which mvn))))" ./mvnw clean install
--   '/Users/mike/gitrepos/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',

--   -- git clone git@github.com:dgileadi/vscode-java-decompiler.git
--   '/Users/mike/gitrepos/vscode-java-decompiler/server/*.jar',

  -- git clone git@github.com:microsoft/vscode-java-test.git && cd vscode-java-test/java-extension
  -- npm install
  -- JAVA_HOME="$(/usr/libexec/java_home -F -v 18)" M2_HOME='/opt/homebrew/Cellar/maven/3.8.6' npm run build-plugin
  -- JAVA_HOME="$(/usr/libexec/java_home -F -v 18)" M2_HOME="$(dirname $(dirname $(readlink -f $(which mvn))))" ./mvnw clean install

--   '/Users/mike/gitrepos/vscode-java-test/java-extension/com.microsoft.java.test.plugin/target/*.jar',
--   '/Users/mike/gitrepos/vscode-java-test/java-extension/com.microsoft.java.test.runner/target/*.jar',
--   '/Users/mike/gitrepos/vscode-java-test/server/*.jar',

  -- git clone git@github.com:testforstephen/vscode-pde.git && cd vscode-pde/pde/
  -- JAVA_HOME="$(/usr/libexec/java_home -F -v 18)" M2_HOME="$(dirname $(dirname $(readlink -f $(which mvn))))" ./mvnw clean install
--   '/Users/mike/gitrepos/vscode-pde/pde/org.eclipse.jdt.ls.importer.pde/target/*.jar'
-- }

-- local bundles = {}
-- for _, jar_pattern in ipairs(jar_patterns) do
--   for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
--     if not vim.endswith(bundle, 'com.microsoft.java.test.runner-jar-with-dependencies.jar')
--         and not vim.endswith(bundle, 'com.microsoft.java.test.runner.jar') then
--       table.insert(bundles, bundle)
--     end
--   end
-- end

local bundles = {

  -- java 19 not compatible as of 12/20/22 https://github.com/eclipse-tycho/tycho/issues/958 fails on mvnw clean install
  -- git clone git@github.com:microsoft/java-debug.git && cd java-debug
  -- JAVA_HOME="$(/usr/libexec/java_home -F -v 18)" M2_HOME="$(dirname $(dirname $(readlink -f $(which mvn))))" ./mvnw clean install
  vim.fn.glob("/Users/mike/gitrepos/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1), "\n",
}

  -- git clone git@github.com:dgileadi/vscode-java-decompiler.git
vim.list_extend(bundles, vim.split(vim.fn.glob("/Users/mike/gitrepos/vscode-java-decompiler/server/*.jar", 1), "\n"))

  -- git clone git@github.com:microsoft/vscode-java-test.git && cd vscode-java-test/java-extension
  -- npm install
  -- JAVA_HOME="$(/usr/libexec/java_home -F -v 18)" M2_HOME='/opt/homebrew/Cellar/maven/3.8.6' npm run build-plugin
  -- JAVA_HOME="$(/usr/libexec/java_home -F -v 18)" M2_HOME="$(dirname $(dirname $(readlink -f $(which mvn))))" ./mvnw clean install

--   vim.split(vim.fn.glob("/Users/mike/gitrepos/vscode-java-test/java-extension/com.microsoft.java.test.plugin/target/*.jar", 1), "\n"),
--   vim.split(vim.fn.glob("/Users/mike/gitrepos/vscode-java-test/java-extension/com.microsoft.java.test.runner/target/*.jar", 1), "\n"),
vim.list_extend(bundles, vim.split(vim.fn.glob("/Users/mike/gitrepos/vscode-java-test/server/*.jar", 1), "\n"))

  -- git clone git@github.com:testforstephen/vscode-pde.git && cd vscode-pde/pde/
  -- JAVA_HOME="$(/usr/libexec/java_home -F -v 18)" M2_HOME="$(dirname $(dirname $(readlink -f $(which mvn))))" ./mvnw clean install
--   vim.split(vim.fn.glob("/Users/mike/gitrepos/vscode-pde/pde/org.eclipse.jdt.ls.importer.pde/target/*.jar", 1), "\n"),
-- }

print(bundles)

local extendedClientCapabilities = jdtls.extendedClientCapabilities;
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;
config.init_options = {
  bundles = bundles;
  extendedClientCapabilities = extendedClientCapabilities;
}

jdtls.start_or_attach(config)
