-- For some reason this nvim-dap doesn't wan't to find lldb-dap executable...
local function get_binary_path(binary)
  local handle = io.popen('whereis -b ' .. binary .. ' | cut -d" " -f2')
  if handle then
    local result = handle:read('*a')
    handle:close()
    return result:gsub('\n', '') -- Remove trailing newline
  end
  return nil
end

local dap = require('dap')
dap.adapters = {
  lldb = {
    type = 'executable',
    command = get_binary_path('lldb-dap'),
    name = 'lldb',
  },
  gdb = {
    type = 'executable',
    command = 'gdb',
    args = { '-i', 'dap' },
  },
}

local lldb = {
  name = 'lldb',
  type = 'lldb',
  request = 'launch',
  program = function()
    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  end,
  cwd = '${workspaceFolder}',
  stopOnEntry = false,
  args = {},
  runInTerminal = true,
}

local gdb = {
  name = 'gdb',
  type = 'gdb',
  request = 'launch',
  program = function()
    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  end,
  cwd = '${workspaceFolder}',
}

dap.configurations.c = { lldb, gdb }
dap.configurations.cpp = { lldb, gdb }
dap.configurations.rust = lldb

-- DAP UI
local dapui = require('dapui')
dapui.setup()

dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end
