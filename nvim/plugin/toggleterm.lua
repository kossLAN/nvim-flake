if vim.g.did_load_toggleterm_plugin then
  return
end
vim.g.did_load_toggleterm_plugin = true

require('toggleterm').setup {
  open_mapping = nil,
  direction = 'float',
  persist_mode = false,
  auto_scroll = false,
  float_opts = {
    border = 'rounded',
  },
}

for i = 0, 9 do
  vim.keymap.set(
    { 'n', 't' }, -- Both terminal and normal
    '<C-' .. i .. '>',
    '<CMD>ToggleTerm ' .. i .. '<CR>',
    { noremap = true, silent = true }
  )
end
