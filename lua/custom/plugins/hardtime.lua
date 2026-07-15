-- [[ hardtime.nvim ]]
vim.pack.add {
  'https://github.com/m4xshen/hardtime.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

require('hardtime').setup {
  -- 🛑 The "Strict" Settings
  disable_mouse = false, -- Set to true to completely disable mouse support
  max_time = 1000, -- Time (in ms) to count repeated key presses
  max_count = 2, -- Maximum allowed repeated presses within `max_time` (e.g. `jj` is okay, `jjj` gets blocked)

  -- 🥾 The "Kick Me Out" Settings
  -- Automatically leaves Insert mode if you idle for too long (forces you back to Normal mode)
  -- Great for preventing you from treating Neovim like Notepad!
  hint = true,

  -- 🚫 Ignore specific filetypes where you *want* to spam keys (like file explorers)
  disabled_filetypes = {
    'qf',
    'netrw',
    'NvimTree',
    'lazy',
    'mason',
    'oil',
  },

  -- 🎯 Custom hints to teach you better motions
  -- For example, instead of doing `d` then `i` then `w`, it tells you to just do `ciw`.
  custom_hints = {
    ['d[tTfF].i'] = {
      message = function() return 'Use c instead of d...i' end,
      length = 3,
    },
  },
}
