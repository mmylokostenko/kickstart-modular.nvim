-- Custom LSP configurations
-- This file automatically hooks into the native Neovim 0.12+ LSP API
-- and mason-tool-installer to ensure the servers are installed.

local servers = {
  asm_lsp = {},
  ansiblels = {},
  bashls = {},
  jsonls = {},
  yamlls = {},
  dockerls = {},
  terraformls = {},
  marksman = {},
  rust_analyzer = {},
}

-- Ensure these servers and tools are installed via mason-tool-installer
local ensure_installed = vim.tbl_keys(servers)
table.insert(ensure_installed, 'ty') -- User preferred Python tool

local ok, mti = pcall(require, 'mason-tool-installer')
if ok then
  mti.check_install(ensure_installed)
end

-- Hook into the native LSP configuration logic
for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end
