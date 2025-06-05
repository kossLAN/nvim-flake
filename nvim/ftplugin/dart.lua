-- Exit if the language server isn't available
if vim.fn.executable('dart') ~= 1 then
  return
end

local root_files = {
  '.git',
}

local lsp = require('user.lsp')

vim.lsp.start {
  name = 'dartls',
  cmd = { 'dart', 'language-server', '--protocol=lsp' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = lsp.make_client_capabilities(),
  on_attach = lsp.on_attach,
}
