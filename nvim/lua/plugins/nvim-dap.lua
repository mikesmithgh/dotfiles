return {
  "mfussenegger/nvim-dap",
  config = function()
    -- copied from https://github.com/mfussenegger/dotfiles/blob/833d634251ebf3bf7e9899ed06ac710735d392da/vim/.config/nvim/lua/me/dap.lua
    local api = vim.api
    local M = {}
    local log_level = 'INFO'


    local function reload()
      require('dap.repl').close()
      M.setup()
      require('jdtls.dap').setup_dap({ hotcodereplace = 'auto' })
      vim.cmd('set ft=' .. vim.bo.filetype)
      require('dap').set_log_level(log_level)
    end

    function M.setup()

      -- TODO: revist and improve highlights
      local signs = {
        DapBreakpoint = { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" },
        DapBreakpointCondition = { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" },
        DapBreakpointRejected = { text = '', texthl = 'DiagnosticError', linehl = '', numhl = '' },
        DapLogPoint = { text = '', texthl = 'DiagnosticError', linehl = '', numhl = '' },
        DapStopped = { text = '', texthl = 'DiagnosticWarn', linehl = 'PmenuSel', numhl = 'PmenuThumb' },
      }
      for name, opts in pairs(signs) do
        vim.fn.sign_define(name, opts)
      end

      local status, dap = pcall(require, "dap")
      if not status then
        return
      end

      local orig_set_log_level = dap.set_log_level
      function dap.set_log_level(level)
        orig_set_log_level(level)
        log_level = level
      end

      -- local widgets
      -- status, widgets = pcall(require, "dap.ui.widgets")
      -- if not status then
      --   return
      -- end
      local keymap = vim.keymap
      local function set(mode, lhs, rhs)
        keymap.set(mode, lhs, rhs, { silent = true })
      end

      -- TODO: move mappings to keymaps file

      set('n', '<leader>b', dap.toggle_breakpoint)
      set('n', '<f9>', dap.toggle_breakpoint) -- vscode
      set('n', '<leader>B', function()
        dap.toggle_breakpoint(vim.fn.input('Breakpoint Condition: '), nil, nil, true)
      end)
      set('n', '<leader>lp', function()
        dap.toggle_breakpoint(nil, nil, vim.fn.input('Log point message: '), true)
      end)

      set('n', '<f5>', dap.continue) -- vscode

      set('n', '<f11>', dap.step_into) -- vscode
      set('n', '<s-f11>', dap.step_out) -- vscode
      set('n', '<f23>', dap.step_out) -- vscode, same as <s-f11>

      set('n', '<f10>', dap.step_over) -- vscode

      set('n', '<s-f5>', dap.terminate) -- vscode
      set('n', '<f17>', dap.terminate) -- vscode, same as <s-f5>

      -- set('n', '<leader>dr', function() dap.repl.toggle({ height = 15 }) end)
      set('n', '<leader>dl', dap.run_last)
      set('n', '<leader>dj', dap.down)
      set('n', '<leader>dk', dap.up)
      set('n', '<leader>dc', dap.run_to_cursor)

      -- set('n', '<leader>dS', function() widgets.centered_float(widgets.frames) end)
      -- set('n', '<leader>dt', function() widgets.centered_float(widgets.threads) end)
      -- set('n', '<leader>ds', function() widgets.centered_float(widgets.scopes) end)
      -- set('n', '<leader>dh', widgets.hover)
      -- set('v', '<leader>dh',
      --   [[<ESC><CMD>lua require'dap.ui.widgets'.hover(require("dap.utils").get_visual_selection_text)<CR>]])

      dap.listeners.before.event_initialized["dapui_config"] = function()
        local dapui
        status, dapui = pcall(require, "dapui")
        if not status then
          return
        end
        dapui.setup()
        vim.api.nvim_notify("::::::::: init (before)", vim.log.levels.INFO, {})
      end

      dap.listeners.after.event_initialized["dapui_config"] = function()
        local dapui
        status, dapui = pcall(require, "dapui")
        if not status then
          return
        end
        dapui.open()
        vim.api.nvim_notify("::::::::: init (after)", vim.log.levels.INFO, {})
      end

      dap.listeners.after.event_terminated["dapui_config"] = function()
        vim.api.nvim_notify("::::::::: terminated", vim.log.levels.INFO, {})
      end
      dap.listeners.after.disconnected["dapui_config"] = function()
        vim.api.nvim_notify("::::::::: disconnected", vim.log.levels.INFO, {})
      end
      dap.listeners.after.event_exited["dapui_config"] = function()
        vim.api.nvim_notify("::::::::: exited", vim.log.levels.INFO, {})
      end

      -- local sidebar = widgets.sidebar(widgets.scopes)
      -- api.nvim_create_user_command('DapSidebar', sidebar.toggle, { nargs = 0 })
      api.nvim_create_user_command('DapReload', reload, { nargs = 0 })
      api.nvim_create_user_command('DapBreakpoints', function() dap.list_breakpoints(true) end, { nargs = 0 })
      -- help dap-configuration
      api.nvim_create_user_command('DapLoadJavaConfigurations', function()
        dap.configurations.java = {
          {
            type = 'java',
            request = 'launch',
            name = "Ingest Profiles",
            mainClass = "com.brightcove.profiles.ProfilesService",
            args = "server ./target/classes/ingest-profiles.yml",
            vmArgs = "-Dhystrix.command.default.fallback.enabled=false",
            cwd = "/Users/mike/repos/ingest-profiles/service/webapp",
            -- modulePaths = { "/Users/mike/repos/ingest-profiles" }, -- java 9 or greater
          },
          {
            type = 'java',
            request = 'launch',
            name = "Run with log4j debug",
            mainClass = "com.brightcove.profiles.dynamo.DynamoDBTestAdd",
            -- classPaths = "${Auto}",
            args = "",
            vmArgs = "-Dlog4j.debug=true",
            -- cwd = "${cwd}",
            cwd = "/Users/mike/repos/ingest-profiles/service/webapp",
          },
        }
      end, { nargs = 0 })
      local function get_arguments() -- TODO: remove, this was copied
        local co = coroutine.running()
        if co then
          return coroutine.create(function()
            local args = {}
            vim.ui.input({ prompt = "Args: " }, function(input)
              args = vim.split(input or "", " ")
            end)
            coroutine.resume(co, args)
          end)
        else
          local args = {}
          vim.ui.input({ prompt = "Args: " }, function(input)
            args = vim.split(input or "", " ")
          end)
          return args
        end
      end

      api.nvim_create_user_command('DapLoadGoConfigurations', function()
        -- dap.adapters.delve = {
        --   type = "server",
        --   host = "127.0.0.1",
        --   port = 4040,
        -- }
        -- TODO: clean this up just copied defaults and added stuff for now
        dap.configurations.go = {
          {
            type = "go",
            name = "Debug",
            request = "launch",
            program = "${file}",
          },
          {
            type = "go",
            name = "Debug (Arguments)",
            request = "launch",
            program = "${file}",
            args = get_arguments,
          },
          {
            type = "go",
            name = "Debug Package",
            request = "launch",
            program = "${fileDirname}",
          },
          {
            type = "go",
            name = "Attach",
            mode = "local",
            request = "attach",
            processId = require("dap.utils").pick_process,
          },
          {
            type = "go",
            name = "Debug test",
            request = "launch",
            mode = "test",
            program = "${file}",
          },
          {
            type = "go",
            name = "Debug test (go.mod)",
            request = "launch",
            mode = "test",
            program = "./${relativeFileDirname}",
          },
          {
            type = "go",
            name = "Debug boulder-wfe2",
            request = "launch",
            mode = "debug",
            args = { "--config", "/Users/mike/go/src/github.com/letsencrypt/boulder/test/config/wfe2-local.json" },
            program = "/Users/mike/go/src/github.com/letsencrypt/boulder/cmd/boulder/main.go",
            output = "boulder-wfe2",
            cwd = "/Users/mike/go/src/github.com/letsencrypt/boulder",
            -- stopOnEntry = true,
          },
          {
            type = "go",
            name = "Remote Debug boulder-wfe2",
            request = "attach",
            mode = "remote",
            port = 4040,
            debugAdapter = "dlv-dap",
            host = "127.0.0.1",
            substitutePath = {
              {
                from = "${workspaceFolder}",
                to = "/boulder",
              }
            },
          },
          {
            type = "go",
            name = "Remote Debug testing",
            request = "attach",
            mode = "remote",
            port = 40000,
            debugAdapter = "dlv-dap",
            host = "127.0.0.1",
            -- showLog= true,
            -- trace= "log",
            -- logOutput= "rpc",
            substitutePath = {
              {
                from = "${workspaceFolder}",
                to = "/debuggingTutorial",
              }
            }
          },
        }
      end, { nargs = 0 })

      -- handled by dap ui
      -- dap.defaults.fallback.console = 'internalConsole'
      -- dap.defaults.fallback.terminal_win_cmd = 'Dap Console'
      -- dap.defaults.fallback.terminal_win_cmd = 'tabnew'
      -- dap.defaults.fallback.external_terminal = {
      --   command = '/usr/bin/alacritty';
      --   args = { '--hold', '-e' };
      -- }
      -- require('dap.ext.vscode').load_launchjs()
    end

    M.setup()

    return M
  end,
}
