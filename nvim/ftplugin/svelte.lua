if vim.fn.executable('svelteserver') ~= 1 then
  return
end

local root_files = {
  '.git',
}

local lsp = require('user.lsp')

vim.lsp.start {
  name = 'svelte',
  cmd = { 'svelteserver', '--stdio' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = lsp.make_client_capabilities(),
  on_attach = lsp.on_attach,
}
