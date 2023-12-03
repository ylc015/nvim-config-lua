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
  { desc = 'Eval selected top level' })
vim.keymap.set('n', '<leader>eb',
  string.format("<Cmd>lua require('vscode-neovim').call('%s')<CR>", 'calva.loadFile'),
  { desc = 'Eval whole file' })


-- Git related (Source Control)
vim.keymap.set('n', '<leader>gs',
  string.format("<Cmd>lua require('vscode-neovim').call('%s')<CR>", 'workbench.scm.focus'),
  { desc = 'Focus on Git' })


-- File Ex
vim.keymap.set('n', '<leader>tt',
  string.format("<Cmd>lua require('vscode-neovim').call('%s')<CR>", 'workbench.files.action.focusFilesExplorer'),
  { desc = 'Focus File Explorer' })
  

vim.keymap.set('n', '<leader><esc>',
  string.format("<Cmd>lua require('vscode-neovim').call('%s')<CR>", 'workbench.action.focusActiveEditorGroup'),
  { desc = 'Focus active editor' })

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

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
}, {})

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim', 'http', 'json' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['ai'] = '@assignment.inner',
        ['il'] = '@assignment.lhs',
        ['ao'] = '@assignment.outer',
        ['ik'] = '@assignment.rhs',
        ['ak'] = '@statement.outer',
        ['au'] = '@return.outer',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}
-- Make tree sitter movement repeatable
local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
