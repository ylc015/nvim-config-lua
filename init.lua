local config_path = vim.fn.stdpath('config')
if vim.g.vscode then
  -- VSCode extension
  print('using VScode ext', 0)
  local vscode_lua_config_path = config_path .. '/init-vscode.lua'
  dofile(vscode_lua_config_path)
else
  -- ordinary Neovim
  print('using ordinary Neovim', 0)
  local nvim_lua_config_path = config_path .. '/init-nvim.lua'
  dofile(nvim_lua_config_path)
end
