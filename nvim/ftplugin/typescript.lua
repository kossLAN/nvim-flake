-- Exit if the language server isn't available
if vim.fn.executable('typescript-language-server') ~= 1 then
  return
end

local root_files = {
  '.git',
}

vim.lsp.start {
  name = 'ts_ls',
  cmd = { 'typescript-language-server', '--stdio' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
}
