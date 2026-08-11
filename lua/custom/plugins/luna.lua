vim.pack.add { 'https://github.com/WTFox/luna.nvim' }

require('luna').setup {
  transparent = false,
  accent = 1.0, -- 0-1, blends syntax accents toward grey_light; 1 = full color
  plugins = {
    all = true, -- enable every plugin integration unconditionally
  },
  on_colors = function(colors) end,
  on_highlights = function(highlights, colors) end,
}

-- Activate the colorscheme
vim.cmd.colorscheme 'luna'
