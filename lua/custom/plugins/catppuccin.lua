-- [[ catppuccin ]]
-- Set up catppuccin colorscheme
vim.pack.add { 'https://github.com/catppuccin/nvim' }

require('catppuccin').setup {
  flavour = 'mocha', -- latte, frappe, macchiato, mocha
  background = {
    light = 'latte',
    dark = 'mocha',
  },
  transparent_background = false,
  term_colors = true,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = false,
    snacks = true,
    mini = {
      enabled = true,
      indentscope_color = '',
    },
  },
}

-- Setup must be called before loading colorscheme
-- vim.cmd.colorscheme 'catppuccin'
