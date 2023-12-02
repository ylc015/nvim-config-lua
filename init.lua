if vim.g.vscode then
  -- VSCode extension
  print('using VScode ext', 0)
else
  -- ordinary Neovim
  print('using ordinary Neovim', 0)
  local config_path = vim.fn.stdpath('config')
  local nvim_lua_config_path = config_path .. '/init-nvim.lua'
  dofile(nvim_lua_config_path)
end
