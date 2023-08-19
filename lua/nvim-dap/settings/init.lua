local M = {}

M.setup = function()
  local dap = require('dap')
  dap.adapters.codelldb = {
    type = 'server',
    port = "13000",
    executable = {
      -- CHANGE THIS to your path!
      -- use Mason to install codelldb
      -- like ~/.local/share/nvim/mason/bin/codelldb
      command = 'codelldb',
      args = { "--port", "13000" },

      -- On windows you may have to uncomment this:
      -- detached = false,
    }
  }
  dap.configurations.cpp = {
    {
      name = "Launch file for Main",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = { "127.0.0.1", "Message233" },
    },
  }
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp

  -- mapping for Nvim DAP
  vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
  vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
  vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
  vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
  vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
  vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
  vim.keymap.set('n', '<Leader>lp',
    function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
  vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
  vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
  vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
  end)
  vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
  end)
  vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
  end)
  vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
  end)
end

return M
