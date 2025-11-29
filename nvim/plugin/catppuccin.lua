require('catppuccin').setup {
  flavour = 'mocha', -- latte, frappe, macchiato, mocha
  transparent_background = true, -- disables setting the background color.
  auto_integrations = true,
}

-- setup must be called before loading
vim.cmd.colorscheme('catppuccin')
