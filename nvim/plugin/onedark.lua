if vim.g.did_load_onedark_plugin then
  return
end
vim.g.did_load_onedark_plugin = true

require('onedark').setup {
  style = 'darker',
  transparent = true,
  lualine = { transparent = true },
}

require('onedark').load()

vim.cmd.colorscheme('onedark')
