if vim.fn.executable('OmniSharp') ~= 1 then
  return
end

vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true

local lsp = require('user.lsp')

-- TODO: make a helper function that does the wildcard matching to find the root dir
local root_files = {
  '.git',
  -- '*.sln',
  -- '*.csproj',
  -- 'omnisharp.json',
}

vim.lsp.start {
  name = 'roslyn',
  cmd = {
    'OmniSharp',
    '-z',
    'DotNet:enablePackageRestore=false',
    '--encoding',
    'utf-8',
    '--languageserver',
  },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = lsp.make_client_capabilities(),
  on_attach = lsp.on_attach,
  settings = {
    FormattingOptions = {
      EnableEditorConfigSupport = true,
    },
    MsBuild = {},
    RenameOptions = {},
    RoslynExtensionsOptions = {},
    Sdk = {
      IncludePrereleases = true,
    },
  },
}
