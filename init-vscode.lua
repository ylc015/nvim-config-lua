vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local vscode = require('vscode-neovim')
vim.notify = vscode.notify
vim.notify("Neovim: Using Vscode config")

-- Minmicking Conjure
vim.keymap.set('n', '<leader>ee',
  string.format("<Cmd>lua require('vscode-neovim').call('%s')<CR>", 'calva.evaluateEnclosingForm'),
  { desc = 'Eval current form' })
vim.keymap.set('v', '<leader>E',
  string.format("<Cmd>lua require('vscode-neovim').call('%s')<CR>", 'calva.evaluateSelection'),
  { desc = 'Eval selected current form' })
vim.keymap.set('n', '<leader>ece',
  string.format("<Cmd>lua require('vscode-neovim').call('%s')<CR>", 'calva.evaluateSelectionAsComment'),
  { desc = 'Eval selected and comment' })
vim.keymap.set('n', '<leader>er',
  string.format("<Cmd>lua require('vscode-neovim').call('%s')<CR>", 'calva.evaluateCurrentTopLevelForm'),
  { desc = 'Eval selected and comment' })
vim.keymap.set('n', '<leader>eb',
  string.format("<Cmd>lua require('vscode-neovim').call('%s')<CR>", 'calva.loadFile'),
  { desc = 'Eval selected and comment' })
  

vim.keymap.set('n', '<leader>nc', string.format("<Cmd>lua require('vscode-neovim').call('%s')<CR>", 'calva.jackIn'),
  { desc = 'Jack in' })

local local_config = vim.fn.stdpath('config') .. '/init-vscode.lua'
vim.keymap.set('n', '<leader>,', string.format(':e %s<CR>', local_config))
vim.keymap.set('n', '<leader>aa', ":msg someghing")

-- using a different runtime path
local lazypath = vim.fn.stdpath 'data' .. '/lazy-vscode/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({


  -- Clojure related

  {
    'guns/vim-sexp',
    config = function()
      vim.g.sexp_mappings['sexp_swap_list_backward'] = ''
      vim.g.sexp_mappings['sexp_swap_list_forward'] = ''
      vim.g.sexp_mappings['sexp_swap_element_backward'] = ''
      vim.g.sexp_mappings['sexp_swap_element_forward'] = ''
    end
  },

  'tpope/vim-sexp-mappings-for-regular-people',

  -- Vim editing
  'tpope/vim-surround',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  'ggandor/leap.nvim',

  'ggandor/leap-spooky.nvim',

  'mbbill/undotree',

  require 'iron.plugins',

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
}, {})
