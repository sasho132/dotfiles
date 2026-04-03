vim.pack.add {
  'https://github.com/mfussenegger/nvim-dap',
  -- Dependencies
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/williamboman/mason.nvim',
  'https://github.com/jay-babu/mason-nvim-dap.nvim',
  'https://github.com/leoluz/nvim-dap-go',
  'https://github.com/mfussenegger/nvim-dap-python',
  -- 'https://github.com/theHamsta/nvim-dap-virtual-text',
}

local dap = require 'dap'
local dapui = require 'dapui'

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

local function first_existing_path(paths)
  for _, path in ipairs(paths) do
    if vim.loop.fs_stat(path) then
      return path
    end
  end
end

local function mason_path(...)
  return vim.fn.stdpath 'data' .. '/mason/' .. table.concat({ ... }, '/')
end

local js_debug_path = first_existing_path {
  vim.fn.stdpath 'data' .. '/mason/packages/js-debug/src/dapDebugServer.js',
  vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
}

local function launch_file_config()
  return {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    cwd = '${workspaceFolder}',
  }
end

-- Basic debugging keymaps, feel free to change to your liking!
map('n', '<F5>', dap.continue, 'Debug: Start/Continue')
map('n', '<F1>', dap.step_into, 'Debug: Step Into')
map('n', '<F2>', dap.step_over, 'Debug: Step Over')
map('n', '<F3>', dap.step_out, 'Debug: Step Out')
map('n', '<leader>b', dap.toggle_breakpoint, 'Debug: Toggle Breakpoint')
-- vim.keymap.set('n', '<leader>B', dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ', 'Debug: Set Breakpoint'))

-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
map('n', '<F7>', dapui.toggle, 'Debug: See last session result.')

require('mason-nvim-dap').setup {
  -- Makes a best effort to setup the various debuggers with
  -- reasonable debug configurations
  automatic_installation = true,

  -- You can provide additional configuration to the handlers,
  -- see mason-nvim-dap README for more information
  handlers = {},

  -- You'll need to check that you have the required things installed
  -- online, please don't ask me how to install them :)
  ensure_installed = {
    -- Update this to ensure that you have the debuggers for the langs you want
    'delve',
    'debugpy',
    'js-debug-adapter',
  },
}

-- Dap UI setup
-- For more information, see |:help nvim-dap-ui|
dapui.setup {
  -- Set icons to characters that are more likely to work in every terminal.
  --    Feel free to remove or use ones that you like more! :)
  --    Don't feel like these are good choices.
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
}

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

-- Change breakpoint icon and color
vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#ffaf7f' })
vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint' })

-- require('nvim-dap-virtual-text').setup {
--   enabled = true,
--   enable_commands = true,
--   show_stop_reason = true,
-- }

-- Install golang specific config
require('dap-go').setup {
  delve = {
    path = first_existing_path {
      mason_path('bin', 'dlv'),
      'dlv',
    } or 'dlv',
    port = '${port}',
    -- On Windows delve must be run attached or it crashes.
    -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    detached = vim.fn.has 'win32' == 0,
  },
}

-- Install python specific config
require('dap-python').setup(first_existing_path {
  mason_path('packages', 'debugpy', 'venv', 'bin', 'python'),
  mason_path('packages', 'debugpy', 'venv', 'bin', 'python3'),
  vim.fn.exepath 'python3',
  vim.fn.exepath 'python',
} or 'python3')

-- Install node specific config
if js_debug_path then
  require('dap').adapters['pwa-node'] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
      command = 'node',
      args = { js_debug_path, '${port}' },
    },
  }

  dap.configurations.javascript = { launch_file_config() }
  dap.configurations.javascriptreact = { launch_file_config() }
  dap.configurations.typescript = { launch_file_config() }
  dap.configurations.typescriptreact = { launch_file_config() }
else
  vim.notify('js-debug server not found; skipping pwa-node adapter setup', vim.log.levels.WARN)
end
