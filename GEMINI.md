# kickstart-modular.nvim

## Project Overview

`kickstart-modular.nvim` is a starting point for Neovim configuration. It is designed to be small, single-file (primarily), and completely documented. It serves as a foundation for users to build their own custom Neovim setup, rather than acting as a full-fledged Neovim distribution. The project relies on `lazy.nvim` for plugin management and integrates standard, modern Neovim tools like Telescope, Treesitter, and native LSP.

## Key Technologies
*   **Neovim:** Targets the latest 'stable' or 'nightly' versions.
*   **Language:** Lua is used for all configurations.
*   **Plugin Manager:** `lazy.nvim`
*   **Core Plugins:**
    *   `nvim-telescope/telescope.nvim` (Fuzzy finder)
    *   `neovim/nvim-lspconfig` & `mason.nvim` (LSP management and configuration)
    *   `nvim-treesitter/nvim-treesitter` (Syntax highlighting and navigation)
    *   `stevearc/conform.nvim` (Auto-formatting)
    *   `saghen/blink.cmp` (Auto-completion)

## Directory Structure & Architecture
*   `init.lua`: The entry point. It bootstraps the configuration by requiring modular components in the correct order.
*   `lua/options.lua`: Standard Neovim options (`vim.opt`).
*   `lua/keymaps.lua`: Basic, non-plugin keymaps.
*   `lua/lazy-bootstrap.lua`: Logic to automatically install `lazy.nvim` if missing.
*   `lua/lazy-plugins.lua`: The core plugin configuration file. It manages the `lazy.nvim` setup and imports all plugin specifications.
*   `lua/kickstart/plugins/`: Modularized configurations for core/optional plugins (e.g., `lspconfig.lua`, `telescope.lua`).
*   `lua/custom/plugins/`: A designated directory for users to add their own plugin specifications. These are automatically imported in `lua/lazy-plugins.lua`.
*   `lua/custom/autocmd.lua`: Custom autocommands for improved workflow and automation.
*   `.stylua.toml`: Configuration for the `stylua` formatter.

## Development & Usage
### Installation / Running
1.  Ensure prerequisites are installed: `git`, `make`, `unzip`, a C compiler, `ripgrep`, `fd`, and optionally a Nerd Font.
2.  Clone this repository to the standard Neovim configuration path (e.g., `~/.config/nvim` on Linux/macOS).
3.  Run `nvim`. `lazy.nvim` will automatically bootstrap and install all specified plugins.

### Adding Plugins
*   **Recommended Approach:** Create a new `.lua` file inside `lua/custom/plugins/` returning a table with the plugin specification (following `lazy.nvim` conventions). It will be automatically loaded.

### Conventions & Tooling
*   **Formatting:** Lua files should be formatted using `stylua`. The repository includes a GitHub Action (`.github/workflows/stylua.yml`) to enforce this.
*   **Health Checks:** If encountering issues, run `:checkhealth` within Neovim to diagnose missing dependencies or configuration errors.
*   **Keymaps:** Space (`<space>`) is configured as the `mapleader`. Help searches are often prefixed with `<leader>s` (e.g., `<leader>sh` for Search Help).
*   **Documentation:** Read the comments throughout `init.lua`. They frequently reference Neovim help pages (e.g., `:help vim.o`) to encourage learning.
