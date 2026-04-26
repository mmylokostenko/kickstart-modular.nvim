# Neovim Configuration Optimization Design

## 1. Overview
This document outlines the design for optimizing the `kickstart-modular.nvim` configuration, focusing on resolving redundancies, cleaning up inherited code artifacts, and improving portability while preserving the user's specific workflow and custom features.

## 2. Redundancy Removal (Indentation)
**Problem:** The configuration currently uses both `lukas-reineke/indent-blankline.nvim` (in `lua/kickstart/plugins/indent_line.lua`) and `folke/snacks.nvim` (in `lua/custom/plugins/snacks.lua`) for indentation guides.
**Solution:** 
- Disable the `indent_line.lua` plugin to reduce overhead.
- Rely solely on `snacks.indent` as the provider for indentation guides, as it is fast and integrates well with other Snacks features.

## 3. Theming & Visuals Integration
**Problem:** The `catppuccin` theme configuration in `lua/custom/plugins/catppuccin.lua` does not explicitly integrate with `snacks.nvim`.
**Solution:**
- Update the `integrations` table in `catppuccin.lua` to include `snacks = true`.
- Ensure `notify = false` remains if `snacks.notifier` is managing notifications (which it is).

## 4. Logic Refinement & Artifact Cleanup
**Problem:** The `lua/custom/autocmd.lua` file contains variable names inherited from LazyVim (e.g., `lazyvim_last_loc`).
**Solution:**
- Rename `lazyvim_last_loc` to `kickstart_last_loc` (or similar) to align with the current project's namespace.

## 5. Portability Improvements (Templates)
**Problem:** Autocommands in `lua/custom/autocmd.lua` use absolute, hardcoded paths for templates (e.g., `~/.config/nvim/templates/bash.sh`), making the config less portable across different machines or usernames.
**Solution:**
- Refactor the paths to use `vim.fn.stdpath('config') .. '/templates/bash.sh'` to dynamically resolve the configuration directory.

## 6. Testing Strategy
- Ensure Neovim starts without errors (`:checkhealth`).
- Verify indentation guides are visible and provided by Snacks.
- Verify Catppuccin styles apply to Snacks UI elements (like notifications or dashboard).
- Verify opening a previously opened file restores the cursor position.
- Verify opening a new `.sh` or `.md` file correctly loads the template content (assuming the templates exist in the config directory).
