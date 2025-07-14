if vim.fn.executable('zls') ~= 1 then
  return
end

local root_files = {
  'zls.json',
  'build.zig',
  '.git',
}

local lsp = require('user.lsp')

vim.lsp.start {
  name = 'zls',
  cmd = { 'zls' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = lsp.make_client_capabilities(),
  on_attach = lsp.on_attach,
}
