# kickstart-modular.nvim

## 1. Overview

`kickstart-modular.nvim` is a starting point for Neovim configuration. It is designed to be small, single-file (primarily), and completely documented. It serves as a foundation for users to build their own custom Neovim setup, rather than acting as a full-fledged Neovim distribution. The project relies on `lazy.nvim` for plugin management and integrates standard, modern Neovim tools like Telescope, Treesitter, and native LSP.

## 2. Getting Started

### Installation
1.  Ensure prerequisites are installed: `git`, `make`, `unzip`, a C compiler, `ripgrep`, `fd`, and optionally a Nerd Font.
2.  Clone this repository to the standard Neovim configuration path (e.g., `~/.config/nvim` on Linux/macOS).
3.  Run `nvim`. `lazy.nvim` will automatically bootstrap and install all specified plugins.

## 3. Architecture

The configuration is modularized for better maintainability:

*   **`init.lua`**: The entry point. It bootstraps the configuration by requiring modular components in the correct order.
*   **Core Configuration (`lua/`)**:
    *   `options.lua`: Standard Neovim options (`vim.opt`).
    *   `keymaps.lua`: Basic, non-plugin keymaps.
    *   `lazy-bootstrap.lua`: Logic to automatically install `lazy.nvim` if missing.
    *   `lazy-plugins.lua`: The core plugin configuration file. It manages the `lazy.nvim` setup and imports all plugin specifications.
*   **Plugins & Customization**:
    *   `lua/kickstart/plugins/`: Modularized configurations for core/optional plugins (e.g., `lspconfig.lua`, `telescope.lua`).
    *   `lua/custom/plugins/`: A designated directory for users to add their own plugin specifications. These are automatically imported in `lua/lazy-plugins.lua`.
    *   `lua/custom/autocmd.lua`: Custom autocommands for improved workflow and automation.
*   **Tooling**:
    *   `.stylua.toml`: Configuration for the `stylua` formatter.

## 4. Customization

### Adding Plugins
*   **Recommended Approach:** Create a new `.lua` file inside `lua/custom/plugins/` returning a table with the plugin specification (following `lazy.nvim` conventions). It will be automatically loaded without causing upstream merge conflicts.

### Keymaps & Autocommands
*   **Keymaps:** Space (`<space>`) is configured as the `mapleader`. Help searches are often prefixed with `<leader>s` (e.g., `<leader>sh` for Search Help). Define custom keymaps in `lua/keymaps.lua` or alongside plugin definitions.
*   **Autocommands:** Add custom behavior in `lua/custom/autocmd.lua`.

## 5. Technology Stack

*   **Neovim:** Targets the latest 'stable' or 'nightly' versions.
*   **Language:** Lua is used for all configurations.
*   **Plugin Manager:** `lazy.nvim`
*   **Core Plugins:**
    *   `nvim-telescope/telescope.nvim` (Fuzzy finder)
    *   `neovim/nvim-lspconfig` & `mason.nvim` (LSP management and configuration)
    *   `nvim-treesitter/nvim-treesitter` (Syntax highlighting and navigation)
    *   `stevearc/conform.nvim` (Auto-formatting)
    *   `saghen/blink.cmp` (Auto-completion)

## 6. Conventions & Tooling

*   **Formatting:** Lua files should be formatted using `stylua`. The repository includes a GitHub Action (`.github/workflows/stylua.yml`) to enforce this.
*   **Health Checks:** If encountering issues, run `:checkhealth` within Neovim to diagnose missing dependencies or configuration errors.
*   **Documentation:** Read the comments throughout the configuration files. They frequently reference Neovim help pages (e.g., `:help vim.o`) to encourage learning.

## 7. AI Agent Instructions

When AI agents (like Gemini) interact with this repository, they MUST adhere to the following rules:

*   **Preserve the Kickstart Philosophy:** Do NOT introduce overly complex, bloated "distribution-like" frameworks. This config is meant to be highly readable, minimal, and educational. Preserve all existing explanatory comments, as they are a core feature.
*   **Modularity over Monolith:** When asked to add a new plugin or feature, DO NOT modify `init.lua` directly.
    *   Place all new plugin configurations in `lua/custom/plugins/` (as a new `.lua` file returning a `lazy.nvim` spec).
    *   Place custom global autocommands in `lua/custom/autocmd.lua`.
    *   Place custom global keymaps in `lua/keymaps.lua` (or within the respective plugin spec if they are plugin-specific).
*   **Code Style:** All modified or newly created Lua files MUST be formatted using `stylua` to ensure consistent code styling.
*   **Validation:** Remind the user to run `:checkhealth` or `:Lazy` inside Neovim after adding new tools or plugins to ensure dependencies are correctly installed.
