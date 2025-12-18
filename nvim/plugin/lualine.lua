if vim.g.did_load_lualine_plugin then
  return
end
vim.g.did_load_lualine_plugin = true

require('lualine').setup {
  options = {
    theme = 'auto',
    globalstatus = true,
    icons_enabled = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { { 'mode', icon = '' } },
    lualine_b = { { 'branch', icon = '' }, 'diff' },
    lualine_c = {
      {
        'filename',
        path = 1, -- relative path
      },
    },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
      },
      'encoding',
      'fileformat',
      'filetype',
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { 'quickfix', 'fugitive' },
}
