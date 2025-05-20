if vim.fn.executable('OmniSharp') ~= 1 then
  return
end

vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true

local lsp = require('user.lsp')

vim.lsp.start {
  name = 'roslyn',
  cmd = { 'OmniSharp', '-z', 'DotNet:enablePackageRestore=false', '--encoding', 'utf-8', '--languageserver' },
  capabilities = lsp.make_client_capabilities(),
  on_attach = lsp.on_attach,
}
