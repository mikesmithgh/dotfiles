-- jdtls is required to be installed
-- e.g, brew install jdtls
local jdtls = require('jdtls')

local root_markers = {'gradlew', '.git'}
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
    },
  },
}

jdtls.start_or_attach(config)
