-- [[ snacks.nvim ]]
vim.pack.add { 'https://github.com/folke/snacks.nvim' }

-- Setup some globals for debugging (lazy-loaded)
_G.dd = function(...) Snacks.debug.inspect(...) end
_G.bt = function() Snacks.debug.backtrace() end
vim.print = _G.dd -- Override print to use snacks for `:=` command

require('snacks').setup {
  bigfile = { enabled = true },
  dashboard = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 3000,
  },
  quickfile = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  styles = {
    notification = {
      -- wo = { wrap = true } -- Wrap notifications
    },
  },
}

vim.keymap.set('n', '<leader>un', function() Snacks.notifier.hide() end, { desc = 'Dismiss All Notifications' })
vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = 'Delete Buffer' })
vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'Lazygit' })
vim.keymap.set('n', '<leader>gb', function() Snacks.git.blame_line() end, { desc = 'Git Blame Line' })
vim.keymap.set('n', '<leader>gB', function() Snacks.gitbrowse() end, { desc = 'Git Browse' })
vim.keymap.set('n', '<leader>gf', function() Snacks.lazygit.log_file() end, { desc = 'Lazygit Current File History' })
vim.keymap.set('n', '<leader>gl', function() Snacks.lazygit.log() end, { desc = 'Lazygit Log (cwd)' })
vim.keymap.set('n', '<leader>cR', function() Snacks.rename.rename_file() end, { desc = 'Rename File' })
vim.keymap.set('n', '<c-/>', function() Snacks.terminal() end, { desc = 'Toggle Terminal' })
vim.keymap.set('n', '<c-_>', function() Snacks.terminal() end, { desc = 'which_key_ignore' })
vim.keymap.set({ 'n', 't' }, ']]', function() Snacks.words.jump(vim.v.count1) end, { desc = 'Next Reference' })
vim.keymap.set({ 'n', 't' }, '[[', function() Snacks.words.jump(-vim.v.count1) end, { desc = 'Prev Reference' })
vim.keymap.set(
  'n',
  '<leader>N',
  function()
    Snacks.win {
      file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
      width = 0.6,
      height = 0.6,
      wo = {
        spell = false,
        wrap = false,
        signcolumn = 'yes',
        statuscolumn = ' ',
        conceallevel = 3,
      },
    }
  end,
  { desc = 'Neovim News' }
)

-- Create some toggle mappings
Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>ts'
Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>tw'
Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>tL'
Snacks.toggle.diagnostics():map '<leader>td'
Snacks.toggle.line_number():map '<leader>tl'
Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>tc'
Snacks.toggle.treesitter():map '<leader>tT'
Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>tb'
Snacks.toggle.inlay_hints():map '<leader>th'
Snacks.toggle.indent():map '<leader>tg'
Snacks.toggle.dim():map '<leader>tD'
