-- Override default kickstart keymaps safely

-- Delete the default Kickstart <leader>f mapping for conform.nvim
pcall(vim.keymap.del, { 'n', 'v' }, '<leader>f')

-- Add the preferred mapping: <leader>cf
vim.keymap.set({ 'n', 'v' }, '<leader>cf', function() require('conform').format { async = true } end, { desc = '[C]ode [F]ormat buffer' })

-- Debugger overrides
pcall(vim.keymap.del, 'n', '<leader>b')
vim.keymap.set('n', '<F9>', function() require('dap').toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })

pcall(vim.keymap.del, 'n', '<leader>B')
vim.keymap.set('n', '<A-F9>', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, { desc = 'Debug: Set Breakpoint' })
