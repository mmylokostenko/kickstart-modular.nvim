# Config Optimization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Optimize Neovim configuration by removing redundant indentation plugins, fixing integration between Catppuccin and Snacks, and making autocommands more portable and internally consistent.

**Architecture:** We will surgically modify three files: disabling `indent-blankline.nvim` in its spec file, adding the `snacks` integration to the Catppuccin spec, and converting hardcoded string commands in the autocommands to Lua callbacks using `vim.fn.stdpath('config')`.

**Tech Stack:** Neovim, Lua, lazy.nvim

---

### Task 1: Disable Redundant Indentation Plugin

**Files:**
- Modify: `lua/kickstart/plugins/indent_line.lua`

- [ ] **Step 1: Disable the plugin in its spec**

Modify `lua/kickstart/plugins/indent_line.lua` to add `enabled = false` to the plugin specification table.

```lua
return {
  'lukas-reineke/indent-blankline.nvim',
  enabled = false,
  main = 'ibl',
  ---@module 'ibl'
  ---@type ibl.config
  opts = {},
}
```

- [ ] **Step 2: Verify the configuration loads without errors**

Run: `nvim --headless -c "checkhealth" -c "qa"`
Expected: Clean exit with 0 errors related to indentation loading.

- [ ] **Step 3: Commit**

```bash
git add lua/kickstart/plugins/indent_line.lua
git commit -m "chore: disable indent-blankline.nvim in favor of snacks.indent"
```

### Task 2: Integrate Catppuccin with Snacks

**Files:**
- Modify: `lua/custom/plugins/catppuccin.lua`

- [ ] **Step 1: Add snacks integration**

Modify `lua/custom/plugins/catppuccin.lua` to set `snacks = true` in the `integrations` table.

```lua
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
```

- [ ] **Step 2: Verify the configuration loads without errors**

Run: `nvim --headless -c "checkhealth catppuccin" -c "qa"`
Expected: Clean exit with 0 errors.

- [ ] **Step 3: Commit**

```bash
git add lua/custom/plugins/catppuccin.lua
git commit -m "style: enable snacks integration in catppuccin"
```

### Task 3: Refactor Autocommands for Consistency and Portability

**Files:**
- Modify: `lua/custom/autocmd.lua`

- [ ] **Step 1: Rename `lazyvim_last_loc` to `kickstart_last_loc`**

Modify `lua/custom/autocmd.lua`. Find all instances of `lazyvim_last_loc` and replace them with `kickstart_last_loc`.

```lua
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].kickstart_last_loc then
      return
    end
    vim.b[buf].kickstart_last_loc = true
```

- [ ] **Step 2: Update template paths to use `vim.fn.stdpath('config')`**

Modify the `BufNewFile` autocommands in `lua/custom/autocmd.lua` to use a callback with `vim.fn.stdpath('config')` instead of hardcoded paths.

```lua
-- Templates
vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = { '*.sh' },
  callback = function()
    vim.cmd('0r ' .. vim.fn.stdpath('config') .. '/templates/bash.sh')
  end,
})

vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = { '*.md' },
  callback = function()
    vim.cmd('0r ' .. vim.fn.stdpath('config') .. '/templates/markdown_template.md')
  end,
})
```

- [ ] **Step 3: Verify the configuration loads without errors**

Run: `nvim --headless -c "checkhealth" -c "qa"`
Expected: Clean exit with 0 errors.

- [ ] **Step 4: Commit**

```bash
git add lua/custom/autocmd.lua
git commit -m "refactor: clean up autocommand logic and template paths"
```
