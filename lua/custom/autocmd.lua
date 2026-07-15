-- [[ Custom Autocommands]]

-- Go to last loc when opening a buffer
--
local function augroup(name) return vim.api.nvim_create_augroup('kickstnvim_' .. name, { clear = true }) end

vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup 'last_loc',
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].kickstart_last_loc then return end
    vim.b[buf].kickstart_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
  end,
})

-- Don't auto comment new line
vim.api.nvim_create_autocmd('BufEnter', { command = [[set formatoptions-=cro]] })

-- Templates
vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = { '*.sh' },
  callback = function() vim.cmd('0r ' .. vim.fn.stdpath 'config' .. '/templates/bash.sh') end,
})

vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = { '*.md' },
  callback = function() vim.cmd('0r ' .. vim.fn.stdpath 'config' .. '/templates/markdown_template.md') end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'wrap_spell',
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Quit with q
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'quit_with_q',
  pattern = {
    'lspinfo',
    'git*',
    'help',
    'notify',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})
