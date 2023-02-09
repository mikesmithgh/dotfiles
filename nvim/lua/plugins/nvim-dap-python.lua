  return { 'mfussenegger/nvim-dap-python', dependencies = { "mfussenegger/nvim-dap" },
config = function()
local status, dap = pcall(require, "dap")
if not status then
  return
end
local dappython
status, dappython = pcall(require, "dap-python")
if not status then
  return
end
dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file (justMyCode = false)',
    program = '${file}',
    console = "integratedTerminal",
    justMyCode = false,
    -- pythonPath = opts.pythonPath,
  },
}
dappython.setup('~/.virtualenvs/debugpy/bin/python', {
  include_configs = true,
  console = 'integratedTerminal',
  pythonPath = nil,
})
end
}
