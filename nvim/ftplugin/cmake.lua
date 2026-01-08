-- Exit if the language server isn't available
if vim.fn.executable('cmake-language-server') ~= 1 then
  return
end

vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true

local root_files = {
  '.git',
  'build',
  'cmake',
}

local lsp = require('user.lsp')

vim.lsp.start {
  name = 'cmake',
  cmd = { 'cmake-language-server' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = lsp.make_client_capabilities(),
  on_attach = lsp.on_attach,
}
