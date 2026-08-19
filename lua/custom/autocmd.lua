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
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'no_auto_comment',
  pattern = '*',
  callback = function() vim.opt_local.formatoptions:remove { 'c', 'r', 'o' } end,
})

-- Templates (safely read template only if it exists)
local function load_template(rel_path)
  local path = vim.fs.joinpath(vim.fn.stdpath 'config', 'templates', rel_path)
  if vim.uv.fs_stat(path) then vim.cmd('0r ' .. vim.fn.fnameescape(path)) end
end

vim.api.nvim_create_autocmd('BufNewFile', {
  group = augroup 'templates',
  pattern = { '*.sh' },
  callback = function() load_template 'bash.sh' end,
})

vim.api.nvim_create_autocmd('BufNewFile', {
  group = augroup 'templates',
  pattern = { '*.md' },
  callback = function() load_template 'markdown_template.md' end,
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

-- Quit with q (for ephemeral/preview windows, excluding gitcommit)
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'quit_with_q',
  pattern = {
    'checkhealth',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'startuptime',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})
