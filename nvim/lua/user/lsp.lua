---@mod user.lsp
---
---@brief [[
---LSP related functions
---@brief ]]

local M = {}

---Gets a 'ClientCapabilities' object, describing the LSP client capabilities
---Extends the object with capabilities provided by plugins.
function M.make_client_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- Add com_nvim_lsp capabilities
  local cmp_lsp = require('cmp_nvim_lsp')
  local cmp_lsp_capabilities = cmp_lsp.default_capabilities()
  capabilities = vim.tbl_deep_extend('keep', capabilities, cmp_lsp_capabilities)
  -- Add any additional plugin capabilities here.
  -- Make sure to follow the instructions provided in the plugin's docs.
  return capabilities
end

---Setup LSP keymaps for the current buffer
---@param bufnr number Buffer number
function M.setup_keymaps(bufnr)
  -- Create a shorthand for mapping keys
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Code actions
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  -- Quick fix
  vim.keymap.set('n', '<leader>qf', vim.lsp.buf.code_action, opts)
  -- Apply first available code action
  vim.keymap.set('n', '<leader>af', function()
    vim.lsp.buf.code_action {
      filter = function(action)
        return action.isPreferred
      end,
      apply = true,
    }
  end, opts)
end

-- Attach keymaps when LSP client attaches to a buffer
function M.on_attach(_, bufnr)
  M.setup_keymaps(bufnr)
end

return M
