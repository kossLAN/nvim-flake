if vim.g.did_load_dap_plugin then
  return
end
vim.g.did_load_dap_plugin = true

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

local keymap = vim.keymap

keymap.set(
  'n',
  '<leader>db',
  ':lua require"dap".toggle_breakpoint()<CR>',
  { noremap = true, silent = true, desc = 'debugger set [b]reakpoint' }
)

keymap.set(
  'n',
  '<leader>dc',
  ':lua require"dap".continue()<CR>',
  { noremap = true, silent = true, desc = 'debugger [c]ontinue' }
)

keymap.set(
  'n',
  '<leader>dn',
  ':lua require"dap".step_over()<CR>',
  { noremap = true, silent = true, desc = 'debugger [s]tep over' }
)

keymap.set(
  'n',
  '<leader>di',
  ':lua require"dap".step_into()<CR>',
  { noremap = true, silent = true, desc = 'debugger [s]tep into' }
)

keymap.set(
  'n',
  '<leader>dr',
  ':lua require"dap".repl.open()<CR>',
  { noremap = true, silent = true, desc = 'debugger [r]epl' }
)

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
