local dap = require("dap")

local dapui = require("dapui")
dapui.setup()

local dp_path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
require('dap-python').setup(dp_path)

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

vim.fn.sign_define(
  "DapBreakpoint",
  { text = "", texthl = "DiagnosticError" }
)
vim.fn.sign_define(
  "DapBreakpointCondition",
  { text = "", texthl = "DiagnosticError" }
)
vim.fn.sign_define(
  "DapLogPoint",
  { text = "", texthl = "DiagnosticInfo" }
)
vim.fn.sign_define(
  "DapStopped",
  { text = "👉", texthl = "Constant", linehl = "debugPC" }
)
vim.fn.sign_define("DapBreakpointRejected", { text = "" })
dap.configurations.python = {
  -- https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
  {
    -- The first three options are required by nvim-dap
    type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch',
    name = "Launch file",

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}", -- This configuration will launch the current file if used.
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
        -- Also looking for pyrightconfig.json
      elseif vim.fn.filereadable(cwd .. '/pyrightconfig.json') == 1 then
        local data = vim.fn.json_decode(vim.fn.readfile(cwd .. '/pyrightconfig.json'))
        local venv = data["venv"]
        local venvPath = data["venvPath"]
        return venvPath .. '/' .. venv .. '/bin/python'
      else
        return '/usr/bin/python'
      end
    end,
  },
}
dap.set_log_level("TRACE")
