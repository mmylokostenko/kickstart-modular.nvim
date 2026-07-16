-- [[ yazi.nvim ]]
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.pack.add {
  'https://github.com/mikavilpas/yazi.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/s1n7ax/nvim-window-picker',
}

require('window-picker').setup {
  hint = 'floating-big-letter',
  filter_rules = {
    include_current_win = false,
    autoselect_one = true,
    -- filter using buffer options
    bo = {
      -- if the file type is one of following, the window will be ignored
      filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
      -- if the buffer type is one of following, the window will be ignored
      buftype = { 'terminal', 'quickfix' },
    },
  },
}

require('yazi').setup {
  -- if you want to open yazi instead of netrw, see below for more info
  open_for_directories = true,
  keymaps = {
    show_help = '<f1>',
  },
}

vim.keymap.set('n', '<leader>e', '<cmd>Yazi<cr>', { desc = 'Open yazi at the current file' })
vim.keymap.set('n', '<leader>-', '<cmd>Yazi toggle<cr>', { desc = 'Resume the last yazi session' })
