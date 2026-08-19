-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Load snacks first if it exists, as other custom plugins might depend on it
pcall(require, 'custom.plugins.snacks')

-- Iterate over all Lua files in this directory and load them
local current_file = debug.getinfo(1, 'S').source:sub(2)
local plugins_dir = vim.fs.dirname(current_file)
if not vim.uv.fs_stat(plugins_dir) then plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'plugins') end

if vim.uv.fs_stat(plugins_dir) then
  for file_name, type in vim.fs.dir(plugins_dir, { follow = true }) do
    if (type == 'file' or type == 'link') and file_name:match '%.lua$' and file_name ~= 'init.lua' and file_name ~= 'snacks.lua' then
      local module = file_name:gsub('%.lua$', '')
      require('custom.plugins.' .. module)
    end
  end
end
